---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-24"

---

# IAM policy controller

Identity and Access Management (IAM) policy controller can be used to receive notifications about IAM policy non-compliance.
{:shortdesc}

The IAM policy controller checks for compliance of the number of cluster administrators that you allow in your cluster, and ensures parity between the IAM role-based access control (RBAC) and Kubernetes RBAC role bindings. The compliance check is based on the parameters that you configure in the IAM policy, and on any backend change that you did to the role bindings in your cluster. The IAM policy controller verifies compliance of the role bindings based on the RBAC that you configure in your cluster. The controller reports whether a role binding is compliant or not. For more information about RBAC in Red Hat Advanced Cluster Management for Kubernetes, see [Role-based access control (RBAC)](../compliance/security.md).

- You must create an IAM policy, which is a CustomResourceDefinition (CRD) instance that contains the specification of the number of cluster administrators that can be configured in your cluster, and role bindings. The controller uses this policy to verify compliance. For more information about CRDs, see [Extend the Kubernetes API with CustomResourceDefinitions](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/).

- You must add the namespaces in the policy in the `namespaceSelector.include` section for which the controller needs to verify compliance. You can also add the namespaces that you do not want the controller to verify compliance for in the `namespaceSelector.exclude` section.

- The IAM policy controller runs on the managed cluster or hub cluster, and checks for compliance against the IAM policy that you define.

## IAM policy
{: #iam-policy}

The IAM policy controller watches the namespaces that are included in the `namespaceSelector.include` section and reports whether the role binding in the namespaces and the policy itself are compliant or not.

Following is a sample IAM policy definition:
```yaml
apiVersion: iam.policies.ibm.com/v1alpha1
kind: IamPolicy
metadata:
  name: iam-grc-policy
  label:
    category: "System-Integrity"
spec:
  # Include are the namespaces for which you want to watch the cluster administrator role and IAM role bindings, while exclude are the namespaces that you explicitly do not want to watch.
  namespaceSelector:
    include: ["default","kube-*"]
    exclude: ["kube-system"]
  #labelSelector:
    #env: "production"
  # Options are `enforce` or `inform`. However, only the `inform` option is available in this release.
     remediationAction: inform # enforce or inform
  # Maximum number of cluster role bindings that are still valid before a namespace is considered as non-compliant.
     disabled: false
  maxClusterRoleBindingUsers: 5
  # Maximum number of IAM role binding violations that are still valid before a namespace is considered as non-compliant.
  maxRoleBindingViolationsPerNamespace: 2
```

## Creating an IAM policy

You can create a YAML file for your IAM policy or create an IAM policy from the console.

* [Creating a YAML file for an IAM policy](#yaml)
* [Creating an IAM policy from the console](#policy_gui)

### Creating a YAML file for an IAM policy
{: #yaml}

Complete the following steps to create an IAM policy from the command-line interface (CLI):

1. Create a YAML file with the IAM policy definition. See [IAM policy](#iam-policy).

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <iam-policy-file-name>  --namespace=<mcm_namespace>
   ```
   {: codeblock}

3. Verify and list the policy by running the following command:

   ```
   kubectl get <iam-policy-file-name> --namespace=<mcm_namespace>
   ```

### Create an IAM policy from the console
{: #policy_gui}

1. Log in to your cluster from the console.
2. From the navigation menu, click **Govern risk**.
3. Click **Create policy**.
4. Copy and paste the IAM policy definition in the **Create policy** window. See [IAM policy](#iam-policy).
5. Click **Create policy**.  

An IAM policy is created.
