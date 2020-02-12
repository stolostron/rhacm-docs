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

# Installing the {{site.data.keyword.cloud_pak_mcm}} online

Follow these steps for an online installation of the {{site.data.keyword.cloud_pak_mcm}} by using the entitled registry. During this install, you can install the additional modules.
{:shortdesc}

  1. [Install the {{site.data.keyword.mcm_notm}}](#common_services)
      - [Update the installation config.yaml](#config.yaml)
      - [Deploy the {{site.data.keyword.mcm_notm}}](#deploy)
  2. [Verify the installation](#verify)
      - [Services disabled by default](#disabled_common_services)
      - [Services enabled by default](#enabled_common_services)
  3. [Post installation](#post_install)

Before you begin, you must have a supported version of {{site.data.keyword.ocp}} installed. For more information, see [Preparing to install the {{site.data.keyword.cloud_pak_mcm}}](prep.md), and [System requirements](requirements.md).

## Install the {{site.data.keyword.mcm_notm}}
{: #common_services}

As the {{site.data.keyword.cloud_pak_mcm}} cannot install natively on the {{site.data.keyword.ocp}}, the services must be installed before other Cloud Pak modules.

1. Obtain the entitlement key that is assigned to your ID.
   1. Log in to [MyIBM Container Software Library ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://myibm.ibm.com/products-services/containerlibrary) with the IBMid and password that are associated with the entitled software.
   2. In the Entitlement keys section, select **Copy key** to copy the entitlement key to the clipboard.

2. If there are no {{site.data.keyword.ocp}} CLI tools on the boot node, you need to download, decompress, and install the {{site.data.keyword.ocp}} CLI tools `oc` from
[{{site.data.keyword.ocp}} client binaries ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://mirror.openshift.com/pub/openshift-v3/clients/).

3. Log in to the entitled registry:
      ```
      docker login cp.icr.io --username cp --password <entitlement_key>
      ```
      {: codeblock}

4. Ensure that you have a Kubernetes Docker-registry secret that is called `entitled-registry` by running the following command:
      ```
      oc create secret docker-registry entitled-registry --docker-server=cp.icr.io --docker-username=cp --docker-password=<entitlement_key> --docker-email=<docker_email>`
      ```
      {: codeblock}

5. Pull the installer image from the entitled registry by running the following command:
      ```
      docker pull cp.icr.io/cp/icp-foundation/mcm-inception:3.2.3
      ```
      {: codeblock}

6. Create an installation directory on the boot node:
      ```
      mkdir /opt/ibm-multicloud-manager-1.2 ; cd /opt/ibm-multicloud-manager-1.2
      ```
      {: codeblock}
7. Extract the cluster directory:
      ```
      sudo docker run --rm -v $(pwd):/data:z -e LICENSE=accept --security-opt label:disable cp.icr.io/cp/icp-foundation/mcm-inception:3.2.3 cp -r cluster /data
      ```
      {: codeblock}

8. Create cluster configuration files.

    * Obtain the `kubeconfig` from the {{site.data.keyword.ocp}}:

      The {{site.data.keyword.open_s}} configuration files can be found on the {{site.data.keyword.open_s}} master node.

      1. Copy the {{site.data.keyword.open_s}} `admin.kubeconfig` file to the cluster directory. The {{site.data.keyword.open_s}} `admin.kubeconfig` file can be found in the `/etc/origin/master/admin.kubeconfig` directory:
          ```
          sudo cp /etc/origin/master/admin.kubeconfig /opt/ibm-multicloud-manager-1.2/cluster/kubeconfig
          ```
          {: codeblock}

      1. If your boot node is different from the {{site.data.keyword.open_s}} master node, then the previous files must be copied to the boot node.

          For an {{site.data.keyword.ocp_ibmcloud}} cluster, you can obtain or generate its Kubernetes configuration by following the steps in [Creating a cluster with the console ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/containers?topic=containers-openshift_tutorial#openshift_create_cluster_console). Once you log in with `oc`, you can generate the configuration file by running the following command:
            ```
            oc config view > /opt/ibm-multicloud-manager-1.2/cluster/kubeconfig
            ```
            {: codeblock}

    * For {{site.data.keyword.iks_ocp}}, you can use the `oc login` command to update `$KUBECONFIG` to point to a file that can hold the profile information.

      The default location for the `kubernetes` config file is `~/.kube/config` unless you override it.

        1. From your boot node terminal run the following commands:
            ```
            export KUBECONFIG=$(pwd)/myclusterconfig
            ```
            {: codeblock}

            ```
            oc login --token=EtZqGLpwxpL8b6CAjs9Bvx6kxe925a1HlB__AR3gIOs --server=https://c100-e.us-east.containers.cloud.ibm.com:32653
            ```
            {: codeblock}

            You can see that `$(pwd)/myclusterconfig` has been populated.

        1. Copy the `kubeconfig` file:
            ```
            cp $KUBECONFIG /opt/ibm-multicloud-manager-1.2/cluster/kubeconfig
            ```
            {: codeblock}

### Update the installation config.yaml
{: #config.yaml}

You must update the `config.yaml` file or use the `power.openshift.config.yaml` file to replace the `config.yaml` for {{site.data.keyword.ppc_notm}} before you deploy the services.

1. Add the {{site.data.keyword.ocp}} nodes on the cluster that you want to deploy services upon, to the `config.yaml` file.

    1. Collect information for the `config.yaml` file. Run `oc get nodes` to get all the cluster node names. Use these {{site.data.keyword.ocp}} worker node names to select master, proxy, and management targets. Assign any of the {{site.data.keyword.ocp}} worker nodes to each of the `cluster_nodes`.

    2. Update the `cluster_nodes` section of the `config.yaml` to identify your chosen {{site.data.keyword.ocp}} worker nodes. For example:
        ```
        oc get nodes
        NAME            STATUS    ROLES                                AGE       VERSION
        10.148.87.135   Ready     compute,infra                        6h        v1.11.0+d4cacc0
        10.148.87.140   Ready     compute,infra                        6h        v1.11.0+d4cacc0
        10.148.87.186   Ready     compute,infra                        6h        v1.11.0+d4cacc0
        ```
      **Notes**: For {{site.data.keyword.iks_ocp}}, you see only the {{site.data.keyword.ocp}} worker nodes in an {{site.data.keyword.iks}} managed cluster. The node names are the same as the private IP address of their hosting VMs.

    3. Use the node information to create the following entries in the `config.yaml`:
        ```
        # A list of OpenShift nodes that used to run services components
        cluster_nodes:
          master:
            - 10.148.87.135
          proxy:
            - 10.148.87.135
          management:
            - 10.148.87.186
        ```
        {: codeblock}

        **Note**: The value of the `master`, `proxy`, and `management` parameters is an array and can have multiple nodes; and the same node can be used for the master, management, and proxy. Due to a limitation from {{site.data.keyword.open_s}}, if you want to deploy {{site.data.keyword.mcm_notm}} on any {{site.data.keyword.open_s}} master or infrastructure node, you must label the node as an {{site.data.keyword.open_s}} compute node with the following command:

        ```
        oc label node <master node host name/infrastructure node host name> node-role.kubernetes.io/compute=true
        ```
        {: codeblock}

2. Run `oc get storageclass` to identify an {{site.data.keyword.ocp}} dynamic block storage class. You need some persistent storage for some of the service pods.

    Example output:
    ```
    oc get sc
    NAME                          PROVISIONER         AGE
    default                       ibm.io/ibmc-file    4h
    ibmc-block-bronze (default)   ibm.io/ibmc-block   4h
    ibmc-block-custom             ibm.io/ibmc-block   4h
    ibmc-block-gold               ibm.io/ibmc-block   4h
    ibmc-block-retain-bronze      ibm.io/ibmc-block   4h
    ibmc-block-retain-custom      ibm.io/ibmc-block   4h
    ibmc-block-retain-gold        ibm.io/ibmc-block   4h
    ibmc-block-retain-silver      ibm.io/ibmc-block   4h
    ibmc-block-silver             ibm.io/ibmc-block   4h
    ibmc-file-bronze              ibm.io/ibmc-file    4h
    ibmc-file-custom              ibm.io/ibmc-file    4h
    ibmc-file-gold                ibm.io/ibmc-file    4h
    ibmc-file-retain-bronze       ibm.io/ibmc-file    4h
    ibmc-file-retain-custom       ibm.io/ibmc-file    4h
    ibmc-file-retain-gold         ibm.io/ibmc-file    4h
    ibmc-file-retain-silver       ibm.io/ibmc-file    4h
    ibmc-file-silver              ibm.io/ibmc-file    4h
    ```

   If you want to use the default block class `ibmc-block-bronze`, Add `storage_class: ibmc-block-bronze` to the `config.yaml`.

   For {{site.data.keyword.ppc_notm}}, update the `config.yaml` file with the storage class parameter. You can use `ibmc-powervc-k8s-volume-default` for a {{site.data.keyword.ppc_notm}} environment. For more information on how to create `ibmc-powervc-k8s-volume-default`, see [Creating a storage class for the IBM PowerVC FlexVolume Driver (IBM Power only)](../mcm/manage_cluster/create_fvd_vol.md).

3. Update the default password for the `admin` user. This password becomes the {{site.data.keyword.mcm_notm}} login password for the `admin` user. This login is not an {{site.data.keyword.ocp}} account.

   1. Set up a default password in the `config.yaml` file that meets the default password enforcement rule `'^([a-zA-Z0-9\-]{32,})$'`. You can also define a custom set of password rules.
   2. Open the `/<installation_directory>/cluster/config.yaml` file, and set the `default_admin_password`. The password must satisfy all regular expressions that are specified in `password_rules`.

   3. Optional: You can define one or more rules as regular expressions in an array list that the password must pass. For example, a rule can state that the password must be longer than a specified number of characters and or that it must contain at least one special character. The rules are written as regular expressions that are supported by the Go programming language. To define a set of password rules, add the following parameter and values to the `config.yaml` file:
      ```
      password_rules:
      - '^.{10,}'
      - '.*[!@#\$%\^&\*].*'
      ```
      To disable the `password_rule`, add `(.*)`
      ```
      password_rules:
      - '(.*)'
      ```
      **Note**: The `default_admin_password` must match all rules that are defined. If `password_rules` is not defined, the `default_admin_password` must meet the default passport enforcement rule `'^([a-zA-Z0-9\-]{32,})$'`.

4. Set image registry to the entitled registry. This step is for the installer to pull images from the entitled registry. The following content needs to be added into the `config.yaml`:
      ```
      image_repo: cp.icr.io/cp/icp-foundation
      private_registry_enabled: true
      docker_username: cp
      docker_password: <entitlement_key>
      ```

5. Define the management_services in the `config.yaml` appropriate to your Cloud Pak.
    For example:
      ```
      management_services:
        monitoring: enabled
        metering: enabled
        logging: disabled
        custom-metrics-adapter: disabled
        image-security-enforcement: disabled
      ```
    These [services](#disabled_common_services) are disabled by default. If you want to install these services during the installation, you need to add them into the `management_services` section.

    For example, if you want to enable `logging` during the installation.
      ```
      management_services:
        monitoring: enabled
        metering: enabled
        logging: enabled
        custom-metrics-adapter: disabled
        image-security-enforcement: disabled
      ```
    **Note:** For more information about how to enable Vulnerability Advisor, see [Enabling the Vulnerability Advisor (VA)](../mcm/manage_cluster/va_openshift_mcm.md).

    You can disable the enabled [services](#enabled_common_services) by setting the values in the `management_services` section to `disabled`.
    For example, if you want to disable `metering` during the installation:
    ```
    management_services:
      monitoring: enabled
      metering: disabled
      logging: disabled
      custom-metrics-adapter: disabled
      image-security-enforcement: disabled
    ```
    **Note**: Disabling services can impact the installation of the {{site.data.keyword.cloud_pak_mcm}}. Proceed with caution and refer to [Enabling and disabling services](disable_and_enable_services.md).

    For more information about these configuration settings and other settings that you can configure for your cluster, see [Customizing the cluster with the config.yaml file](../installer/3.2.2/config_yaml.md) and [Multicluster config.yaml file settings](config_mcm.md).

### Deploy the {{site.data.keyword.mcm_notm}}
{: #deploy}

1. Run the deployment command:
      ```
      sudo docker run -t --net=host -e LICENSE=accept -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable cp.icr.io/cp/icp-foundation/mcm-inception:3.2.3 install-with-openshift
      ```
      {: codeblock}

## Verify the installation
{: #verify}

If the installation succeeded, the access information for your cluster is displayed. You can use the URL to connect to the {{site.data.keyword.mcm_notm}} {{site.data.keyword.gui}}.

From a web browser, browse to the URL of your cluster. For a list of supported browsers, see [Supported browsers](../common-web-ui/1.0.0/supported_browsers.md).
  * To learn how to access your cluster by using the {{site.data.keyword.mcm_notm}} {{site.data.keyword.gui}} from a web browser, see [Accessing your {{site.data.keyword.mcm_notm}} cluster by using the {{site.data.keyword.gui}}](../common-web-ui/1.0.0/access_cluster.md).
  * To learn how to access your cluster by using the command line, see the [CLI tools guide](../cloudctl/3.2.3/cli_guide.md).

### Services disabled by default
{: #disabled_common_services}

```
cis-controller: disabled
kmsplugin: disabled
logging: disabled
mutation-advisor: disabled
notary: disabled
platform-pod-security: disabled
secret-encryption-policy-controller: disabled
system-healthcheck-service: disabled
vulnerability-advisor: disabled
```

### Services enabled by default
{: #enabled_common_services}

```
auth-apikeys: enabled
auth-idp: enabled
auth-pap: enabled
auth-pdp: enabled
catalog-ui: enabled
cert-manager: enabled
cert-manager-webhook: enabled
cluster-api-provider-aks: enabled (disabled in {{site.data.keyword.ppc_notm}})
cluster-api-provider-gke: enabled
cluster-api-provider-iks: enabled (disabled in {{site.data.keyword.ppc_notm}})
cluster-api-provider-ocp: enabled
helm-api: enabled
helm-repo: enabled
iam-policy-controller: enabled
icp-management-ingress: enabled
image-security-enforcement: enabled (disabled in {{site.data.keyword.ppc_notm}})
key-management: enabled
mcm-kui: enabled
metering: enabled
mgmt-repo: enabled
mongodb: enabled
monitoring: enabled
monitoring-crd: enabled
multicluster-hub: enabled
nginx-ingress: enabled
oidcclient-watcher: enabled
platform-api: enabled
platform-ui: enabled
search: enabled
secret-watcher: enabled
security-onboarding: enabled
tiller: enabled
web-terminal: enabled
```
## Post installation tasks
{: #post_install}

Install the optional modules in the {{site.data.keyword.cloud_pak_mcm}}.

- [Installing IBM Cloud App Management](https://www.ibm.com/support/knowledgecenter/SS8G7U_19.4.0/com.ibm.app.mgmt.doc/content/install_mcm.html?cp=SSFC4F_1.2.0)
- [Installing IBM Cloud Automation Manager](https://www.ibm.com/support/knowledgecenter/SS2L37_4.1.0.0/cam_install_EE_online_icpos.html?cp=SSFC4F_1.2.0)
