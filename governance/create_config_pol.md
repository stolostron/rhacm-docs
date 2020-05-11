# Managing a configuration policy 

Learn to create, apply, update, and view your configuration policies.

## Creating a configuration policy 

You can create a YAML file for your configuration policy or create a configuration policy from the console. View the following sections to create a configuration policy:

### Creating a YAML file for a configuration policy

Complete the following steps to create a configuration policy from the command line interface (CLI):

1. Create a YAML file for your configuration policy. Run the following command:

  ```
  kubectl create -f policy-1.yaml
  ```


  Your configuration policy might resemble the following policy:

    ```yaml
    apiVersion: policy.mcm.ibm.com/v1alpha1
    kind: Policy
    metadata:
      name: policy-1
      namespace: kube-system
    spec:
    # "include" are parameter values of the namespaces you want to apply the configuration policy , while exclude specifies the namespaces you explicitly do not want to apply
      namespaces:
        include: ["default", "kube-*"]
        exclude: ["kube-system"]
      remediationAction: inform
      disabled: false
      complianceType: musthave
      object-templates:
       ...
     ```

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <policy-file-name>  --namespace=<namespace>
   ```

3. Verify and list the policies by running the following command:

   ```
   kubectl get policy --namespace=<namespace>
   ```

Your configuration policy is created.

#### Viewing your configuration policy

Complete the following steps to view your configuration policy from the CLI:

1. View details for a specific configuration policy by running the following command:

   ```
   kubectl get policy <policy-name> -n <namespace> -o yaml
   ```

2. View a description of your configuration policy by running the following command:

   ```
   kubectl describe policy <name> -n <namespace>
   ```

### Creating a configuration policy from the console

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk**
3. Click **Create policy**.
4. Enter or select the appropriate values for the following fields:
   * Name
   * Namespace
   * Specifications
   * Cluster selector
   * Remediation action
   * Standards
   * Categories
   * Controls
   * Disabled

5. Click **Create**.



#### View your configuration policy

You can view any configuration policy and its status from the console.

1. Log in to your cluster from the console.
2. From the navigation menu, click **Govern risk** to view a table list of your policies.

   **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab.
3. Select one of your policies.

See [Manage security policies](manage_policy_overview.md) to manage other policies. View policy samples of policies that are checked by the configuration policy controller, see [Policy samples](policy_sample_intro.md).