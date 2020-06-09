# Configuring package overrides

Configure package overrides for a subscription override value for the Helm chart or Kubernetes resource that is subscribed to by the subscription.

To configure a package override, specify the field within the Kubernetes resource spec to override as the value for the `path` field. Specify the replacement value as the value for the `value` field.

For example, if you need to override the values field within the spec for a Helm release for a subscribed Helm chart, you need to set the value for the `path` field in your subscription definition to `spec`. 

```
packageOverrides:
- packageName: nginx-ingress
  packageOverrides:
  - path: spec
    value: my-override-values
```

The contents for the `value` field are used to override the values within the `spec` field of the `HelmRelease` spec.

* For a Helm release, override values for the `spec` field are merged into the Helm release `values.yaml` file to override the existing values. This file is used to retrieve the configurable variables for the Helm release.

* If you need to override the release name for a Helm release, include the `packageOverride` section within your definition. Define the `packageAlias` for the Helm release by including the following fields:

  * `packageName` to identify the Helm chart.
  * `packageAlias` to indicate that you are overriding the release name.

   By default, if no Helm release name is specified, the Helm chart name is used to identify the release. In some cases, such as when there are multiple releases subscribed to the same chart, conflicts can occur. The release name must be unique among the subscriptions within a namespace. If the release name for a subscription that you are creating is not unique, an error occurs. You must set a different release name for your subscription by defining a `packageOverride`. If you want to change the name within an existing subscription, you must first delete that subscription and then recreate the subscription with the preferred release name.

  ```
  packageOverrides:
  - packageName: nginx-ingress
    packageAlias: my-helm-release-name
  ```
