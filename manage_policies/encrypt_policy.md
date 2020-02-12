---

copyright:
  years: 2016, 2019
lastupdated: "2019-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Secret encryption policy controller

Secret encryption policy controller can be used to receive notifications about non-compliant secret encryption policies. Secret encryption policy controller monitors the configurations of Kubernetes secret encryption, and validates if the configurations are compliant with the secret encryption policy. You can create and apply secret encryption policies with the controller to monitor your encryption mechanisms. 
{:shortdesc}

## Installing the secret encryption controller from the {{site.data.keyword.gui}}

Complete the following steps to install the Helm chart for the secret encryption controller from the {{site.data.keyword.gui}}:

1. Log in to your {{site.data.keyword.product}} cluster. 
2. Select **Catalog** from the {{site.data.keyword.product}} menu bar.
3. From the search box, enter `secret-encryption-policy-controller` and select the Helm chart.
4. Click **Configure**. 
5. From the _Configuration_ tab, enter values for the required fields.
6. Click **All parameters** to expand other configuration details. Enable the `volumes.readOnly` parameters in your policy by selecting the following parameters: _readOnly.encrConf_, _readOnly.masterJson_, and __readOnly.openShift_.
7. Click **Install**. 

The secret encryption controller is installed. 

## Secret encryption policy

A secret encryption policy is a CustomResourceDefinition (CRD) instance that contains the specifications of secrets across your cluster that are encrypted with specific encryption mechanisms. For more information about encryption mechanisms in Kubernetes, see [Encrypting Secret Data at Rest ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/).

For more information about CRDs, see [Extend the Kubernetes API with CustomResourceDefinitions ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/){: new_window}.

### Parent policy for the secret encryption policy

A secret encryption policy can be either created directly on your managed cluster, or on your hub cluster if it manages your managed cluster. If {{site.data.keyword.mcm}} is not installed, you can create a secret encryption policy directly on your managed cluster by running the following command:

   ```
   kubectl create -f encryptionPolicyFile.yaml
   ```
   {: pre}

If {{site.data.keyword.mcm_notm}} is installed, create a parent policy that includes the secret encryption policy to be propagated to the managed cluster.

  View the following example description of a secret encryption policy and review the element descriptions of the encryption policy:

  ```yaml
  Name:         secret-encryption-policy-example
  Namespace:    default
  Labels:       category=system-and-information-integrity
  APIVersion:  policies.ibm.com/v1alpha1
  Kind:         SecretEncryptionPolicy
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
      Include:
        default
        kube-*
    RemediationAction:  inform
    Disabled: false 
    SecretEncryptionEnabled: true
    EncrytionMechanism: kms
    Severity: 
 Status:
   CompliancyDetails:
     Secret-Encryption-Policy-Example:
       No violation detected
   Compliant:  Compliant
  Events:
    Type    Reason                                                       Age                From                       Message
    ----    ------                                                       ----               ----                       -------
    Normal  policy: mcm-managed-cluster/secret-encryption-policy-example 41m (x2 over 42m)  secretencryptionpolicy-controller  NonCompliant
    Normal  policy: mcm-managed-cluster/secret-encryption-policy-example 41m (x4 over 43m)  secretencryptionpolicy-controller  Compliant
  ```
  {: pre}


  **Note:** In a secret encryption policy, the `category=system-and-information-integrity` label categorizes the policy and facilitates querying the secret encryption policies. If there is a different value for the `category` key in your secret encryption policy, the value is overridden by the secret encryption controller.

### Secret encryption policy elements

The `namespaceSelector` defines which namespaces are subject to the enforcement of the secret encryption policy. The secret encryption policy is applied to all namespaces because the encryption mechanism is cluster-level.

  View the following YAML example of the `namespaceSelector` parameter in a secret encryption policy that is applied to multiple namespaces:

   ```yaml
   spec:
     namespaceSelector:
          include: ["default"]
          exclude: [ ]
   ```
  {: pre}

The `remediationAction` parameter indicates how the non-compliant policy is addressed. Set the parameter value to `inform` to receive reports about your cluster compliance. Set the parameter value to `enforce` to receive automatic remediation based on the encryption mechanism. View the following notes when `enforce` is the remediation action:

  * When you define the `encryptionMechanism` parameter value as `aescbc`, the secret encryption policy controller lists the AES-CBC provider as the first provider in the `providers` list of the `encryption-config.yaml` file. If `aescbc` is not present, the secret encryption policy controller creates a new provider entry with a new secret key.
  
  * When you disable the secret encryption, the `- identity: {}` parameter is added in to the `encryption-config.yaml` by the secret encryption policy controller. Existing encrypted secrets are encrypted at rest, but new secrets are not protected by the encryption. 

The `secretEncryptionEnabled` parameter indicates that the secret encryption is enabled. Set the parameter value to `true` to enable the secret encryption, or `false` to disable the secret encryption. 

View the following YAML example of the `remediationAction` and `secretEncryptionEnabled` parameters:

  ```yaml
  # The parameter value can be "inform" or "enforce"
  remediationAction: inform
  # Indicates if the secret encryption is enabled
  disabled: false
  secretEncryptionEnabled: true
  ```
  {: pre}

