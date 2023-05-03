# Инфрастуктрутрый модуль пайплана создает ресурсы в YandexCloud и производит их наполнение в --namespace momo-store:
# 1.job:helm-repo-update Загрузка ранее созданного Helm chart momo-store (frontend\backend) в репозиторий Nexus.  
# Дополнительное описание смотрите в ./helm/momo-store/README.md  
#   - требует указать переменные и их значения в CI/CD
#       NEXUS_REPO_URL_HELM
#       NEXUS_REPO_USER
#       NEXUS_REPO_PASS
#
#
#
# 2. job:deploy_terraform - Создается k8s cluster в YandexCloud, включая Bucket (в целях обучения). 
# Дополнительное описание смотрите в tf-momo-store/README.md.
#   - требует указать переменные и их значения в CI/CD
#       DEV_USER
#       DEV_HOST
#       SSH_PRIVATE_KEY
#       SSH_KNOWN_HOSTS
#       TF_VAR_token
#   - после завершения задачи будет вывод с IP адрессами и сертификатом кластера. вывод ip_ingress необходимо добавить как переменную EXTERAL_IP в CI/CD GitLab
#
#
#
# 3. job:deploy_yc_k8s - Заполнение среды k8s:
#       - создание конфигурации для подключения к k8s
#       - загрузка дополнительных модулей для k8s: external-secrets (for CertMeneger); ingress-nginx; VPA
#       - загрузка секретов для работы кластера
#       - установка в кластер стека Prometheus\trickster\Grafana
#       - добавление ingress для Prometheus\Grafana 
#       - Grafana dashboard import 8588 - Kubernetes Deployment Statefulset Daemonset metrics  
#       - Grafana метрики бэкэна - labels: app="backend" instance="backend:8081" job="backend_metrics"
#       - Требуется указать ID сертификата, ранее полученного через Certificate Manager/Сертификаты в панели управления YandexCloud, и внести его значение в файл ./infra/k8s-momo-store/exteral-secret.yaml  spec.data.secretKey.remoteRef.key 
#        - ./k8s-momo-store хранятся файлы конфигурациии k8s - deploy grafana и ingress для grafana\prometheus, для указания своих доменов в ingress-файлах укажите свои значения домена (hosts)и секрета (secretName).      
#        - требует указать переменные и их значения в CI/CD
#           DEV_USER
#           DEV_HOST
#           SSH_PRIVATE_KEY
#           SSH_KNOWN_HOSTS
#           EXTERAL_IP
#           DOKERCONFIGJSON
#       - После установки требуется зайти в grafana (grafana.momostoreby.site), логин по умолчанию graafana - admin:admin, до   бавить провайдера Promethheus (URL — http://trickster:8480), добавить дашборды мониторинга.
#       - Задача не всегда отрабатывает с первого раза, стоит задержка в минуту, но не всегда успеват подготовится хранилище секретов external-secrets, отвечает за привязывние сертифката к ingress. Можно просто перезапустить задачу при обнаружении ошибки: 
#   Error from server (InternalError): error when creating "./k8s-momo-store/secretstore.yaml": Internal error occurred: failed calling webhook "validate.secretstore.external-secrets.io": failed to call webhook: Post "https://external-secrets-webhook.momo-store.svc:443/validate-external-secrets-io-v1beta1-secretstore?timeout=5s": dial tcp 10.50.212.11:443: connect: connection refused
#
#
#momostoreby.site
#promet.momostoreby.site
#grafana.momostoreby.site
#
