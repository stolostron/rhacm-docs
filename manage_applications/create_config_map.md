---

copyright:
  years: 2016, 2018
lastupdated: "2018-01-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating ConfigMaps

You can store configuration data in key-value pairs to apply to pods or system components, such as controllers.
{:shortdesc}

Configuration files, or ConfigMaps, contain configuration information that is decoupled from image content. By decoupling the configuration data, containerized applications are more portable.

For more information about ConfigMap files, see [https://kubernetes.io/docs/tasks/configure-pod-container/configmap/ ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/){: new_window}.

Two formats are available for you to create a configuration files from the {{site.data.keyword.gui}}.

You can create configuration files either by entering the parameter values in the Create ConfigMaps window or by pasting a YAML file into the "Create resource" window.

**Required user type or access level**: Cluster administrator or team administrator

## Creating configuration files by using the Create ConfigMaps window

1. From the navigation menu, click **Configuration** > **ConfigMaps**.
2. Click **Create ConfigMap**.
3. Provide a name for your ConfigMap and enter the configuration details in key-value pairs.
4. Click **Create**.

<!--You can include the configuration details in an application's JSON files. See [Deploying applications and jobs](create_apps.md).-->

## Creating configuration files by using the "Create resource" window

1. From the dashboard, click **Create resource**.
2. Paste a YAML or JSON file into the "Create resource" dialog box.
3. Click **Create**.
