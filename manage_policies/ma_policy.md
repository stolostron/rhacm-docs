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

# Mutation policy controller

Mutation policy controller can be used to report mutated pods from originally scanned images. You can enforce mutation policies with the mutation policy controller.
{:shortdesc} 
 
The mutation policy controller communicates with multiple components to detect and remediate mutations. There are two component interfaces for the mutation policy controller:
 
  * One component interface communicates with the local Kubernetes API server to get the list of mutated pods and restart the mutated pods.
  * Second component interface receives the mutation status of a pod by communicating with the Mutation Advisor API.

## Mutation policy

A mutation policy is a CustomResourceDefinition (CRD) instance that contains the specifications of which pods to monitor and what action to take if a mutation is detected. For more information about CRDs, see [Extend the Kubernetes API with CustomResourceDefinitions ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/){: new_window}.

  View the following example description of a mutation policy and review the element descriptions of the mutation policy:

  ```yaml
  Name:         mutation-policy-example
  Namespace:    default
  Labels:       category=system-and-information-integrity
  APIVersion:  mcm.ibm.com/v1alpha1
  Kind:         MutationPolicy
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
    labelsSelector:
      env: "production"
    RemediationAction:  enforce
    Disabled: false
 Status:
   CompliancyDetails:
     Mutation-Policy-Example:
       Default:
         0 mutated pods detected in namespace `default`
       Kube - Public:
         0 mutated pods detected in namespace `kube-public`
   Compliant:  Compliant
  Events:
    Type    Reason         Age                            From                       Message
    ----    ------         ----                           ----                       -------
    Normal  Pod-Restarted  37m                            mutationpolicy-controller  Restarted Pod default/nginx-7cdbd8cdc9-j8fh9
    Normal  Pod-Restarted  37m                            mutationpolicy-controller  Restarted Pod kube-public/nginx-7cdbd8cdc9-5k2j4
  ```
  {: pre}

**Note:** In a mutation policy, the `category=system-and-information-integrity` label categorizes the policy and facilitates querying the mutation policies. If there is a different value for the `key` category in your mutation policy, the value is overridden by the mutation controller. 

### Mutation policy elements

The `namespaceSelector` defines which namespaces are subject to the enforcement of the mutation policy. A single mutation policy can be applied to multiple namespaces. For example, if there are two mutation policies with same value for the `namespaceSelector` parameter, only the first policy is applied to the specified namespace.

  View the following YAML example of the `namespaceSelector` parameter in a mutation policy that is applied to multiple namespaces:

   ```yaml
   spec:
     namespaceSelector:
          include: ["default", "kube-*"]
          exclude: ["kube-system"]
   ```
  {: pre}

The `labelsSelector` defines which pod is monitored by the mutation policy controller. You can list specific labels for your pods to be monitored by the controller. If the `labelsSelector` parameter is not specified, then all pods in the specified namespaces are monitored by the mutation policy controller. 

  **Note**: Mutation Advisor scans all containers in your Kubernetes cluster, however the mutation policy controller checks for only pods that satisfy the `namespaceSelector` and the `labelsSelector`.

  View the following YAML example of the `labelsSelector` parameter in a mutation policy: 

   ```yaml
   labelsSelector:
      env: "production"
   ```
   {: pre}

The `conditions` parameter specifies the conditions in which the mutation policy controller is able to restart a mutated pod. A pod must be owned by one of the following controllers: ReplicaSet, Deployment, DaemonSet, ReplicationController.

To restart a pod, you must update and edit the value for the `remediationAction` parameter to `enforce`. View the following YAML example of the `conditions` parameter in a mutation policy: 

  ```yaml
  remediationAction: enforce
  disabled: false
  conditions:
      ownership: ["ReplicaSet", "Deployment", "DaemonSet", "ReplicationController"]
  ```
  {: pre}
  
  **Note**: Enable the controller to delete pods that are not owned by a controller by updating the `ownership` value to `none`.
  
### Parent policy for the mutation policy

A mutation policy can be either created directly on your managed cluster, or on your hub cluster if it manages your managed cluster.

If {{site.data.keyword.mcm_notm}} is not installed, you can create a mutation policy directly on your managed cluster by running the following command: `kubectl create -f mutationPolicyFile.yaml`.

If {{site.data.keyword.mcm_notm}} is installed, create a parent policy that includes the mutation policy to be propagated to the managed cluster.

View the example description of the parent policy:

```yaml
API Version:  policy.mcm.ibm.com/v1alpha1
Kind:         Policy
Name:         policy-objects
Namespace:    default
Labels:       dev=true
Spec:
  Compliance Type:  musthave
  Namespaces:
    Exclude:
      kube*
    Include:
      default
  Policy-Templates:
    Compliance Type:         musthave
    ObjectDefinition:
    - apiVersion: policies.ibm.com/v1alpha1
      kind: MutationPolicy
      metadata:
        name: mutation-policy-example
        label: 
          category: "System-Integrity"
      spec:
        namespaceSelector:
          include: ["default","kube-*"]
          exclude: ["kube-system"]
        labelsSelector:
          env: "production"
        remediationAction: enforce # enforce or inform
        conditions:
          ownership: ["ReplicaSet", "Deployment", "DeamonSet", "ReplicationController"]
        RemediationAction:  enforce
        Disabled: false
      - apiVersion: policies.ibm.com/v1alpha1
        kind: MutationPolicy
        metadata:
          name: mutation-policy-example2
          ...
Events:
  Type     Reason                                                 Age                 From                       Message
  ----     ------                                                 ----                ----                       -------
  Normal   policy: default/mutation-policy-example2               2m46s               mutationpolicy-controller  NonCompliant ; 1 mutated pods detected in namespace `system`
  Normal   policy: default/mutation-policy-example                2m5s                mutationpolicy-controller  NonCompliant ; 3 mutated pods detected in namespace `kube-public`; 2 mutated pods detected in namespace `default`
  ```
  {: pre}

  
  The `policy-templates` parameter defines a set of mutation policies to be propagated to the managed clusters. The mutation policies are created by the policy controller on the managed cluster. 

