./create-cluster.sh

if [ $? -ne 0 ]; then
  echo ""
  echo ""
  echo "❗  - Failed to create cluster. Aborting."
  exit -1
fi

./setup-one-password-operator.sh

if [ $? -ne 0 ]; then
  echo ""
  echo ""
  echo "❗  - Failed to setup 1password operator. Aborting."
  exit -1
fi

./install-gitops-runtime.sh

if [ $? -ne 0 ]; then
  echo ""
  echo ""
  echo "❗  - Failed to setup gitops runtime. Aborting."
  exit -1
fi

printf "🏗️  - Done 🎉\n\n"
