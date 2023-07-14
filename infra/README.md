 Инфрастуктрутрый модуль пайплана создает ресурсы в YandexCloud и производит их наполнение в --namespace momo-store:
 1.job:helm-repo-update Загрузка ранее созданного Helm chart momo-store (frontend\backend) в репозиторий Nexus.  
 Дополнительное описание смотрите в ./helm/momo-store/README.md  
   - требует указать переменные и их значения в CI/CD
       NEXUS_REPO_URL_HELM
       NEXUS_REPO_USER
       NEXUS_REPO_PASS



 2. job:deploy_terraform - Создается k8s cluster в YandexCloud, включая Bucket (в целях обучения). 
 Дополнительное описание смотрите в tf-momo-store/README.md.
   - требует указать переменные и их значения в CI/CD
       DEV_USER
       DEV_HOST
       SSH_PRIVATE_KEY
       SSH_KNOWN_HOSTS
       TF_VAR_token
   - после завершения задачи будет вывод с IP адресами и сертификатом кластера. вывод ip_ingress необходимо добавить, как переменную EXTERAL_IP в CI/CD GitLab



 3. job:deploy_yc_k8s - Заполнение среды k8s:
       - создание конфигурации для подключения к k8s
       - загрузка дополнительных модулей для k8s: external-secrets (for CertMeneger); ingress-nginx; VPA
       - загрузка секретов для работы кластера
       - установка в кластер стека Prometheus\trickster\Grafana
       - добавление ingress для Prometheus\Grafana 
       - Grafana dashboard import 8588 - Kubernetes Deployment Statefulset Daemonset metrics  
       - Grafana метрики бэкэнда - labels: app="backend" instance="backend:8081" job="backend_metrics"
       - Требуется указать ID сертификата, ранее полученного через Certificate Manager/Сертификаты в панели управления YandexCloud, и внести его значение в файл ./infra/k8s-momo-store/exteral-secret.yaml  spec.data.secretKey.remoteRef.key 
        - ./k8s-momo-store хранятся файлы конфигурации k8s - deploy grafana и ingress для grafana\prometheus, для указания своих доменов в ingress-файлах укажите свои значения домена (hosts)и секрета (secretName).      
        - требует указать переменные и их значения в CI/CD
           DEV_USER
           DEV_HOST
           SSH_PRIVATE_KEY
           SSH_KNOWN_HOSTS
           EXTERAL_IP
           DOKERCONFIGJSON
       - После установки требуется зайти в grafana (grafana.momostoreby.site), логин по умолчанию graafana - admin:admin, до   бавить провайдера Promethheus (URL — http://trickster:8480), добавить дашборды мониторинга.
       - Задача не всегда отрабатывает с первого раза, стоит задержка в две минуты, при возникновении ошибки необходимо увеличить время задержки, а задачу можно просто перезапустить.


momostoreby.site
promet.momostoreby.site
grafana.momostoreby.site

