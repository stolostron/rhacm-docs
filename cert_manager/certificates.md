---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Certificates in Red Hat Advanced Cluster Management for Kubernetes

Various certificates are created and used throughout Red Hat Advanced Cluster Management for Kubernetes.
{:shortdesc}

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
{: codeblock}

### Created and managed by Red Hat Advanced Cluster Management for Kubernetes Certificate manager (_cert-manager_)

The following internal services use `cert-manager` to create and manage their certificates: 

* MongoDB
* Web Terminal

All certificates managed by `cert-manager` for example, MongoDB, are managed (created, refreshed, and watched) by `cert-manager`.

For more information about `cert-manager`, see [Using Red Hat Advanced Cluster Management for Kubernetes Certificate manager](cert_manager.md).
