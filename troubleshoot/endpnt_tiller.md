---
copyright:
  years: 2019, 2020
lastupdated: "2020-03-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Multicluster-endpoint fails to initialize with user-installed Tiller in the `kube-system` namespace  

If your cluster remains in `Pending` status on the hub cluster, and `endpoint-workmgr` pod remains in `ContainerCreating` state, complete the following process:
{:shortdesc}

## Symptom

A new imported cluster remains in `Pending` status on the hub cluster, and `endpoint-workmgr` pod remains in `ContainerCreating` state.

  Run the following command to get the all the pods in the `multicluster-endpoint` namespace on the targeted managed cluster. Check the `endpoint-workmgr` pod status:

  ```
  kubectl get pod -n multicluster-endpoint
  ```
  {: codeblock}

  If the status of `endpoint-workmgr` pod is `ContainerCreating`, run the following command to describe the Tiller client certificate:

  ```
  kubectl describe certificate endpoint-workmgr-tiller-client-certs -n multicluster-endpoint
  ```
  {: codeblock}

  The output of the `describe` command displays the following message:
  ```
  Type     Reason          Age              From          Message
  ----     ------          ----             ----          -------
  Warning  IssuerNotFound  6m (x3 over 6m)  cert-manager  clusterissuer.certmanager.k8s.io "icp-ca-issuer" not found
  ```
  {: pre}

## Causes

The user-deployed Tiller is treated as an Red Hat Advanced Cluster Management for Kubernetes Tiller and does not work because of the CA issuer.

## Resolving the problem

Complete only one of the following options:

1. Remove the deployed Tiller from the `kube-system` namespace and redeploy it in another namespace.

  For more information about how to remove a Tiller deployment, see [Deleting or Reinstalling Tiller](https://helm.sh/docs/install/#deleting-or-reinstalling-tiller){: new_window}

  For more information about how to install Tiller in a specific namespace, see [Easy In-Cluster Installation](https://helm.sh/docs/install/#easy-in-chttps://github.ibm.com/ibmprivatecloud/cp4mcm/issues/422luster-installation){: new_window}

2. Disable Tiller integration feature of the multicluster-endpoint.

  Edit the `endpoint` resource in `multicluster-endpoint` namespace with the following command:

  ```
  kubectl edit endpoint -n multicluster-endpoint
  ```
  {: codeblock}

  In the editor, disable `tillerIntegration` feature by changing the `tillerIntegration` parameter to `enabled: false`, as it is displayed in the following example:

  ```
    tillerIntegration:
      enabled: false
  ```
  {: pre}
