# Managing memory usage policies 

Apply a memory usage policy to limit or restrict your memory and compute usage. Learn to create, apply, view, and update your memory usage policy in the following sections.

## Creating a memory usage policy 

You can create a YAML file for your memory usage policy from the command line interface (CLI) or from the console. View the following sections to create a memory usage policy: 

### Creating a memory usage policy from the CLI

Complete the following steps to create a memory usage policy from the CLI:

1. Create a YAML file for your memory usage policy by running the following command:

   ```
   kubectl create -f memorypolicy-1.yaml
   ```

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <memory-policy-file-name>  --namespace=<namespace>
   ```

3. List and verify the policies by running the following command:

   ```
   kubectl get memorypolicy --namespace=<namespace>
   ```

Your memory usage policy is created from the CLI. 

#### Viewing your policy from the CLI 

Complete the following steps to view your memory usage policy from the CLI:

1. View details for a specific memory usage policy by running the following command:

   ```
   kubectl get memorypolicy <policy-name> -n <namespace> -o yaml
   ```

2. View a description of your memory usage policy by running the following command:

   ```
   kubectl describe memorypolicy <name> -n <namespace>
   ```

### Creating an memory usage policy from the console

As you create a memory usage policy from the console, a YAML file is also created in the YAML editor. Complete the following steps to create the memory usage policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Governance and risk**. 
3. Click **Create policy**. 
4. Select **Limitrange** from the _Specifications_ field. Parameter values are automatically set. You can edit your values.
5. Click **Create**.

#### Viewing your memory usage policy from the console

You can view any memory usage policy and its status from the console.

1. Log in to your cluster from the console.

2. From the navigation menu, click **Govern risk** to view a table list of your policies.
   
   **Note**: You can filter the table list of your policies by selecting the All policies tab or Cluster violations tab.

3. Select one of your policies to view more details.

4. View the policy violations by selecting the _Violations_ tab.

## Updating memory usage policies

Learn to update memory usage policies by viewing the following section.

### Disabling memory usage policies

Complete the following steps to disable your memory usage policy:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

2. From the navigation menu, click **Govern risk** to view a table list of your policies.

3. Disable your policy by clicking the **Options** icon > **Disable**. The _Disable Policy_ dialog box appears.

4. Click **Disable policy**.

Your policy is disabled.

### Deleting a memory usage policy

Delete the memory usage policy from the CLI or the console. 

* Delete a memory usage policy from the CLI:

  1. Delete a memory usage policy by running the following command: <!--verify command `namespace`-->

      ```
      kubectl delete policy <memorypolicy-name> -n <mcm namespace>  
      ```

      After your policy is deleted, it is removed from your target cluster or clusters.

  2. Verify that your policy is removed by running the following command:

      ```
      kubectl get policy <memorypolicy-name> -n <mcm namespace>
      ```
      
* Delete a memory usage policy from the console:

  1. From the navigation menu, click **Govern risk** to view a table list of your policies.
  2. Click the **Options** icon for the policy you want to delete in the policy violation table.
  3. Click **Remove**.
  4. From the _Remove policy_ dialog box, click **Remove policy**.

Your memory usage policy is deleted.

View a sample of a memory usage policy, see _Memory usage policy sample_ from the [Memory usage policy](memory_policy.md) page. See [Kubernetes configuration policy controller](config_policy_ctrl.md) to learn about other configuration policies. See [Manage security policies](manage_policy_overview.md) to manage other policies.
