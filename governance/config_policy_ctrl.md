# Kubernetes configuration policy controller

Configuration policy controller can be used to configure any Kubernetes resource and apply security policies across your clusters.


## Configuration policy elements

The configuration policy controller communicates with the local Kubernetes API server to get the list of your configurations that are in your cluster. 

## Configuration policy
  
A `Policy` is a CustomResourceDefinition (CRD) instance that contains the specifications of the configuration policy elements section. For more information about CRDs, see [Extend the Kubernetes API with CustomResourceDefinitions](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/).

### Policy elements

Each _policy_ within the policy document contains the following elements.

  - A `namespace` selector that specifies which namespaces within the cluster that the policy is applied to.
  
  - A `remediationAction` specifies the remediation of your policy. The configuration policy controller can inform users of violations when you set the parameter to `inform`. When you set the parameter value to `enforce`, the controller creates the object on the managed cluster with the `objectTemplate` value.

  - A list of `templates`, such as `role-templates`, `object-templates`, and `policy-templates` within the policy that describes how a resource in Kubernetes might be defined, and whether it is allowed to exist.

    - A `role-template` is used to list RBAC roles that must be evaluated or applied to the managed clusters. Role templates are treated as a special category of templates, as they have rules inside that can be analyzed and compared to evaluate the compliance of a cluster.

    - An `object-template` is used to list any other Kubernetes object that must be evaluated or applied to the managed clusters. An example of object can be a pod security policy, an image policy, or a limit range.
    
    - A `policy-template` is used to create one or more policies for third party or external security controls. For example, you can create a certificate expiration policy with the certificate policy controller. For more information about other policy and their  controllers, see [Red Hat Advanced Cluster Management for Kubernetes policy controllers](../governance/policy_controllers.md).

## Creating a Kubernetes configuration policy

You can create a YAML file for your configuration policy or create a configuration policy from the console. View the following sections to create a configuration policy:

* [Creating a YAML file for a configuration policy](#creating-a-yaml-file-for-a-configuration-policy)
* [Creating a configuration policy from the console](#creating-a-configuration-policy-from-the-console)

### Creating a YAML file for a configuration policy

Complete the following steps to create a configuration policy from the command line interface (CLI):

1. Create a YAML file for your configuration policy. See [Creating a YAML file for an Red Hat Advanced Cluster Management for Kubernetes policy](../governance/create_policy.md#yaml) for more information on policy requirements. 

    Your configuration policy might resemble the following policy:

    ```yaml
    apiVersion: policy.mcm.ibm.com/v1alpha1
    kind: Policy
    metadata:
      name: policy-1
      namespace: kube-system
    spec:
    # "include" are parameter values of the namespaces you want to apply the configuration policy , while exclude specifies the namespaces you explicitly do not want to apply
      namespaces:
        include: ["default", "kube-*"]
        exclude: ["kube-system"]
      remediationAction: inform
      disabled: false 
      complianceType: musthave
      object-templates:
       ...
     ``` 
    
2. Apply the policy by running the following command:
   
   ```
   kubectl apply -f <policy-file-name>  --namespace=<namespace>
   ```
   
3. Verify and list the policies by running the following command:

   ```
   kubectl get policy --namespace=<namespace>
   ```
   
Your configuration policy is created.

#### Viewing your configuration policy

Complete the following steps to view your configuration policy from the CLI:

1. View details for a specific configuration policy by running the following command:
   
   ```
   kubectl get policy <policy-name> -n <namespace> -o yaml
   ```
   
2. View a description of your configuration policy by running the following command:

   ```
   kubectl describe policy <name> -n <namespace>
   ```

### Creating a configuration policy from the console

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk**
3. Click **Create policy**.
4. Enter or select the appropriate values for the following fields:
   * Name
   * Namespace
   * Specifications
   * Cluster selector
   * Remediation action
   * Standards
   * Categories
   * Controls
   * Disabled

5. Click **Create**.

A configuration policy is created and the `Policy` definition might resemble the following YAML:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-1
     namespace: kube-system
   spec:
   # "include" are parameter values of the namespaces you want to apply the configuration policy , while exclude specifies the namespaces you explicitly do not want to apply
     namespaces:
       include: ["default", "kube-*"]
       exclude: ["kube-system"]
     remediationAction: inform
     disabled: false
     complianceType: musthave
     object-templates:
      ...
     
   ```

#### View your configuration policy

You can view any configuration policy and its status from the console.

1. Log in to your cluster from the console.
2. From the navigation menu, click **Govern risk** to view a table list of your policies. 

   **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab. 
3. Select one of your policies.

For more information, see [Policy samples](../governance/policy_samples.md) to view policy samples that can be applied with the configuration policy controller.
