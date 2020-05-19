# Performance and scalability

Red Hat Advanced Cluster Management for Kubernetes is tested to determine certain scalability and performance data. The major areas that are tested are cluster scalability and search performance. 

You can use this information to help you plan your environment. 

**Important:** Data is based on the results from a lab environment at the time of testing. Your results might vary, depending on your environment, network speed, and changes to the product. 

## Maximum number of managed clusters

The Red Hat Advanced Cluster Management for Kubernetes hub cluster provided good performance when managing up to 250 managed clusters. The following table shows the configuration information for the clusters on the Amazon Web Services cloud platfrom that were used to determine the cluster maximums:

| Node | Flavor | vCPU | RAM (GiB) | Disk type | Disk size(GiB)/IOS | Count | Region |
| ------- | --------| -----|----- |
| Master | m5.2xlarge | 8 | 32 | gp2 | 100 | 3 | us-east-1 |
| Worker | m5.2xlarge | 8 | 32 | gp2 | 100 | 3/5 | us-east-1 |

## Search scalability

The scalability of the Search component depends on the performance of the data store. The following variables are important when analyzing the search performance:

* Physical memory
* Write throughput (Cache recovery time)
* Query execution time

### Physical memory

Search keeps the data in-memory to achieve fast response times. The memory required is proportional to the number of resources (ConfigMaps, Deployments, Pods, etc) and their relationships in the cluster.

| Clusters | Kubernetes resources  | Relationships  | Observed size (with simulated data) |
| ------- | --------| -----|----- |
| 1 medium   | 5000 | 9500  | 50 MB |
| 5 medium     | 25,000 | 75,000  | 120 MB | 
| 15 medium     | 75,000 | 20,0000  | 263 MB |
| 30 medium     | 150,000 | 450,000  | 492 MB |
| 50 medium     | 250,000 | 750,000  | 878 MB | 

Table: Physical memory data

By default, the datastore is deployed with a memory limit of 1 GB. If you are managing larger clusters, you might need to increase this limit by editing the deployment named `search-prod-xxxxx-redisgraph` in the open-cluster-management namespace.

### Write throughput (cache recovery time)

Most clusters in steady state generate a small number of resource updates. The highest rate of updates happen when the data in RedisGraph is cleared, which causes the remote collectors to synchronize their full state around the same time.

| Clusters | Kubernetes resources  | Relationships  | Average recovery time from simulation |
| ------- | --------| -----|----- |
| 1 medium   | 5000 | 9500  | less than 2 seconds |
| 5 medium     | 25,000 | 75,000  | less than 15 seconds | 
| 15 medium     | 75,000 | 200,000  | 2 minutes and 40 seconds |
| 30 medium     | 150,000 | 450,000  | 5-8 minutes |

Table: Cache recovery time data

**Remember:** Times might increase for clusters that have a slow network connection to the hub.

### Query execution considerations

There are some things that can affect the time that it takes to run and return results from a query. Consider the following items when planning and configuring your environment:

* Searching for a keyword is not efficient.
* The first search takes longer than later searches because it takes additional time to gather the user's access rules.
* The length of time to complete a request is proportional to the number of namespaces and resources the user is authorized to access.
* The worst performance is observed for a request by a non-administrator user with access to all of the namespaces, or all of the managed clusters.
