---

copyright:
  years: 2019
lastupdated: "2019-09-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Enabling an Istio service for discovery

You can configure the {{site.data.keyword.mcm_notm}} service registry to discover Istio services that are in different {{site.data.keyword.mcm_notm}} managed clusters.
{: shortdesc}

When you have multiple instances of an Istio service that are managed by {{site.data.keyword.mcm_notm}}, it is challenging to maintain them. The {{site.data.keyword.mcm_notm}} service discovery function discovers Istio services that are configured to be discovered.

**Required user type or access level:** Cluster administrator.

## Enable the Istio discovery plug-in

The plug-in for the Istio discovery must be enabled if you want to discover an Istio service in your managed clusters. Complete the following steps to enable an Istio plug-in:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

2. Navigate to **Workloads** -> **Helm Releases**.

3. Select your `ibm-klusterlet` release.

4. Expand **All parameters**.

5. In the *Multicloud Manager service registry configuration* section, you can enable the plug-in that you want to use by entering it in the **Enabled Plugins** field. Your entry must be comma-separated, like the following example:

    ```
	kube-service,istio
	```

    **Note:** If you enable the Istio plug-in, you need to install the [Multicluster service mesh ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://istio.io/docs/concepts/multicluster-deployments/#multicluster-service-mesh){: new_window}. The mesh must include individually deployed Istio control planes in every cluster and must use gateways to connect services across clusters.

## Discover the Istio service

To discover an Istio service within the managed clusters, complete the following steps:

1. Add a service discovery annotation to the Istio service. You must add the annotation to your Istio service definition YAML file for the service that you want to discover.
  ```
  mcm.ibm.com/service-discovery
  ```
  {: codeblock}

  The following example shows how to add the annotation to the service definition YAML file:
  ```
  apiVersion: v1
  kind: Service
  metadata:
   annotations:
     mcm.ibm.com/service-discovery: "{}"
   name: dbservice
   namespace: database
  spec:
   ports:
   - name: http
      nodePort: 8080
      port: 8000
      protocol: TCP
   selector:
     app: dbservice
  ```
  {: codeblock}

2. If the Istio application that you added the discovery annotation for has other applications that depend on it, add the annotated service to the entry of the application as a deployable dependency.

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
   - name: dbgateway
     namespace: database
     kind: Service
  placement:
     clusterNames:
     - managed cluster1
  ```
  {: codeblock}  

  After you apply this deployable to an Istio system, its dependent service is automatically discovered in the cluster (`managed cluster1`) in which the application is deployed.

3. Access the discovered service by using the service hostname. In this example, the hostname is `mydb.database.global`.