### Mutation controller flags

As you install the mutation controller, you must set mutation controller flags. View the descriptions of the mutation controller flags: 

* `update-frequency`: Defines the frequency of query updates from the mutation policy controller to the Mutation Advisor for new mutations. 

* `watch-ns`: Must match the namespace where the parent policies are created. 

* `parent-event`: Defines whether events are sent to the parent policies in the namespace about the status of the mutation policies.

## Creating a mutation policy

You can create a YAML file for your mutation policy or create a mutation policy from the {{site.data.keyword.gui}}. View the following sections to create a certificate policy:

  * [Creating a YAML file for a mutation policy](#mutation_yaml) 
  * [Creating a mutation policy from the {{site.data.keyword.gui}}](#mutation_policy_gui)
 
### Creating a YAML file for a mutation policy
{: #mutation_yaml} 

1. Create a YAML file for your mutation policy. Ensure that the mutation policy CRD exists. 

    Your mutation policy YAML file might resemble the following content:

    ```yaml
    apiVersion: apiextensions.k8s.io/v1beta1
    kind: CustomResourceDefinition
    metadata:
        creationTimestamp: null
        labels:
            controller-tools.k8s.io: "1.0"
        name: mutationpolicies.mcm.ibm.com
    spec:
        group: mcm.ibm.com
        names:
        kind: MutationPolicy
        plural: mutationpolicies
        scope: Namespaced
        validation:
        openAPIV3Schema:
            properties:
            apiVersion:
                description: 'APIVersion defines the versioned schema of this representation
                    of an object. Servers should convert recognized schemas to the latest
                    internal value, and can reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
                type: string
            kind:
                description: 'Kind is a string value representing the REST resource this
                    object represents. Servers might infer this from the endpoint the client
                    submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                    type: string
            metadata:
                type: object
    ```
    {: pre}

2. Create a mutation policy in your parent policy. 

    Your mutation policy might resemble the following YAML file: 

    ```yaml
    apiVersion: policies.ibm.com/v1alpha1
    kind: MutationPolicy
    metadata:
      name: mutation-policy-example
      label: 
        category: "System-Integrity"
    spec:
      namespaceSelector:
        include: ["default","kube-*"]
        exclude: ["kube-system"]
      #labelsSelector:
        #env: "production"
      remediationAction: enforce # enforce or inform
      disabled: false
      conditions:
        ownership: ["ReplicaSet", "Deployment", "DaemonSet", "ReplicationController"]
    ```
    {: pre}

3. Apply the policy by running the following command:

   ```
   kubectl apply -f <mutation-policy-file-name>  --namespace=<mcm_namespace>
   ```
   {: codeblock}
   
4. Verify and list the mutation policies by running the following command:

   ```
   kubectl get mutationpolicy --namespace=<mcm_namespace>
   ```
   {: codeblock}

Your mutation policy is created.

#### Viewing your mutation policy

Complete the following steps to view your mutation policy from the CLI:

1. View details for a specific mutation policy by running the following command:
   
   ```
   kubectl get mutationpolicy <policy-name> -n <mcm_namespace> -o yaml
   ```
   {: codeblock}

2. View a description of your mutation policy by running the following command:

   ```
   kubectl describe mutationpolicies.mcm.ibm.com <myPolicyName>
   ```
   {: codeblock}

### Creating a mutation policy from the {{site.data.keyword.gui}}
{: #mutation_policy_gui}

1. Log in to your cluster from the {{site.data.keyword.gui}}.
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
6. View the example `MutationPolicy` definition. Copy and paste the YAML file for your policy. 
   
   Your YAML file might resemble the following policy:
     
     ```yaml
     apiVersion: policies.ibm.com/v1alpha1
     kind: MutationPolicy
     metadata:
       name: mutation-policy-example
       label: 
         category: "System-Integrity"
     spec:
       namespaceSelector:
         include: ["default","kube-*"]
         exclude: ["kube-system"]
       #labelsSelector:
        #env: "production"
       remediationAction: enforce # enforce or inform
       disabled: false
       conditions:
         ownership: ["ReplicaSet", "Deployment", "DaemonSet", "ReplicationController"]
     ```
     {: codeblock}

A mutation policy is created.

#### View your mutation policy

You can view any mutation policy and its status from the {{site.data.keyword.gui}}.

1. Log in to your cluster from the {{site.data.keyword.gui}}.
2. From the navigation menu, click **Govern risk**. 
3. Click the _Policies_ tab to view a summary of your policies and a table list of your policies.
   **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab. 
4. Select one of your policies.

For more information about other policy controllers, see [{{site.data.keyword.mcm_notm}} policy controllers](../compliance/policy_controllers.md). See [{{site.data.keyword.mcm_notm}} Governance and risk](../compliance/compliance_intro.md) for more information about policies.
