---

copyright:
  years: 2019
lastupdated: "2019-11-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Configuring high availability for your {{site.data.keyword.mcm_notm}} clusters

Configure high availability (HA) for {{site.data.keyword.mcm_notm}}.
{:shortdesc}

**{{site.data.keyword.tech_prev}}**

**Note:** HA for {{site.data.keyword.mcm_notm}} is not supported in a multitenancy environment.

When you configure {{site.data.keyword.mcm_notm}} HA, multiple hub clusters that work in active mode can maintain the state of clusters and applications that run on all managed clusters. When a hub cluster stops working, all the managed clusters that the hub cluster manages automatically switch to another hub cluster.

{{site.data.keyword.mcm_notm}} HA has a consul agent in each hub cluster. All consul agents together are a consul cluster. Each hub cluster synchronizes its applications, policy information, and managed cluster data with the consul cluster. It also synchronizes the data of other hub clusters from the consul cluster to the local hub cluster.

**Note:** Application and policy resources are synchronized across all hub clusters. If a namespace of a resource in a hub cluster does not exist in other hub clusters, but you want to synchronize it, you must add the label `multicloud-ha: enabled` to the namespace.

## Prerequisites

Before you configure HA for {{site.data.keyword.mcm_notm}}, you must complete the following configurations:

