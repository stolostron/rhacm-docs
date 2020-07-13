# Sizing your cluster

Each Red Hat Advanced Cluster Management for Kubernetes cluster has its own characteristics. There are guidelines that provide sample deployment sizes. They have been classified by size and purpose. The considerations are focused on clusters that are either deployed to VMware or OpenStack environments.

Red Had Advanced Cluster Management for Kubernetes applies 3 dimensions for sizing and placement of supporting services:

1. Availability Zones that isolate potential fault domains across the cluster. Typical clusters should have roughly equivalent worker node capacity in 3 or more availability zones. 
2. vCPU reservations and limits establish vCPU capacity on a worker node to assign to a container. 
3. Memory reservations and limits establish memory capacity on a worker node to assign to a container. 

A vCPU is equivalent to a Kubernetes compute unit. For more information, see Kubernetes [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu).

Reservations establish a lower bound of CPU or memory and limits establish an upper bound. 

The persistent data managed by the product is stored in the etcd cluster used by Kubernetes. Best practices for OpenShift recommend distributing the master nodes of the cluster across three (3) availability zones as well.

**Note:** The requirements that are listed are not minimum requirements.

### Red Hat Advanced Cluster Management for Kubernetes environment 

|OpenShift Node Role|Availability Zones|Data Stores|Total reserved memory (lower bound)|Total reserved CPU (lower bound)|
|---|---|---|---|---|
|Master|3|etcd x 3|Per OpenShift sizing guidelines|Per OpenShift sizing guidelines|
|Worker|3|redisgraph/redis x 1|12Gi|6 CPU|

In addition to Red Hat Advanced Cluster Management for Kubernetes, the OpenShift cluster will run additional services to support cluster features. The following node sizes (3 nodes of the types noted below, distributed evenly across 3 availability zones) are recommended.

- Creating an OpenShift cluster on Amazon Web Services. 

  See the [Amazon Web Services product documentation](https://docs.openshift.com/container-platform/4.4/installing/installing_aws/installing-aws-customizations.html#installing-aws-customizations) for more information. Also learn more about [machine types](https://aws.amazon.com/ec2/instance-types/m5/).

  - Node Count: 3
  - Availability Zones: 3
  - Instance size: m5.xlarge
    - vCPU: 4
    - Memory: 16 GB
    - Storage size: 120 GB

- Creating an OpenShift cluster on Google Cloud Platform. 

  See the [Google Cloud Platform product documentation](https://cloud.google.com/docs/quota) for more information about quotas. Also learn more about [machine types](https://cloud.google.com/compute/docs/machine-types).
  

  - Node Count: 3
  - Availability Zones: 3
  - Instance size: N1-standard-4 (0.95–6.5 GB)
    - vCPU: 4
    - Memory: 15 GB
    - Storage size: 120 GB  
  
- Creating an OpenShift cluster on Microsoft Azure. See the following [product documentation](https://docs.openshift.com/container-platform/4.4/installing/installing_azure/installing-azure-account.html) for more details.

  - Node Count: 3
  - Availability Zones: 3
  - Instance size: Standard_D4_v3
    - vCPU: 4
    - Memory: 16 GB
    - Storage size: 120 GB

- Creating an OpenShift cluster on bare metal. See the following [product documentation](https://docs.openshift.com/container-platform/4.4/installing/installing_bare_metal/installing-bare-metal.html) for more details.

  - CPU: 6 (minimum)
  - Memory: 16 GB (minimum)
  - Storage size: 50 GB (minimum)


 
