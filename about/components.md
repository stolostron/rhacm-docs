---

copyright:
  years: 2020
lastupdated: "2020-03-13"

---

# Services and components

See the following tables for information about components that are installed and enabled on the hub cluster by default.

|Service|Description|Required|
|--------|-----------|-------------------|
|management-ingress|Unifies all management services behind a network ingress controller with predictable annotations and TLS protection. This service should not be accessed directly.|Yes|
|cert-manager||Yes|
|cert-manager-webhook||Yes|
|configmap-watcher||Yes|
|mongo-db|All platform services that require a persistent data store use the MongoDB service. Highly available topologies for MongoDB are supported out of the box. This is a service that should not be accessed directly.|Yes|
|etcd||Yes|
{: caption="Table 1. Red Hat Advanced Cluster Management for Kubernetes default enabled services" caption-side="top"}

|Service|Description|Required|
|--------|-----------|---------------------|
|apiserver||Yes|
|application-ui||Yes|
|console|Provide a view of the resources available in the cluster with support for creation, modification, or removal.|Yes|
|controller||Yes|
|grc-ui||Yes|
|grc-ui-api||Yes|
|hive||Yes|
|kui-web-terminal|Provides the Visual Web Terminal.|Yes|
|mcm-compliance||Yes|
|mcm-topology||Yes|
|mcm-topology-api||Yes|
|multicloudhub-repo|Provides management of the single cluster or many clusters. This includes tracking multicloud inventory of cluster resources and configuration, as well as enforcing the multicloud Kubernetes security and compliance policy management.|Yes|
|multicloud-manager||Yes|
|multicloud-operators-cluster-controller||Yes|
|multicluster-inventory||Yes|
|rcm-api||Yes|
|rcm-controller||Yes|
|redisgraph-tls||Yes|
|search-aggregator||Yes|
|search-api||Yes|
|search-collector|Provides the capability to search for resources using the console and Visual Web Terminal |Yes|
|topology-aggregator||Yes|
|webhook||Yes|
{: caption="Table 2. Red Hat Advanced Cluster Management for Kubernetes default enabled components on the hub cluster" caption-side="top"}

There are some services that are installed on the managed clusters, but not enabled by default. You can enable them by activating them in the `config.yaml` file. The following table shows the services that are installed, but not enabled by default:

|Service|Description|Required need dev input|
|--------|-----------|-------------------|
|Empty|Empty|Empty|
{: caption="Table 3. Red Hat Advanced Cluster Management for Kubernetes enabled components on the managed cluster" caption-side="top"}
