# Helm Docker

A Docker image containing the Helm CLI tool, ready to be used in Kubernetes environments.

## Building the image

docker build -t rmnobarra/helm-docker:latest .

## Running locally

docker run -it --rm rmnobarra/helm-docker:latest

## Deploying to Kubernetes

kubectl apply -f kubernetes/deployment.yaml

## Usage

To use the Helm client in Kubernetes:


kubectl exec -it $(kubectl get pod -l app=helm-client -o jsonpath='{.items[0].metadata.name}') -- helm version

## To use this setup:

1. Create a new repository on GitHub called `helm-docker`
2. Clone it locally
3. Add these files to the repository
4. Build and push the Docker image
5. Apply the Kubernetes manifest

The deployment will create a pod that you can use to run Helm commands. You can exec into the pod or run commands directly using `kubectl exec`.

For example, to run a Helm command:


kubectl exec -it $(kubectl get pod -l app=helm-client -o jsonpath='{.items[0].metadata.name}') -- helm list


Remember to:
- Add appropriate RBAC if you need to give the pod permissions to install Helm charts
- Consider adding a ServiceAccount if needed
- You might want to add more tools to the Docker image depending on your needs
- Consider using specific versions instead of `latest` tag in production

Get Helm version
kubectl exec -it $(kubectl get pod -l app=helm-client -o jsonpath='{.items[0].metadata.name}') -- helm version
List Helm releases
kubectl exec -it $(kubectl get pod -l app=helm-client -o jsonpath='{.items[0].metadata.name}') -- helm list
Add a Helm repository
kubectl exec -it $(kubectl get pod -l app=helm-client -o jsonpath='{.items[0].metadata.name}') -- helm repo add bitnami https://charts.bitnami.com/bitnami
Update Helm repositories
kubectl exec -it $(kubectl get pod -l app=helm-client -o jsonpath='{.items[0].metadata.name}') -- helm repo update
Install a Helm chart
kubectl exec -it $(kubectl get pod -l app=helm-client -o jsonpath='{.items[0].metadata.name}') -- helm install my-release bitnami/nginx

3. Interactive shell access:

kubectl exec -it $(kubectl get pod -l app=helm-client -o jsonpath='{.items[0].metadata.name}') -- /bin/bash


### Common Helm Commands

Once you're inside the container or pod, you can use these common Helm commands:

Search for charts
helm search repo nginx
Get information about a chart
helm show chart bitnami/nginx
Install a chart
helm install my-release bitnami/nginx
List installed releases
helm list
Upgrade a release
helm upgrade my-release bitnami/nginx

Rollback a release
helm rollback my-release 1
Uninstall a release
helm uninstall my-release
Get release status
helm status my-release
Get release history
helm history my-release


## Notes

- The container runs with minimal permissions by default
- For production use, consider:
  - Using specific versions instead of the `latest` tag
  - Adding appropriate RBAC rules
  - Creating a dedicated ServiceAccount
  - Setting resource limits and requests
  - Adding additional security contexts

## Troubleshooting

If you encounter permission issues in Kubernetes, you may need to create appropriate RBAC rules:

Create a ServiceAccount
kubectl create serviceaccount helm-client
Create a ClusterRoleBinding (for cluster-wide access)
kubectl create clusterrolebinding helm-client --clusterrole=cluster-admin --serviceaccount=default:helm-client


## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details