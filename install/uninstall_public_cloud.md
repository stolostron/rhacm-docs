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

# Uninstalling the {{site.data.keyword.product}} on {{site.data.keyword.product}}

Follow these steps to uninstall the {{site.data.keyword.product}} by removing the associated resources for your {{site.data.keyword.ocp_tm}} (OCP) cluster.
{:shortdesc}

Use the `oc` command-line interface to complete the steps to uninstall the Cloud Pak. Use the project name that you initially selected during the installation of the {{site.data.keyword.ocp}} cluster as a replacement for the `<project_name>` variable in the following commands.

1. Delete the resources for the custom resource definition (CRD):
    ```
    oc -n <project_name> delete isp default
    ```
    {: codeblock}

2. Delete the `deployment`:
    ```
    oc -n <project_name> delete deployment ibmservice-operator
    ```
    {: codeblock}

3. Delete the custom resource definition:
    ```
    oc -n <project_name> delete CustomResourceDefinition ibmservicesplatforms.operator.ibm.com
    ```
    {: codeblock}

4. Delete the `ClusterRoleBinding`:
    ```
    oc -n <project_name> delete clusterrolebinding ibmservice-operator
    ```
    {: codeblock}

5. Delete the pull `secret`:
    ```
    oc -n <project_name> delete secret infra-registry-key
    ```
    {: codeblock}

6. Delete the `admin-credential`:
    ```
    oc -n <project_name> delete secret admin-credential
    ```
    {: codeblock}

7. Verify that the Cloud Pak is uninstalled:

   Access the {{site.data.keyword.open_s}} web console and verify that the components that are related to the {{site.data.keyword.product}}, such as any related pods, are no longer installed.
