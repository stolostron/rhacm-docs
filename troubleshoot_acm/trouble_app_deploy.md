# Troubleshooting application Kubernetes deployment version

A managed cluster with a deprecated Kubernetes `apiversion` might not be supported. See the [Kubernetes issue](https://kubernetes.io/blog/2019/07/18/api-deprecations-in-1-16/) for more details about the deprecated API version.

## Symptom: Application deployment version

You might see an error similar to the following if one or more of your application resources use the deprecated API:

```
failed to install release: unable to build kubernetes objects from release manifest: unable to recognize "": no matches for
kind "Deployment" in version "extensions/v1beta1"
```

Or with new Kubernetes API version in your YAML file named `old.yaml` for instance, you might receive the following error:

```
error: unable to recognize "old.yaml": no matches for kind "Deployment" in version "deployment/v1beta1"
```

## Resolving the problem: Application deployment version

1. Update the `apiVersion` in the resource. For example, if the error displays for _Deployment_ YAML, you need to update the `apiVersion` from `extensions/v1beta1` to `apps/v1`.

  See the following example:
  
  ```
  apiVersion: apps.open-cluster-management.io/v1
  kind: Deployable
  ```

2. Verify the available versions by running the following command:

  ```
  kubectl explain <resource>
  ```
  Check for `VERSION`.
