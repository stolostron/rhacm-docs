# Managing rolebinding policies

Learn to create, apply, view, and update your rolebinding policies.

## Creating a rolebinding policy 

You can create a YAML file for your rolebinding policy from the command line interface (CLI) or from the console. View the following sections to create a rolebinding policy:

### Creating a rolebinding policy from the CLI

Complete the following steps to create a rolebinding policy from the CLI:

1. Create a YAML file for your rolebinding policy. Run the following command:

   ```
   kubectl create -f rolebindingpolicy.yaml
   ```

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <rolebinding-policy-file-name>  --namespace=<namespace>
   ```

3. Verify and list the policies by running the following command:

   ```
   kubectl get rolebindingpolicy --namespace=<namespace>
   ```

Your rolebinding policy is created.

#### Viewing your rolebinding policy from the CLI

Complete the following steps to view your rolebinding policy from the CLI:

1. View details for a specific rolebinding policy by running the following command:

   ```
   kubectl get rolebindingpolicy <policy-name> -n <namespace> -o yaml
   ```

2. View a description of your rolebinding policy by running the following command:

   ```
   kubectl describe rolebindingpolicy <name> -n <namespace>
   ```

### Creating a rolebinding policy from the console

As you create a rolebinding policy from the console, a YAML file is also created in the YAML editor. Complete the following steps to create a rolebinding policy from the console:

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk**.
3. Click **Create policy**.
4. Enter or select the appropriate values for the following fields:
   * Name
   * Specifications
   * Cluster selector
   * Remediation action
   * Standards
   * Categories
   * Controls
   * Disabled

5. Click **Create**.

A rolebinding policy is created.

#### Viewing your rolebinding policy from the console

You can view any rolebinding policy and its status from the console.

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk** to view a table list of your policies.
   
   **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab.

4. Select one of your policies to view more details.
5. View the rolebinding policy violations by selecting the _Violations_ tab.

## Updating rolebinding policies

Learn to update rolebinding policies by viewing the following section. 

### Disabling rolebinding policies

Complete the following steps to disable your rolebinding policy:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

2. From the navigation menu, click **Govern risk** to view a table list of your policies.

3. Disable your policy by clicking the **Options** icon > **Disable**. The _Disable Policy_ dialog box appears.

4. Click **Disable policy**.

Your policy is disabled.

### Deleting a rolebinding policy

Delete the rolebinding policy from the CLI or the console. 

* Delete a rolebinding policy from the CLI:

  1. Delete a rolebinding policy by running the following command: <!--verify command `namespace`-->

      ```
      kubectl delete policy <podsecurity-policy-name> -n <namespace>  
      ```

      After your policy is deleted, it is removed from your target cluster or clusters.

  2. Verify that your policy is removed by running the following command:

      ```
      kubectl get policy <podsecurity-policy-name> -n <namespace>
      ```
      
* Delete a rolebinding policy from the console:

  1. From the navigation menu, click **Govern risk** to view a table list of your policies.
  2. Click the **Options** icon for the policy you want to delete in the policy violation table.
  3. Click **Remove**.
  4. From the _Remove policy_ dialog box, click **Remove policy**.

Your rolebinding policy is deleted.

View a sample of a rolebinding policy, see _Rolebinding policy sample_ on the [Rolebinding policy](rolebinding_policy.md) page. See [Kubernetes configuration policy controller](config_policy_ctrl.md) to learn about other configuration policies. See [Manage security policies](manage_policy_overview.md) to manage other policies.
