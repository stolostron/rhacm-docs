# Managing configuration policies

Learn to create, apply, view, and update your configuration policies.

## Creating a configuration policy 

You can create a YAML file for your configuration policy from the command line interface (CLI) or from the console. View the following sections to create a configuration policy:

### Creating a configuration policy from the CLI

Complete the following steps to create a configuration policy from the (CLI):

1. Create a YAML file for your configuration policy. Run the following command:

   ```
   kubectl create -f configpolicy-1.yaml
   ```

     Your configuration policy might resemble the following policy:

     ```yaml
     apiVersion: policy.mcm.ibm.com/v1alpha1
     kind: Policy
     metadata:
       name: policy-1
       namespace: kube-system
     spec:
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

#### Viewing your configuration policy from the CLI

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

As you create a configuration policy from the console, a YAML file is also created in the YAML editor. Complete the following steps to create a configuration policy from the console:

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk**.
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

#### Viewing your configuration policy from the console

You can view any configuration policy and its status from the console.

1. Log in to your cluster from the console.

2. From the navigation menu, click **Govern risk** to view a table list of your policies.
   
   **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab.

3. Select one of your policies.

4. View the policy violations by selecting the _Violations_ tab.

## Updating configuration policies

### Disabling configuration policies

Complete the following steps to disable your policy: <!--add steps to disable from the CLI if available-->

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

2. From the navigation menu, click **Govern risk** to view a table list of your policies.

3. Disable your policy by clicking the **Options** icon > **Disable**. The _Disable Policy_ dialog box appears.

4. Click **Disable policy**.

Your policy is disabled.

## Deleting a configuration policy

Delete a configuration policy from the CLI or the console.

* Delete a configuration policy from the CLI:

  1. Delete a configuration policy by running the following command:

    ```
    kubectl delete policy <policy-name> -n <mcm namespace>  
    ```

    After your policy is deleted, it is removed from your target cluster or clusters.

  2. Verify that your policy is removed by running the following command:

    ```
    kubectl get policy <policy-name> -n <mcm namespace>
    ```

* Delete a configuration policy from the console:

  1. From the navigation menu, click **Govern risk** to view a table list of your policies.
  2. Click the **Options** icon for the policy you want to delete in the policy violation table.
  3. Click **Remove**.
  4. From the _Remove policy_ dialog box, click **Remove policy**.

Your policy is deleted.

View configuration policy samples, see [Policy samples](policy_sample_intro.md). See [Manage security policies](manage_policy_overview.md) to manage other policies. 
