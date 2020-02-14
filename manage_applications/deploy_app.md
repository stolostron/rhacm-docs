---

copyright:
  years: 2016, 2019
lastupdated: "2019-05-31"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating a deployment

Create a new deployment in your namespace.
{:shortdesc}

New deployments are assigned to the namespace of the user that creates them. When administrators create deployments, they should assign them to the `default` namespace.

**Note:** You should not use `default` namespace in the production environment.

Two formats are available for you to create a deployment from the {{site.data.keyword.gui}}.

You can create deployments either by entering the parameter values in the Create Deployment window or by pasting a YAML file into the "Create resource" window.

**Required user type or access level**: Cluster administrator or team administrator

## Creating a deployment by using the Create Deployment window

1. From the navigation menu, click **Workloads** > **Deployments**.
2. Click **Create Deployment**.
3. Provide the deployment details. Provide individual values in the Create Deployment window.

    You must provide values for the following parameters:

    * On the General tab, provide these values:
        * **Name** - A name for your deployment
        * **Replicas** - The number of pods or replicas. The default value is 1.
    * On the Container settings tab, provide these values:
        * **Name** - A name for the container.
        * **Image** - The image to use for the container. If you use an image from the private image registry, you must provide the image name in the following format. `<cluster_CA_domain>` is the certificate authority (CA) domain that was set in the `config.yaml` file during installation. 
          ```
          <cluster_CA_domain>:8500/namespace/imagename
          ```
          {: codeblock}

        * **Protocol** and **Container Port** - The communications protocol and port number for the container.

    **Note:** Values for other parameters are optional. If you do not specify resource limits for the CPU, memory, and GPU, the containers can use unlimited cluster resources.

4. (Optional) Attach a `PersistentVolume` claim to the container. For more information, see [Attaching PersistentVolumeClaims to a deployment](../manage_cluster/attach_volume_app.md).

5. Click **Create**.

## Creating a deployment by using the Create resource window

  1. From the dashboard, click **Create resource**.
  2. Copy and paste a YAML or JSON file into the **Create resource** dialog box. For more information about creating a Kubernetes deployment by using a YAML file, see _Creating a Deployment_ on the [Kubernetes Concepts page ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#creating-a-deployment){: new_window}.
  
  If you want to use images from your private image registry that are in a different namespace, you must have access to that namespace and provide the `imagePullSecrets` value for that namespace in the YAML file. For more information, see [Creating imagePullSecrets for a specific namespace](../manage_images/imagepullsecret.md).

  3. Click **Create**.

After the deployment completes, a new deployment is displayed on the Deployments page. The **DESIRED**, **CURRENT**, **READY**, and **AVAILABLE** columns all display the same value, which is the number of pods or replica that you specified during the deployment.

Click the deployment name to view detailed information about the deployment. Review the deployment properties and ensure that they are accurate.

**Important**: To access your deployment from the Internet, you must expose your deployment as a service. For more information, see [Creating services](expose_app.md).
