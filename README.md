# Momo Store aka Пельменная №2

# Данный пайпплан создает инфраструктуру в YandexCloud, разворачивает на ней k8s кластер, приложение Пельменная №2 (frontend + backend), сервисы мониторинга и nginx-ingress controller необходимый для подлючение из вне к магазину и сервисам по заранее определенным адресам, VPA.

# Пайплан модульный, состоит из трех частей:
# 1. Frontend с отслеживанием изменений (задачи связанные со сборкой, тестированием, сохранением и разворачиванием  фронтенда сосисочной).
# 2. Backend с отслеживанием изменений(задачи связанные со сборкой, тестированием, сохранением и разворачиванием  бэкэнда сосисочной).
# 3. Infrastructure с отслеживанием изменений(задачи связанные с разворачиванием,  настройкой и мониторингом инфраструктуры в YandexCloud).

# Модули имеют свое, дополнительное описание.
# Все артефакты версионируются и хранятся в GitRegistry (dockerImages) и Nexus (helmChart)
# Работа скриптов, периодично,  происходит через взаимодействия Git и АРМ пользователя, с необходимым ПО (terraform, yc, git, helm, k8s)

# 1. Для работы необходимо заранее зарегистрировать домен
# 2. Завести аккаунт  на YandexCloud
# 3. Внести платежные данные, пополнить баланс.
# 4. Создать каталог.
# 5. Перевести зарегистрированный домен в Яндекс (ns1.yandexcloud.net. , ns2.yandexcloud.net.)
# 6. Создать сертификат Let's Encrypt (Certificate Manager - добавить сертификат) для зарегистрированного домена (example.com, *.example.com), подтвердить права на домен.
# 7. Создать сервисный аккаут на YandexCloud  с правами admin
# 8. Завести bucket (для хранения состояния terraform и статики приложения, имя bucket заменить в provider.tf - backend"s3".bucket)
# 9. Создать\получить токент для Terrafrom.
#       - установить yc (curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash)
#       - инициализировать yc init (Update https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb)
#       - создать постоянный ключ для аккаунта yc iam key create --service-account-name astore --output /home/student/.ssh/key.json
#       - задать созданный ранее ключ yc config set service-account-key /home/student/.ssh/key.json
#       - создать токен yc iam create-token       
# 10. Добавить необходимые переменные в GitLab CI/CD
# 11. После выполнения инфраструктурного модуля необходимо создать, в вебке YandexCloud, А-записи домена и поддоменов.
#
#

# Переменные:
# VERSION  - Версия сборки (1.0.${CI_PIPELINE_ID})
# URL_TELEGRAMM - url телеграмм бота
# TF_VAR_token - токен для терраформа (job:deploy_terraform)
# SSH_PRIVATE_KEY - приватный ключ для доступа к АРМ полльзователя
# SSH_KNOWN_HOSTS - разрешенные хосты для подключения
# SONARQUBE_URL - SonarQube url для возможности тестирования кода
# SONAR_PROJECT_KEY_FRONT - SonarQube ключ для возможности тестирования кода фронтэнда
# SONAR_PROJECT_KEY_BACK - SonarQube ключ для возможности тестирования кода бэкэнда
# SONAR_LOGIN_FRONT - SonarQube ключ для возможности тестирования кода фронтенда
# SONAR_LOGIN_BACK - SonarQube ключ для возможности тестирования кода бэкэнда
# NEXUS_REPO_USER - пользователь Nexus для хранения Helm charts
# NEXUS_REPO_URL_HELM - url Nexus для хранения Helm charts
# NEXUS_REPO_PASS - пароль Nexus для хранения Helm charts
# EXTERAL_IP - внещний IP для nginx loadbalancer, появдяется после выполнения job:deploy_terraform, поле ip_ingress
# DEV_USER - пользователь АРМ
# DEV_HOST - IP адресс АРМ
# CONTENT_TYPE - тип контента для сообщения Телеграмм
# DOKERCONFIGJSON - секрет для подключения к ContinerRegistry GIT

# Version:
# k8s - client (1.26) and server (1.23)
# Helm - v3.11.2
# Terraform -  v1.1.4
# yc  - Yandex Cloud CLI 0.104.0


# Не все действия прямо связанны между собой. 
# Дополнительное описание смотрите в файле README.md расположенный в дирректориях моудлей frontend/backend
# Порядок выполнения job:
#  1. infrastructure -> deploy_terraform
#  2. infrastructure -> deploy_yc_k8s
#  3. infrastructure -> helm-repo-update
#  3. frontend -> build -> test (sast\postman) -> upload-frontend-latest -> helm-repo-update (manual) -> notify - deploy (manual)
#  4. backend  -> build -> test (sast\postman) -> upload-backend-latest -> helm-repo-update (manual) -> notify - deploy (manual)
# Примечание:
# helm-repo-update - запускать в ручном режиме, один за раз(либо fronend после backend, либо backend после frontend)