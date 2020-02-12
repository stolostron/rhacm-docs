---
copyright:
  years: 2019
lastupdated: "2019-10-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Manually deleting a namespace fails when the cluster resources still exist

Deleting a namespace results in `Terminating` status because the `cluster.cluster.k8s.io` cluster resource was not and cannot be deleted.
{:shortdesc}

## Symptom

When you attempt to delete a namespace, the status remains in `terminating` state.

## Resolve the issue

1. For {{site.data.keyword.open_s}}, get the cluster metadata information from the secret. You need the secret to complete step 5. 

For the other available cloud providers, proceed to step 2.

Run the following command to get the secret name for ({{site.data.keyword.open_s}}):

```
kubectl get secret -n <namespace> -l cloud-provider=ocp,purpose=import-cluster | grep <your-cluster-name>
```
{:codeblock}

Generate the `metadata.json` file with the following command:

```
kubectl get secret <your-secret-name> -n <namespace> -o 'go-template={{index .data "metadata.json"}}' | base64 --decode > metadata.json
```
{:codeblock}

2. Run the following command to remove the _finalizer_ on the cluster resource:
   
```
kubectl -n <namespace> patch cluster.cluster.k8s.io/<cluster_name> -p '{"metadata":{"finalizers":[]}}' --type=merge
```
{:codeblock}

3. Confirm that your cluster was deleted by running the following command:

```
kubectl -n <namespace> get clusters.cluster.k8s.io
```
{:codeblock}

4. Confirm that the namespace was deleted:

```
kubectl get namespaces
```
{:codeblock}

5. Delete the cluster from the remote cloud provider manually. See the following resources from the cloud provider documentation:

- For {{site.data.keyword.iks}} [{{site.data.keyword.iks}} removing clusters ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/containers?topic=containers-remove){: new_window}.

- For {{site.data.keyword.open_s}} on Amazon Web Services (AWS), see [{{site.data.keyword.open_s}}: Removing a cluster from AWS ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/4.1/installing/installing_aws/uninstalling-cluster-aws.html){: new_window}.
  
- For Google Kubernetes Engine, see [Google Kubernetes Engine: Deleting a cluster ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.google.com/kubernetes-engine/docs/how-to/deleting-a-cluster){: new_window}.

- For Azure Kubernetes Service, see [Quickstart: Deploy an Azure Kubernetes Service (AKS) cluster by using the Azure portal ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal#delete-cluster){: new_window}.
