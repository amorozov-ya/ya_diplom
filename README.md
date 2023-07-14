<img width="900" alt="image" src="https://user-images.githubusercontent.com/9394918/167876466-2c530828-d658-4efe-9064-825626cc6db5.png">

## Frontend

```bash
npm install
NODE_ENV=production VUE_APP_API_URL=http://localhost:8081 npm run serve
```

## Backend

```bash
go run ./cmd/api
go test -v ./... 
```

Пайплан собирает  фронт (nodejs), бэк (golang), создает инфраструктуру в яндексОблаке с последующим разворачиванием приложения.
Не все действия прямо связанны между собой. 
Дополнительное описание смотрите в файле README.md расположенный в директориях модулей frontend/backend
Порядок выполнения job:
1. infrastructure -> deploy_terraform
2. infrastructure -> deploy_yc_k8s
3. infrastructure -> helm-repo-update
4. frontend -> build -> test (sast\postman) -> upload-frontend-latest -> helm-repo-update (manual) -> notify - deploy (manual)
5. backend  -> build -> test (sast\postman) -> upload-backend-latest -> helm-repo-update (manual) -> notify - deploy (manual)
Примечание:
helm-repo-update - запускать в ручном режиме, один за раз(либо fronend после backend, либо backend после frontend)



Переменные:
VERSION  - Версия сборки (1.0.${CI_PIPELINE_ID})
URL_TELEGRAMM - url телеграмм бота
TF_VAR_token - токен для терраформа (job:deploy_terraform)
SSH_PRIVATE_KEY - приватный ключ для доступа к АРМ пользователя
SSH_KNOWN_HOSTS - разрешенные хосты для подключения
SONARQUBE_URL - SonarQube url для возможности тестирования кода
SONAR_PROJECT_KEY_FRONT - SonarQube ключ для возможности тестирования кода фронтэнда
SONAR_PROJECT_KEY_BACK - SonarQube ключ для возможности тестирования кода бэкэнда
SONAR_LOGIN_FRONT - SonarQube ключ для возможности тестирования кода фронтенда
SONAR_LOGIN_BACK - SonarQube ключ для возможности тестирования кода бэкэнда
NEXUS_REPO_USER - пользователь Nexus для хранения Helm charts
NEXUS_REPO_URL_HELM - url Nexus для хранения Helm charts
NEXUS_REPO_PASS - пароль Nexus для хранения Helm charts
EXTERAL_IP - внешний IP для nginx loadbalancer, появляется после выполнения job:deploy_terraform, поле ip_ingress
DEV_USER - пользователь АРМ
DEV_HOST - IP адрес АРМ
CONTENT_TYPE - тип контента для сообщения Телеграмм
DOKERCONFIGJSON - секрет для подключения к ContinerRegistry GIT

Version:
k8s - client (1.26) and server (1.23)
Helm - v3.11.2
Terraform -  v1.1.4
yc  - Yandex Cloud CLI 0.104.0

