terraform {
  required_version = ">= 1.1.4" 
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.84.0"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "momo-terra"
    region     = "ru-central1"
    key        = "terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}