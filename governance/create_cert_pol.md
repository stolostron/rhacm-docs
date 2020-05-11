# Managing a certificate policy

Learn to create, apply, update, and view your certificeate policies.

## Creating a certificate policy 

You can create a YAML file for your certificate policy or create a certificate policy from the console. View the following sections to create a certificate policy:

### Creating a YAML file for a certificate policy

Complete the following steps to create a certificate policy from the command line interface (CLI):

1. Create a YAML file for your certificate policy. Run the following command:

  ```
  kubectl create -f policy-1.yaml
  ```

  Your certificate policy might resemble the following policy:

    ```yaml
    apiVersion: policies.ibm.com/v1alpha1
    kind: CertificatePolicy
    metadata:
      name: certificate-policy-1
      namespace: kube-system
      label:
        category: "System-Integrity"
    spec:
      namespaceSelector:
        include: ["default", "kube-*"]
        exclude: ["kube-system"]
      remediationAction: inform
      minimumDuration: 100h
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

#### Viewing your certificate policy

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

A certificate policy is created and the `CertificatePolicy` definition within it will look similar to the following YAML:

   ```yaml
   apiVersion: policies.ibm.com/v1alpha1
   kind: CertificatePolicy
   metadata:
     name: certificate-policy-1
     namespace: kube-system
     label:
       category: "System-Integrity"
   spec:
     namespaceSelector:
       include: ["default", "kube-*"]
       exclude: ["kube-system"]
     remediationAction: inform
     disabled: false
     minimumDuration: 100h
   ```

#### Viewing your certificate policy

You can view any certificate policy and its status from the console.

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk** to view a table list of your policies.

   **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab.
4. Select one of your policies.


For more information about other policy controllers, see [Red Hat Advanced Cluster Management for Kubernetes policy controllers](../governance/policy_controllers.md). See [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../governance/compliance_intro.md) for more information about policies.

### Bringing your own certificates

You can monitor your own certificates with the certificate policy controller. You must complete one of the following requirements to monitor your own certificates:

* Create a Kubernetes TLS Secret for your certificate.
* Add the label `certificate_key_name` into your Kubernetes secret.

Create a Kubernetes TLS secret to monitor your own certificates by running the following command:

   ```
   kubectl -n <namespace> create secret tls <secret name> --cert=<path to certificate>/<certificate name> --key=<path to key>/<key name>
   ```

### Adding a label into your Kubernetes secret

You can also monitor your own certificates with the certificate policy controller by adding the `certificate_key_name` label for your certificate key.

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

View a sample of a certificate policy, see _Certificate policy sample_ on the [Policy samples page](policy_samples_intro.md).
