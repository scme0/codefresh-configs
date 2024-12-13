This is my configuration for running a gitops runtime in a local Kind cluster - bootstrapping from 1password.

To use a similar setup, you should do the following on your personal 1password account:
1. Add a new vault called "Kubernetes"
2. configure a 1password connect server
3. upload the generated 1password-credentials.json file as a document to your new vault with the name "k8s-home-credentials-file"
4. Add a new entry called "github-local-dev" with entries named "pat" for your runtime github pat and "userToken" for your local instance codefresh user token.
5. Install 1password macos app and the 1password cli.
6. Go to 1password app -> Settings -> Developer and check "Integrate with 1Password CLI"
5. ensure that the paths in the scripts match your local setup (path to gitops-runtime-helm repo in `install-gitops-runtime.sh` is probably not right for you)
6. Make sure your local instance is running!
7. Run `create-and-bootstrap-cluster.sh`

Note: You can change the name of the vault and the 1password entries, but you'll have to update it in the scripts where it's referenced.