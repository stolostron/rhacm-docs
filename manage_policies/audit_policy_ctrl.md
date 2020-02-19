---

copyright:
  years: 2019, 2020
lastupdated: "2020-02-19"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Audit logging policy controller

The audit logging policy verifies whether audit logging is enabled for key services in your cluster.  
{:shortdesc}

Audit logging policy controller can be used to verify the compliance of audit logging policy rules for certain key services. The audit logging policy controller is enabled by default, and runs on the hub cluster or any managed cluster.

- You must create an audit logging policy, which is a CustomResourceDefinition (CRD) instance that contains the audit logging policy rules that you define. The audit logging policy controller runs on the hub cluster or a managed cluster, and checks for compliance against the audit logging policy. For more information about CRDs, see [Extend the Kubernetes API with CustomResourceDefinitions ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://v1-13.docs.kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/).

- The audit logging controller validates the value of the `audit_enabled` parameter in the configmap that is associated with a service. If the audit logging policy rule specifies the rule for a service as `validate`, the audit logging controller checks the audit configuration for the service and reports it as compliant. If the audit logging policy rule specifies the rule for a service as `ignore`, the audit logging controller does not check the audit configuration of the service. The audit policy controller supports verification of the audit configuration of the Kubernetes API server.

## Audit logging policy
{: #audit-policy}

In {{site.data.keyword.cloud_pak_mcm}}, each service runs as a container. The audit logging policy contains the list of containers for which audit logging compliance needs to be checked. The policy can include any service that runs in your cluster. You can configure the logging level for each service.

Following is a sample audit policy definition:

```yaml
apiVersion: audit.policies.ibm.com/v1alpha1
kind: AuditPolicy # Verify if audit is enabled
metadata:
  name: iam-audit-policy-example
  label:
    category: "System-Integrity"
spec:
  severity: low
  namespaceSelector:
    include: ["default", "kube-*"]
    exclude: ["kube-public"]
  clusterAuditPolicy:
    auditPolicyRules:
      "kubernetes": ignore
      "platform-api": validate
      "helmapi": validate
      "platform-identity-manager": validate
      "platform-identity-provider": validate
      "vulnerability-advisor": validate
  remediationAction: inform # enforce or inform
  disabled: false
```
{: codeblock}

**Note:** `kubernetes` is the container name of the Kubernetes API server.

### Audit logging policy elements

In the `namespaceSelector.include` section, you can specify the namespaces that the controller must watch. Use the `namespaceSelector.exclude` section to specify the namespaces that the controller must ignore.

In the `auditPolicyRules` section, you must add the container names of the services for which logging compliance must be checked. Add `"<container-name>": [validate|ignore]` for each container. You can set the following logging level by using the `remediationAction` parameter:

  - Set to `enforce` to fix the gap as reported by the compliance check.
  - Set to `inform` to only report whether the services are compliant or not.

    When you set the `auditPolicyRules` for a service as `validate`, and you set the `remediationAction` as `enforce`, the controller checks the `AUDIT_ENABLED` parameter value that is set in the configmap of the container. If the parameter value is set to `true`, the controller reports the service as compliant. If the parameter value is set to `false`, the controller reports the service as non-compliant and updates the parameter value to `true` in the configmap. However, the updated value reflects in the container only after the container restarts. The controller does not restart the container after it updates the parameter value.  

    **Note:** For the `kubernetes` service, the `enforce` option has no effect. Even if `remediationAction: enforce` is set, the controller only reports the compliance status, and does not fix the gap in compliance.

**Note:** For Kubernetes API server, the controller checks the `audit-policy-file` flag to verify compliance.


## Creating an audit logging policy

You can create a YAML file for your audit logging policy or create an audit logging policy from the {{site.data.keyword.gui}}.

* [Creating a YAML file for an audit logging policy](#yaml)
* [Creating an audit logging policy from the {{site.data.keyword.gui}}](#policy_gui)

### Creating a YAML file for an audit logging policy
{: #yaml}

Complete the following steps to create an audit logging policy from the command-line interface (CLI):

1. Create a YAML file with the audit logging policy definition. See [Audit policy](#audit-policy).

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <audit-logging-policy-file-name>  --namespace=<mcm_namespace>
   ```
   {: codeblock}

3. Verify and list the policy by running the following command:

   ```
   kubectl get <audit-logging-policy-file-name> --namespace=<mcm_namespace>
   ```
   {: codeblock}


### Create an audit logging policy from the {{site.data.keyword.gui}}
{: #policy_gui}

1. Log in to your cluster from the {{site.data.keyword.gui}}.
2. From the navigation menu, click **Govern risk**.
3. Click **Create policy**.
4. Edit the audit policy definition in the **Create policy** window. See [Audit policy](#audit-policy).
  - Specify the `Cluster Selector`, `Standards`, `Categories`, and `Controls`.
  - Define the audit policy rules for each service that you want to validate.
  - Specify the remediation action.
5. Click **Create policy**.  

An audit logging policy is created.

## Getting the container names

To get the container names, run the following command. You need `kubectl` to run the command. For more information about installing `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).
  ```
  kubectl get pods -n <namespace> -o json | jq '.items[].spec.containers[].name' | grep -v null | sort | uniq
  ```
  {: codeblock}

Following is a sample output from the `kube-system` namespace:
```
"catalog-ui"
"grafeas"
"hcm-ui"
"hcm-ui-api"
"helmapi"
"helm-repo"
"image-manager"
"platform-api"
"platform-auth-service"
"platform-header"
"platform-identity-manager"
"platform-identity-provider"
"platform-ui
```
{: pre}
