# printf "🏗️  - Updating chart dependencies...\n\n"
# helm dependency update ~/Documents/dev/gitops-runtime-helm/charts/gitops-runtime

printf "🏗️  - Installing codefresh runtime...\n\n"
# helm upgrade --install scotts-local-runtime \
# --create-namespace --namespace codefresh \
# --values values.yaml \
# --set global.codefresh.url="https://${NGROK_PLATFORM_DOMAIN}" \
# --set app-proxy.config.cors="http://local.codefresh.io\,https://${NGROK_PLATFORM_DOMAIN}" \
# ~/dev/gitops-runtime-helm/charts/gitops-runtime

helm upgrade --install cf-gitops-runtime \
--create-namespace --namespace codefresh-ns \
--values values.yaml \
--set global.codefresh.url="https://${NGROK_PLATFORM_DOMAIN}" \
--set app-proxy.config.cors="http://local.codefresh.io\,https://${NGROK_PLATFORM_DOMAIN}" \
oci://quay.io/codefresh/gitops-runtime

# --version 0.18.0 \