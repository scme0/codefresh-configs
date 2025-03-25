printf "🏗️  - Updating chart dependencies...\n\n"
helm dependency update ~/Documents/dev/gitops-runtime-helm/charts/gitops-runtime

printf "🏗️  - Installing codefresh runtime...\n\n"
helm upgrade --install scotts-local-runtime \
--create-namespace --namespace codefresh \
--values values.yaml \
--set global.codefresh.url="https://${NGROK_PLATFORM_DOMAIN}" \
--set app-proxy.config.cors="http://local.codefresh.io\,https://${NGROK_PLATFORM_DOMAIN}" \
~/Documents/dev/gitops-runtime-helm/charts/gitops-runtime

# helm upgrade --install scotts-local-runtime \
# --create-namespace --namespace codefresh \
# --values values.yaml \
# --set global.codefresh.url="https://${NGROK_PLATFORM_DOMAIN}" \
# --set app-proxy.config.cors="http://local.codefresh.io\,https://${NGROK_PLATFORM_DOMAIN}" \
# --version 0.0.0-feat-upgrade-operator-dev \
# oci://quay.io/codefresh/gitops-runtime