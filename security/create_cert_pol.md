# Managing a certificate policy

Learn to create, apply, view, and update your certificate policies.

## Creating a certificate policy 

You can create a YAML file for your certificate policy from the command line interface (CLI) or from the console. View the following sections to create a certificate policy:

### Creating a certificate policy from the CLI

Complete the following steps to create a certificate policy from the CLI:

1. Create a YAML file for your certificate policy. Run the following command:

  ```
  kubectl create -f policy-1.yaml
  ```

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <certificate-policy-file-name>  --namespace=<namespace>
   ```

3. Verify and list the policies by running the following command:

   ```
   kubectl get certificatepolicy --namespace=<namespace>
   ```

Your certificate policy is created.

#### Viewing your certificate policy from the CLI

Complete the following steps to view your certificate policy from the CLI:

1. View details for a specific certificate policy by running the following command:

   ```
   kubectl get certificatepolicy <policy-name> -n <namespace> -o yaml
   ```

2. View a description of your certificate policy by running the following command:

   ```
   kubectl describe certificatepolicy <name> -n <namespace>
   ```

### Creating a certificate policy from the console

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

A certificate policy is created. 

#### Viewing your certificate policy from the console

You can view any certificate policy and its status from the console.

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk** to view a table list of your policies.

   **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab.
4. Select one of your policies to view more details.
5. View the certificate policy violations by selecting the _Violations_ tab. 

## Updating certificate policies

### Bringing your own certificates

You can monitor your own certificates with the certificate policy controller. You must complete one of the following requirements to monitor your own certificates:

* Create a Kubernetes TLS Secret for your certificate.
* Add the label `certificate_key_name` into your Kubernetes secret to monitor your certificates.

Create a Kubernetes TLS secret to monitor your own certificates by running the following command:

   ```
   kubectl -n <namespace> create secret tls <secret name> --cert=<path to certificate>/<certificate name> --key=<path to key>/<key name>
   ```

### Adding a label into your Kubernetes secret

Update the `metadata` parameter in your TLS Secret by adding the `certificate_key_name` label. Run the following command to add the `certificate_key_name` label:

   ```
   kubectl label secret my-certificate -n default certificate_key_name=cert
   ```

   Your updated TLS Secret might resemble the following content:

   ```yaml
   apiVersion: v1
   kind: Secret
   metadata:
     name: my-certificate
     namespace: default
     labels:
       certificate_key_name: cert
   type: Opaque
   data:
     cert: <Certificate Data>
     key: <Private Key Data>
   ```
   **Note**: When you add the label from the console, you must manually add the label into the TLS Secret YAML file.

### Disabling certificate policies

When you create a certificate policy, it is enabled by default. Complete the following steps to disable a certificate policy from the CLI or the console:

* Disable a certificate policy from the CLI:

<!--add info here-->

* Disable a certificate policy from the console:

  1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

  2. From the navigation menu, click **Govern risk** to view a table list of your policies.

  3. Disable your policy by clicking the **Options** icon > **Disable**. The _Disable Policy_ dialog box appears.

  4. Click **Disable policy**.

Your policy is disbaled.

### Deleting a certificate policy

Delete the certificate policy from the CLI or the console. 

* Delete a certificate policy from the CLI:

  1. Delete a certificate policy by running the following command: <!--verify command `namespace`-->

      ```
      kubectl delete policy <cert-policy-name> -n <mcm namespace>  
      ```

      After your policy is deleted, it is removed from your target cluster or clusters.

  2. Verify that your policy is removed by running the following command:

      ```
      kubectl get policy <policy-name> -n <mcm namespace>
      ```
      
* Delete a certificate policy from the console:

  1. From the navigation menu, click **Govern risk** to view a table list of your policies.
  2. Click the **Options** icon for the policy you want to delete in the policy violation table.
  3. Click **Remove**.
  4. From the _Remove policy_ dialog box, click **Remove policy**.

Your certificate policy is deleted.
   
View a sample of a certificate policy, see _Certificate policy sample_ on the [Policy samples page](policy_samples_intro.md). For more information about other policy controllers, see [Policy controllers](policy_controllers.md). See [Manage security policies](manage_policy_overview.md) to manage other policies.
