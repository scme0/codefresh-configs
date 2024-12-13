kubectl config use-context kind-codefresh-local-cluster

RELEASE_NAME=$(helm ls -n codefresh -q) && helm uninstall ${RELEASE_NAME} -n codefresh

kind delete cluster --name codefresh-local-cluster
