# Sizing your cluster

Each Red Hat Advanced Cluster Management for Kubernetes cluster has its own characteristics. There are guidelines that provide sample deployment sizes. They have been classified by size and purpose. The considerations are focused on clusters that are either deployed to VMware or OpenStack environments.

**Note:** Three worker nodes of approximately equal capacity spread across three availability zones are required. The requirements that are listed are not minimum requirements.

### Worker nodes (workloads)

As you determine the number of worker nodes and the resource configurations, consider the workload that is running.

- If your cluster has a few worker nodes, consider increasing the number of worker nodes while decreasing the size of the nodes for adequate headspace, efficiency, mobility, and resiliency.
- Accommodate the workload mobility.
- Consider the memory that is required for a specific type of workload.
- Consider the memory that is required for other application frameworks.
- The maximum pod per node is 500 and the maximum pod per CPU core is 10.
- The cluster size depends on the worker node number. The pod number depends on the application type and the worker node's configuration.

A vCPU is equivalent to a Kubernetes compute unit. For more information, see Kubernetes [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu).

### Red Hat Advanced Cluster Management for Kubernetes environment 

- Creating an OpenShift cluster on Amazon Web Services. 

  See the [Amazon Web Services product documentation](https://docs.openshift.com/container-platform/4.4/installing/installing_aws/installing-aws-customizations.html#installing-aws-customizations) for more information. Also learn more about [machine types](https://aws.amazon.com/ec2/instance-types/m5/).

  - Instance size: m5.xlarge
  - vCPU: 6
  - Memory: 16 GB
  - Storage size: 120 GB

- Creating an OpenShift cluster on Google Cloud Platform. 

  See the [Google Cloud Platform product documentation](https://cloud.google.com/docs/quota) for more information about quotas. Also learn more about [machine types](https://cloud.google.com/compute/docs/machine-types).

  - Instance size: N1-standard-4 (0.95–6.5 GB)
  - vCPU: 6
  - Memory: 16 GB
  - Storage size: 120 GB  
  
- Creating an OpenShift cluster on Microsoft Azure. See the following [product documentation](https://docs.openshift.com/container-platform/4.4/installing/installing_azure/installing-azure-account.html) for more details.

  - Instance size: Standard_D2s_v3
  - vCPU: 6
  - Memory: 16 GB
  - Storage size: 120 GB

- Creating an OpenShift cluster on bare metal. See the following [product documentation](https://docs.openshift.com/container-platform/4.4/installing/installing_bare_metal/installing-bare-metal.html) for more details.

  - CPU: 6 (minimum)
  - Memory: 16 GB (minimum)
  - Storage size: 120 GB (minimum)


 
