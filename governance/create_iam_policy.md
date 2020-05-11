# Managing IAM policies 

Learn to create, update, and view your IAM policies.

## Creating an IAM policy

You can create a YAML file for your IAM policy or create an IAM policy from the console.

### Creating a YAML file for an IAM policy

Complete the following steps to create an IAM policy from the command-line interface (CLI):

1. Create a YAML file with the IAM policy definition. See [IAM policy](#iam-policy).

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <iam-policy-file-name>  --namespace=<mcm_namespace>
   ```

3. Verify and list the policy by running the following command:

   ```
   kubectl get <iam-policy-file-name> --namespace=<mcm_namespace>
   ```

### Creating an IAM policy from the console

1. Log in to your cluster from the console.
2. From the navigation menu, click **Govern risk**.
3. Click **Create policy**.
4. Copy and paste the IAM policy definition in the _Create policy_ window.
5. Click **Create policy**.  

An IAM policy is created. See _IAM policy sample_ on [IAM policy comtroller page](iam_policy_ctrl.md). See [Manage security policies](manage_policy_overview.md) for more topics.
