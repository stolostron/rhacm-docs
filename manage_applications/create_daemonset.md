---

copyright:
  years: 2016, 2019
lastupdated: "2019-05-01"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating DaemonSets

You can create a `DaemonSet` to allow each node in your cluster to run a copy of a pod.
{:shortdesc}

For more information about DaemonSets, see the [Kubernetes Concepts page ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/){: new_window}.

Two formats are available for you to create a DaemonSets from the {{site.data.keyword.gui}}.

You can create DaemonSets either by entering the parameter values in the Create DaemonSet window or by pasting a YAML file into the Create resource window.

**Required user type or access level**: Cluster administrator or team administrator

## Creating DaemonSets in the Create DaemonSet window

1. From the navigation menu, click **Workloads** > **DaemonSets**.
2. Click **Create DaemonSet**.
3. Provide the `DaemonSet` details. Provide individual values in the Create DaemonSet window.
    You must provide values for several parameters:

    * On the General tab, provide these values:
        * **Name** - A name for your `DaemonSet`      
    * On the Container settings tab, provide these values:
        * **Name** - A name for the container.
        * **Image** - The image to use for the container. If you use an image from the private image registry, you must provide the image name in the following format. `<cluster_CA_domain>` is the certificate authority (CA) domain that was set in the `config.yaml` file during installation.
          ```
          <cluster_CA_domain>:8500/namespace/imagename
          ```
          {: codeblock}

        * **Protocol** and **Container Port** - The communications protocol and port number for the container.

    **Note:** Values for other parameters are optional. If you do not specify resource limits for the CPU, memory, and GPU, the containers can use unlimited cluster resources.

4. Click **Create**.

## Creating DaemonSets in the Create resource window

1. From the dashboard, click **Create resource**.
2. Copy and paste a YAML file into the Create resource dialog box. For more information about creating a DaemonSet YAML file, see _Writing a DaemonSet Spec_ on the [Kubernetes Concepts page ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/#writing-a-daemonset-spec){: new_window}.
3. Click **Create**.
