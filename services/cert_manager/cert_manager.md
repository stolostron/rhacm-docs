---

copyright:
  years: 2018, 2020
lastupdated: "2020-03-03"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}


# Using {{site.data.keyword.product}} Certificate manager (cert-manager)

**Note:** Beginning with release 1.3.0, apiVersion `certmanager.k8s.io/v1alpha1` in all cert-manager Custom Resources (Certificates, Issuers, and ClusterIssuers) is deprecated. Replaced by `certmanager.io/v1alpha2` for all cert-manager custom resources in a future release. New apiVersion not yet available in this release.

You can use the {{site.data.keyword.product}} cert-manager to create and mount a certificate to a Kubernetes Deployment, StatefulSet, or DaemonSet. You can also create and add a certificate to a Kubernetes Ingress.
{:shortdesc}

_Issuer_, _ClusterIssuer_, and _Certificate_ are Kubernetes resource types that were introduced to support certificate generation and lifecycle management. For more information about cert-manager, see the [cert-manager community documentation ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cert-manager.readthedocs.io/en/latest/).

See the following list to learn how {{site.data.keyword.product}} cert-manager works:

 *	The Issuer signs new certificates and key pairs.
 *  The certificate object is similar to a certificate signing request.
 *	The actual X.509 certificate and key pair for TLS or authentication is stored as a Kubernetes Secret.
 *  The certificate is renewed automatically or can be renewed manually.

First, create an Issuer and then create a certificate that will be signed by that Issuer. {{site.data.keyword.product}} Certificate manager generates an X.509 certificate and key pair and stores it within a Kubernetes Secret.

Certificate manager supports IPv4 and IPv6 addresses.

For more information about Certificate manager and other configuration tools, see the following product documentation:

- {: child} [Creating your own self-signed and CA Issuers ](create_issuer.md)
- {: child} [Creating {{site.data.keyword.product}} cert-manager certificates](create_cert.md)
- {: child} [Viewing {{site.data.keyword.product}} cert-manager resources](cert_view.md)
- {: child} [Refreshing {{site.data.keyword.product}} cert-manager certificates](refresh_certs.md)
- {: child} [Adding certificates by using the Vault Issuer](cert_vault.md)
- {: child} [Adding certificates by using the Acme Issuer](cert_acme.md)
- {: child} [Adding certificates by using the ECDSA algorithm for encryption](cert_ecdsa.md)
- {: child} [{{site.data.keyword.product}} Certificate Manager role-based access control (RBAC) support](cert_manager_rbac.md)

For information about refreshing, replacing, and restoring certificates that are created and managed by Installer, see [Certificates in {{site.data.keyword.product}}](certificates.md)  


{: childlinks}
