---

copyright:
  years: 2020
lastupdated: "2020-03-25"

---

# Sizing your Red Hat Advanced Cluster Management for Kubernetes cluster

Each Red Hat Advanced Cluster Management for Kubernetes cluster has its own characteristics. There are guidelines that provide sample deployment sizes. They have been classified by size and purpose. The considerations are focused on clusters that are either deployed to VMware or OpenStack environments.

**Note:** The requirements that are listed are not minimum requirements.

* [Considerations before you size your cluster](#considerations)
* [Sample deployments](#samples)

## Considerations before you size your cluster
{: #considerations}

View the following considerations before you size your cluster.

- [Worker nodes (workloads)](#workload)
- [Proxy nodes](#proxy)
- [Management nodes](#manage)
- [Large cluster considerations](#large_consider)

### Worker nodes (workloads)
{: #workload}

As you determine the number of worker nodes and the resource configurations, consider the workload that is running.

- If your cluster has a few worker nodes, consider increasing the number of worker nodes while decreasing the size of the nodes for adequate headspace, efficiency, mobility, and resiliency.
- Accommodate the workload mobility.
- Consider the memory that is required for a specific type of workload.
- Consider the memory that is required for other application frameworks.
- The maximum pod per node is 500 and the maximum pod per CPU core is 10.
- The cluster size depends on the worker node number. The pod number depends on the application type and the worker node's configuration.

### Proxy nodes
{: #proxy}

The following considerations are for proxy node sizing. Proxy nodes can be added at any time.

- Consider the total resource sizing versus the number of nodes.
- You must edit your ingress controller to match your workload through your configuration map.
- Your proxy virtual IP address references only a single node at a time.
- (Optional) Consider a load balancer to spread the workload to your proxy nodes with the external IP address.
- Istio also uses the proxy node for running Ingress and Egress gateways.

### Management nodes
{: #manage}

Larger clusters with more workload require larger management nodes. Management nodes can be added at any time if they were originally externalized.

For proxy nodes, consider the headspace requirements to carry the workload due to a node failure.

**Note**: In a High Availability (HA) environment, the minimum memory required to allow redundancy and failover can vary. It depends on which components and services you choose to install, and how many management nodes you have.

For example, if you install logging but disable monitoring, two 16 GB management nodes would leave enough unclaimed space. When a node terminates, space is available for key logging pods to fail over to remaining management nodes.

If monitoring and other optional components are enabled, you might not have enough free memory to allow for failover. The additional pods consume memory, and must also restart on the remaining node. Consider adding memory or increasing the number of management nodes.

### Large cluster considerations
{: #large_consider}

Consider the capabilities of Red Hat Advanced Cluster Management for Kubernetes when you plan for a large cluster. Red Hat Advanced Cluster Management for Kubernetes has extra enterprise capability workloads in addition to Vanilla Kubernetes, adding more services, such as Calico (node to node MeSH). Also, consider monitoring and logging assessment.

The following are more considerations:

- The node-to-node mesh starts to fail with 700 nodes in the cluster.  You must create a router reflector for BGP Daemons.
- Consider to use etcd outside of your master nodes if you plan on having a cluster with several hundred worker nodes. A separated etcd cluster is ideal to reduce the impact on the master node.
- Be sure to implement load balancing on your master node.
- The number of services in your cluster affects the load on each node.  In large clusters with more than 5000 services, you must run your nodes in IP Virtual Server (IPVS) mode.

**Note:** IPVS takes extra considerations for deployment.

## Sample deployments
{: #samples}

View the following sample deployments of different sized environments.

- [Small Red Hat Advanced Cluster Management for Kubernetes environment (resilience medium)](#small)
- [Medium Red Hat Advanced Cluster Management for Kubernetes environment (resilience medium)](#medium)
- [Large Red Hat Advanced Cluster Management for Kubernetes environment (resilience high)](#large)

### Small Red Hat Advanced Cluster Management for Kubernetes environment (resilience medium)
{: #small}

| Node type | Number of nodes | vCPU | Memory (GB) | Disk (GB) |
| :---: | :---: | :---: | :---: | :---: |
| Boot	| 1	| 2	| 8	| 250 |
|	Master	| 3	| 16	| 32	| 500 |
|	Management	| 2	| 8	| 16	| 500 |
|	Proxy	| 2	| 4	| 16	| 400 |
|	Worker - Java Workloads | 3+ (Max:20)	| 8	| 32	| 400 |

To create a testing environment with this particular cluster, you can deploy a single master node and decrease the proxy nodes (resilience low). To provide the most flexibility for your environment, you must not combine node types. The workers included are shaped for Java workloads. See the [Worker nodes](#workload) section.

### Medium Red Hat Advanced Cluster Management for Kubernetes environment (resilience medium)
{: #medium}

| Node type | Number of nodes | vCPU | Memory (GB) | Disk (GB) |
| :---: | :---: | :---: | :---: | :---: |
| Boot	| 1	| 2	| 8	| 250 |
|	Master	| 3	| 16	| 32	| 500 |
|	Management	| 2	| 16	| 32	| 500 |
|	Proxy	| 2	| 4	| 16	| 400 |
|	Worker - Java Workloads | 3+ (Max:20)	| 8	| 32	| 400 |
|	Worker | 5+ (Max:70)| 8 | 32	| 400 |

To increase your cluster's resilience level, add two extra master nodes.

### Large Red Hat Advanced Cluster Management for Kubernetes environment (resilience high)
{: #large}

**Sizing cluster for 500 worker nodes**:

| Node type| Number | vCPU |Memory (GB)|Disk (GB)|
| :---: | :---: | :---: | :---: | :---: |
|Boot node| 1 | 4 | 8 |  250 |
|Master node|3|16|128 | 500|
|Management node|2|16 |128 | 500 |
|Proxy node|2|4 |16 |256|
|Worker node|500|8 |32| 400|

**Sizing cluster for 1000 worker nodes**:

| Node type | Number of nodes | vCPU | Memory (GB) | Disk (GB) |
| :---: | :---: | :---: | :---: | :---: |
|	Boot	| 1	| 4	| 8	| 250 |
|	Master | 3 | 16 | 128	| 500 |
|	Management	| 5	| 16	| 128 |	500 |
|	Proxy |	2	| 4	| 16	| 256 |
|	Worker | 1000| 8	| 32	|400 |

To increase your cluster resilience level, you must deploy and manage workloads across multiple clusters.

 * A vCPU is equivalent to a Kubernetes compute unit. For more information, see Kubernetes [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu).
