---

copyright:
  years: 2020
lastupdated: "2020-03-16"


---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# System requirements and recommendations

Before you install Red Hat Advanced Cluster Management for Kubernetes, review the system requirements and the footprint sizing.
{:shortdesc}

  - [Red Hat OpenShift Container Platform](#ocp)
  - [Red Hat Advanced Cluster Management for Kubernetes](#rhacm)
  - [Sizing for the management hub services](#management_services)
  - [Sizing for the multicluster-endpoint](#mc_endpoint)

## Red Hat OpenShift Container Platform
{: #ocp}

* Red Hat OpenShift Container Platform compute or worker nodes: 16 Core | 32 GB RAM
**Note:** The required resources are the allocatable resources on the OpenShift nodes.

* Storage requirements:
  - For offline installation, the Red Hat OpenShift Container Platform image registry requires at least 100 GB.
  - The management services MongoDB and logging each require 20 GB through the storage class.
  
## Red Hat Advanced Cluster Management for Kubernetes
{: #rhacm}

Sizing is available for entry, standard, and enterprise footprints.

**Notes:** A vCPU is equivalent to a Kubernetes compute unit. For more information, see Kubernetes [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu).

### Deployment topology for OpenShift and Advanced Cluster Management for Kubernetes

| Deployment topology | Description of usage | OpenShift 3.11 node configuration  | OpenShift 4.2 node configuration | OpenShift 4.3 node configuration |
| :--- | :--- | :--- | :---| :---|
| Development | For development, test, and POC | Both {{site.data.keyword.open_s}} and the Cloud Pak on a single node | | |
| Minimal | Small cluster deployment | <p>OpenShift:<br>&nbsp; 1 master node <br>&nbsp; 1 or 2 infra nodes <br>&nbsp; 2 or more worker nodes </p><p>Advanced Cluster Management for Kubernetes <br> &nbsp; 1 dedicated worker node (see note) </p> | <p>OpenShift: <br> &nbsp; 3 master nodes <br> &nbsp; 2 or more worker nodes </p><p>Advanced Cluster Management for Kubernetes<br> &nbsp; 1 dedicated worker node </p> | <p>OpenShift: <br> &nbsp; 3 master nodes <br> &nbsp; 2 or more worker nodes </p><p>Advanced Cluster Management for Kubernetes<br> &nbsp; 1 dedicated worker node </p> |
| Standard | Regular production deployment | <p> OpenShift: <br>&nbsp; 3 master nodes (native HA) <br> &nbsp; 2 infra nodes <br>&nbsp; 4 or more worker nodes </pr><pr> <br><br> Advanced Cluster Management for Kubernetes: <br>&nbsp; 1 master node <br>&nbsp; 1 management node <br> &nbsp; 1 proxy node </p> | <p> OpenShift: <br>&nbsp; 3 master nodes (native HA) <br>&nbsp; 4 or more worker nodes </p><p> Advanced Cluster Management for Kubernetes:<br>&nbsp; 1 master node <br> &nbsp; 1 management node <br>&nbsp; 1 proxy node </p> |  <p> OpenShift: <br>&nbsp; 3 master nodes (native HA) <br>&nbsp; 4 or more worker nodes </p><p> Advanced Cluster Management for Kubernetes:<br>&nbsp; 1 master node <br> &nbsp; 1 management node <br>&nbsp; 1 proxy node </p> |
| Enterprise	| Medium and large-scale production deployment| <p></p>OpenShift: <br>&nbsp; 3 master nodes (native HA) <br> &nbsp; 2 or more infra nodes <br>&nbsp; 8 or more worker nodes </p><p><br> Advanced Cluster Management for Kubernetes: <br> &nbsp; 3 master nodes <br> &nbsp; 2 management nodes <br>&nbsp; 2 proxy nodes </p> | OpenShift: <br> &nbsp; 3 master nodes (native HA) <br>&nbsp; 8 or more worker nodes </p><p> <br> Advanced Cluster Management for Kubernetes: <br> &nbsp; 3 master nodes <br> &nbsp; 2 management nodes <br>&nbsp; 2 proxy nodes </p> | OpenShift: <br> &nbsp; 3 master nodes (native HA) <br>&nbsp; 8 or more worker nodes </p><p> <br> Advanced Cluster Management for Kubernetes: <br> &nbsp; 3 master nodes <br> &nbsp; 2 management nodes <br>&nbsp; 2 proxy nodes </p> |
{: caption="Table 1. Deployment topology configurations for Red Hat Advanced Cluster Management for Kubernetes" caption-side="top"}

**Note:** For one dedicated worker node, set the master, management, and proxy nodes to one OpenShift worker node.

### Default configurations

| Topology | vCPUs | Memory | Persistent volumes (GB)  | Disk Space (GB) |
| :--- | :---: | :---: | :---: |:---: |
| Development | 8 | 16 | 20 | 100 |
| Minimal | 16 | 32	| 20 | 100 |
| Standard | 32 | 60 | 20 | 300 |
| Enterprise | 54 | 97	| 60 | 700 |
{: caption="Table 2. Default configuration sizing" caption-side="top"}

**Note:** For the following sizings, requirements are rounded up to the nearest node configuration. All persistent volumes indicated are default. You must size the volumes based on the amount of data that is stored over a time.

### Development sizing
| Configuration | Number of nodes | vCPUs | Memory | Persistent volumes (GB) | Disk Space (GB) | Note |
| :--- | :---: | :---: | :---: | :---: |:---: |:--- |
| master, management, proxy	| 1 | 8	| 16 | 20 | 100 | Advanced Cluster Management for Kubernetes runs on the same node as OpenShift |
{: caption="Table 3. Development, test, and POC OpenShift node sizing for the Advanced Cluster Management for Kubernetes" caption-side="top"}

### Minimal sizing
| Configuration | Number of nodes | vCPUs | Memory | Persistent volumes (GB) | Disk Space (GB) |
| :--- | :---: | :---: | :---: | :---: |:---: |
| master, management, proxy	| 1| 16	| 32 | 20 | 100 |
{: caption="Table 4. Minimal OpenShift node sizing for Advanced Cluster Management for Kubernetes" caption-side="top"}

### Standard sizing

| Configuration | Number of nodes | vCPUs | Memory | Persistent volumes (GB) | Disk Space (GB) |
| :--- | :---: | :---: | :---: | :---: |:---: |
| master | 1 | 16 | 32 | 20 | 100 |
| management | 1 | 12 | 24 | - | 100 |
| proxy| 1| 4 | 8 | - | 100 |
{: caption="Table 5. Standard OpenShift node sizing for Advanced Cluster Management for Kubernetes caption-side="top"}

### Enterprise sizing

| Configuration | Number of nodes | vCPUs | Memory | Persistent volumes (GB) | Disk Space (GB) |
| :--- | :---: | :---: | :---: | :---: |:---: |
| master | 3 | 48 | 96 | 60 | 200 |
| management | 2 | 24 | 48 | - | 200 |
| proxy| 2| 8	| 16	| - | 200  |
{: caption="Table 6. Enterprise OpenShift node sizing for the Red Hat Advanced Cluster Management for Kubernetes" caption-side="top"}

## Sizing for management hub services
{: #management_services}

| Service Name                 | Optional | CPU Request | CPU Limit | Memory Request | Memory Limit | Persistent Volume (value is default) | Additional considerations |
|-------------------------------- |---------- |------------- |------------ |----------------- |-------------- |----------------- |-------------- |
| Mcm-kui, search | Default | 9,025 m | 29,289 m | 16,857 Mi | 56,963 Mi | 20 GiB | |
| Multitenancy Account Quota Enforcement | Optional | 25 m | 100 m | 64 Mi | 64 Mi | | |
| Notary | Optional | 600 m | 600 m  | 1,024 Mi | 1,024 Mi | | |
| Secret Encryption Policy Controller | Optional | 50 m | 100 m  | 100 Mi | 200 Mi | 110 GiB | |
| Secure Token Service (STS) | Optional | 410 m | 600 m  | 94 Mi  | 314 Mi | | Requires Red Hat OpenShift Service Mesh (Istio) |
{: caption="Table 10. Hub services sizing" caption-side="top"}

## Sizing for multicluster-endpoint
{: #mc_endpoint}

| Component Name                 	| Optional 	| CPU Request 	| CPU Limit  	| Memory Request  	| Memory Limit 	|
|--------------------------------	|----------	|-------------	|------------	|-----------------	|--------------	|
| ApplicationManager             	| True     	| 100 mCore   	| 500 mCore   	| 128 MiB         	| 2 GiB        	|
| WorkManager                    	| False    	| 100 mCore   	| 500 mCore  	| 128 MiB         	| 512 MiB       |
| ConnectionManager              	| False    	| 100 mCore   	| 500 mCore  	| 128 MiB         	| 256 MiB      	|
| ComponentOperator              	| False    	| 50 mCore    	| 250 mCore  	| 128 MiB         	| 512 MiB      	|
| CertManager                    	| False    	| 100 mCore   	| 300 mCore  	| 100 MiB         	| 300 MiB      	|
| PolicyController               	| True     	| 100 mCore   	| 500 mCore  	| 128 MiB         	| 256 MiB      	|
| SearchCollector                	| True     	| 25 mCore    	| 250 mCore  	| 128 MiB         	| 512 MiB      	|
| ServiceRegistry                	| True     	| 100 mCore   	| 500 mCore  	| 128 MiB         	| 258 MiB      	|
| ServiceRegistryDNS             	| True     	| 100 mCore   	| 500 mCore  	| 70 MiB          	| 170 MiB      	|
| MeteringSender                 	| True     	| 100 mCore   	| 500 mCore  	| 128 MiB         	| 512 MiB      	|
| MeteringReader                 	| True     	| 100 mCore   	| 500 mCore  	| 128 MiB         	| 512 MiB      	|
| MeteringDataManager            	| True     	| 100 mCore   	| 1000 mCore 	| 256 MiB         	| 2560 MiB     	|
| MeteringMongoDB                	| True     	| -           	| -          	| 500 MiB           | 1 GiB        	|
| Tiller                         	| True     	| -           	| -          	| -               	| -            	|
| TopologyWeaveScope(1 per node) 	| True     	| 50 mCore    	| 250 mCore  	| 64 MiB          	| 256 MiB      	|
| TopologyWeaveApp               	| True     	| 50 mCore    	| 250 mCore  	| 128 MiB         	| 256 MiB      	|
| TopologyCollector              	| True     	| 50 mCore    	| 100 mCore  	| 20 MiB          	| 50 MiB       	|
| MulticlusterEndpointOperator   	| False    	| 100 mCore   	| 500 mCore  	| 100 MiB         	| 500 MiB      	|
{: caption="Table 9. Multicluster-endpoint instructions" caption-side="top"}
