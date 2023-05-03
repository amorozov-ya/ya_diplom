# monitoring

Установка fronend, backend Momo-store
helm upgrade --install momo-store  momo-store --namespace momo-store


* Создается ingress "nginx" - хост по умолчанию  momostoreby.site

Структура чартов

|-- momo-store
|   |-- Chart.yaml
|   |-- README.md
|   |-- charts
|   |   |-- backend
|   |   |   |-- Chart.yaml
|   |   |   `-- templates
|   |   |       |-- _helpers.tpl
|   |   |       |-- deployment.yaml
|   |   |       |-- service.yaml
|   |   |       `-- vpa.yaml
|   |   `-- frontend
|   |       |-- Chart.yaml
|   |       |-- templates
|   |       |   |-- NOTES.txt
|   |       |   |-- _helpers.tpl
|   |       |   |-- configmap.yaml
|   |       |   |-- deployment.yaml
|   |       |   |-- ingress.yaml
|   |       |   `-- service.yaml
|   |       `-- tests
|   |           `-- test-connections.yaml
|   `-- values.yaml
