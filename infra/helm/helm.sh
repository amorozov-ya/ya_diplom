#!/bin/bash
helm repo add nexus ${NEXUS_REPO_URL_HELM} --username ${NEXUS_REPO_USER} --password ${NEXUS_REPO_PASS} || true
helm repo update || true
helm upgrade --install momo-store \
      --set environment=test \
      --atomic --timeout 15m \
      momo-store/momo-store 
