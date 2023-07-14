helm repo add momo-store ${NEXUS_REPO_URL_HELM} --username ${NEXUS_REPO_USER} --password ${NEXUS_REPO_PASS} || true
helm repo update momo-store
helm upgrade momo-store momo-store/momo-store --install --namespace momo-store