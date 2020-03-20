---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-19"

---

# Certificates in Red Hat Advanced Cluster Management for Kubernetes

Various certificates are created and used throughout Red Hat Advanced Cluster Management for Kubernetes.

More information about managing certificates created by the installer can be found in the following documents:

* [Refreshing certificates](refresh_certs.md)
* [Replacing certificates](byok_certs.md)
* [Restoring certificates](restore_certs.md)

## Creating a certificate

All certificates required by services that run on Red Hat Advanced Cluster Management for Kubernetes are created during the installation of Red Hat Advanced Cluster Management for Kubernetes. Certificates are either created and managed by the Red Hat Advanced Cluster Management for Kubernetes installer or by the Red Hat Advanced Cluster Management for Kubernetes Certificate manager (`cert-manager`).

Use the certificate policy controller to create and manage certificate policies. For more information, see [Certificate policy controller](../compliance/cert_policy_ctrl.md).

## Red Hat Advanced Cluster Management for Kubernetes Certificates

These are the certificates that are automatically created during the installation of Red Hat Advanced Cluster Management for Kubernetes. 

#### Accessing the Red Hat Advanced Cluster Management for Kubernetes Root CA Certificate

The Red Hat Advanced Cluster Management for Kubernetes Root CA Certificate is stored within the Kubernetes Secret `multicloud-ca-cert` in the `open-cluster-management` namespace. The certificate can be imported into your client truststores to access Red Hat Advanced Cluster Management for Kubernetes Platform APIs.

To retrieve and decode the certificate, run the following command:

```
kubectl get secret -n open-cluster-management multicloud-ca-cert -o jsonpath='{.data.ca\.crt}' | base64 --decode
```

### Created and managed by Red Hat Advanced Cluster Management for Kubernetes Certificate manager (_cert-manager_)

The following internal services use `cert-manager` to create and manage their certificates: 

| Certificate Name | Issuer Name | Secret Name | Installed On | Usage |
| ---------------- | ----------- | ----------- | ------------ | ----- |
| console-chart-ef680-ca-cert | multicluster-hub-mcm-server-ca-issuer | console-chart-ef680-uiapi-secrets | Hub, Red Hat Advanced Cluster Management for Kubernetes namespace | Red Hat Advanced Cluster Management for Kubernetes Console CA cert |
| grc-59010-ca-cert | multicluster-hub-mcm-server-ca-issuer | grc-59010-grc-secrets | Hub, Red Hat Advanced Cluster Management for Kubernetes namespace | Red Hat Advanced Cluster Management for Kubernetes Govern and risk CA cert |
| kui-proxy | multicloud-ca-issuer | kui-proxy-secret | Hub, Red Hat Advanced Cluster Management for Kubernetes namespace | kui-web-terminal |
| management-ingress-a0ae5-cert | multicloud-ca-issuer | management-ingress-c38ac-tls-secret | Hub, Red Hat Advanced Cluster Management for Kubernetes namespace | Ingress |
| multicloud-ca-cert | cert-manager-rhacm-selfsign | multicloud-ca-cert | Hub, Red Hat Advanced Cluster Management for Kubernetes namespace | Red Hat Advanced Cluster Management for Kubernetes Root CA |
| search-prod-c62a6-aggregator-ca-cert | multicloud-ca-issuer | search-prod-95fcc-search-secrets | Hub, Red Hat Advanced Cluster Management for Kubernetes namespace | Search |
| search-prod-c62a6-redis-ca-cert | multicloud-ca-issuer | search-prod-95fcc-redisgraph-secrets | Hub, Red Hat Advanced Cluster Management for Kubernetes namespace | Search |
| search-prod-c62a6-search-ca-cert | multicloud-ca-issuer | search-prod-95fcc-search-api-secrets | Hub, Red Hat Advanced Cluster Management for Kubernetes namespace | Search |
| topology-276c4-ca-cert | multicluster-hub-mcm-server-ca-issuer | topology-b24e0-topology-secrets | Hub, Red Hat Advanced Cluster Management for Kubernetes namespace | Topology |
| endpoint-monitoring-ca-cert | endpoint-self-signed | endpoint-monitoring-ca-cert | Endpoint | Monitoring |
| endpoint-topology-ca-cert | endpoint-self-signed | endpoint-topology-ca-cert | Endpoint | Topology |
| endpoint-topology-client-cert | endpoint-topology | endpoint-topology-client-secret | Endpoint | Topology |
| endpoint-topology-server-cert | endpoint-topology | endpoint-topology-server-secret | Endpoint | Topoloy |
{: caption="Table 1. Certificates Red Hat Advanced Cluster Management for Kubernetes" caption-side="top"}

All certificates managed by `cert-manager` for example, MongoDB, are managed (created, refreshed, and watched) by `cert-manager`. For more information about `cert-manager`, see [Using Red Hat Advanced Cluster Management for Kubernetes Certificate manager](cert_manager.md).
