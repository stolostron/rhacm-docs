---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-26"

---

# Modifying the multicluster endpoint settings of your cluster

You can modify the settings of `multicluster endpoint` to change your configuration either by using the hub cluster or the managed cluster.

The `multicluster endpoint` operator manages the functions that are enabled and disabled according to the settings in the `endpoint.multicloud.ibm.com` Kubernetes resource.

The following settings can be updated in the `endpoint.multicloud.ibm.com` Kubernetes resource:

|Setting name|Value|
|-----------------------|------------|
|applicationmanager |`true` or `false`|
|metering |`true` or `false`|
|policyController |`true` or `false`|
|prometheusIntegration |`true` or `false`|
|searchCollector |`true` or `false`|
|serviceRegistry: dnsSuffix: |`mcm.svc`|
|serviceRegistry |`true` or `false`|
|serviceRegistry: plugins: |`kube-service`|
|tillerIntegration |`true` or `false`|
|topologyCollector |`true` or `false`|
{: caption="Table 1. Settings for endpoint.multicloud.ibm.com" caption-side="top"}

## Modify from the hub cluster

You can modify the settings of the `endpoint.multicloud.ibm.com` resource by using the hub cluster. Complete the following steps to change the settings: 

1. Authenticate into the Red Hat Advanced Cluster Management for Kubernetes console of the hub cluster.

2. From the main menu of the hub cluster console, select **Search**. 

3. In the search parameters, enter the following value: `kind:endpoint`

4. Select the endpoint resource that you want to update.

5. Find the `spec` section and select **Edit** to edit the content.

6. Modify your settings.

7. Select **Save** to apply your changes. 

## Modify from the managed cluster

You must have access to the `multicluster endpoint` namespace to modify your settings by using the managed cluster. Complete the following steps:

1. Authenticate into the managed cluster.

2. Enter the following command to edit the resource:

  ```
  kubectl edit endpoint.multicloud.ibm.com endpoint -n multicluster -endpoint
  ```

3. Find the `spec` section.

4. Modify your settings, as necessary.
