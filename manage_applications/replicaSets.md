---

copyright:
  years: 2016, 2018
lastupdated: "2018-01-18"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Managing ReplicaSets

Use ReplicaSets to create and manage the number of pods in a deployment.
{:shortdesc}

ReplicaSets ensure that the correct number of pods are running at all times. Pods that are managed by ReplicaSets are automatically rescheduled when a failure occurs. These failures include node or network issues.

ReplicaSets replaces the Replication Controller as the pod manager. For more information about ReplicaSets, see [https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/ ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/){: new_window}.

To view a list of all ReplicaSets in the cluster, from the navigation menu, click **Workloads** > **ReplicaSets**. From this view, you can also filter ReplicaSets by their namespace.

**Required user type or access level**: Cluster administrator or team administrator

* [Creating ReplicaSets](#create)
* [Scaling a ReplicaSet](#scale)
* [Updating a ReplicaSet](#update)


## Creating ReplicaSets
{: #create}

1. From the navigation menu, click **Workloads** > **ReplicaSets**.
2. From the namespace drop-down menu, select a namespace. If a namespace is not selected, the ReplicaSet is created in the `default` namespace.
3. Click **Create ReplicaSet**.
4. Provide the details for your ReplicaSet.
You must provide values for several parameters:

* On the General tab, provide these values:
    * **Name** - A name for your ReplicaSet
    * **Replicas** - The number of pods or replicas. The default value is 3.
* On the Container settings tab, provide these values:
    * **Name** - A name for the container.
    * **Image** - The image to use for the container. If you use an image from the private image registry, you must provide the image name in the following format. `<cluster_CA_domain>` is the certificate authority (CA) domain that was set in the `config.yaml` file during installation.
      ```
      <cluster_CA_domain>:8500/namespace/imagename
      ```
      {: codeblock}

    * **Protocol** and **Container Port** - The communications protocol and port number for the container.
    **Note:** Values for other parameters are optional.
5. Click **Create**.

## Scaling a ReplicaSet
{: #scale}

1. From the navigation menu, click **Workloads** > **ReplicaSets**.
2. For the ReplicaSet that you want to scale, select **Action** > **Scale**.
3. Specify the number of pods or instances that you want.
4. Click **Scale ReplicaSet**.

## Updating a ReplicaSet
{: #update}

1. From the navigation menu, click **Workloads** > **ReplicaSets**.
2. For the ReplicaSet that you want to modify, select **Action** > **Edit**. The ReplicaSet's JSON file is displayed.
3. Update the properties.
4. Click **Submit**. The ReplicaSet updates.
