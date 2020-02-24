---

copyright:
  years: 2019
lastupdated: "2019-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Preparing your {{site.data.keyword.mcm_notm}} to discover services

You can configure the {{site.data.keyword.mcm_notm}} service registry to discover Kubernetes services, Kubernetes ingress services, and Istio services that are in different {{site.data.keyword.mcm_notm}} managed clusters.
{: shortdesc}

When you have multiple instances of a Kubernetes service, a Kubernetes ingress service, or an Istio service that are managed by {{site.data.keyword.mcm_notm}}, it is challenging to maintain them. The {{site.data.keyword.mcm_notm}} service discovery function only discovers Kubernetes services, Kubernetes ingress services, and Istio services that are configured to be discovered.

**Required user type or access level:** Cluster administrator.

After the {{site.data.keyword.mcm_notm}} hub cluster and managed cluster are configured, you need complete the following steps to configure your service registry component:

## Configure DNS

Configure the DNS for each managed cluster by completing these steps:

1. Find the `mcm-svc-registry-dns` service cluster IP by entering the following command, where *<ibm-klusterlet-namespace>* is the namespace that contains your registry component:

  ```
  kubectl get -n <ibm-klusterlet-namespace> service mcm-svc-registry-dns -o jsonpath='{.spec.clusterIP}'
  ```
  {: codeblock}

2. Configure your cluster DNS configuration by entering the following command:

  ```
  kubectl edit -n kube-system configmap kube-dns
  ```
  {: codeblock}

3. Enable the forwarding plugin in the `kube-dns` configuration, similar to the following example, where *<mcm-svc-registry-dns-service-cluster-ip>* is the IP address that you identified in step 1:

  ```
  Corefile: |
    .:53 {

        ...

        forward mcm.svc. <mcm-svc-registry-dns-service-cluster-ip>
    }
  ```
  {: codeblock}

  The value `mcm.svc` is the default DNS domain suffix for the service registry. If you want to set it to another value, complete the following steps:

    1. Log in to your {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}}.

	2. Navigate to **Workloads** -> **Helm Releases**.

	3. Select your `ibm-klusterlet` release.

	4. Expand **All parameters**.

	5. In the *Multicloud Manager service registry configuration* section, set the DNS suffix in the *DNS Suffix* field.

      **Tip**: If your managed cluster is an IBM Cloud Kubernetes Service, you can also configure your cluster DNS by running the following command:

	  ```
	  kubectl edit -n kube-system configmap coredns
	  ```
	  {: codeblock}
