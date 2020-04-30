# Secret sample

Secrets (`Secret`) are Kubernetes resources that you can use to store authorization and other sensitive information, such as passwords, OAuth tokens, and SSH keys. By storing this information as secrets, you can separate the information from the application components that require the information to improve your data security.

If you have applications that require secret resources to operate, you can use subscriptions to deploy the secrets to the managed clusters where the resources are needed.

If you have applications that require Kubernetes resources or Helm charts from channels that require authorization, such as entitled GitHub repositories, you can use secrets to provide access to these channels. You can include a reference to a secret within your subscriptions to provide your subscriptions the required credentials to access secure channels. With this access, your subscriptions can access Kubernetes resources and Helm charts for deployment from these channels while maintaining data security.

The definition structure for a secret can resemble the following YAML content:

```yaml
apiVersion: v1
kind: Secret
metadata:
  annotations:
      apps.open-cluster-management.io/deployables: "true"
  name: [secret-name]
  namespace: [channel-namespace]
data:
  AccessKeyID: [ABCdeF1=] #Base64 encoded
  SecretAccessKey: [gHIjk2lmnoPQRST3uvw==] #Base64 encoded
```

For more information about creating and managing secrets, see [Managing secrets](managing_secrets.md).