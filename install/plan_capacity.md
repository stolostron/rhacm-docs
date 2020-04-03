---

copyright:
  years: 2020
lastupdated: "2020-03-31"

---

# Sizing your hub cluster

Each Red Hat Advanced Cluster Management for Kubernetes cluster has its own characteristics. There are guidelines that provide sample deployment sizes. They have been classified by size and purpose. The considerations are focused on clusters that are either deployed to VMware or OpenStack environments.

**Note:** The requirements that are listed are not minimum requirements.

* [Considerations before you size your cluster](#considerations)
* [Sample deployments](#samples)

## Considerations before you size your cluster
{: #considerations}

View the following considerations before you size your cluster.

- [Worker nodes (workloads)](#workload)

### Worker nodes (workloads)
{: #workload}

As you determine the number of worker nodes and the resource configurations, consider the workload that is running.

- If your cluster has a few worker nodes, consider increasing the number of worker nodes while decreasing the size of the nodes for adequate headspace, efficiency, mobility, and resiliency.
- Accommodate the workload mobility.
- Consider the memory that is required for a specific type of workload.
- Consider the memory that is required for other application frameworks.
- The maximum pod per node is 500 and the maximum pod per CPU core is 10.
- The cluster size depends on the worker node number. The pod number depends on the application type and the worker node's configuration.

### Basic Red Hat Advanced Cluster Management for Kubernetes environment 
{: #small}

| Node type | Number of nodes | vCPU | Memory (GB) | Disk (GB) |
| :---: | :---: | :---: | :---: | :---: |
| Boot	| 1	| 2	| 8	| 250 |
|	Master	| 3	| 16	| 32	| 500 |
|	Worker  | 3+ (Max:20)	| 8	| 32	| 400 |

To create a testing environment with this particular cluster, you can deploy a single master node and decrease the proxy nodes (resilience low). To provide the most flexibility for your environment, you must not combine node types. The workers included are shaped for Java workloads. See the [Worker nodes](#workload) section.

 * A vCPU is equivalent to a Kubernetes compute unit. For more information, see Kubernetes [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu).
