---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Configuring multiple zones in an {{site.data.keyword.mcm_notm}} cluster

**{{site.data.keyword.tech_prev}}**

Configure multiple zones in an {{site.data.keyword.mcm}} cluster.
{:shortdesc}

You can set up a cluster with nodes that reside across data centers and configure high availability (HA) across these data centers. Each data center is an availability zone. Configuring multiple zones helps in the following ways:

- Protects against data loss if a data center fails.
- Reduces service restoration time when a data center fails or when an automated failover is set up, and provides continuous operation across data centers.
- Keeps services from stopping even during tasks such as cluster upgrade.


## Multiple zones environment

Multiple zones have the following requirement for network connectivity between the zones and for shared storage:

- The zones must have a common failure domain.
- An external load balancer must be configured.
- Storage must be configured such that it is available to all the zones.
- Network infrastructure must be set up in a way that there is no single point of failure (SPOF).

Table 1 shows the minimum hardware requirement for the nodes in your multizone cluster. 

Requirement | Boot node | Master node | Proxy node | Worker node | Management node | etcd node
-- | -- | -- | -- | -- | -- | --
Cores | 1 | 8  | 4 |4 | 8| 1
CPU | >= 2.4 GHz | >= 2.4 GHz | >= 2.4 GHz | >= 2.4 GHz | >= 2.4 GHz | >= 2.4 GHz
RAM | 4 GB |16 GB | 8 GB | 8 GB | 16 GB | 4 GB
Free disk space to install | 100 GB |300 GB| 150 GB| 300GB,20GB | 300 GB | 100 GB
{: caption="Table 1. Minimum hardware requirement in a multizone environment" caption-side="top"}

You can configure the number of hosts based on your requirement. However, the number of master nodes must be an odd number. The number of etcd nodes must be the same as the number of master nodes. The cluster nodes can be placed in any zone. Table 2 is an example of hosts that are used in a three-zone environment. 

Requirement | Boot node | Master node | Proxy node | Worker node | Management node | etcd node
-- | -- | -- | -- | -- | -- | -- | --
Number of hosts | 1 | 5 | 3 | 3 | 3 | 5
{: caption="Table 2. Example of hosts used in a three-zone environment" caption-side="top"}

**Note:** You need only one boot node for your multizone environment.

## Setting up a multizone cluster

Complete the following steps to set up a multizone cluster:

1. Prepare your nodes. For more information, see [Preparing to install the {{site.data.keyword.cloud_pak_mcm}}](../../install/prep.md).

2. Prepare the `<installation_directory>/cluster/hosts` file for installation.

  Consider the following sample multizone nodes distribution:

  - One boot node in zone 1 (z1)
  - One master node in z1, two master nodes in zone 2 (z2), and two master nodes in zone 3 (z3)
  - One management node in z1, one management node in z2, and one management node in z3
  - Two proxy nodes in z2 and one proxy node in z3
  - One worker node in z1, one worker node in z2, and one worker node in z3
  - One etcd node in z1, two etcd nodes in zone 2 (z2), and two etcd nodes in zone 3 (z3)
  
  **Note:** You must replace the node names in the following sample `hosts` file with the IP addresses of the nodes that are in your multizone environment. 

  Following is a sample `hosts` file:
  ```
  [master:children]
  master_zone1
  master_zone2
  master_zone3
  [master_zone1]
  <IP address of master node in zone 1>
  [master_zone2]
  <IP address of first master node in zone 2>
  <IP address of second master node in zone 2>
  [master_zone3]
  <IP address of first master node in zone 3>
  <IP address of second master node in zone 3>

  [proxy:children]
  proxy_zone2
  proxy_zone3
  [proxy_zone2]
  <IP address of first proxy node in zone 2>
  <IP address of second proxy node in zone 2>
  [proxy_zone3]
  <IP address of proxy node in zone 3>
  
  [management:children]
  management_zone1
  management_zone2
  management_zone3
  [management_zone1]
  <IP address of management node in zone 1>
  [management_zone2]
  <IP address of management node in zone 2>
  [management_zone3]
  <IP address of management node in zone 3>

  [worker:children]
  worker_zone1
  worker_zone2
  worker_zone3
  [worker_zone1]
  <IP address of worker node in zone 1>
  [worker_zone2]
  <IP address of worker node in zone 2>
  [worker_zone3]
  <IP address of worker node in zone 3>
  
  [etcd:children]
  etcd_zone1
  etcd_zone2
  etcd_zone3
  [etcd_zone1]
  <IP address of etcd node in zone 1>
  [etcd_zone2]
  <IP address of first etcd node in zone 2>
  <IP address of second etcd node in zone 2>
  [etcd_zone3]
  <IP address of first etcd node in zone 3>
  <IP address of second etcd node in zone 3>  
  ```
  {: codeblock}

3. Configure HA for your multizone environment. For more information, see [Configuring high availability for your {{site.data.keyword.mcm_notm}} clusters](mcm_ha.md). 

4. Install your cluster. For more information, see [{{site.data.keyword.cloud_pak_mcm}} installation](../../install/overview.md).


