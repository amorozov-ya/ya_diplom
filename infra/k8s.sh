#!/bin/bash
# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/home/student/yandex-cloud/path.bash.inc' ]; then source '/home/student/yandex-cloud/path.bash.inc'; fi
# The next line enables shell command completion for yc.
if [ -f '/home/student/yandex-cloud/completion.bash.inc' ]; then source '/home/student/yandex-cloud/completion.bash.inc'; fi
sudo apt-get update < /dev/null || true
sudo apt install jq -y < /dev/null || true
export CLUSTER_ID=$(yc managed-kubernetes cluster get k8s-momo | head -n 1 | awk -F ':' '{print $2}')
yc iam key create --service-account-name k8s-manager --output /home/${DEV_USER}/.ssh/sa-key.json || true
yc managed-kubernetes cluster get-credentials ${CLUSTER_ID}  --external --force
yc managed-kubernetes cluster get --id ${CLUSTER_ID} --format json | \
    jq -r .master.master_auth.cluster_ca_certificate | awk '{gsub(/\\n/,"\n")}1' > /home/${DEV_USER}/.kube/ca.pem
kubectl create -f /home/${DEV_USER}/k8s-momo-store/sa.yaml
SA_TOKEN=$(kubectl -n kube-system get secret $(kubectl -n kube-system get secret | grep admin-user | \
    awk '{print $1}') -o json | jq -r .data.token | base64 --d)
MASTER_ENDPOINT=$(yc managed-kubernetes cluster get --id ${CLUSTER_ID} --format json | jq -r .master.endpoints.external_v4_endpoint)
kubectl config set-cluster sa-k8s-momo --certificate-authority=/home/${DEV_USER}/.kube/ca.pem \
  --server=${MASTER_ENDPOINT} \
  --kubeconfig=/home/student/.kube/momo.kubeconfig
kubectl config set-credentials admin-user --token=$SA_TOKEN --kubeconfig=/home/student/.kube/momo.kubeconfig
kubectl config set-context momo-store --cluster=sa-k8s-momo --user=admin-use --kubeconfig=/home/student/.kube/momo.kubeconfig
kubectl config use-context momo-store
kubectl create namespace momo-store
helm repo add external-secrets https://charts.external-secrets.io
helm install external-secrets external-secrets/external-secrets --namespace momo-store
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx --set controller.service.loadBalancerIP=${EXTERAL_IP} --namespace momo-store

echo "Sleeping for 120 seconds…"
date +"%H:%M:%S"
sleep 120
echo "Completed"
date +"%H:%M:%S"
kubectl --namespace momo-store create secret generic yc-auth --from-file=authorized-key=/home/${DEV_USER}/.ssh/sa-key.json
sleep 10
kubectl --namespace momo-store apply -f ./k8s-momo-store/secretstore.yaml
kubectl --namespace momo-store apply -f ./k8s-momo-store/exteral-secret.yaml
cat > ./k8s-momo-store/secret.yaml << ENDOFFILE
---
kind: Secret
apiVersion: v1
metadata:
  name: docker-config-secret
data:
  .dockerconfigjson: >-
    $DOKERCONFIGJSON
type: kubernetes.io/dockerconfigjson 
ENDOFFILE
kubectl apply -f ./k8s-momo-store/secret.yaml -n momo-store
rm -./k8s-momo-store/secret.yaml
git clone https://github.com/kubernetes/autoscaler.git 
./autoscaler/vertical-pod-autoscaler/hack/vpa-up.sh 
helm repo add momo-store ${NEXUS_REPO_URL_HELM} --username ${NEXUS_REPO_USER} --password ${NEXUS_REPO_PASS} && helm repo update
helm install my-prom momo-store/prometheus --namespace momo-store
kubectl apply -f k8s-momo-store/ingress-promet.yaml -n momo-store
helm repo add tricksterproxy https://helm.tricksterproxy.io && helm repo update
helm install trickster tricksterproxy/trickster --namespace momo-store -f ./k8s-momo-store/trickster.yaml
kubectl apply -f k8s-momo-store/grafana.yaml -n momo-store
