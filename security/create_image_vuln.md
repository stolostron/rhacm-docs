# Managing an image vulnerability policy 

Configuration policy controller monitors the status of image vulnerability policies. Image vulnerability policies are applied to check if your containers have vulnerabilities. Learn to create, apply, view, and update your image vulnerability policy. 

## Creating an image vulnerability policy 

You can create a YAML for your image vulnerability policy from the command line interface (CLI) or from the console. View the following sections to create an image vulnerability policy: 

### Creating an image vulnerability policy from the CLI

Complete the following steps to create an image vulnerability policy from the CLI:

1. Create a YAML file for your image vulnerability policy by running the following command:

   ```
   kubectl create -f iamgevulnpolicy-1.yaml
   ```

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <imagevuln-policy-file-name>  --namespace=<namespace>
   ```

3. List and verify the policies by running the following command:

   ```
   kubectl get imagevulnpolicy --namespace=<namespace>
   ```

Your image vulnerability policy is created. 

#### Viewing your policy from the CLI 

Complete the following steps to view your image vulnerability policy from the CLI:

1. View details for a aspecific image vulnerability policy by running the following command:

   ```
   kubectl get imagevulnpolicy <policy-name> -n <namespace> -o yaml
   ```

2. View a description of your image vulnerability policy by running the following command:

   ```
   kubectl describe imagevulnpolicy <name> -n <namespace>
   ```

## Creating an image vulnerability policy from the console

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk**.
3. Click **Create policy**.
4. Select **ImageManifestVulnPolicy** from the _Specifications_ field. Parameter values are automatically set. You can edit your values.
5. Click **Create**.

An image vulnerability policy is created.

## Viewing image vulnerability violations from the console

1. From the navigation menu, click **Govern risk** to view a table list of your policies.
2. Select the **`policy-imagemanifestvulnpolicy`** policy > **_Violations_ tab** to view the cluster location of the violation.

   Your image vulnerability violation might resemble the following:

   ```
   imagemanifestvulns exist and should be deleted: [sha256.7ac7819e1523911399b798309025935a9968b277d86d50e5255465d6592c0266] in namespace default; [sha256.4109631e69d1d562f014dd49d5166f1c18b4093f4f311275236b94b21c0041c0] in namespace calamari; [sha256.573e9e0a1198da4e29eb9a8d7757f7afb7ad085b0771bc6aa03ef96dedc5b743, sha256.a56d40244a544693ae18178a0be8af76602b89abe146a43613eaeac84a27494e, sha256.b25126b194016e84c04a64a0ad5094a90555d70b4761d38525e4aed21d372820] in namespace multicluster-endpoint; [sha256.64320fbf95d968fc6b9863581a92d373bc75f563a13ae1c727af37450579f61a] in namespace openshift-cluster-version
   ```

3. Navigate to your OpenShift Container Platform console by selecting the _Cluster_ link.

4. From the navigation menu on the OpenShift Container Platform console, click **Administration** > **Custom Resource Definitions**.

5. Select **`imagemanifestvulns`** > **_Instances_ tab** to view all of the `imagemanifestvulns` instances.

6. Select an entry to view more details.

## Updating an image vulnerability policy

### Deleting an image vulnerability policy

Delete the image vulnerability policy from the CLI or the console. 

* Delete an image vulnerability policy from the CLI:

  1. Delete a certificate policy by running the following command: <!--verify command `namespace`-->

      ```
      kubectl delete policy <imagevulnpolicy-name> -n <mcm namespace>  
      ```

      After your policy is deleted, it is removed from your target cluster or clusters.

  2. Verify that your policy is removed by running the following command:

      ```
      kubectl get policy <imagevulnpolicy-name> -n <mcm namespace>
      ```
      
* Delete an image vulnerability policy from the console:

  1. From the navigation menu, click **Govern risk** to view a table list of your policies.
  2. Click the **Options** icon for the policy you want to delete in the policy violation table.
  3. Click **Remove**.
  4. From the _Remove policy_ dialog box, click **Remove policy**.

Your image vulnerability policy is deleted.

View a sample of an image vulnerability policy, see _Image vulnerability policy sample_ on the [Policy samples page](policy_samples_intro.md). See [Kubernetes configuration policy controller](config_policy_ctrl.md) to learn about other policies that are monitored by the Kubernetes configuration policy controller. See [Manage security policies](manage_policy_overview.md) to manage other policies.
