# Managing pod nginx policies

Kubernetes configuration policy controller monitors the status of you pod nginx policies. Pod nginx policies are applied to to define the container rules for your pods. Learn to create, apply, view, and update your pod nginx policy.

## Creating a pod nginx policy

You can create a YAML for your pod nginx policy from the command line interface (CLI) or from the console. View the following sections to create a pod nginx policy:

### Creating a pod nginx policy from the CLI

Complete the following steps to create a pod nginx policy from the CLI:

1. Create a YAML file for your pod nginx policy by running the following command:

   ```
   kubectl create -f podnginxpolicy-1.yaml
   ```

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <podnginx-policy-file-name>  --namespace=<namespace>
   ```

3. List and verify the policies by running the following command:

   ```
   kubectl get podnginxpolicy --namespace=<namespace>
   ```

Your image pod nginx policy is created from the CLI.

#### Viewing your nginx policy from the CLI 

Complete the following steps to view your pod nginx policy from the CLI:

1. View details for a specific pod nginx policy by running the following command:

   ```
   kubectl get podnginxpolicy <policy-name> -n <namespace> -o yaml
   ```

2. View a description of your pod nginx policy by running the following command:

   ```
   kubectl describe podnginxpolicy <name> -n <namespace>
   ```

## Creating an pod nginx policy from the console

As you create a pod nginx policy from the console, a YAML file is also created in the YAML editor. Complete the following steps to create the pod nginx policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Govern risk**.
3. Click **Create policy**.
4. Select **Pod** from the _Specifications_ field. Parameter values are automatically set. You can edit your values.
5. Click **Create**.

#### Viewing your pod nginx policy from the console

You can view any pod nginx policy and its status from the console.

1. Log in to your cluster from the console.

2. From the navigation menu, click **Govern risk** to view a table list of your policies.

  **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab.

3. Select one of your policies to view more details.

4. View the policy violations by selecting the _Violations_ tab.

## Updating pod nginx policies

### Deleting a pod nginx policy

Delete the pod nginx policy from the CLI or the console.

* Delete a pod nginx policy from the CLI:

  1. Delete a pod nginx policy by running the following command: <!--verify command `namespace`-->

      ```
      kubectl delete policy <podnginxpolicy-name> -n <mcm namespace>  
      ```

      After your policy is deleted, it is removed from your target cluster or clusters.

  2. Verify that your policy is removed by running the following command:

      ```
      kubectl get policy <podnginxpolicy-name> -n <mcm namespace>
      ```

* Delete a pod nginx policy from the console:

  1. From the navigation menu, click **Govern risk** to view a table list of your policies.
  2. Click the **Options** icon for the policy you want to delete in the policy violation table.
  3. Click **Remove**.
  4. From the _Remove policy_ dialog box, click **Remove policy**.

Your pod nginx policy is deleted.

View a sample of a pod nginx policy, see _Pod nginx policy sample_ on the [Pod nginx sample](pod_nginx_policy.md). See [Kubernetes configuration policy controller](config_policy_ctrl.md) to learn about other configuration policies. See [Manage security policies](manage_policy_overview.md) to manage other policies.
