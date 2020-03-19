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

# Preparing your Red Hat Advanced Cluster Management for Kubernetes to discover services

You can configure the Red Hat Advanced Cluster Management for Kubernetes service registry to discover Kubernetes services, Kubernetes ingress services, and Istio services that are in different Red Hat Advanced Cluster Management for Kubernetes managed clusters.
{: shortdesc}

When you have multiple instances of a Kubernetes service, a Kubernetes ingress service, or an Istio service that are managed by Red Hat Advanced Cluster Management for Kubernetes, it is challenging to maintain them. The Red Hat Advanced Cluster Management for Kubernetes service discovery function only discovers Kubernetes services, Kubernetes ingress services, and Istio services that are configured to be discovered.

**Required user type or access level:** Cluster administrator.

After the Red Hat Advanced Cluster Management for Kubernetes hub cluster and managed cluster are configured, you need complete the following steps to configure your service registry component:

## Configure DNS

Configure the DNS for each managed cluster by completing these steps:

1. Find the `mcm-svc-registry-dns` service cluster IP by entering the following command, where *<rcm-klusterlet-namespace>* is the namespace that contains your registry component:

  ```
  kubectl get -n <rcm-klusterlet-namespace> service mcm-svc-registry-dns -o jsonpath='{.spec.clusterIP}'
  ```
  {: codeblock}

2. Configure your cluster DNS configuration by entering the following command:

  ```
  kubectl edit -n openshift-dns configmap dns-default
  ```
  {: codeblock}

3. Enable the forwarding plugin in the `dns-default` configuration, similar to the following example, where *<mcm-svc-registry-dns-service-cluster-ip>* is the IP address that you identified in step 1:

  ```
  Corefile: |
    .:53 {

        ...

        forward mcm.svc. <mcm-svc-registry-dns-service-cluster-ip>
    }
  ```
  {: codeblock}

  The value `mcm.svc` is the default DNS domain suffix for the service registry. If you want to set it to another value, complete the following steps:

  1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

  2. Navigate to **Workloads** -> **Helm Releases**.

  3. Select your `rcm-klusterlet` release.

  4. Expand **All parameters**.

  5. In the *Multicloud Manager service registry configuration* section, set the DNS suffix in the *DNS Suffix* field.
