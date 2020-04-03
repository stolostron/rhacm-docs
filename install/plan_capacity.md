---

copyright:
  years: 2020
lastupdated: "2020-03-31"

---

# Sizing your hub cluster

Each Red Hat Advanced Cluster Management for Kubernetes cluster has its own characteristics. There are guidelines that provide sample deployment sizes. They have been classified by size and purpose. The considerations are focused on clusters that are either deployed to VMware or OpenStack environments.

**Note:** The requirements that are listed are not minimum requirements.

* [Considerations before you size your cluster](#considerations)

## Considerations before you size your cluster
{: #considerations}

### Worker nodes (workloads)
{: #workload}

As you determine the number of worker nodes and the resource configurations, consider the workload that is running.

- If your cluster has a few worker nodes, consider increasing the number of worker nodes while decreasing the size of the nodes for adequate headspace, efficiency, mobility, and resiliency.
- Accommodate the workload mobility.
- Consider the memory that is required for a specific type of workload.
- Consider the memory that is required for other application frameworks.
- The maximum pod per node is 500 and the maximum pod per CPU core is 10.
- The cluster size depends on the worker node number. The pod number depends on the application type and the worker node's configuration.

### Red Hat Advanced Cluster Management for Kubernetes environment 

Creating an OpenShift cluster on Amazon Web Services. See [product documentation](https://docs.openshift.com/container-platform/4.3/installing/installing_aws/installing-aws-customizations.html#installing-aws-customizations).

Node type | Number of nodes | vCPU | Memory (GB) | Disk (GB) |
| :---: | :---: | :---: | :---: | :---: |
|	Master m5.xlarge	| 3	| ? | ?|100 |
|	Worker m5.xlarge | 3 | ?| ?| 100|

Creating an OpenShift cluster on Google Cloud Platform

Node type | Number of nodes | vCPU | Memory (GB) | Disk (GB) |
| :---: | :---: | :---: | :---: | :---: |
| Boot	| ?	| ?|?| 120|
|	Master	| 3	| ? | ?|120 |
|	Worker  | 3 | ?| ?| 120|

Creating an OpenShift cluster on Microsoft Azure

Node type | Number of nodes | vCPU | Memory (GB) | Disk (GB) |
| :---: | :---: | :---: | :---: | :---: |
| Boot	| ?	| ?|?| 100|
|	Master	| 3	| ? | ?|100 |
|	Worker  | 3 | ?| ?| 100|

Creating an OpenShift cluster on bare metal

Node type | Number of nodes | vCPU | Memory (GB) | Disk (GB) |
| :---: | :---: | :---: | :---: | :---: |
| Boot	| ?	| ?|?| 100|
|	Master	| 3	| ? | ?|100 |
|	Worker  | 3 | ?| ?| 100|

 * A vCPU is equivalent to a Kubernetes compute unit. For more information, see Kubernetes [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu).
