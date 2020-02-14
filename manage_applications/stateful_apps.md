---

copyright:
  years: 2016, 2018
lastupdated: "2018-09-27"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}


# Creating StatefulSets

Create pods with assured network and storage identity.
{:shortdesc}

Normal pod deployments are designed with a weak notion of identity and are handled as stateless units. If a pod is unhealthy or is superseded by a newer version, the system removes the older or unhealthy pod. With the introduction of stateful applications, also known as StatefulSets, you can create applications that have a stronger notion of identity. These stateful applications are also able to provision storage on-demand in the cloud.

For more information about stateful applications or StatefulSets, see [https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/ ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){: new_window}.

Two formats are available for you to create a StatefulSet from the {{site.data.keyword.gui}}.

You can create stateful applications either by entering the parameter values in the Create StatefulSet window or by pasting a YAML file into the "Create resource" window.

**Required user type or access level**: Cluster administrator or team administrator

## Creating StatefulSets by using the Create StatefulSet window

1. From the navigation menu, click **Workloads** > **StatefulSets**.
2. Click **Create StatefulSet**.
3. Provide the application details.

    You must provide values for several parameters:

    * On the General tab, provide these values:
        * **Name** - A name for your StatefulSet.
        * **Service name** - The service that defines access to the pods.
        * **Replicas** - The number of pods or replicas. The default value is 1.
    * On the Container settings tab, provide these values:
        * **Name** - The container name.
        * **Image** - The image to use for the containers. If you use an image from the private image registry, you must provide the image name in the following format. `<cluster_CA_domain>` is the certificate authority (CA) domain that was set in the `config.yaml` file during installation.
          ```
          <cluster_CA_domain>:8500/namespace/imagename
          ```
          {: codeblock}

        * **Protocol** and **Container Port** - The communications protocol and port number for the container.


    **Note:** Values for other parameters are optional. If you do not specify resource limits for the CPU, memory, and GPU, the containers can use unlimited cluster resources.

4. (Optional) Attach PersistentVolume storage to the container. See [Attaching volume to an application](../manage_cluster/attach_volume_app.md).
5. Click **Create**.

## Creating StatefulSets by using the "Create resource" window

1. From the dashboard, click **Create resource**.
2. Copy and paste a YAML or JSON file into the "Create resource" dialog box. For more information about creating a StatefulSet by using a YAML file, see [https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/#creating-a-statefulset ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/#creating-a-statefulset){: new_window}.
<p>**Note:** If you want to use images from your private image registry that are in a different namespace, you must have access to that namespace and provide the **imagePullSecrets** value for that namespace in the YAML file. See [Creating imagePullSecrets for a specific namespace](../manage_images/imagepullsecret.md).
</p>
3. Click **Create**.
