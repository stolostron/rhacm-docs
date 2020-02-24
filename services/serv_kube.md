---

copyright:
  years: 2019
lastupdated: "2019-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Enabling a Kubernetes service for discovery

You can configure the {{site.data.keyword.mcm_notm}} service registry to discover Kubernetes services that are in different {{site.data.keyword.mcm_notm}} managed clusters. 
{: shortdesc}

A Kubernetes service exposes a group of pods that are running on a managed cluster. The {{site.data.keyword.mcm_notm}} service discovery function only discovers Kubernetes services that are configured to be discovered. 

**Required user type or access level:** Cluster administrator.

## Discover the Kubernetes service

To discover a Kubernetes service on your managed clusters, complete the following steps:

1. Annotate the service to enable the service discovery.

  You must enable the service in the managed cluster to be discovered by adding the following annotation to your service definition `yaml` file for the service that you want to discover:

  ```
  mcm.ibm.com/service-discovery
  ```
  {: codeblock}
  
  The following example shows the format for the `dbservice`:
  
  ```
  apiVersion: v1
  kind: Service
  metadata:
    annotations:
      mcm.ibm.com/service-discovery: "{}"
    name: dbservice
    namespace: database
  spec:
    type: LoadBalancer
    ports:
    - name: http
      nodePort: 8080
      port: 8000
      protocol: TCP
    selector:
      app: dbservice
  ```

  **Note:** The Kubernetes service that you want to discover must be either a `LoadBalancer` or `NodePort` type.

2. If the service that you added the discovery annotation for has other applications that depend on it, add the service to the application's entry as a deployable dependency.

  The following example shows how to add this dependency:

  ```
  apiVersion: apps.ibm.com/v1alpha1
  kind: Deployable
  metadata:
    name: name1
    namespace: workspace
  spec:
    template:
      apiVersion: extensions/v1beta1
      kind: Deployment
      metadata:
        name: ibm-websphere
        labels:
          app: ibm-websphere
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: ibm-websphere
        template:
          metadata:
            labels:
              app: ibm-websphere
          spec:
            containers:
            - name: ibm-websphere
              image: "registry.ng.bluemix.net/seed/ibm-websphere-sample"
              imagePullPolicy: Always
    dependencies:
    - name: dbservice
      namespace: database
      kind: Service
      apiGroup: v1
   placement:
      clusterNames:
      - managed cluster1
  ```

  The deployable dependent service is automatically discovered in the cluster (`managed cluster1`) in which the application is deployed. 
  
3. Access the discovered service by using the following format:
  
  ```
  <service-name>.<service-namespace>.<service-registry-dns-suffix>
  ```
  {: codeblock}
  
  
  An example of the format is: `dbservice.database.mcm.svc`.


