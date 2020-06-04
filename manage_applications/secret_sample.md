# Secret samples

Secrets (`Secret`) are Kubernetes resources that you can use to store authorization and other sensitive information, such as passwords, OAuth tokens, and SSH keys. By storing this information as secrets, you can separate the information from the application components that require the information to improve your data security. For more information about secrets, see [Managing secrets](managing_secrets.md).

The definition structure for a secret can resemble the following YAML content:

## Secret YAML structure

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
