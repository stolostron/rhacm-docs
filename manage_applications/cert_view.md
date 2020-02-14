---

copyright:
  years: 2018, 2019
lastupdated: "2019-05-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}


# Viewing {{site.data.keyword.icp_notm}} cert-manager resources

The {{site.data.keyword.icp}} Certificate manager service creates three Kubernetes `CustomResourceDefinitions` (CRD):
1. Certificate
2. Issuer
3. ClusterIssuer


You can use the `kubectl` command to view these Kubernetes resources.
* [View the certificates in your cluster](#certs)
* [View the Issuers and ClusterIssuers in your cluster](#issuers)

## View the certificates in your cluster
{: #certs}

To view all the certificates that are created and managed by {{site.data.keyword.icp}} Certificate manager service, run the following command:

  ```
  kubectl get certificate --all-namespaces
  ```
  {: codeblock}

The command output provides the following information:

| Header | Description |
| ----------- | ----------- |
| Namespace | The namespace where this certificate is located. |
| Name | The name of the certificate. |
| Ready | Whether the certificate is successfully issued and ready for use. |
| Secret | The name of the secret that contains the issued certificate, and private key for the certificate. |
| Age | When the certificate resource was first created in Kubernetes. |
| Expiration | When the certificate expires. |

For more information about certificates, see [kubectl flags](https://kubernetes.io/docs/reference/kubectl/kubectl/).

For example, a `kubectl describe` gives you more information about the certificate:
  ```
  kubectl describe certificate <certificate name> -n <certificate namespace>
  ```
  {: codeblock}

## View the Issuers and ClusterIssuers in your cluster
{: #issuers}

To view the Issuers or ClusterIssuers available in your cluster, run the following command:
  ```
  # To view all Issuers
  kubectl get issuer --all-namespaces

  # To view ClusterIssuers
  kubectl get clusterissuer
  ```
  {: codeblock}
