---

copyright:
  years: 2019,2020
lastupdated: "2020-03-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Hardware requirements and recommendations

Before you install the {{site.data.keyword.cloud_pak_mcm}}, review the system requirements for each of the products and the footprint sizing for the entire Cloud Pak.
{:shortdesc}

  - [{{site.data.keyword.ocp_tm}}](#ocp)
  - [{{site.data.keyword.cloud_pak_mcm}}](#cloud_pak)
  - [IBM Cloud App Management](#app)
  - [IBM Cloud Automation Manager](#auto)
  - [Sizing for the multicluster-endpoint](#mc_endpoint)
  - [Sizing for the management hub services](#management_services)

## {{site.data.keyword.ocp_tm}}
{: #ocp}

* {{site.data.keyword.ocp}} compute or worker nodes: 16 Core | 32 GB RAM
**Note:** The required resources are the allocatable resources on the {{site.data.keyword.open_s}} nodes. If you want to install Cloud Paks on top of the {{site.data.keyword.cloud_pak_mcm}}, you need to add the additional required resources.

* Storage requirements:
  - For offline installation, the {{site.data.keyword.ocp}} image registry requires at least 100 GB.
  - The management services MongoDB and logging each require 20 GB through the storage class.
  - Vulnerability advisor requires 60 GB through the storage class.

## {{site.data.keyword.cloud_pak_mcm}}
{: #cloud_pak}

Sizing is available for entry, standard, and enterprise footprints.

**Notes:** A vCPU is equivalent to a Kubernetes compute unit. For more information, see Kubernetes [Meaning of CPU ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu){: new_window}.

### Deployment topology for {{site.data.keyword.open_s}} and the {{site.data.keyword.cloud_pak_mcm}}

| Deployment topology | Description of usage | {{site.data.keyword.open_s}} 3.11 node configuration  | {{site.data.keyword.open_s}} 4.2 node configuration |
| :--- | :--- | :--- | :---|
| Development | For development, test, and POC | Both {{site.data.keyword.open_s}} and the Cloud Pak on a single node | |
| Minimal | Small cluster deployment | <p>{{site.data.keyword.open_s}}:<br>&nbsp; 1 master node <br>&nbsp; 1 or 2 infra nodes <br>&nbsp; 2 or more worker nodes </p><p>Cloud Pak: <br> &nbsp; 1 dedicated worker node (see note) </p> | <p>{{site.data.keyword.open_s}}: <br> &nbsp; 3 master nodes <br> &nbsp; 2 or more worker nodes </p><p>Cloud Pak:<br> &nbsp; 1 dedicated Cloud Pak worker node </p> |
| Standard | Regular production deployment | <p> {{site.data.keyword.open_s}}: <br>&nbsp; 3 master nodes (native HA) <br> &nbsp; 2 infra nodes <br>&nbsp; 4 or more worker nodes </pr><pr> <br><br> Cloud Pak: <br>&nbsp; 1 Cloud Pak master node <br>&nbsp; 1 Cloud Pak management node <br> &nbsp; 1 Cloud Pak proxy node </p> | <p> {{site.data.keyword.open_s}}: <br>&nbsp; 3 master nodes (native HA) <br>&nbsp; 4 or more worker nodes </p><p> Cloud Pak:<br>&nbsp; 1 Cloud Pak master node <br> &nbsp; 1 Cloud Pak management node <br>&nbsp; 1 Cloud Pak proxy node </p>|
| Enterprise	| Medium and large-scale production deployment| <p></p>{{site.data.keyword.open_s}}: <br>&nbsp; 3 master nodes (native HA) <br> &nbsp; 2 or more infra nodes <br>&nbsp; 8 or more worker nodes </p><p><br> Cloud Pak: <br> &nbsp; 3 Cloud Pak master nodes <br> &nbsp; 2 Cloud Pak management nodes <br>&nbsp; 2 Cloud Pak proxy nodes </p> |{{site.data.keyword.open_s}}: <br> &nbsp; 3 master nodes (native HA) <br>&nbsp; 8 or more worker nodes </p><p> <br> Cloud Pak: <br> &nbsp; 3 Cloud Pak master nodes <br> &nbsp; 2  Cloud Pak management nodes <br>&nbsp; 2 Cloud Pak proxy nodes </p> |
{: caption="Table 1. Deployment topology configurations for the {{site.data.keyword.cloud_pak_mcm}}" caption-side="top"}

**Note:** For one dedicated Cloud Pak worker node, set the master, management, and proxy nodes to one {{site.data.keyword.open_s}} worker node.

### Default configurations

| Topology | vCPUs | Memory | Persistent volumes (GB)  | Disk Space (GB) |
| :--- | :---: | :---: | :---: |:---: |
| Development | 8| 16	| 20 | 100 |
| Minimal | 16|32	| 20	| 100 |
| Standard | 32|60	| 20	| 300 |
| Enterprise | 54| 97	| 60	| 700 |
{: caption="Table 2. Default configuration sizing" caption-side="top"}

**Note:** For the following sizings, requirements are rounded up to the nearest node configuration. All persistent volumes indicated are default. You must size the volumes based on the amount of data that is stored over a time.

### Development sizing
| Configuration | Number of nodes | vCPUs | Memory | Persistent volumes (GB) | Disk Space (GB) | Note |
| :--- | :---: | :---: | :---: | :---: |:---: |:--- |
| master, management, proxy	| 1| 8	| 16	| 20  | 100  | The Cloud Pak runs on the same node as {{site.data.keyword.open_s}}
{: caption="Table 3. Development, test, and POC {{site.data.keyword.open_s}} node sizing for the {{site.data.keyword.cloud_pak_mcm}}" caption-side="top"}

### Minimal sizing
| Configuration | Number of nodes | vCPUs | Memory | Persistent volumes (GB) | Disk Space (GB) |
| :--- | :---: | :---: | :---: | :---: |:---: |
| master, management, proxy	| 1| 16	| 32	| 20  | 100  |
{: caption="Table 4. Minimal {{site.data.keyword.open_s}} node sizing for the {{site.data.keyword.cloud_pak_mcm}}" caption-side="top"}

### Standard sizing

| Configuration | Number of nodes | vCPUs | Memory | Persistent volumes (GB) | Disk Space (GB) |
| :--- | :---: | :---: | :---: | :---: |:---: |
| master | 1| 16	| 32	| 20 | 100  |
| management | 1| 12	| 24	| - | 100 |
| proxy| 1| 4	| 8	| - | 100  |
{: caption="Table 5. Standard {{site.data.keyword.open_s}} node sizing for the {{site.data.keyword.cloud_pak_mcm}}" caption-side="top"}

### Enterprise sizing

| Configuration | Number of nodes | vCPUs | Memory | Persistent volumes (GB) | Disk Space (GB) |
| :--- | :---: | :---: | :---: | :---: |:---: |
| master | 3| 48	| 96	| 60 | 200  |
| management | 2| 24	| 48	| - | 200  |
| proxy| 2| 8	| 16	| - | 200  |
{: caption="Table 6. Enterprise {{site.data.keyword.open_s}} node sizing for the {{site.data.keyword.cloud_pak_mcm}}" caption-side="top"}

## IBM Cloud App Management
{: #app}

| Topology | vCPUs | Memory | Persistent volumes (GB) | Resources monitored | Max metrics per minute |
| :--- | :---: | :---: | :---: | :---: |:---: |
| Development | 10 | 32	| 75	| 50 | 25,000 |
| Minimal | 35| 55	| 1,200	| 3,000 | 1,000,000 |
| Standard | 90| 180	| 7,000	| 6,000 | 2,000,000  |
| Enterprise | 105| 230	| 10,500	| 9,000 | 3,000,000  |
{: caption="Table 7. IBM Cloud Automation Manager sizing" caption-side="top"}

For more information, see [Planning hardware and sizing](https://www.ibm.com/support/knowledgecenter/SS8G7U_19.4.0/com.ibm.app.mgmt.doc/content/planning_scaling.html?cp=SSFC4F_1.2.0).

## IBM Cloud Automation Manager
{: #auto}

| Topology | vCPUs | Memory | Persistent volumes (GB)  |
| :--- | :---: | :---: | :---: |
| Development | 12 | 20 | 65 |
| Minimal | 12| 30 | 65 |
| Standard | 15|48 | 65 |
| Enterprise | 18| 60 | 65 |
{: caption="Table 8. IBM Cloud App Management sizing" caption-side="top"}

For more information, see [System requirements](https://www.ibm.com/support/knowledgecenter/SS2L37_4.1.0.0/cam_requirements.html?cp=SSFC4F_1.2.0).

## Sizing for multicluster-endpoint
{: #mc_endpoint}

| Component Name                 	| Optional 	| CPU Request 	| CPU Limit  	| Memory Request  	| Memory Limit 	|
|--------------------------------	|----------	|-------------	|------------	|-----------------	|--------------	|
| ApplicationManager             	| True     	| 100 mCore   	| 500mCore   	| 128 MiB         	| 2 GiB        	|
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

## Sizing for management hub services
{: #management_services}

| Service Name                 | Optional | CPU Request | CPU Limit | Memory Request | Memory Limit | Persistent Volume (value is default) | Additional considerations |
|-------------------------------- |---------- |------------- |------------ |----------------- |-------------- |----------------- |-------------- |
| Catalog-ui, Common-web-ui, iam-policy-controller, key-management, mcm-kui, metering, monitoring, multicluster-hub,nginx-ingress, search | Default | 9,025 m | 29,289 m | 16,857 Mi | 56,963 Mi | 20 GiB | |
| Audit Logging | Optional | 125 m | 500 m | 250 Mi | 700 Mi | | |
| CIS Policy Controller | Optional | 525 m | 1,450 m | 832 Mi | 2,560 Mi | | |
| Image Security Enforcement | Optional | 128 m | 256 m | 128 Mi | 256 Mi | | |
| Licensing | Optional | 200 m | 500 m | 256 Mi | 512 Mi | | |
| Logging | Optional | 1,500 m | 3,000 m | 9,940 Mi | 10,516 Mi | 20 GiB | |
| Multitenancy Account Quota Enforcement | Optional | 25 m | 100 m | 64 Mi | 64 Mi | | |
| Notary | Optional | 600 m | 600 m  | 1,024 Mi | 1,024 Mi | | |
| Secret Encryption Policy Controller | Optional | 50 m | 100 m  | 100 Mi | 200 Mi | 110 GiB | |
| Secure Token Service (STS) | Optional | 410 m | 600 m  | 94 Mi  | 314 Mi | | Requires Red Hat OpenShift Service Mesh (Istio) |
| System Healthcheck Service | Optional | 75 m | 600 m | 96 Mi | 256 Mi | | |
| Vulnerability Advisor (VA) | Optional | 1,940 m | 4,440 m | 8,040 Mi | 27,776 Mi | 10 GiB | Requires Red Hat OpenShift logging (Elasticsearch) |
{: caption="Table 10. Hub services sizing" caption-side="top"}
