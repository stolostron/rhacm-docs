---

copyright:
  years: 2018, 2020
lastupdated: "2020-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}


# Using Red Hat Advanced Cluster Management for Kubernetes Certificate manager (cert-manager)

You can use the Red Hat Advanced Cluster Management for Kubernetes cert-manager to create and mount a certificate to a Kubernetes Deployment, StatefulSet, or DaemonSet. You can also create and add a certificate to a Kubernetes Ingress.
{:shortdesc}

_Issuer_, _ClusterIssuer_, and _Certificate_ are Kubernetes resource types that were introduced to support certificate generation and lifecycle management. For more information about cert-manager, see the [cert-manager community documentation](https://cert-manager.readthedocs.io/en/latest/){:new_window}.

See the following list to learn how Red Hat Advanced Cluster Management for Kubernetes cert-manager works:

 *	The Issuer signs new certificates and key pairs.
 *  The certificate object is similar to a certificate signing request.
 *	The actual X.509 certificate and key pair for TLS or authentication is stored as a Kubernetes Secret.
 *  The certificate is renewed automatically or can be renewed manually.

First, create an Issuer and then create a certificate that will be signed by that Issuer. Red Hat Advanced Cluster Management for Kubernetes Certificate manager generates an X.509 certificate and key pair and stores it within a Kubernetes Secret.

Certificate manager supports IPv4 and IPv6 addresses.

For more information about Certificate manager and other configuration tools, see the following product documentation:

- {: child} [Creating your own self-signed and CA Issuers ](create_issuer.md)
- {: child} [Creating Red Hat Advanced Cluster Management for Kubernetes cert-manager certificates](create_cert.md)
- {: child} [Viewing Red Hat Advanced Cluster Management for Kubernetes cert-manager resources](cert_view.md)
- {: child} [Refreshing Red Hat Advanced Cluster Management for Kubernetes cert-manager certificates](refresh_certs.md)
- {: child} [Adding certificates by using the Vault Issuer](cert_vault.md)
- {: child} [Adding certificates by using the Acme Issuer](cert_acme.md)
- {: child} [Adding certificates by using the ECDSA algorithm for encryption](cert_ecdsa.md)
- {: child} [Red Hat Advanced Cluster Management for Kubernetes Certificate Manager role-based access control (RBAC) support](cert_manager_rbac.md)
{: childlinks}

For information about refreshing, replacing, and restoring certificates that are created and managed by Installer, see [Certificates in Red Hat Advanced Cluster Management for Kubernetes](certificates.md)  



