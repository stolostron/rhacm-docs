---

copyright:
  years: 2019
lastupdated: "2019-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Vulnerability policy controller

Vulnerability policy controller can be used to report security vulnerabilities from originally scanned live containers. You can enforce vulnerability policies with the vulnerability policy controller.
{:shortdesc} 

The vulnerability policy controller communicates with multiple components to detect and remediate vulnerability. There are two component interfaces for the vulnerability policy controller:
 
  * One component interface communicates with the local Kubernetes API server to get the list of pods.
  * Second component interface receives the security vulnerability status of a pod by communicating with the Vulnerability Advisor API.

## Vulnerability policy 

A vulnerability  policy is a CustomResourceDefinition (CRD) instance that contains the specifications of which pods to monitor and what action to take if a vulnerability is detected. For more information about CRDs, see [Extend the Kubernetes API with CustomResourceDefinitions ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/){: new_window}.

View the following example description of a vulnerability policy and review the element descriptions of the vulnerability policy:

  ```yaml
  Name:         va-policy-example
  Namespace:    kube-system
  Labels:       category=system-and-information-integrity
  Annotations:  <none>
  API Version:  policies.ibm.com/v1alpha1
  Kind:         VulnerabilityPolicy
  Metadata:
    Creation Timestamp:  2019-08-16T08:29:16Z
    Finalizers:
      finalizer.policies.ibm.com
    Generation:        4
    Resource Version:  4846738
    Self Link:         /apis/policies.ibm.com/v1alpha1/namespaces/kube-system/vulnerabilitypolicies/va-policy-example
    UID:               ef645f75-bfff-11e9-ac88-0016ac10172d
  Spec:
    Namespace Selector:
      Exclude:
        kube-system
      Include:
        default
        kube-*
    Remediation Action:  enforce
    Disabled: false
  Status:
    Compliancy Details:
      Va - Policy - Example:
        Default:
          1 Vulnerable pods detected in namespace `default`
        Kube - Public:
          0 Vulnerable pods detected in namespace `kube-public`
    Compliant:  NonCompliant
  Events:
    Type    Reason             Age   From                            Message
    ----    ------             ----  ----                            -------
    Normal  Container-stopped  1s    vulnerabilitypolicy-controller  Stopped container default/nginx-bcbbfc654-h2qq7/nginx
  ```
  {: pre}

**Note:** In a vulnerability policy, the `category=system-and-information-integrity` label categorizes the policy and facilitates querying the vulnerability policies. If there is a different value for the `key` category in your vulnerability policy, the value is overridden by the VA controller. 

### Vulnerability policy elements

The `namespaceSelector` defines which namespaces are subject to the enforcement of the vulnerability policy. A single vulnerability policy can be applied to multiple namespaces. For example, if there are two vulnerability policies with same value for the `namespaceSelector` parameter, only the first policy is applied to the specified namespace.

  View the following YAML example of the `namespaceSelector` parameter in a vulnerability policy that is applied to multiple namespaces:

   ```yaml
   spec:
     namespaceSelector:
          include: ["default", "kube-*"]
          exclude: ["kube-system"]
   ```
  {: pre}

To stop a container, you must update and edit the value for the `remediationAction` parameter to `enforce`. View the following YAML example of the `remediationAction` parameter in a vulnerability policy: 

  ```yaml
  remediationAction: enforce
  disabled: false
  ```
  {: pre}

### Parent policy for the vulnerability policy

A vulnerability policy can be either created directly on your managed cluster, or on your hub cluster if it manages your managed cluster.

If {{site.data.keyword.mcm}} is not installed, you can create a vulnerability policy directly on your managed cluster by running the following command: `kubectl create -f vulnerabilityPolicyFile.yaml`.

If {{site.data.keyword.mcm_notm}} is installed, create a parent policy that includes the vulnerability policy to be propagated to the managed cluster.

View the example of the parent policy:

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
      kind: VulnerabilityPolicy
      metadata:
        name: vulnerability-policy-example
        label: 
          category: "System-Integrity"
      spec:
        namespaceSelector:
          include: ["default","kube-*"]
          exclude: ["kube-system"]
        #labelsSelector:
          #env: "production"
        remediationAction: enforce # enforce or inform
        RemediationAction:  enforce
        Disabled: false
      - apiVersion: policies.ibm.com/v1alpha1
        kind: VulnerabilityPolicy
        metadata:
          name: vulnerability-policy-example2
          ...
