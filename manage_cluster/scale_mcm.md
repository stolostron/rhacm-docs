---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-26"

---

# Scaling your cluster

You can customize your cluster specifications, such as virtual machine sizes and number of nodes.

See the following list of recommended settings for each available cloud provider:

* [OpenShift cluster in Amazon Web Services (AWS)](#ocp_aws)

## OpenShift cluster in Amazon Web Services (AWS)
{: #ocp_aws}

- Number of compute, worker, machines:
  
```
compute.replicas: 3
```

- The number of control plane machines:
 
```
controlPlane.replicas: 3
```

- Type of EC2 instance, including compute, memory and networking resources, for control plane machines and compute machines:

```
controlPlane.platform.aws.type: m5.xlarge
compute.platform.aws.type: m5.xlarge
```

See the Amazon documentation at [Amazon EC2 Instance Types](https://aws.amazon.com/ec2/instance-types/) for more details.

- Resizing:

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster. To learn how to resize your cluster, refer to [Creating a MachineSet to scale your cluster](https://docs.openshift.com/container-platform/4.1/machine_management/creating-machineset.html).

