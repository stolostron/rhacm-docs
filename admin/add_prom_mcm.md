---

copyright:
  years: 2016, 2019
lastupdated: "2019-12-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Adding more Prometheus instances to manage cluster monitoring

In {{site.data.keyword.product}} hub clusters, there is one Prometheus instance for local cluster monitoring. The instance also collects metrics data for all the managed clusters. A single Prometheus instance does not work well in heavy workload scenarios. For example, when the number of managed clusters increases, the Prometheus instance might fail.

You can add more Prometheus instances to avoid this situation. Complete the following steps to add more Prometheus instances to manage clusters monitoring. 

1. Create configmap, `hub-prometheus-config` in the `kube-system` namespace. 

  The following configmap is an example of `hub-prometheus-config`.

   ```
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: hub-prometheus-config
   data:
     prometheus_config.yaml: |-
       defaultPrometheus: prometheus-1
       prometheusDefaultConfig:
         image: ibmcom/prometheus:v2.8.0-build.2
         routerImage: ibmcom/icp-management-ingress:2.5.0
         retention: 24h
         scrapeInterval: 1m
         evaluationInterval: 1m
         resources:
           limits:
             memory: 2048Mi
         volumeClaimTemplate:
           spec:
             storageClassName: "*******"
             accessModes: ["ReadWriteOnce"]
             resources:
               requests:
                 storage: 10Gi
       prometheusInstances:
         - name: prometheus-2
           retention: 30d
           resources:
             limits:
               memory: 1024Mi
   ```
   {: pre}

   For information about `hub-prometheus-config` parameters, see Table 1. Table of `hub-prometheus-config` parameters.

2. Add, update, or delete Prometheus instances by updating the `hub-prometheus-config` configmap. 

   - A new Prometheus resource is created for each item that you add to `prometheusInstances`. Additionally, a new Grafana datasource, and a Kubernetes service, which points to this new Prometheus instance are also created. All of these items have the same name, which is the value of the `name` parameter.
   - When you update configuration parameters, the related Prometheus instances pick up the updated configurations. 
   - If you delete one or more items in `prometheusInstances`, the related Prometheus instances, and the corresponding Grafana datasources and Kubernetes services are removed. After one Prometheus instance is deleted, all of the metrics data is lost.
   - If you delete the configmap, all additional Prometheus instances are removed.

3. View metrics for managed clusters in different Prometheus instances.

   - From the Grafana console, open the `MCM: Managed Cluster Monitoring` dashboard. At the top of the dashboard, locate the Datasource for the Managed Cluster table.
   - To view metrics for one managed cluster, locate the datasource name for that cluster in the table. From the drop-down box, select the datasource to which your wanted cluster belongs, and select the cluster. You can now view the metrics for the selected cluster.

4. Change the Prometheus instance that is associated with your managed cluster.

   Each managed cluster has a corresponding `ServiceMonitor` that adds the managed cluster as a scrape target to one Prometheus instance. The `ServiceMonitor` is automatically created when the cluster is imported, and it includes the `prometheus` label whose value points to the name of the target Prometheus instance. During the `ServiceMonitor` creation, the label uses the value of `defaultPrometheus` in the `hub-prometheus-config` configmap.

   If you want to change a managed cluster to use another Prometheus instance for monitoring, you can manually update the `ServiceMonitor` to set the value of the `prometheus` label to use the name of a different Prometheus instance.

   **Note:** After you change the Prometheus instance that is associated with a managed cluster, all historical metrics data is removed.  The data that is stored in the old Prometheus instance is not migrated to the new Prometheus instance.

