# IAM policy controller

Identity and Access Management (IAM) policy controller can be used to receive notifications about IAM policies that are non-compliance. The compliance check is based on the parameters that you configure in the IAM policy, and on any backend change that you did to the role bindings in your cluster.

The IAM policy controller checks for compliance of the number of cluster administrators that you allow in your cluster. IAM policy controller communicates with the local Kubernetes API server. For more information, see [Extend the Kubernetes API with CustomResourceDefinitions](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/).

The IAM policy controller runs on the hub cluster, and checks for compliance against the IAM policy that you define. IAM policy is created on your managed cluster. The IAM policy controller verifies and reports compliance of the role bindings based on the RBAC that you configure in your cluster. For more information about RBAC in Red Hat Advanced Cluster Management for Kubernetes, see [Role-based access control](security_intro.md).

<!--add policy controller YAML structure-->

## IAM policy YAML structure

```yaml
apiVersion: iam.policies.ibm.com/v1alpha1
kind: IamPolicy
metadata:
  name: iam-grc-policy
  label:
    category: "System-Integrity"
spec:
  namespaceSelector:
    include:
    exclude:
  remediationAction:
  disabled:
  maxClusterRoleBindingUsers:
  maxRoleBindingViolationsPerNamespace:
```

## IAM policy YAMl table

|Field|Description|
|-- | -- |
| apiVersion | Required. Set the value to `policy.mcm.ibm.com/v1alpha1`. <!--current place holder until this info is updated--> |
| kind | Required. Set the value to `Policy` to indicate the type of policy. |
| metadata.name | Required. The name for identifying the policy resource. |
| metadata.label | Required. <!--add explanation-->|
| metadata.category | Required. <!--add details-->|
| spec | Required. Add configuration details for your policy. |
| spec.namespaceSelector | Required. The namespaces within the hub cluster that the policy is applied to. Enter parameter values for `include`, which are the namespaces you want to apply to the policy to. `exclude` specifies the namespaces you explicitly do not want to apply the policy to. **Note**: A namespace that is specified in the object template of a policy controller overrides the namespace in the corresponding parent policy.|
| remediationAction | Optional. Specifies the remediation of your policy. Enter  `inform`. <!--we can explain what the controller does when the value is set to this-->|
| disabled | Required. Set the value to `true` or `false`. The `disabled` parameter provides the ability to enable and disable your policies.|
| spec.maxClusterRoleBindingUsers | Required. Maximum number of IAM rolebinding users that are able to create a IAM policy. <!--need to verify-->. |
| spec.maxRolebindingViolationsPerNamespace | Required. Maximum number of IAM role binding violations that are valid before a namespace is considered as non-compliant.
{: caption="Table 1. Required and optional definition fields" caption-side="top"}

Refer to [Policy controllers](policy_controllers.md) for more topics.
