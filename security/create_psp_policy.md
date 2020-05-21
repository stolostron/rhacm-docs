# Managing pod security policies

Apply a pod security policy to secure pods and containers. Learn to create, apply, view, and update your pod security policy in the following sections.

## Creating a pod security policy 

You can create a YAML file for your pod security policy from the command line interface (CLI) or from the console. View the following sections to create a pod security policy: 

### Creating a pod security policy from the CLI

Complete the following steps to create a pod security from the CLI:

1. Create a YAML file for your pod security policy by running the following command:

   ```
   kubectl create -f podsecuritypolicy-1.yaml
   ```

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <podsecurity-policy-file-name>  --namespace=<namespace>
   ```

3. List and verify the policies by running the following command:

   ```
   kubectl get podsecuritypolicy --namespace=<namespace>
   ```

Your pod security policy is created from the CLI. 

#### Viewing your pod security policy from the CLI 

Complete the following steps to view your pod security policy from the CLI:

1. View details for a specific pod security policy by running the following command:

   ```
   kubectl get podsecuritypolicy <policy-name> -n <namespace> -o yaml
   ```

2. View a description of your pod security policy by running the following command:

   ```
   kubectl describe podsecuritypolicy <name> -n <namespace>
   ```

### Creating a pod security policy from the console

As you create a pod security policy from the console, a YAML file is also created in the YAML editor. Complete the following steps to create the pod security policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **Podsecuritypolicy** from the _Specifications_ field. Parameter values are automatically set. You can edit your values.
5. Click **Create**. 

#### Viewing your pod security policy from the console

You can view any pod security policy and its status from the console.

1. Log in to your cluster from the console.

2. From the navigation menu, click **Govern risk** to view a table list of your policies.
   **Note**: You can filter the table list of your policies by selecting the All policies tab or Cluster violations tab.

3. Select one of your policies to view more details.

4. View the policy violations by selecting the _Violations_ tab.

## Updating pod security policies

### Deleting a pod security policy

Delete the pod security policy from the CLI or the console. 

* Delete a pod security policy from the CLI:

  1. Delete a pod security policy by running the following command: <!--verify command `namespace`-->

      ```
      kubectl delete policy <podsecurity-policy-name> -n <mcm namespace>  
      ```

      After your policy is deleted, it is removed from your target cluster or clusters.

  2. Verify that your policy is removed by running the following command:

      ```
      kubectl get policy <podsecurity-policy-name> -n <mcm namespace>
      ```
      
* Delete a pod security policy from the console:

  1. From the navigation menu, click **Govern risk** to view a table list of your policies.
  2. Click the **Options** icon for the policy you want to delete in the policy violation table.
  3. Click **Remove**.
  4. From the _Remove policy_ dialog box, click **Remove policy**.

Your pod security policy is deleted.

View a sample of a pod security policy, see _Pod security policy sample_ on the [Pod security policy](memory_policy.md) page. See [Kubernetes configuration policy controller](config_policy_ctrl.md) to learn about other configuration policies. See [Manage security policies](manage_policy_overview.md) to manage other policies.
 
