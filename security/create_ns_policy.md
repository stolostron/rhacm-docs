# Managing namespace policies

Namespace policies are applied to define specific rules for your namespace. Learn to create, apply, view, and update your memory usage policy in the following sections.


## Creating a namespace policy 

You can create a YAML file for your namespace policy from the command line interface (CLI) or from the console. View the following sections to create a namespace policy: 

### Creating a namespace policy from the CLI

Complete the following steps to create a namespace policy from the CLI:

1. Create a YAML file for your namespace policy by running the following command:

   ```
   kubectl create -f namespacepolicy-1.yaml
   ```

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <namespace-policy-file-name>  --namespace=<namespace>
   ```

3. List and verify the policies by running the following command:

   ```
   kubectl get namespacepolicy --namespace=<namespace>
   ```

Your namespace policy is created from the CLI. 

#### Viewing your namespace policy from the CLI 

Complete the following steps to view your namespace policy from the CLI:

1. View details for a specific namespace policy by running the following command:

   ```
   kubectl get namespacepolicy <policy-name> -n <namespace> -o yaml
   ```

2. View a description of your namespace policy by running the following command:

   ```
   kubectl describe namespacepolicy <name> -n <namespace>
   ```

### Creating a namespace policy from the console

As you create a namespace policy from the console, a YAML file is also created in the YAML editor. Complete the following steps to create a namespace policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Governance and risk**. 
3. Click **Create policy**. 
4. Select **Namespace** from the _Specifications_ field. Parameter values are automatically set. You can edit your values.
5. Click **Create**.

#### Viewing your namespace policy from the console

You can view any namespace policy and its status from the console.

1. Log in to your cluster from the console.

2. From the navigation menu, click **Governance and risk** to view a table list of your policies.

  **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab.

3. Select one of your policies to view more details.

4. View the policy violations by selecting the _Violations_ tab.

## Updating namespace policies

### Deleting a namespace policy

Delete a namespace policy from the CLI or the console. 

* Delete a namespace policy from the CLI:

  1. Delete a namespace policy by running the following command: <!--verify command `namespace`-->

      ```
      kubectl delete policy <memorypolicy-name> -n <mcm namespace>  
      ```

      After your policy is deleted, it is removed from your target cluster or clusters.

  2. Verify that your policy is removed by running the following command:

      ```
      kubectl get policy <memorypolicy-name> -n <mcm namespace>
      ```
      
* Delete a namespace policy from the console:

  1. From the navigation menu, click **Govern risk** to view a table list of your policies.
  2. Click the **Options** icon for the policy you want to delete in the policy violation table.
  3. Click **Remove**.
  4. From the _Remove policy_ dialog box, click **Remove policy**.

Your namespace policy is deleted.

View a sample of a namespace policy, see _Namespace policy sample_ on the [Namespace policy page](namespace_policy.md). See [Kubernetes configuration policy controller](config_policy_ctrl.md) to learn about other configuration policies. See [Manage security policies](manage_policy_overview.md) to manage other policies.
