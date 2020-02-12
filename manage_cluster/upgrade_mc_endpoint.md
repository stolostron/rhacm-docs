---

copyright:
  years: 2019
lastupdated: "2019-11-23"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Upgrading multicluster endpoint

After you upgrade your IBM Cloud Pak, you can upgrade your multicluster endpoint for your managed clusters.

{:shortdesc}

  - [Prerequisites](#prereq)
  - [Preparing for upgrade](#prep)
  - [Upgrading](#upgrading)

## Prerequisites
{: #prereq}

* You must have an {{site.data.keyword.cloud_pak_mcm}} hub cluster that is deployed on the latest version of {{site.data.keyword.cloud_pak_mcm}} and a managed cluster. To upgrade your {{site.data.keyword.cloud_pak_mcm}}, see [Upgrading the {{site.data.keyword.cloud_pak_mcm}}](../../install/upgrade_offline.md).

* You need to install the Kubernetes CLI, `kubectl`. To install `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

* You must install the {{site.data.keyword.cloud_pak}} CLI, `cloudctl`. For more information, see [Installing the {{site.data.keyword.cloud_pak}} CLI](../../cloudctl/install_cli.md) to install the CLI.

  **Note:** Download the installation file for CLI tools from the {{site.data.keyword.gui}}.

* After you install the {{site.data.keyword.cloud_pak}} CLI, you need to install the multicluster plug-in (mc). For more information, see [Installing the {{site.data.keyword.cloud_pak}} CLI (cloudctl) multicluster plug-in (mc)](../../cli/installing_mc_plugin.md) to install the CLI.

* To learn more about the `mc` plugin and other commands and see [options] that are available, see [{{site.data.keyword.cloud_pak}} CLI (cloudctl) multicluster commands (mc)](../../cli/cli_mc_commands.md).

## Upgrading
{: #upgrading}

Log in to your _hub_ cluster with `cloudctl login`. Run the following command:

  ```
  cloudctl login -a https://<Hub Cluster Master Host>:<Cluster Master API Port> --skip-ssl-validation
  ```
  {: codeblock}

1. Run the following command to upgrade, then enter `y` after the output:

  ```
  cloudctl mc cluster upgrade <cluster-name>
  ```
  {: codeblock}

  **Note:** You do not need to specify the version. By default, you receive the latest version that is available.

2. Verify that the cluster is successfully upgraded. Run the following command:

  ```
  kubectl get clusterstatus <cluster-name> -n <cluster-namespace>
  ```
  {: codeblock}

  In your output, `ENDPOINTVERSION` and `ENDPOINTOPERATORVERSION` values match the version that you received from the upgrade command.
