# Creating an Red Hat Advanced Cluster Management for Kubernetes security policy

Create a security policy to report and validate your cluster compliance based on your specified security standards, categories, and controls. To create a policy for Red Hat Advanced Cluster Management for Kubernetes, you must create a YAML file to create a policy for managed clusters.

**Required access level**: Cluster administrator 

As you create your new policy from the console, a YAML file is also created.

  - [Creating a YAML file for an Red Hat Advanced Cluster Management for Kubernetes policy](#creating-a-yaml-file-for-an-red-hat-advanced-cluster-Management-for-kubernetes-policy)
  - [Creating a cluster security policy from the Red Hat Advanced Cluster Management for Kubernetes console](#creating-a-cluster-security-policy-from-the-red-hat-advanced-cluster-management-for-kubernetes-console)

The following objects are required for your Red Hat Advanced Cluster Management for Kubernetes policy:

  *  _PlacementRule_: Defines a _cluster selector_ where the policy must be deployed.
  * _PlacementBinding_: Binds the placement to a PlacementPolicy.

View more descriptions of the policy YAML files in the [Red Hat Advanced Cluster Management for Kubernetes policy example](policy_example.md).

## Creating a YAML file for an Red Hat Advanced Cluster Management for Kubernetes policy

Complete the following steps to create a policy:

1. Create a policy by running the following command:

   ```
   kubectl create -f policy.yaml -n <namespace>
   ```

2. Define the template that the policy uses. Edit your `.yaml` file by adding a `templates` field to define a template. Your policy might resemble the following YAML file:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy1
   spec:
     remediationAction: "enforce" # or inform
     disabled: false # or true
     namespaces:
       include: ["default"]
       exclude: ["kube*"]
     role-templates:
       - apiVersion: roletemplate.mcm.ibm.com/v1alpha1
         kind: RoleTemplate
         metadata:
           namespace: kube-system # will be inferred
           name: operator
         selector:
           matchLabels:
             dev: "true"
         complianceType: "musthave" # at this level, it means the role must exist and must have the following rules
         rules:
           - complianceType: "musthave" # at this level, it means if the role exists the rule is a musthave
             policyRule:
               apiGroups: ["extensions", "apps"]
               resources: ["deployments"]
               verbs: ["get", "list", "watch", "create", "delete","patch"]
   ```

  - The `disabled` parameter provides the ability to enable and disable your policies.
  - The value _enforce_ provides automatic remediation based on the policies.
  - The value _inform_ reports whether the cluster is compliant to the specified policies.

      **Note**: For example, with `remediationAction` set to _inform_ and a policy that requires a specific role-based access control (RBAC), the policy status reports that the cluster is non-compliant if the role is not on the cluster. The policy includes the list of violations. No remediation actions are carried out in _inform_ mode.

      With `remediationAction` set to _enforce_, the Red Hat Advanced Cluster Management for Kubernetes policy manager automatically creates the missing policy on the target managed clusters.

3. Define a `PlacementRule`. Be sure to change the `PlacementRule` to specify the clusters where the policies need to be applied, either by `clusterNames`, or `clusterLabels`. View the [PlacementRule definition YAML structure](../manage_applications/managing_placement_rules.md#placement-rule-definition-yaml-structure). Your `PlacementRule` might resemble the following content:

   ```yaml
   apiVersion: apps.open-cluster-management.io/v1
   kind: PlacementRule
   metadata:
     name: placement1
   spec:
     clusterConditions:
     - type: OK
     clusterNames:
     - "cluster1"
     - "cluster2"
     clusterLabels:
       matchLabels:
         cloud: IBM
   ```

4. Define a `PlacementBinding` to bind your policy and your `PlacementRule`. Your `PlacementBinding` might resemble the following YAML sample:

   ```yaml
   apiVersion: mcm.ibm.com/v1alpha1
   kind: PlacementBinding
   metadata:
     name: binding1
   placementRef:
     name: placement1
     apiGroup: apps.open-cluster-management.io
     kind: PlacementRule
   subjects:
   - name: policy1
     apiGroup: policy.mcm.ibm.com
     kind: Policy
   ```

## Creating a cluster security policy from the Red Hat Advanced Cluster Management for Kubernetes console

1. From the navigation menu, click **Govern risk**.
2. To create a policy, click **Create policy**.
3. From the _Create policy_ page, enter the appropriate values for the following policy fields:

   * Name
   * Specifications
   * Cluster selector
   * Enforce (rememdiation action)
   * Standards
   * Categories
   * Controls

   **Note**: You can copy and paste an existing policy in to the _Policy YAML_. The values for the parameter fields are automatically entered when you paste your existing policy. You can search the contents in your policy YAML file with the search feature.

4. View the example Red Hat Advanced Cluster Management for Kubernetes security policy definition. Copy and paste the YAML file for your policy.

   **Important**: You must define a PlacementPolicy and PlacementBinding to apply your policy to a specific cluster. Enter a value for the Cluster select field to define a PlacementPolicy and PlacementBinding.

    Your YAML file might resemble the following policy:

    ```yaml
    apiVersion: policy.mcm.ibm.com/v1alpha1
    kind: Policy
    metadata:
      name: policy-pod
      annotations:
        policy.mcm.ibm.com/categories: 'SystemAndCommunicationsProtections,SystemAndInformationIntegrity'
        policy.mcm.ibm.com/controls: 'control example'
        policy.mcm.ibm.com/standards: 'NIST,HIPAA'
    spec:
      complianceType: musthave
      namespaces:
        exclude: ["kube*"]
        include: ["default"]
      object-templates:
      - complianceType: musthave
        objectDefinition:
          apiVersion: v1
          kind: Pod
          metadata:
            name: nginx1
          spec:
            containers:
            - name: nginx
              image: 'nginx:1.7.9'
              ports:
              - containerPort: 80
      remediationAction: enforce
      disabled: false

    ---
    apiVersion: mcm.ibm.com/v1alpha1
    kind: PlacementBinding
    metadata:
      name: binding-pod
    placementRef:
      name: placement-pod
      kind: PlacementRule
      apiGroup: apps.open-cluster-management.io
    subjects:
    - name: policy-pod
      kind: Policy
      apiGroup: policy.mcm.ibm.com

    ---
    apiVersion: apps.open-cluster-management.io/v1
    kind: PlacementRule
    metadata:
      name: placement-pod
    spec:
      clusterConditions:
      - type: OK
      clusterLabels:
        matchLabels:
          cloud: "IBM"
    ```

 **Important**: Be sure to add values for the `policy.mcm.ibm.com/controls` and `policy.mcm.ibm.com/standards` to display modal cards of what controls and standards are violated in the _Policy Overview_ section.

4. Click **Create Policy**.

   Your policy is enabled by default. You can disable your policy by selecting the `Disabled` check box.

A cluster policy is created.

To manage your policies, see [Managing a security policy](../governance/manage_grc_policy.md) for more information. You can also create custom policy controllers to enforce specific policies. For more information, see [Red Hat Advanced Cluster Management for Kubernetes policy controllers](../governance/policy_controllers.md).

See [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../governance/compliance_intro.md) for more information about policies.
