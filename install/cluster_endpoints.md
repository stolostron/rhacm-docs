---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-24"

---

# Red Hat Advanced Cluster Management for Kubernetes endpoints

An endpoint is a network destination address that is exposed by Kubernetes resources, such as services and ingresses. The following sections describe the available external and internal endpoints in an Red Hat Advanced Cluster Management for Kubernetes cluster.

See the endpoints that are created in your Red Hat Advanced Cluster Management for Kubernetes cluster.

- [External endpoints](cluster_endpoints.md#external)
  - [Master endpoint](cluster_endpoints.md#master)
  - [Proxy endpoint](cluster_endpoints.md#proxy)
  - [NodePort endpoint](cluster_endpoints.md#nodeport)
- [Internal endpoints](cluster_endpoints.md#internal)


## External endpoints
{: #external}

The Master and Proxy endpoints are the external endpoints that are used for access from outside the cluster. <!--You define these endpoints in the `config.yaml` during installation.--> Typically, you create a fully qualified domain name (FQDN), which is a DNS entry and CA-signed certificate, and apply it to the Red Hat Advanced Cluster Management for Kubernetes master node. The master node applies the FQDN to all master endpoints.

The external endpoints can be defined in one of the following ways:

- Single node endpoint: The IP address or FQDN of a single node
- HA Endpoints that use a virtual IP address (VIP): The VIP address or FQDN of multiple HA nodes
- HA Endpoints that use a cluster load balancer: The load balancer IP address or FQDN of multiple HA nodes

### Master endpoint
{: #master}

All platform APIs are accessed through the Master node or nodes directly through the management ingress or through the management load balancer. 

Following is the format of the URL to access the master endpoint:

`https://<Cluster Master Host>:<Cluster Master API Port>/<API path>`

Where:  
- **Cluster Master Host** is one of the following values:
 <!-- - The `cluster_CA_domain` value in the [`config.yaml`](config_yaml.md#cluster_setting) file.-->
  - The `cluster_ca_domain` value in the [`ibmcloud-cluster-info`](configmap_cluster.md) ConfigMap.
 <!-- - The `cluster_lb_address` value in the [`config.yaml`](config_yaml.md#cluster_setting) file.-->
  - The `cluster_address` value in the [`ibmcloud-cluster-info`](configmap_cluster.md) ConfigMap.
- **Cluster Master API Port** is one of the following values: 
  <!--- The `router_http_port` value in the [`config.yaml`](config_yaml.md#general_setting) file.-->
  - The `cluster_router_http_port` value in the [`ibmcloud-cluster-info`](configmap_cluster.md) ConfigMap.
  <!--- The `router_https_port` value in the [`config.yaml`](config_yaml.md#general_setting) file.-->
  - The `cluster_router_https_port` value in the [`ibmcloud-cluster-info`](configmap_cluster.md) ConfigMap.
- **Kubernetes API Port** is one of the following values:
  - Any `<Cluster Master API Port>` value. 
  - The `cluster_kube_apiserver_port` in the [`ibmcloud-cluster-info`](configmap_cluster.md) ConfigMap.
 <!-- - The `kube_apiserver_secure_port` in the [`config.yaml`](config_yaml.md#kub_setting) file.-->

### Proxy endpoint
{: #proxy}

The proxy endpoint is one or more ingress proxies that are exposed by workloads that are deployed on Red Hat Advanced Cluster Management for Kubernetes through the ingress resource.  

Following is the format of the URL:

`https://<Cluster Proxy Host>:<Cluster Proxy API Port>/<API path>`

Where: 
- **Cluster Proxy Host** is one or more of the following values:
 <!-- - The `proxy_vip` value in the [`config.yaml`](config_yaml.md#proxy_ha_setting) file.-->
 <!-- - The `proxy_lb_address` value in the [`config.yaml`](config_yaml.md#cluster_setting) file.-->
  - The `proxy_address` value in the [`ibmcloud-cluster-info`](configmap_cluster.md) ConfigMap.
  - A custom fully qualified domain name.
- **Cluster Proxy API Port** is either of the following values: 
 <!-- - The TLS `ingress_https_port` value in the [`config.yaml`](config_yaml.md#general_setting) file.-->
  - The TLS `proxy_ingress_https_port` value in the [`ibmcloud-cluster-info`](configmap_cluster.md) ConfigMap.
 <!-- - The unsecured `ingress_http_port` value in the [`config.yaml`](config_yaml.md#general_setting) file.-->
  - The unsecured `proxy_ingress_http_port` value in the [`ibmcloud-cluster-info`](configmap_cluster.md) ConfigMap.

### NodePort endpoint
{: #nodeport}

Workloads can define services that are exposed as NodePorts. If a service uses the NodePort type, it bypasses the proxy endpoint.  

## Internal Endpoints
{: #internal}

Your Red Hat Advanced Cluster Management for Kubernetes cluster has an internal network for workloads. Services must communicate with the workloads on the internal cluster network.

Services that need to communicate within the cluster to platform services do so by using the internal management ingress service on the internal cluster network, unless otherwise specified by the service API documentation.

The endpoint to access platform services is `https://icp-management-ingress.kube-system:8443`. This endpoint is the internal endpoint for the management ingress and is available from all namespaces.

For other services, following are the formats to access the service by using the service name in the local cluster: 

- If the service is in the same namespace, the format is `https://<service-name>:8443`.  
- If the service is in a different namespace, the format is `https://<service-name>.<namespace-name>:8443`.

For more information, see the following articles:

- [DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/){: new_window}
- [DNS](https://kubernetes.io/docs/concepts/services-networking/service/#dns){: new_window}


### Custom ingress URLs

By default, the `platform-oidc` and `platform-auth` ingresses use the localhost for Cross-Origin Resource Sharing (CORS). You can specify additional domains that the ingresses can use.

Add the domains to the ingress. See the following example:
```
add_header "Access-Control-Allow-Origin" "http://test.com, https://example.com"
```





