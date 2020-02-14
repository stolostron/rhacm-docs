---

copyright:
  years: 2016, 2019
lastupdated: "2019-09-22"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Enabling and disabling {{site.data.keyword.icp_notm}} components

{{site.data.keyword.icp}} includes several components which are composed of one or more management services.

After you install {{site.data.keyword.icp_notm}}, you can enable or disable management services that are comprised in a component. For more information on the default values for the management services, see [Customizing the cluster with the config.yaml file](../installing/config_yaml.md#vuln_setting). For more information on the components that are available and the management services that are included with the component, see [{{site.data.keyword.icp}} components](../getting_started/components.md). This topic covers the platform that a service can run on and service dependencies. <!--You can disable all services to obtain an IBM Edge for IBM Cloud Private cloud.-->
{:shortdesc}

See [{{site.data.keyword.icp}} components](../getting_started/components.md) for more information on the components that are available and the management services that are included with the component.

**Required user type or access level**: Cluster administrator.

## Enabling {{site.data.keyword.icp_notm}} components

1. If you are upgrading to version 3.1.0, or later, you must reformat the management services section in the `config.yaml` file before you upgrade.
    The section of the file before the upgrade reads similar to the following example:
	  ```
	  disabled_management_services:["istio","vulnerability-advisor","custom-metrics-adapter"]
	  ```
	  {: pre}

    The section of the file after the changes for the upgrade reads similar to the following example:
	  ```
	  management-services:
	    istio: disabled
		vulnerability-advisor: disabled
		custom-metrics-adapter: disabled
	  ```
	  {: codeblock}

    If you are enabling the `vulnerability-advisor` after upgrade, deploy the new vulnerability advisor (VA) nodes. For more information about deploying the new VA nodes, see [Adding an {{site.data.keyword.icp_notm}} cluster node](../installing/add_node.md).

    **Note:** If you enabled `vulnerability-advisor` on the previous version, ensure that the `vulnerability-advisor` entry is enabled in the `management-services` section of the `config.yaml` file after the upgrade. Your `vulnerability-advisor` parameter might resemble the following parameter value: `vulnerability-advisor: enabled`. The setting is disabled by default in the upgraded version, and the setting is not automatically retained during the upgrade.

2. Add a service to the `management_services` parameter list and set its status to `enabled` in the `config.yaml` file to enable a service. Change the service parameter value to `enabled`to enable the service.

   **Important**: You must also enable or disable all services that comprise a component. The following services cannot be disabled: `tiller`, `calico/nsx-t`, `kube-dns`, `monitoring-crd`, `cert-manager`.

3. Run the add-on command to enable the service on your cluster:
    ```
    docker run --rm -t -e LICENSE=accept --net=host -v $(pwd):/installer/cluster ibmcom/icp-inception-$(uname -m | sed 's/x86_64/amd64/g'):3.2.1-ee addon
    ```
    {: codeblock}

  **Note:** {{site.data.keyword.icp_notm}} management services have dependency relationships between each other. The dependency relationships are valid only if `tiller`, `calico/nsx-t`, `kube-dns`, `monitoring-crd` and `cert-manager` are enabled.

## Disabling {{site.data.keyword.icp_notm}} components

1. If you want to disable an add-on component in the fresh install, you must update the management services section in the `config.yaml`. Set the relevant add-on status to disable. The add-on component is skipped during installation.

2. If you want to remove an add-on component after you install {{site.data.keyword.icp_notm}}, complete the following steps to remove it from the cluster:
		
	  * Set the add-on component you want to remove to the `deleted` status in the management services section of the `config.yaml`.

    * Remove the add-on components by running the following command:
	  ```
	  docker run --rm -t -e LICENSE=accept --net=host -v $(pwd):/installer/cluster ibmcom/icp-inception-$(uname -m | sed 's/x86_64/amd64/g'):3.2.1-ee addon
	  ```
    {: codeblock}

**Important:** Disabling services may impact the installation of {{site.data.keyword.cloud_pak}}.
**Note:** {{site.data.keyword.icp_notm}} management services have dependency relationships between each other. For example, the `auth-idp` service depends on the `mongodb` service. If `mongodb` is disabled, the `auth-idp` service cannot function.

## Dependencies of the {{site.data.keyword.icp_notm}} components

View the following table of the {{site.data.keyword.icp_notm}} management services, their dependencies, and whether they are required for the {{site.data.keyword.icp_OpenShift}} environment or for supporting {{site.data.keyword.cloud_pak}}:

| Management service | Dependencies  | Supported platforms | Required for {{site.data.keyword.icp_OpenShift}} | Required for {{site.data.keyword.cloud_paks}} |
|-----|-------|-----|-----|-----|
| `kmsplugin` | IAM, `key-management` | {{site.data.keyword.icp_notm}} | No | No |
| `tiller` |  | {{site.data.keyword.icp_notm}} | Yes | Yes |
| `image-manager` |  | {{site.data.keyword.icp_notm}} | No | No |
| `kube-dns` |  | {{site.data.keyword.icp_notm}} | No | No |
| `calico` |  | {{site.data.keyword.icp_notm}} | No | No |
| `nsx-t` |  | {{site.data.keyword.icp_notm}} | No | No |
| `cert-manager` |  | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | Yes | Yes |
| `mongodb` |  |{{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | Yes | Yes |
| `monitoring-crd` | | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | Yes | Yes |
| `auth-idp` | `mongodb` | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `auth-apikeys` | `mongodb` | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | Yes | Yes |
| `auth-pap` | `mongodb` | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `auth-pdp` | `mongodb`, `auth-idp`, `auth-pap`, `auth-apikeys` |  {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `catalog-ui` | `auth-idp`, `platform-api`, `helm-api`, `helm-repo`, `multicluster-hub` | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `custom-metrics-adapter` | `monitoring` | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | No |
| `heapster` | None | {{site.data.keyword.icp_notm}} | No | No |
| `helm-api` | `mongodb`, `platform-api`, `icp-management-ingress`, `helm-repo`, `mgmt-repo` | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} |  No | Yes |
| `helm-repo` | `mongodb` | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `ibm-search-prod` |IAM| {{site.data.keyword.icp_notm}}, {{site.data.keyword.mcm_notm}} | No | No |
| `icp-management-ingress` | | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `image-security-enforcement`| | {{site.data.keyword.icp_notm}} | No | No |
| `istio`| | {{site.data.keyword.icp_notm}} | No | No |
| `nvidia-device-plugin`| | {{site.data.keyword.icp_notm}} | No | No |
| `key-management` | IAM, `mongodb` | {{site.data.keyword.icp_notm}} | No | No |
| `key-management-hsm` |  | {{site.data.keyword.icp_notm}} | No | No |
| `logging` | IAM  | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | No |
| `metering` | `mongodb`, IAM | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `metrics-server` | | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | No |
| `nginx-ingress` | | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `mgmt-repo` | `mongodb` | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | No |
| `monitoring` | IAM | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `mongdb` | IAM | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}}, {{site.data.keyword.icp_notm}} with IKS| No | No |
| `multicluster-hub` | mongodb monitoring IAM | {{site.data.keyword.icp_notm}} | No | No |
| `node-problem-detector-draino` |  | {{site.data.keyword.icp_notm}} | No | No |
| `platform-api` | IAM | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `platform-ui` | `auth-idp`, `platform-api`, `catalog-ui`, `image-manager`| {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `platform-pod-security` | | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}}, {{site.data.keyword.icp_notm}} with IKS | Yes | No |
| `platform-security-netpols` | | {{site.data.keyword.icp_notm}} | No | No |
| `ibm-search-prod` | | {{site.data.keyword.icp_notm}}, {{site.data.keyword.mcm_notm}} | No | No |
| `secret-watcher` | | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `security-onboarding` | IAM | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | Yes |
| `service-catalog` | `metrics-server` | {{site.data.keyword.icp_notm}} | No | Yes |
| `storage-glusterfs` | `monitoring` | {{site.data.keyword.icp_notm}} | No | No |
| `storage-minio` | `icp-management-ingress`, `monitoring` | {{site.data.keyword.icp_notm}} | No | Do not use the system instance. |
| `vulnerability-advisor` | `logging`, `image-manager`, IAM | {{site.data.keyword.icp_notm}} | No | No |
| `web-terminal` | `platform-api`, IAM | {{site.data.keyword.icp_notm}}, {{site.data.keyword.icp_OpenShift}} | No | No |
| `multicluster-hub` | IAM, `monitoring`, `mongodb` | {{site.data.keyword.icp_notm}} | No | No |
| `multicluster-endpoint` | `monitoring` | {{site.data.keyword.icp_notm}} | No | No |
| `system-healthcheck-service` | `icp-management-ingress`| {{site.data.keyword.icp_notm}} | No | No |
{: caption="Table 1. {{site.data.keyword.icp_notm}} management service dependencies" caption-side="top"}

**Note:** Identity and Access Management (IAM) includes the following services: `auth-idp`, `auth-pap`, `auth-pdp`, `auth-apikeys`, and `secret-watcher`.