The following table contains information about `hub-prometheus-config` parameters.

   | Parameters | Description |
   |----|----|
   | `prometheusDefaultConfig` | The default configuration for additional Prometheus instances. |
   | `image` | Prometheus container image. |
   | `routerImage` | Sidecar router image. |
   | `retention` | Length of time to retain old metrics data. |
   | `evaluationInterval` | The frequency at which you evaluate alert rules.|
   | `resources` | Request and limit resources (cpu and memory) for the Prometheus container. For more information, see [ResourceRequirements](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#resourcerequirements-v1-core).|
   | `volumeClaimTemplate.spec` | The persistent volume configuration for the Prometheus instance. For more information, see [PersistentVolumeClaimSpec](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#persistentvolumeclaimspec-v1-core).|
   | `prometheusInstances` |Specify a list of Prometheus instances. Each item in the list represents one additional Prometheus instance. Each one has a required `name` parameter, which is the unique ID for one Prometheus instance. Allowed characters include: digits (0-9), lowercase letters (a-z), **-**, and **.** . Each item can also include optional parameters that are available in `prometheusDefaultConfig`. The values that are defined in `prometheusInstances` override the values that are defined in `prometheusDefaultConfig` during Prometheus instance launching.|
   | `defaultPrometheus` | Specify the current active Prometheus instances. Newly imported managed clusters are federated with the active instances.|
   {: caption="Table 1. Table of `hub-prometheus-config` parameters " caption-side="}

## Logs and metrics management for Prometheus
{: #promlogs}

You can modify the time period for metric retention by updating the `storage.tsdb.retention` parameter in the `config.yaml` file. By default this value is set at `24h`, which means that the metrics are kept for 24 hours and then purged. For more information, see [Configuring the monitoring service](../monitoring/1.7.0/monitoring.md).

However, if you need to manually remove this data from the system, you can use the rest API that is provided by the Prometheus component.

   * To delete metrics data, see [Delete Series ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://prometheus.io/docs/prometheus/latest/querying/api/#delete-series).
   * To remove the deleted data from the disk, and clean up the disk space, see [Clean Tombstones ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://prometheus.io/docs/prometheus/latest/querying/api/#clean-tombstones).

The target URL must use the following format:
```
https://<IP_address>:<Port>/prometheus
```
{: codeblock}

- `<IP_address>` is the IP address that is used to access the {{site.data.keyword.gui}}.
- `<Port>` is the port that is used to access the {{site.data.keyword.gui}}.

 * The command to delete metrics data resembles the following code:

     ```
     https://<IP_address>:<Port>/prometheus/api/v1/admin/tsdb/delete_series?*******
     ```
     {: codeblock}

 * The command to remove deleted data and clean up the disk, resembles the following code:

     ```
     https://<IP_address>:<Port>/prometheus/api/v1/admin/tsdb/clean_tombstones
     ```
     {: codeblock}

## Accessing monitoring service APIs
{: #msapis}

You can access monitoring service APIs such as Prometheus and Grafana APIs. Before you can access the APIs, you must obtain authentication tokens to specify in your request headers. For information about obtaining authentication tokens, see [Preparing to run component or management API commands](../iam/3.4.0/apis/access_api.md)

After you obtain the authentication tokens, complete the following steps to access the Prometheus and Grafana APIs.

1. Access the Prometheus API at url, `https://<Cluster Master Host>:<Cluster Master API Port>/prometheus/*` , and get boot times of all nodes.

   * `$ACCESS_TOKEN` is the variable that stores the authentication token for your cluster.
   * `<Cluster Master Host>` and `<Cluster Master API Port>` are defined in [Master endpoints](../installer/3.2.2/cluster_endpoints.md#master).

   ```
   curl -k -s -X GET -H "Authorization:Bearer $ACCESS_TOKEN" https://<Cluster Master Host>:<Cluster Master API Port>/prometheus/api/v1/query?query=node_boot_time_seconds
   ```
   {: pre}

   For detailed information about Prometheus APIs, see [Prometheus HTTP API ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://prometheus.io/docs/prometheus/latest/querying/api/).

2. Access the Grafana API at url, `https://<Cluster Master Host>:<Cluster Master API Port>/grafana/*` and obtain the `sample` dashboard.

   * `$ACCESS_TOKEN` is the variable that stores the authentication token for your cluster.
   * `<Cluster Master Host>` and `<Cluster Master API Port>` are defined in [Master endpoints](../installer/3.2.2/cluster_endpoints.md#master)

   ```
   curl -k -s -X GET -H "Authorization: Bearer $ACCESS_TOKEN” "https://<Cluster Master Host>:<Cluster Master API Port>/grafana/api/dashboards/db/sample"
   ```
   {: pre}

   For detailed information about Grafana APIs, see [Grafana HTTP API Reference ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](http://docs.grafana.org/http_api/).

## Support for custom cluster access URL in monitoring service
{: #mscustom_url}

You can customize the cluster access URL. For more information, see [Customizing the cluster access URL](../iam/3.4.0/custom_url.md). After you complete the customization, you must manually edit the Prometheus and Alertmanager resources and verify that all external links are correct.
### Prometheus resource

Use `kubectl` to edit the `monitoring-prometheus` resource. For example:

 ```
 kubectl edit prometheus monitoring-prometheus -n kube-system
 ```
 {: pre}

In the `monitoring-prometheus` Prometheus resource, change `externalUrl:*` to the following code:
 ```
 externalUrl: https://<custom_host>:<custom_port>/prometheus
 ```
 {: pre}

`<custom_host>` and `<custom_port>` are the customized host name and port that you defined in the custom cluster access URL.

### Alertmanager resource

Use `kubectl` to edit the `monitoring-prometheus-alertmanager` resource. For example:
 ```
 kubectl edit alertmanager monitoring-prometheus-alertmanager -n kube-system
 ```
 {: pre}

In the `monitoring-prometheus-alertmanager` Alertmanager resource, change `externalUrl:*` to the following code:
 ```
 externalUrl: https//:<custom_host>:<custom_port>/alertmanager
 ```
 {: pre}

`<custom_host>` and `<custom_port>` are the customized host name and port that you defined in the custom cluster access URL.
