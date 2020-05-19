# Managing IAM policies 

Apply an IAM policy to check the number of cluster administrators that you allow in your cluster. Learn to create, apply, view, and update your IAM policies in the following sections.

## Creating an IAM policy

You can create a YAML file for your IAM policy from the command line interface (CLI) or from the console.

### Creating an IAM policy from the CLI

Complete the following steps to create an IAM policy from the CLI:

1. Create a YAML file with the IAM policy definition. Run the following command:
   
   ```
   kubectl create -f iam-policy-1.yaml
   ```
   
   Your IAM policy might resemble the following YAML file:
   
   ```yaml
   apiVersion: iam.policies.ibm.com/v1alpha1
   kind: IamPolicy
   metadata:
     name: iam-grc-policy
     label:
       category: "System-Integrity"
   spec:
     namespaceSelector:
       include: ["default","kube-*"]
       exclude: ["kube-system"]
     remediationAction: inform
     disabled: false
     maxClusterRoleBindingUsers: 5
     maxRoleBindingViolationsPerNamespace: 2
   ```
   
2. Apply the policy by running the following command:

   ```
   kubectl apply -f <iam-policy-file-name>  --namespace=<mcm_namespace>
   ```

3. Verify and list the policy by running the following command:

   ```
   kubectl get <iam-policy-file-name> --namespace=<mcm_namespace>
   ```

Your IAM policy is created.

#### Viewing your IAM policy from the CLI

Complete the following steps to view your IAM policy:

1. View details for. 
specific IAM policy by running the following command:

   ```
   kubectl get iampolicy <policy-name> -n <namespace> -o yaml
   ```

2. View a description of your IAM policy by running the following command:

   ```
   kubectl describe iampolicy <name> -n <namespace>
   ```
   
### Creating an IAM policy from the console

1. Log in to your cluster from the console.
2. From the navigation menu, click **Govern risk**.
3. Click **Create policy**.
4. Enter or select the apapropriate values for the following fields:
  * Name
  * Specifications
  * Cluster selector
  * Remediation action 
  * Standards
  * Categories
  * Controls
  * Disabled
  
5. Click **Create**.

An IAM policy is created.

#### Viewing your IAM policy from the console

You can view any IAM policy and its status from the console.

1. Log in to your cluster from the console.

2. From the navigation menu, click Governance and risk to view a table list of your policies.

   **Note**: You can filter the table list of your policies by selecting the All policies tab or Cluster violations tab.

3. Select one of your policies to view more details.

4. View the IAM policy violations by selecting the _Violations_ tab.

## Updating IAM policies

### Disabling IAM policies

Complete the following steps to disbale your IAM policy: <!--add steps to disable from the CLI if available-->

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

2. From the navigation menu, click **Govern risk** to view a table list of your policies.

3. Disable your policy by clicking the **Options** icon > **Disable**. The _Disable Policy_ dialog box appears.

4. Click **Disable policy**.

Your policy is disbaled.

## Deleting an IAM policy

Delete a configuration policy from the CLI or the console.

* Delete an IAM policy from the CLI:

  1. Delete an IAM policy by running the following command:

    ```
    kubectl delete policy <iam-policy-name> -n <mcm namespace>  
    ```

    After your policy is deleted, it is removed from your target cluster or clusters.

  2. Verify that your policy is removed by running the following command:

    ```
    kubectl get policy <iam-policy-name> -n <mcm namespace>
    ```

* Delete an IAM policy from the console:

  1. From the navigation menu, click **Govern risk** to view a table list of your policies.
  2. Click the **Options** icon for the policy you want to delete in the policy violation table.
  3. Click **Remove**.
  4. From the _Remove policy_ dialog box, click **Remove policy**.

Your policy is deleted.

View the _IAM policy sample_ from the [IAM policy comtroller](iam_policy_ctrl.md) page. See [Manage security policies](manage_policy_overview.md) for more topics.
