#!/bin/bash
cd ./tf-momo-store
terraform init
terraform plan
terraform apply -auto-approve
cd /home/${DEV_USER}/
rm -r  tf-momo-store