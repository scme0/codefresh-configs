kind create cluster --config kind-config.yaml
# set the cluster container to never restart automatically. If we restart docker desktop, the container needs to be restarted manually.
docker update --restart=no codefresh-local-cluster-control-plane
