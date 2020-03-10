---

copyright:
  years: 2018, 2020
lastupdated: "2020-03-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}


# Viewing Red Hat Advanced Cluster Management for Kubernetes cert-manager resources

The Red Hat Advanced Cluster Management for Kubernetes Certificate manager service creates five Kubernetes `CustomResourceDefinitions` (CRD):
1. Certificate
2. Issuer
3. ClusterIssuer
4. Orders
5. Challenges


You can use the `kubectl` command to view these Kubernetes resources.
* [View the certificates in your cluster](#certs)
* [View the Issuers and ClusterIssuers in your cluster](#issuers)
* [View the Orders and Challenges in your cluster](#orders)

## View the certificates in your cluster
{: #certs}

To view all the certificates that are created and managed by Red Hat Advanced Cluster Management for Kubernetes Certificate manager service, run the following command:

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

For more information about certificates, see [kubectl flags](https://kubernetes.io/docs/reference/kubectl/kubectl/){: new_window}.

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

## View the Orders and Challenges in your cluster
{: #orders}

Orders and Challenges resources are created to issue ACME HTTP certificates, and are promptly deleted once the domain is verified and the certificate is issued. To view them, run the following command:
  ```
  # To view all Orders
  kubectl get orders --all-namespaces
  
  # To view all Challenges
  kubectl get challenges --all-namespaces
  ```
  {: codeblock}