The `encryptionMechanism` parameter indicates which mechanism is used for the Kubernetes secret encryption resources across your cluster. Set the parameter value to `aescbc` to specify the mechanism.

**Notes**: {{site.data.keyword.product}} supports Kubernetes AES-CBC and Key Management Service (KMS) to secure data. <!--For more information, see the _Data encryption_ section in [Preparing to secure your cluster page](../../installing/plan_security.md).-->

The `severity` parameter displays the condition of the policy when your cluster is non-compliant. You can set the parameter value to `low`, `medium`, or `high`. 

View the following YAML example of the `encryptionMechanism` and `severity` parameters:

  ```yaml
  # The parameter value can be "inform" or "enforce"
  remediationAction: inform
  # Indicates if the secret encryption is enabled
  disabled: false
  secretEncryptionEnabled: true
  # Indicates the encryption mechanism
  encryptionMechanism: kms
  severity: low
  ```
  {: pre}
  
## Creating a secret encryption policy

You can create a YAML file for your secret encryption policy or create a secret encryption policy from the {{site.data.keyword.gui}}. View the following sections to create a secret encryption policy:

* [Creating a YAML file for a secret encryption policy](#encrypt_yaml)
* [Creating a secret encryption policy from the {{site.data.keyword.gui}}](#encrypt_policy_gui)

### Creating a YAML file for a secret encryption policy
{: #encrypt_yaml}

Complete the following steps to create a secret encryption policy from the command line interface (CLI):

1. Create a YAML file for your secret encryption policy. See [Creating a YAML file for an {{site.data.keyword.mcm_notm}} policy](../compliance/create_policy.md#yaml) for more information on policy requirements. 

   Your secret encryption policy might resemble the following policy:

   ```yaml
   apiVersion: policies.ibm.com/v1alpha1
   kind: SecretEncryptionPolicy
   metadata:
     name: secret-encryption-policy-example-1
     namespace: kube-system
     label:
       category: "System-Integrity"
   spec:
     # include specifies the namespaces in which you want to watch certificates, while exclude specifies the namespaces you explicitly do not want to watch
     namespaceSelector:
       include: ["default", "kube-*"]
     # This parameter value can be "enforce" or "inform"
     remediationAction: inform
     # indicates if the secret encryption is enabled
     disabled: false 
     secretEncryptionEnabled: true
     # indicates the encryption mechanism
     encryptionMechanism: kms
   ```
   {: codeblock} 
    
2. Apply the policy by running the following command:
   
   ```
   kubectl apply -f <secretencryptionpolicy-file-name>  --namespace=<mcm_namespace>
   ```
   {: codeblock}
   
3. Verify and list the policies by running the following command:

   ```
   kubectl get secretencrytpionpolicy --namespace=<mcm_namespace>
   ```
   {: codeblock}
   
Your secret encryption policy is created.

#### Viewing your secret encryption policy

Complete the following steps to view your secret encryption policy from the CLI:

1. View details for a specific secret encryption policy by running the following command:
   
   ```
   kubectl get secretencryptionpolicy <policy-name> -n <mcm_namespace> -o yaml
   ```
   {: codeblock}
   
2. View a description of your secret encryption policy by running the following command:

   ```
   kubectl describe secretencryptionpolicy <name> -n <namespace>
   ```
   {: codeblock}

### Create a secret encryption policy from the {{site.data.keyword.gui}}
{: #policy_gui}

1. Log in to your cluster from the {{site.data.keyword.gui}}.
2. From the navigation menu, click **Govern risk**
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

View the example `SecretEncryptionPolicy` definition. You can copy and paste the YAML file for your policy, or select the approriate values for the parameter fields previously mentioned. 
   
  Your YAML file might resemble the following policy:
     
  ```yaml
  apiVersion: policies.ibm.com/v1alpha1
  kind: SecretEncryptionPolicy
  metadata:
    name: secret-encryption-policy-1
    namespace: kube-system
    label:
      category: "System-Integrity"
  spec:
    # include parameter values are the namespaces you want to watch certificates in; exclude parameter values are the namespaces you explicitly do not want to watch
    namespaceSelector:
      include: ["default", "kube-*"]
    # This parameter value can be "enforce" or "inform"
    remediationAction: inform
    # indicates if the secret encryption is enabled
    disabled: false
    secretEncryptionEnabled: true
    # indicates the encryption mechanism
    encryptionMechanism: kms
  ```
  {: codeblock}

A secret encryption policy is created.

#### View your secret encryption policy

You can view any secret encryption policy and its status from the {{site.data.keyword.gui}}.

1. Log in to your cluster from the {{site.data.keyword.gui}}.
2. From the navigation menu, click **Govern risk**. 
3. Click the _Policies_ tab to view a summary of your policies and a table list of your policies.
   **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab. 
4. Select one of your policies.


For more information about other policy controllers, see [{{site.data.keyword.mcm_notm}} policy controllers](../compliance/policy_controllers.md). For more information about policies, see [{{site.data.keyword.mcm_notm}} Governance and risk](../compliance/compliance_intro.md).


