---

copyright:
  years: 2016, 2019
lastupdated: "2019-05-21"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Managing a service broker resource from the command line interface (CLI)

You can deploy a service broker to view the available services and plans, create an instance from the available services and plans, and create bindings to connect to the service instance.
{:shortdesc}

You can deploy a community sample service broker to test the function, or install your own service broker that follows the Open Service Broker API specification for your own requirements.

You can use the [Kubernetes `ups_broker` sample service broker ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/kubernetes-incubator/service-catalog/tree/master/charts/ups-broker){: new_window} as an easy way to look at the service broker function. You can deploy it on to your cluster as a Helm chart by completing the following steps:

1. Optionally, you can create a new Helm repository named `charts` where you can download the service broker. See [Adding a Helm repository](../app_center/manage_helm_repo.md#add_repo) for the procedure.

2. If you created a new repository, clone the repository to download the service broker into the new Helm repository. 

3. If you chose not to create a new repository, you can download the service broker chart into an existing Helm repository. If you don't want to use a Helm repository, you can download the chart and use the `helm install` command to install the chart on the cluster. See [Installing the Helm CLI (helm)](../app_center/create_helm_cli.md) for more information about the `helm install` command.

4. Run the following Helm command in the Helm CLI to deploy the service broker:

  ```
  helm install charts/ups-broker --name ups-broker --namespace ups-broker
  ```
  {: codeblock}

- [Registering a service broker to the {{site.data.keyword.icp_notm}} {{site.data.keyword.catalog}}](#register_clusterservicebroker)
- [Viewing ServiceClasses and ServicePlans](#view_servicesplans)
- [Creating a ServiceInstance](#create_serviceinstance)
- [Binding the ServiceInstance to an application](#create_servicebindings)
- [Unbinding an ServiceInstance](#unbind_serviceinstance)
- [Deleting a ServiceInstance](#delete_serviceinstance)
- [Deleting a ServiceBroker](#delete_clusterservicebroker)

## Registering a service broker to the {{site.data.keyword.icp_notm}} Service {{site.data.keyword.catalog}} 
{: #register_clusterservicebroker}

You can register a broker to a service in your cluster or in your namespace. Before you can view the services and plans to create an instance of, you must register the broker to the service {{site.data.keyword.catalog}} with the **ServiceBroker** resource.
    
### Registering a cluster-level service broker

Register a cluster-level service broker to the service {{site.data.keyword.catalog}}. Complete the following steps:

  1. Create a ServiceBroker resource by creating a `broker.yaml` file, which contains the broker details. You must specify values for the broker `name` and the `url` for the broker. Your `broker.yaml` file might resemble the following content:

      ```
      apiVersion: servicecatalog.k8s.io/v1beta1
      kind: ClusterServiceBroker
      metadata:
        name: ups-broker
      spec:
        url: http://ups-broker-ups-broker.ups-broker.svc.cluster.local
      ```
      {: pre}

   2. Run the following command to create your cluster-level ServiceBroker resource:
      
        ```
        kubectl create -f broker.yaml
        ```
        {: codeblock}

A cluster-level broker is created.

### Registering a namespace-level service broker

Complete the following steps to register a namespace-level service broker to the service {{site.data.keyword.catalog}}: 

1. Create a ServiceBroker resource by creating a `ns-broker.yaml` file, which contains the broker details. You must specify values for the broker  `name`, `namespace`, and `url`. Your `ns-broker.yaml` file might resemble the following content: 

    ```
    apiVersion: servicecatalog.k8s.io/v1beta1
    kind: ServiceBroker
    metadata:
      name: ups-broker
      namespace: ns-broker
    spec:
      url: http://ups-broker-ups-broker.default.svc.cluster.local 
    ```
    {: pre}

2. Run the following command to create your namespace-level ServiceBroker resource:

      ```
      kubectl create -f ns-broker.yaml
      ```
      {: codeblock}

A namespace-level broker is created.

## Viewing ServiceClasses and ServicePlans
{: #view_servicesplans}

Each service has a corresponding ServiceClass resource and can have one or more plans that are associated with it.

* To display the registered service classes, run the following command:

  * Display the registered service classes for the cluster-level brokers: 
  
    ```
    kubectl get clusterserviceclasses
    ```
    {: codeblock}

  * Display the registered service classes for the namespace-level brokers: 
  
    ```
    kubectl get serviceclasses -n ns-broker
    ```
    {: codeblock}

* To display the registered service plans, run the following command:
  
  * Display the registered service plans for the cluster-level brokers: 
  
    ```
    kubectl get clusterserviceplans
    ```
    {: codeblock}
  
  * Display the registered service plans for the namespace-level brokers: 
  
    ```
    kubectl get serviceplans -n ns-broker
    ```
    {: codeblock}

## Creating a ServiceInstance
{: #create_serviceinstance}  

Create a ServiceInstance resource by creating a `instance.yaml` file for a service broker. You must create an instance of a service class before your applications can use it. Complete the following steps:

### Creating a ServiceInstance for your cluster-level broker

1. Create a ServiceInstance resource for your cluster-level broker in the `instance.yaml` file. Your `instance.yaml` file might resemble the following content:

      ```
      apiVersion: servicecatalog.k8s.io/v1beta1
      kind: ServiceInstance
      metadata:
        name: ups-instance
        namespace: test-ns
      spec:
        clusterServiceClassExternalName: user-provided-service
        clusterServicePlanExternalName: default
        parameters:
          credentials:
            name: root
            password: letmein
      ```
      {: pre}

2. Create the instance by running the following command:

      ```
      kubectl create -f instance.yaml
      ```
      {: codeblock}
      
A service instance is created for your cluster service broker.

### Creating a ServiceInstance for your namespace-level broker 

1. Create a ServiceInstance resource for your  namespace-level broker your `instance.yaml` file. Your `instance.yaml` file might resemble the following content:

      ```
      apiVersion: servicecatalog.k8s.io/v1beta1
      kind: ServiceInstance
      metadata:
        name: ups-ns-instance
        namespace: ns-broker
      spec:
        serviceClassExternalName: user-provided-service
        servicePlanExternalName: default
        parameters:
          credentials:
            name: root
            password: letmein
      ```
      {: codeblock}

2. Create the instance by running the following command:

      ```
      kubectl create -f ns-instance.yaml
      ```
      {: codeblock}
      
A service instance is created for your namespace service broker.

## Viewing the ServiceInstance

You can view your ServiceInstance resources from the command line interface (CLI). 

Complete the following steps to view your ServiceInstance resources: 

1. Get the name of the namespace, where the ServiceInstance resource is located: 

    ```
    kubectl get serviceinstance -n test-ns
    ```
    {: codeblock}

2. Run the following command to view the details of your resource:

    ```
    kubectl get serviceinstance ups-instance -n test-ns -o yaml
    ```
    {: codeblock}

You can also view your resources from the {{site.data.keyword.gui}}. For more information, see [Managing the Service {{site.data.keyword.catalog}} resources from the {{site.data.keyword.icp_notm}} {{site.data.keyword.gui}} ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](../manage_applications/service_catalog.md){: new_window}

## Binding the ServiceInstance to an application
{: #create_servicebindings}

To bind the ServiceInstance to an application, Complete the following steps:

  1. Create the `binding.yaml` file that binds the service instance to an application. You must provide the binding `name` and a `secretName`. Your `binding.yaml` file might resemble the following content:

      ```
      apiVersion: servicecatalog.k8s.io/v1beta1
      kind: ServiceBinding
      metadata:
        name: <binding_name>
        namespace: test-ns
      spec:
        secretName: <secret_name>
        instanceRef:
          name: ups-instance
      ```
      {: pre}
      
      **Note**: The value for the `namespace` parameter of the `binding.yaml` file must be the same value as the service instance namespace. The service binding YAML example is for cluster-level resources, but namespace-level YAML files follow the same format. 

      For more details the pod selector labels in the Kubernetes documentation, see [Labels and Selectors ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/){: new_window}.

  2. Create a `binding.yaml` file by running the following command:

      ```
      kubectl create -f binding.yaml
      ```
      {: codeblock}

      The service catalog controller creates a Kubernetes secret that contains the connection details and credentials for the service instance.

  3. To view the details of your `binding.yaml` file, run the following command:

      ```
      kubectl get servicebindings service_binding -o yaml
      ```
      {: codeblock}

  4. View the secret details to connect to the application. Run the following command:

      ```
      kubectl get secrets <secret_name> -o yaml
      ```
      {: codeblock}

      - `<secret_name>` is the secret name that is used in the binding. Your `<secret_name>` might resemble the following content:

      ```
      apiVersion: v1
      data:
      . . Secret data to connect to the database instance . .
      kind: Secret
      metadata:
      . . metadata parameters and values . .
      type: Opaque
      ```
      {: pre}      

## Unbinding an ServiceInstance
{: #unbind_serviceinstance}

You must delete the ServiceBinding that you created before you unbind an instance from an application. After you delete a binding, the secret that the binding uses is also deleted.

To unbind an instance, run the following command:

  ```
  kubectl delete -n test-ns servicebindings ups-binding
  ```
  {: codeblock}

  - `ups-binding` is the name of the binding to remove.

## Deleting a ServiceInstance
{: #delete_serviceinstance}

Delete the service instance by running the following command:

  ```
  kubectl delete -n test-ns serviceinstances ups-instance
  ```
  {: codeblock}

- `ups-instance` is the name of the instance to delete.

## Deleting a ServiceBroker
{: #delete_clusterservicebroker}

To delete a ClusterServiceBroker you must unregister the broker. To unregister the broker, run the following command:

  ```
  kubectl delete clusterservicebrokers ups-broker
  ```
  {: codeblock}
  
  - `ups-broker` is the name of the cluster-level service broker. 

To delete a NamespaceServiceBroker you must unregister the broker. To unregister the broker, run the following command:

  ```
  kubectl delete servicebrokers ups-broker -n ns-broker
  ```
  {: codeblock}  

  - `ups-broker` is the name of the namespace-level service broker to delete.

## Deleting a Helm deployment

You must delete the Helm deployment when you clean up the service broker server. To delete the Helm deployment, run the following command:

  ```
  helm delete --purge ups-broker
  ```
  {: codeblock}

  - `ups-broker` is the name of the Helm deployment to delete.
  
  **Important**: You must complete the deletion process in the following order: unbind your service instance, delete your service instance, delete your service broker, and delete your Helm deployment.