Events:
  Type     Reason                                                 Age                 From                       Message
  ----     ------                                                 ----                ----                       -------
  Normal   policy: default/vulnerability-policy-example2          2m46s               vulnerabilitypolicy-controller  NonCompliant ; 1 vulnerable pods detected in namespace `system`
  Normal   policy: default/vulnerability-policy-example           2m5s                vulnerabilitypolicy-controller  NonCompliant ; 3 vulnerable pods detected in namespace `kube-public`; 2 vulnerable pods detected in namespace `default`
  ```
  {: pre}

  The `policy-templates` parameter defines a set of vulnerability policies to be propagated to the managed clusters. The vulnerability policies are created by the policy controller on the managed cluster. View the following policy resource example:

  ```yaml
  apiVersion: policy.mcm.ibm.com/v1alpha1
  kind: Policy
  metadata:
    name: policy-objects
    description: Instance descriptor for policy resource
    labels:
      hipaa: "true"
  spec:
    remediationAction: "enforce" # enforce or inform
    disabled: false
    complianceType: "musthave" # used as default, when missing in a particular sub-template
    namespaces:
      include: ["default"]
      exclude: ["kube*"]
    object-templates:
      - complianceType: "musthave"
        objectDefinition:
          apiVersion: policies.ibm.com/v1alpha1
          kind: VulnerabilityPolicy
          metadata:
            name: Vulnerability--policy-example
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
            severity: medium
  ```
  {: codeblock}

## Creating a vulnerability policy

Complete the following steps to create a vulnerability policy:

**Note**: A CustomResourceDefinition (CRD) is created when the Vulnerability Advisor and Mutation Advisor are installed. Recreate the CRD if it is removed.

1. (Optional) Create a CRD for the vulnerability policy.

     

    Your CRD YAML file might resemble the following content:

    ```yaml
    apiVersion: apiextensions.k8s.io/v1beta1
    kind: CustomResourceDefinition
    metadata:
      creationTimestamp: null
      labels:
        controller-tools.k8s.io: "1.0"
      name: vulnerabilitypolicies.mcm.ibm.com
    spec:
      group: mcm.ibm.com
      names:
        kind: VulnerabilityPolicy
        plural: vulnerabilitypolicies
        shortNames:
        -vpl
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
            spec:
              properties:
                labelsSelector:
                  description: selecting a list of namespaces where the policy applies
                  type: object
                namespaceSelector:
                  description: enforce, inform
                  properties:
                    exclude:
                      items:
                        type: string
                      type: array
                    include:
                      items:
                        type: string
                      type: array
                  type: object
                remediationAction:
                disabled: false
                  type: string
              type: object
            status:
              properties:
                compliancyDetails:
                  description: Compliant, NonCompliant, UnkownCompliancy
                type: object
              compliant:
                type: string
              type: object
      version: v1alpha1
    status:
      acceptedNames:
        kind: ""
        plural: ""
      conditions: []
      storedVersions: []
    ```
    {: pre}

2. Create a vulnerability policy. 

    Your vulnerability policy might resemble the following YAML file: 

    ```yaml
    apiVersion: policies.ibm.com/v1alpha1
    kind: VulnerabilityPolicy
    metadata:
      name: va-policy-example
      label: 
        category: "System-Integrity"
    spec:
      namespaceSelector:
        include: ["default","kube-*"]
        exclude: ["kube-system"]
      #labelsSelector:
        #env: "production"
      remediationAction: inform # enforce or inform
      disabled: false
      severity: medium
    ```
    {: pre}

3. To get a description of your vulnerability policy, run the following command: 

    ```
    kubectl describe vpl <your_va_policy_name>
    ```
    {: codeblock}

Your vulnerability policy is created.

For more information about other policy controllers, see [{{site.data.keyword.mcm_notm}} policy controllers](../compliance/policy_controllers.md). See [{{site.data.keyword.mcm_notm}} Governance and risk](../compliance/compliance_intro.md) for more information about policies.
