---

copyright:
  years: 2019
lastupdated: "2019-11-12"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Enabling and disabling services

{{site.data.keyword.mcm_notm}} includes several services that are composed of one or more services.
{:shortdesc}

After you install {{site.data.keyword.cloud_pak_mcm}}, you can enable or disable services that are comprised in a component. For more information on the default values for the services, see [Services disabled and enabled by default](cloud_pak_foundation.md#disabled_common_services).

**Required user type or access level**: Cluster administrator.

## Enabling {{site.data.keyword.mcm_notm}} services

1. Add a service to the `management_services` parameter list and set its status to `enabled` in the `config.yaml` file to enable a service. Change the service parameter value to `enabled` to enable the service.
    For example, if you want to enable `logging` after the installation:
    ```
    management_services:
      monitoring: enabled
      metering: enabled
      logging: enabled
      custom-metrics-adapter: disabled
      image-security-enforcement: disabled
    ```

2. Run the add-on command to enable the service on your cluster:
    * For {{site.data.keyword.linux_bit_notm}}:
      ```
      docker run -t --net=host -e LICENSE=accept -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/mcm-inception-amd64:3.2.3-rhel-ee addon
      ```
      {: codeblock}

   * For {{site.data.keyword.ppc_notm}}:
      ```
      sudo docker run -t --net=host -e LICENSE=accept -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/mcm-inception-ppc64le:3.2.3-ee addon
      ```
      {: codeblock}

## Disabling {{site.data.keyword.mcm_notm}} services

**Note:** If you want to disable an add-on component in a fresh installation, you must update the management services section in the `config.yaml`. Set the relevant add-on status to disable. The add-on component is skipped during installation. For more information on disabling services during the installation, see [Disabling services during the installation](cloud_pak_foundation.md#config.yaml).

1. Set the add-on component that you want to remove to the `deleted` status in the management services section of the `config.yaml`.
    For example, if you want to disable `metering` after the installation:
    ```
    management_services:
      monitoring: enabled
      metering: deleted
      logging: disabled
      custom-metrics-adapter: disabled
      image-security-enforcement: disabled
    ```

2. Remove the add-on services by running the following command:
	 * For {{site.data.keyword.linux_bit_notm}}:
        ```
        docker run -t --net=host -e LICENSE=accept -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/mcm-inception-amd64:3.2.3-rhel-ee addon
        ```
        {: codeblock}

   * For {{site.data.keyword.ppc_notm}}:
        ```
        sudo docker run -t --net=host -e LICENSE=accept -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/mcm-inception-ppc64le:3.2.3-ee addon
        ```
        {: codeblock}

**Important:** Disabling services can impact the installation of {{site.data.keyword.cloud_pak}}.

**Note:** The `enabled` status indicates that the service is installed in the cluster. The `disabled` status indicates that the service is skipped in the installer for both installation and uninstallation. The `deleted` status indicates that the installed service will be deleted from the cluster.

**Note:** {{site.data.keyword.cloud_pak_mcm}} services have dependency relationships between each other. For example, the `auth-idp` service depends on the `mongodb` service. If `mongodb` is disabled, the `auth-idp` service cannot function.

## Dependencies of the {{site.data.keyword.mcm_notm}} services

View the following table of the {{site.data.keyword.mcm_notm}} services, their dependencies, and whether they are required for the {{site.data.keyword.mcm_notm}} environment or for supporting {{site.data.keyword.cloud_pak}}:

| Management service 	| Dependencies 	| Required for {{site.data.keyword.mcm_notm}} 	|
|------------------------------	|-------------------------------------------------------------------------------	|--------------------------------------------------	|
| `tiller` 	|  	| Yes 	|
| `cert-manager` 	|  	| Yes 	|
| `mongodb` 	|  	|  Yes 	|
| `monitoring-crd` 	|  |	Yes 	|
| `auth-idp` 	| `mongodb` 	| Yes 	|
| `auth-apikeys` 	| `mongodb` 	| Yes 	|
| `auth-pap` 	| `mongodb` 	| Yes 	|
| `auth-pdp` 	| `mongodb`, `auth-idp`, `auth-pap`, `auth-apikeys` 	| Yes 	|
| `catalog-ui` 	| `auth-idp`, `platform-api`, `helm-api`, `helm-repo`, `multicluster-hub` 	| No 	|
| `helm-api` 	| `mongodb`, `platform-api`, `icp-management-ingress`, `helm-repo`, `mgmt-repo` 	| No 	|
| `helm-repo` 	| `mongodb` 	| No 	|
| `ibm-search-prod` |IAM | Yes |
| `icp-management-ingress` 	|  	| No 	|
| `image-security-enforcement` 	|  	| No 	|
| `key-management` 	| IAM, `mongodb` 	| No 	|
| `logging` 	| IAM 	| No 	|
| `metering` 	| `mongodb`, IAM 	| No 	|
| `nginx-ingress` 	|  	| No 	|
| `mgmt-repo` 	| `mongodb` 	| No 	|
| `monitoring` 	| IAM 	| Yes 	|
| `mongdb` 	| IAM 	| Yes 	|
| `multicluster-hub` 	| `mongodb` `monitoring` IAM 	| Yes 	|
| `platform-api` 	| IAM 	| No 	|
| `common-web-ui` 	| `auth-idp`, `platform-api`, `catalog-ui` 	| No 	|
| `platform-pod-security` 	|  	| Yes 	|
| `secret-watcher` 	|  	| Yes 	|
| `security-onboarding` 	| IAM 	| No 	|
| `vulnerability-advisor` 	| `logging`, IAM 	| No 	|
{: caption="Table 1. Management service dependencies" caption-side="top"}

**Note:** Identity and Access Management (IAM) includes the following services: `auth-idp`, `auth-pap`, `auth-pdp`, `auth-apikeys`, and `secret-watcher`.
