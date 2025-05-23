printf "🏗️  - Signing into 1password cli...\n\n"
eval $(op signin)

printf "🏗️  - Installing 1password operator...\n\n"
op read --out-file ./1password-credentials.json op://Kubernetes/k8s-home-credentials-file/1password-credentials.json
if [ $? -ne 0 ]; then
  echo ""
  echo ""
  echo "❗  - Failed to get 1password-credentials. Aborting."
  rm ./1password-credentials.json
  exit -1
fi

token=`op read op://Kubernetes/k8s-home-access-token/credential`
if [ $? -ne 0 ]; then
  echo ""
  echo ""
  echo "❗  - Failed to get 1password token. Aborting."
  rm ./1password-credentials.json
  exit -1
fi

helm repo add 1password https://1password.github.io/connect-helm-charts
if [ $? -ne 0 ]; then
  echo ""
  echo ""
  echo "❗  - Failed to add 1password helm repo. Aborting."
  rm ./1password-credentials.json
  exit -1
fi

helm install connect 1password/connect --set-file connect.credentials=./1password-credentials.json --set operator.create=true --set operator.token.value="$token" --set connect.serviceType=ClusterIP
if [ $? -ne 0 ]; then
  echo ""
  echo ""
  echo "❗  - Failed to add 1password operator to cluster. Aborting."
  rm ./1password-credentials.json
  exit -1
fi

printf "🏗️  - Cleaning up 1password credentials file...\n\n"
rm ./1password-credentials.json

printf "🏗️  - Adding codefresh token secret manually for boothstrapping...\n\n"
kubectl create namespace codefresh-ns
kubectl apply -f github-local-dev-op.yaml
if [ $? -ne 0 ]; then
  echo ""
  echo ""
  echo "❗  - Failed to add secret. Aborting."
  exit -1
fi

printf "🏗️  - Waiting for 1password secret to generate...\n\n"
counter=0
kubectl get secret github-local-dev -n codefresh-ns
while [ $? -ne 0 ]; do
  ((counter++))
  if [ $counter -gt 15 ]; then
    echo ""
    echo ""
    echo "❗  - Secret failed to generate. Aborting."
    exit -1
  fi
  sleep 5
  kubectl get secret github-local-dev -n codefresh-ns
done
