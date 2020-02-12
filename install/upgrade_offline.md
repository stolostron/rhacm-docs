---

copyright:
  years: 2019
lastupdated: "2019-12-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Upgrading the {{site.data.keyword.product}}

You can upgrade only offline images that were used to install the {{site.data.keyword.product}}.
{:shortdesc}

  * [Offline upgrade](#offline-upgrade)
    * [Supported upgrade paths](#supported-upgrade-paths)
    * [Prerequisites](#prerequisites)
    * [Steps](#upgrade-steps)
    * [Post upgrade](#post-upgrade)
    * [Managed clusters](#managed-clusters)

## Offline upgrade
{: #offline-upgrade}

You can upgrade services by upgrading all deployed platform Helm charts.

### Supported upgrade paths
{: #supported-upgrade-paths}

You can upgrade only the following supported paths:

* {{site.data.keyword.product}} on {{site.data.keyword.ocp}} version 1.1 to version {{site.data.keyword.version_cp}}

During the upgrade process, you cannot access the services management console.

### Prerequisites
{: #prerequisites}

* Optional. If you have subscriptions for deploying and managing application resources, update your subscription definition to use the expected local placement setting. For more information, see [Migrating subscriptions](../mcm/applications/migrate_subscriptions.md).

### Upgrade steps
{: #upgrade-steps}

1. Log in to the boot node as either a user with root permissions or a user with sudo privileges.
2. Download the installation files for {{site.data.keyword.IBM_notm}} Cloud Pak for Multicloud Management 1.2. You must download the correct file or files for the type of nodes in your cluster. You can obtain these files from the [{{site.data.keyword.IBM_notm}} Passport Advantage® ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/software/passportadvantage/) website.

    - For a {{site.data.keyword.linux_bit_notm}} cluster, download the `ibm-cp4mcm-core-1.2-x86_64.tar.gz` file.
    - For a {{site.data.keyword.ppc_notm}} cluster, download the `ibm-cp4mcm-core-1.2-ppc64le.tar.gz` file.

3. Extract the image and load them into Docker. Extracting the images might take a few minutes.
    - For {{site.data.keyword.ocp}} on {{site.data.keyword.linux_bit_notm}}:
        ```
        tar xf ibm-cp4mcm-core-1.2-x86_64.tar.gz -O | sudo docker load
        ```
        {: codeblock}

    - For {{site.data.keyword.ocp}} on {{site.data.keyword.ppc_notm}}:
        ```
        tar xf ibm-cp4mcm-core-1.2-ppc64le.tar.gz -O | sudo docker load
        ```
        {: codeblock}

4. Create an installation directory and copy the `cluster` directories from the previous installation directory to the new `cluster` folder. Use a different installation directory than you used for the previous version. For example, to store the configuration files in `ibm-multicloud-manager-1.2`, run the following commands:
    ```
    mkdir /opt/ibm-multicloud-manager-1.2
    cd /opt/ibm-multicloud-manager-1.2
    sudo cp -r /<installation_directory>/cluster .
    ```
    {: codeblock}

    **Note:** `/<installation_directory>` is the full path to your previous installation directory, and `/<new_installation_directory>` is the full path to your version 1.2.0 installation directory. It is not required to copy the entire image installation package from the previous version.

    You must set `multicluster-hub.etcd.accessModes` to `ReadWriteMany` in the `config.yaml` file, which is located in the `cluster` folder, if `multicluster-hub.etcd.persistence` is set to `true` and `multicluster-hub.etcd.accessModes` is not configured in the previous version. For example:
    ```
    multicluster-hub:
    etcd:
        persistence: true
        accessModes: ReadWriteMany
    ```
    {: codeblock}

5. Change to the `cluster` directory within your installation directory:
    ```
    cd /<new_installation_directory>/cluster
    ```
    {: codeblock}

6. Upgrade services by running the `upgrade` command:

    - For {{site.data.keyword.ocp}} on {{site.data.keyword.linux_bit_notm}}:
        ```
        sudo docker run -t --net=host -e LICENSE=accept -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/mcm-inception-amd64:3.2.3 upgrade
        ```
        {: codeblock}

    - For {{site.data.keyword.ocp}} on {{site.data.keyword.ppc_notm}} (ppc64le):
        ```
        sudo docker run -t --net=host -e LICENSE=accept -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/mcm-inception-ppc64le:3.2.3 upgrade
        ```
        {: codeblock}

    **Note:** If you want to get more logs from the command, you can add `-v` after the command to enable verbose mode (-vvv for more, -vvvv to enable connection debugging).

### Post upgrade

If you cannot view the {{site.data.keyword.gui}} after you complete the upgrade, complete the following steps:

1. Open the `platform-ui ingress` file:

      ```
      kubectl edit ingress platform-ui -n kube-system
      ```
      {: codeblock}

2. Edit the file by deleting the following line and saving it:

      ```
      icp.management.ibm.com/app-root: /console
      ```
      {: codeblock}

### Upgrading your multicluster endpoint 
{: #managed-clusters}

For more information about upgrading your managed clusters, see [Upgrading multicluster endpoint](../mcm/manage_cluster/upgrade_mc_endpoint.md).
