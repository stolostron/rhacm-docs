---

copyright:
  years: 2020
lastupdated: "2020-01-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Services and components

See information about services that are installed and enabled by default, as well as whether they can be disabled in the environment for this {{site.data.keyword.cloud_pak}}.
{:shortdesc}

|Service|Description|Required|
|--------|-----------|-------------------|
|audit-logging|Supported by Elasticsearch, Fluentd, and Kibana. Enables consistent audit behavior for PCI-DSS and other data compliance standards and ensures that all data in transit is TLS-secured using secure ciphers that meet FIPS requirements. Ensures all data at rest is encrypted using secure ciphers that meet FIPS requirements.|No|
|auth-apikeys|Works with other Identity and Access Management services to control roles and access in the environment.|Yes, if using OIDC, service IDs, API keys, or other Identity and Access Management services.|
|auth-idp|Works with other Identity and Access Management services to control roles and access in the environment.|Yes, if using OIDC, service IDs, API keys, or other Identity and Access Management services.|
|auth-pap|Works with other Identity and Access Management services to control roles and access in the environment.|Yes, if using OIDC, service IDs, API keys, or other Identity and Access Management services.|
|auth-pdp|Works with other Identity and Access Management services to control roles and access in the environment.|Yes, if using OIDC, service IDs, API keys, or other Identity and Access Management services.|
|catalog-ui|Discovers and deploys {{site.data.keyword.IBM_notm}} workload middleware.|Yes|
|cert-manager|Provides cluster services with a way to request signed certificates that are based on local hostnames and provide for the revocation or reconfiguration of the TLS certificates.|Yes|
|cert-manager-webhook||Yes|
|cloudctl | The `cloudctl` command line tool is installed and is required for installing {{site.data.keyword.IBM}} Passport Advantage archives. | Yes |
|helm-api|Packages, deploys, and upgrades {{site.data.keyword.IBM_notm}} and open source software. |No|
|helm-repo|Provides a repository to store Helm charts.|No|
|iam-policy-controller||Yes|
|icp-management-ingress|Unifies all management services behind a network ingress controller with predictable annotations and TLS protection. This service should not be accessed directly.|Yes|
|image-security-enforcement|**Note:** Disabled by default in {{site.data.keyword.ppc_notm}}.|Yes|
|key-management|Enables workloads to manage the keys that are used to encrypt data and integrate with software modules.|No|
|key-management-hsm|Enables workloads to manage the keys that are used to encrypt data and integrate with Hardware Service Modules.|No|
|installation | Common process for preparing services and {{site.data.keyword.cloud_pak}} software | Yes |
|mcm-kui|Provides the {{site.data.keyword.kui}}.|Yes|
|metering|Supported by {{site.data.keyword.IBM_notm}} Metering. Requires content to provide the correct tags for the metering service to understand usage for licensing.|Yes|
|mgmt-repo|Helm repository for common management services. **Note:** Required for dependencies. Do not access directly.|Yes|
|mongo-db|All platform services that require a persistent data store use the MongoDB service. Highly available topologies for MongoDB are supported out of the box. This is a service that should not be accessed directly.|Yes|
|monitoring|Supported by Prometheus, Heapster & Grafana. Collects health metrics from the platform, services, workload and application containers. Ensures that all data in transit is TLS-secured using secure ciphers that meet FIPS requirements. Ensure all data at rest is encrypted using secure ciphers that meet FIPS requirements. |Yes|
|monitoring-crd|Supported by Prometheus, Heapster & Grafana. Collects health metrics from the platform, services, workload and application containers. Ensures that all data in transit is TLS-secured using secure ciphers that meet FIPS requirements. Ensure all data at rest is encrypted using secure ciphers that meet FIPS requirements. Health Dashboard CRD Controller allows content to declare their Grafana & Kibana dashboards as part of their Kubernetes resource model to add or remove dashboards as content is deployed or removed.|Yes|
|multicluster-hub|Provides management of the single cluster or many clusters. This includes tracking multicloud inventory of cluster resources and configuration, as well as enforcing the multicloud Kubernetes security and compliance policy management.|No|
|nginx-ingress|Ingress for applications services with predictable annotations and TLS protection. The platform provides a common set of annotations to enable network access to API and web surfaces for deployed workloads.|No|
|oidcclient-watcher|Works with other Identity and Access Management services to control roles and access in the environment.|Yes, if using OIDC, service IDs, API keys, or other Identity and Access Management services.|
|platform-api| Service that is used by `cloudctl` and other services, and should not be accessed directly. |Yes|
|common-web-ui|Provide a view of the resources available in the cluster with support for creation, modification, or removal.|Yes|
|search|Provides the capability to search for resources using the {{site.data.keyword.gui}} and {{site.data.keyword.kui}} |Yes|
|secret-watcher|Works with other Identity and Access Management services to control roles and access in the environment.|Yes, if using OIDC, service IDs, API keys, or other Identity and Access Management services.|
|security-onboarding|Works with other Identity and Access Management services to control roles and access in the environment.|Yes, if using OIDC, service IDs, API keys, or other Identity and Access Management services.|
|tiller|Provides a secure implementation of the Tiller component that is found in the community, which addresses several open authorization gaps that are not addressed in the community implementation. Maintains API compatibility with the community Helm command line, and provides access to Helm charts by using an API.|Yes, if you are using the Identity and Access Management services.|
{: caption="Table 1. {{site.data.keyword.cloud_pak_mcm}} and standalone {{site.data.keyword.mcm_notm}} enabled services" caption-side="top"}

There are some services that are installed, but not enabled by default. You can enable them by activating them in the `config.yaml` file. The following table shows the services that are installed, but not enabled by default:

|Service|Description|Required|
|--------|-----------|-------------------|
|logging| Supported by Elasticsearch, Logstash, Filebeat, and Kibana. Collects container logs from `stdout`, `stderr`, and custom file definitions within the container and ensures that all data in transit is TLS-secured using secure ciphers that meet FIPS requirements. Ensures that all data is encrypted at rest using secure ciphers that meet FIPS requirements. | No, unless you are bundling Kibana dashboards or invoking logging APIs. |
|mutation-advisor| Discovers modifications of running containers, supporting PCI-DSS file integrity requirements.|No |
|platform-pod-security| When deploying content across multiple Kubernetes vendors, the workload must validate or document what PodSecurityPolicies or SecurityContextConstraints (for RHOS) are required or expected. |No|
|system-healthcheck-service|Healthcheck service to query and interrogate health of services.|No|
|vulnerability-advisor|Discovers common vulnerabilities & exposures (CVEs) and insecure configurations of container images and running containers. |No|
{: caption="Table 2. {{site.data.keyword.cloud_pak_mcm}} and standalone {{site.data.keyword.mcm_notm}} disabled services" caption-side="top"}
