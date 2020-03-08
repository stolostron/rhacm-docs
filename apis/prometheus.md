---

copyright:
  years: 2016, 2019
lastupdated: "2019-12-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Prometheus API

Red Hat Advanced Cluster Management for Kubernetes version {{site.data.keyword.version_cp}} uses Prometheus Version 2.0 to manage the metrics from scrape targets.
{:shortdesc}

Both the cluster administrator and team administrator can access the Prometheus API.

You must access Prometheus through the Prometheus API service proxy.

To view the Prometheus API docs, see [Prometheus HTTP API ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://prometheus.io/docs/prometheus/latest/querying/api/){: new_window}.

## Running Prometheus API commands

When you run a Prometheus API command, you must obtain and specify the authentication header. See [Preparing to run component or management API commands](../iam/3.4.0/apis/access_api.md).

After you obtain that information, you can run Prometheus API commands. For example, to get the boot time for all nodes, run the following command:

```
curl -k -s -X GET -H "Authorization:Bearer $ACCESS_TOKEN" https://<Cluster Master Host>:<Cluster Master API Port>/prometheus/api/v1/query?query=node_boot_time_seconds
```
{: codeblock}

* `$ACCESS_TOKEN` is the variable that stores the authentication token for your cluster.
* `<Cluster Master Host>` and `<Cluster Master API Port>` are defined in [Master endpoints](../installer/3.2.2/cluster_endpoints.md#master).

The output resembles the following content:

```
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"__name__":"node_boot_time","app":"monitoring-prometheus", \
"chart":"ibm-icpmonitoring-1.1.0","component":"nodeexporter","heritage":"Tiller","instance":"9.42.135.189:9100", \
"job":"kubernetes-service-endpoints","kubernetes_name":"monitoring-prometheus-nodeexporter","kubernetes_namespace":"kube-system", \
"release":"monitoring"},"value":[1523394278.231,"1521476293"]}, \
{"metric":{"__name__":"node_boot_time","app":"monitoring-prometheus","chart":"ibm-icpmonitoring-1.1.0", \
"component":"nodeexporter","heritage":"Tiller","instance":"9.42.135.84:9100","job":"kubernetes-service-endpoints", \
"kubernetes_name":"monitoring-prometheus-nodeexporter","kubernetes_namespace":"kube-system","release":"monitoring"}, \
"value":[1523394278.231,"1521476285"]},{"metric":{"__name__":"node_boot_time","app":"monitoring-prometheus", \
"chart":"ibm-icpmonitoring-1.1.0","component":"nodeexporter","heritage":"Tiller","instance":"9.42.78.191:9100", \
"job":"kubernetes-service-endpoints","kubernetes_name":"monitoring-prometheus-nodeexporter","kubernetes_namespace": \
"kube-system","release":"monitoring"},"value":[1523394278.231,"1521476254"]}]}}
```
{: pre}
