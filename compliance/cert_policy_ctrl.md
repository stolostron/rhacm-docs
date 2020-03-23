---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-18"

---

# Certificate policy controller

Certificate policy controller can be used to receive notifications about non-compliant certificate policies.

The certificate policy controller communicates with the local Kubernetes API server to get the list of secrets that contain certificates and determine all non-compliant certificates.

## Certificate policy
  
A `CertificatePolicy` is a CustomResourceDefinition (CRD) instance that contains the specifications of which certificates to monitor and refresh. For more information about CRDs, see [Extend the Kubernetes API with CustomResourceDefinitions](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/).

### Parent policy for the certificate policy 

A certificate policy can be either created directly on your managed cluster, or on your hub cluster if it manages your managed cluster. Your managed cluster must be a Red Hat Advanced Cluster Management for Kubernetes with the required services. If Red Hat Advanced Cluster Management for Kubernetes is not installed, you can create a certificate policy directly on your managed cluster by running the following command: `kubectl create -f certificatePolicyFile.yaml`. 

Create a parent policy that includes the certificate policy to be propagated to the managed cluster.

  View the following example description of a certificate policy and review the element descriptions of the certificate policy:

  ```yaml
  Name:         certificate-policy-example
  Namespace:    default
  Labels:       category=system-and-information-integrity
  APIVersion:  policies.ibm.com/v1alpha1
  Kind:         CertificatePolicy
  Metadata:
    Finalizers:
      finalizer.mcm.ibm.com
  Spec:
    Conditions:
      Ownership:
        ReplicaSet
        Deployment
        DeamonSet
        ReplicationController
    NamespaceSelector:
      Exclude:
        kube-system
      Include:
        default
        kube-*
    RemediationAction:  enforce
    Disabled:  false
    MinimumDuration: 100h
 Status:
   CompliancyDetails:
     Certificate-Policy-Example:
       Default:
         0 secrets with certificates detected in namespace `default`
       Kube - Public:
         0 secrets with certificates detected in namespace `kube-public`
   Compliant:  Compliant
  Events:
    Type    Reason         Age                            From                       Message
    ----    ------         ----                           ----                       -------
    Normal  Pod-Restarted  37m                            certificatepolicy-controller  Restarted Pod default/nginx-7cdbd8cdc9-j8fh9
    Normal  Pod-Restarted  37m                            certificatepolicy-controller  Restarted Pod kube-public/nginx-7cdbd8cdc9-5k2j4
  ```
  
  **Note:** In a certificate policy, the `category=system-and-information-integrity` label categorizes the policy and facilitates querying the certificate policies. If there is a different value for the `category` key in your certificate policy, the value is overridden by the certificate controller.

### Certificate policy elements

The `namespaceSelector` defines which namespaces are subject to the enforcement of the certificate policy. A single certificate policy can be applied to multiple namespaces. For example, if there are two certificate policies with same value for the `namespaceSelector` parameter, only the first policy is applied to the specified namespace.

  View the following YAML example of the `namespaceSelector` parameter in a certificate policy that is applied to multiple namespaces:

   ```yaml
   spec:
     namespaceSelector:
          include: ["default", "kube-*"]
          exclude: ["kube-system"]
   ```

The `minimumDuration` parameter specifies the smallest duration before a certificate is considered non-compliant. When the certificate expiration is greater than the `minimumDuration`, then the certificate is considered compliant. View the following YAML example of the `minimumDuration` parameter in a certificate policy: 

  ```yaml
  remediationAction: enforce
  disabled: false
  minimumDuration: 200h
  ```

  The default value for `minimumDuration` is 30 days (672h).

## Creating a certificate policy

You can create a YAML file for your certificate policy or create a certificate policy from the console. View the following sections to create a certificate policy:

* [Creating a YAML file for a certificate policy](#yaml)
* [Creating a certificate policy from the console](#policy_gui)

### Creating a YAML file for a certificate policy
{: #yaml}

Complete the following steps to create a certificate policy from the command line interface (CLI):

1. Create a YAML file for your certificate policy. See [Creating a YAML file for a Red Hat Advanced Cluster Management for Kubernetes policy](../compliance/create_policy.md#yaml) for more information on policy requirements. 

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
      # include specifies the namespaces in which you want to watch certificates, while exclude specifies the namespaces you explicitly do not want to watch
      namespaceSelector:
        include: ["default", "kube-*"]
        exclude: ["kube-system"]
      # This parameter value can be "enforce" or "inform", however "enforce" does not do anything with regards to this controller
      remediationAction: inform
      # minimum duration is the least amount of time the certificate is still valid from the time the controller checks the policy compliance
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

### Create a certificate policy from the console
{: #policy_gui}

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk**
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

A certificate policy is created and the `CertificatePolicy` definition within it will look similar to the following YAML.

   ```yaml
   apiVersion: policies.ibm.com/v1alpha1
   kind: CertificatePolicy
   metadata:
     name: certificate-policy-1
     namespace: kube-system
     label:
       category: "System-Integrity"
   spec:
   # include parameter values are the namespaces you want to watch certificates in; exclude parameter values are the namespaces you explicitly do not want to watch
     namespaceSelector:
       include: ["default", "kube-*"]
       exclude: ["kube-system"]
     # This parameter value can be "enforce" or "inform", however "enforce" does not do anything with regards to this controller.
     remediationAction: inform
     # minimum duration is the least amount of time the certificate is still valid from the time the controller checks the policy compliance
     disabled: false
     minimumDuration: 100h
   ```

#### View your certificate policy

You can view any certificate policy and its status from the console.

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk**. 
3. Click the _Policies_ tab to view a summary of your policies and a table list of your policies.
   **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab. 
4. Select one of your policies.


For more information about other policy controllers, see [Red Hat Advanced Cluster Management for Kubernetes policy controllers](../compliance/policy_controllers.md). See [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../compliance/compliance_intro.md) for more information about policies.

## Bringing your own certificates

You can monitor your own certificates with the certificate policy controller. You must complete one of the following requirements to monitor your own certificates:

* Create a Kubernetes TLS Secret for your certificate
* Add the label `certificate_key_name` into your Kubernetes secret

### Creating a Kubernetes TLS secret

Create a Kubernetes TLS secret to monitor your own certificates by running the following command: 
   
   ```
   kubectl -n <namespace> create secret tls <secret name> --cert=<path to certificate>/<certificate name> --key=<path to key>/<key name>
   ```
   
   View the following descriptions of the parameters you must update for your TLS secret:
 
   * `<namespace>`: The namespace where you want your certificate secret to be. 
   * `<secret name>`: The name of your Kubernetes Secret.
   * `<path to certificate>`: The folder that contains the certificate on your local file system.
   * `<certificate name>`: The name of the certificate file on your file system.
   * `<path to key>`: The folder that contains the private key of your certificate on your local file system. 
   * `<key name>`: The name of your private key file on your file system.

  
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

The certificate policy controller can monitor your own certificates. 
