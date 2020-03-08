---

copyright:
  years: 2019
lastupdated: "2019-09-21"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Upgrading your multizone cluster

**{{site.data.keyword.tech_prev}}**

Upgrade your multizone cluster.
{: shortdesc}

For more information about upgrading your {{site.data.keyword.product_tm}} cluster, see [Upgrading Red Hat Advanced Cluster Management for Kubernetes ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.1/installing/upgrade.html){: new_window}.

Complete these steps before you complete the [Deploy your environment ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.1/installing/upgrade.html#deploy){: new_window} step.

1. If you used your own certificate in your present cluster, see [Bring your own certificate ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.1/installing/upgrade.html#cert){: new_window} before you upgrade your cluster.

2. Upgrade all nodes, except the worker nodes. Comment out worker sub host group in the `<installation_directory>/cluster/hosts` file.
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
  #worker_zone1
  #worker_zone2
  #worker_zone3
  #[worker_zone1]
  #<IP address of worker node in zone 1>
  #[worker_zone2]
  #<IP address of worker node in zone 2>
  #[wk_zone3]
  #<IP address of worker node in zone 3>

  [va:children]
  va_zone1
  va_zone2
  va_zone3
  [va_zone1]
  <IP address of VA node in zone 1>
  [va_zone2]
  <IP address of VA node in zone 2>
  [va_zone3]
  <IP address of VA node in zone 3>

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

3. Prepare for upgrade.

  See the [Prepare the cluster for upgrade ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.1/installing/upgrade.html#prep){: new_window} step.

4. Upgrade Kubernetes for all nodes except the worker nodes.

  See the [Upgrade Kubernetes ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.1/installing/upgrade.html#kub){: new_window} step.

5. Uncomment the worker sub host group in the `<installation_directory>/cluster/hosts` file.
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
  <IP address of first proxy node in zone 3>
  <IP address of second proxy node in zone 3>

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

  [va:children]
  va_zone1
  va_zone2
  va_zone3
  [va_zone1]
  <IP address of VA node in zone 1>
  [va_zone2]
  <IP address of VA node in zone 2>
  [va_zone3]
  <IP address of VA node in zone 3>
  ```
  {: codeblock}

6. Upgrade Kubernetes for the worker nodes in zone 1.

  * For {{site.data.keyword.linux_bit_notm}}, run the following command:
    ```
    sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster \
    ibmcom/icp-inception-amd64:{{site.data.keyword.version}}-ee upgrade-k8s -l worker_zone1
    ```
    {: codeblock}

  * For {{site.data.keyword.ppc_notm}}, run the following command:
    ```
    sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster \
    ibmcom/icp-inception-ppc64le:{{site.data.keyword.version}}-ee upgrade-k8s -l worker_zone1
    ```
    {: codeblock}

  * For {{site.data.keyword.s390_notm}}, run the following command:
    ```
    sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster \
    ibmcom/icp-inception-s390x:{{site.data.keyword.version}}-ee upgrade-k8s -l worker_zone1
    ```
    {: codeblock}

7. Upgrade Kubernetes for the worker nodes in zone 2.

  * For {{site.data.keyword.linux_bit_notm}}, run the following command:
    ```
    sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster \
    ibmcom/icp-inception-amd64:{{site.data.keyword.version}}-ee upgrade-k8s -l worker_zone2
    ```
    {: codeblock}

  * For {{site.data.keyword.ppc_notm}}, run the following command:
    ```
    sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster \
    ibmcom/icp-inception-ppc64le:{{site.data.keyword.version}}-ee upgrade-k8s -l worker_zone2
    ```
    {: codeblock}

  * For {{site.data.keyword.s390_notm}}, run the following command:
    ```
    sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster \
    ibmcom/icp-inception-s390x:{{site.data.keyword.version}}-ee upgrade-k8s -l worker_zone2
    ```
    {: codeblock}

8. Upgrade Kubernetes for the worker nodes in zone 3.

  * For {{site.data.keyword.linux_bit_notm}}, run the following command:
    ```
    sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster \
    ibmcom/icp-inception-amd64:{{site.data.keyword.version}}-ee upgrade-k8s -l worker_zone3
    ```
    {: codeblock}

  * For {{site.data.keyword.ppc_notm}}, run the following command:
    ```
    sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster \
    ibmcom/icp-inception-ppc64le:{{site.data.keyword.version}}-ee upgrade-k8s -l worker_zone3
    ```
    {: codeblock}

  * For {{site.data.keyword.s390_notm}}, run the following command:
    ```
    sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster \
    ibmcom/icp-inception-s390x:{{site.data.keyword.version}}-ee upgrade-k8s -l worker_zone3
    ```
    {: codeblock}

9. Upgrade the charts.

  See the [Upgrade the charts ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.1/installing/upgrade.html#chart){: new_window} step.

10. Complete the remaining steps for deploying your cluster.

  See the [Deploy your environment ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.1/installing/upgrade.html#deploy){: new_window} step.


For troubleshooting information, see [Multizone upgrade issues](../troubleshoot/multizone_upgrade_issues.md).
