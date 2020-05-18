# Troubleshooting application Kubernetes deployment version

A managed cluster with a deprecated Kubernetes 1.16 version might not be supported. See the [Kubernetes issue](https://kubernetes.io/blog/2019/07/18/api-deprecations-in-1-16/) for more details.

## Symptom: Application deployment version

You might see an error similar to the following:

```
failed to install release: unable to build kubernetes objects from release manifest: unable to recognize "": no matches for
kind "Deployment" in version "extensions/v1beta1"
```

Or with new Kubernetes API version in your YAML file named `old.yaml` for instance, you might receive:

```
error: unable to recognize "old.yaml": no matches for kind "Deployment" in version "deployment/v1beta1"
```

## Resolving the problem: Application deployment version

1. If the current version of Kubernetes API fails, enter the previous version. For example, see the following YAML entry:

2. Validate?