- Configure at least 3 or 5 Red Hat Advanced Cluster Management for Kubernetes clusters. For more information, see [Red Hat Advanced Cluster Management for Kubernetes installation](../../install/overview.md).
- All Red Hat Advanced Cluster Management for Kubernetes clusters, which are hub clusters, must use the same root CA certificate.
  1. Configure the root CA during OpenShift installation. For more information, see [Configuring Your Inventory File ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html). Or, you can redeploy OpenShift root CA after OpenShift installation. For more information, see [Redeploying a New or Custom OpenShift Container Platform CA ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/3.11/install_config/redeploying_certificates.html#redeploying-new-custom-ca).
  2. Configure {{site.data.keyword.mcm_notm}} root CA for all clusters. For more information, see [Certificates in Red Hat Advanced Cluster Management for Kubernetes](../../cert-manager/3.4.0/certificates.md). 
- The name and namespace of a managed cluster must be unique across all Red Hat Advanced Cluster Management for Kubernetes clusters.

## Configure HA on your hub clusters

To configure HA, complete the following steps on each hub cluster:

- [Configure consul secret for gossip encryption](#step1)
- [Prepare the hub cluster for HA](#step2)
- [Configure HA](#step3)
- [Verify HA](#step4)

Complete all the steps on one hub cluster and then proceed with configuring the steps on the other hub clusters. During HA configuration on the other hub clusters, you need to specify the IP address of the master node of the hub cluster on which you already configured HA. This IP address is not required for HA configuration on the first hub cluster.

### Configure consul secret for gossip encryption
{: #step1}

Complete the following steps to configure consul secret:

1. Download the consul command tools.
  ```
  docker run -e LICENSE=accept -v $(pwd):/data <cluster_CA_domain>:8500/kube-system/consul:1.5.2 cp /bin/consul /data/consul
  ```
  {: codeblock}

2. Generate a base64 consul gossip encryption key.

  **Note:** Generate the key on the first hub cluster and share the key with the other hub clusters.

  ```
  ./consul keygen|base64
  ```
  {: codeblock}

3. Configure a secret. You must specify `kube-system` as the `namespace` parameter value. See the following `mcm-gossip-encryption-secret.yaml` sample file:
  ```
  apiVersion: v1
  data:
    gossip-encryption-key: <base64-consul-gossip-encryption-key>
  kind: Secret
  metadata:
    name: mcm-gossip-encryption-secret
    namespace: kube-system
  ```
  {: codeblock}

3. Create the gossip encryption secret in the `kube-system` namespace. You need `kubectl` to run the command. For more information about installing `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

  ```
  kubectl create -f mcm-gossip-encryption-secret.yaml
  ```
  {: codeblock}

### Prepare the hub cluster for HA
{: #step2}

1. Install the Helm CLI. For more information, see [Installing the Helm CLI (helm)](../../helm-cli/3.4.0/create_helm_cli.md).

2. Get the name of the installed multicluster hub Helm release.
  ```
  helm list --tls | grep multicluster-hub
  ```
  {: codeblock}

  Following is a sample output:
  ```
  multicluster-hub    2    Wed May 22 21:37:27 2019    DEPLOYED    ibm-mcm-prod-3.2.0     1.0     kube-system
  ```
  {: pre}

3. Create an override file named `override.yaml`.

#### Note:

- In each hub cluster, specify a unique name as the `global.myName` parameter value. For example, `hub0`, `hub1`, `hub2`.
- The `consul.serflanPort` and `consul.serverPort` parameters are used for consul communication. These ports must be available in your hub cluster on the master node. You must specify the same ports in all hub clusters.
- The `consul.persistence` parameter is used for data persistence. If its value is set to `false`, the `consul.storageclassName`, `consul.storageCapacity`, `consul.accessModes`, and `consul.localPath` parameters are not required. If you set the `consul.persistence` parameter value to `true`, you must set `consul.storageclassName` to use a storage class to request a persistent volume (PV) to store data. If you do not specify a storage class, the Red Hat Advanced Cluster Management for Kubernetes installer creates a default storage class and uses the path that you specify in the `consul.localPath` parameter as storage to create a PV. The installer creates the PV on the management node, or on the master node if your cluster does not have a management node. You must ensure that the path exists on the management node, or on the master node if your cluster does not have a management node.
- The `consul.advertise` parameter usually is the master node IP address of the current hub cluster. However, if you have an OpenShift cluster that is deployed on AWS, the `consul.advertise` parameter is the Elastic IP that is bound to a load balancer that has `TCP:30830` and `TCP_UDP:30831` as listeners. The listeners are associated with a target group to which the worker nodes of the cluster are registered. For more information, see [AWS Elastic Load Balancing Documentation ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.aws.amazon.com/elasticloadbalancing/index.html).

  **Note:** In the first hub cluster on which you configure HA, set the `consul.join` parameter value to `null`. When you configure HA on the other hub clusters, specify the IP address of the master node of the hub cluster on which you already configured HA.

  ```
   global:
     standalone: false
     myName: <Hub Name>
   core:
     highAvailability:
       enabled: true
   consul:
     join: <null-for-first-hub-cluster, or [Master-node-IP-address-for-other-hub-clusters | consul-advertise-IP-address-for-other-hub-clusters]>
     advertise: <[Master-node-IP-address-of-the-current-hub cluster | Elastic-IP-address-for-OpenShift-clusters>
     serflanPort: 30831
     serverPort: 30830
     gossipEncryptionSecret: mcm-gossip-encryption-secret
     persistence: false
     storageclassName: ""
     storageCapacity: 1Gi
     accessModes: ReadWriteMany
     localPath: /var/lib/consul-mcm
     resources:
       requests:
         memory: "64Mi"
         cpu: "25m"
       limits:
         memory: "512Mi"
         cpu: "100m"    
  ```
  {: codeblock}


### Configure HA
{: #step3}

Run the following command to configure HA:

```
helm upgrade multicluster-hub --version=3.2.1 mgmt-charts/ibm-mcm-prod -f override.yaml --tls
```

### Verify HA
{: #step4}

To verify whether HA is successfully configured, log on to each hub cluster and run the following command. If the output has all the peer hubs names, then the HA configuration was successful.

```
kubectl get leadervotes
```
{: codeblock}

Following is a sample output:
```
NAME   IDENTITY   AGE
hub0   hub0       2d
hub1   hub1       2d
hub2   hub2       2d
```
{: pre}

Run the following command to get the status of all managed clusters:

```
kubectl get cluster --all-namespaces
```
{: codeblock}

Following is a sample output:
```
NAMESPACE   NAME      MANAGED BY   ENDPOINTS          STATUS   AGE
cn0          c0       hub0         9.46.77.109:8001   Ready    2d
cn1          c1       hub1         9.46.72.117:8001   Ready    2d
cn2          c2       hub1         9.46.75.82:8001    Ready    2d
```
{: pre}

## Limitations

Following limitations apply when you configure {{site.data.keyword.mcm_notm}} HA:

- Team and account data is not synchronized across hubs. You must manually create teams and update data, as required.
- IBM Cloud Automation Manager and IBM Cloud App Management do not support HA clusters. You cannot install these applications if you configure HA.
- When you define a `PlacementRule` or `PlacementPolicy` for a resource, you cannot use the `clusterReplicas` property. The `clusterReplicas` property is used to specify the number of managed clusters on which the resource is to be deployed.

You can also configure HA for {{site.data.keyword.mcm_notm}} components. For more information, see [Configuring high availability for {{site.data.keyword.mcm_notm}} components](mcm_ha_comp.md).
