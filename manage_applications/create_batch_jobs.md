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

# Creating jobs

Create jobs to ensure that pods deploy or to run multiple pods in parallel.
{:shortdesc}

For more information about batch jobs, see [https://kubernetes.io/docs/user-guide/jobs ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/user-guide/jobs){: new_window}.

Two formats are available for you to create an application from the {{site.data.keyword.gui}}.

You can create jobs either by entering the parameter values in the Create Job window or by pasting a YAML file into the "Create resource" window.

**Required user type or access level**: Cluster administrator or team administrator

## Creating a job by using the Create Job window

1. From the navigation menu, click **Workloads** > **Jobs**.
2. Click **Create Job**.
3. Provide the job details. Provide individual values in the Create Job window.

    You must provide values for several parameters:

    * On the General tab, provide these values:
        * **Name**
    * On the Container settings tab, provide these values:
        * **Name** - The container name.
        * **Image** - The image to use for the containers. If you use an image from the private image registry, you must provide the image name in the following format. `<cluster_CA_domain>` is the certificate authority (CA) domain that was set in the `config.yaml` file during installation.
          ```
          <cluster_CA_domain>:8500/namespace/imagename
          ```
          {: codeblock}

        * **Protocol** and **Port** - The communications protocol and port number for the container.

    **Note:** Values for other parameters are optional.

4. (Optional) Attach PersistentVolume storage to the container. See [Attaching volume to an application](../manage_cluster/attach_volume_app.md).
5. Click **Create**.

## Creating a job by using the "Create resource" window

1. From the dashboard, click **Create resource**.
2. Copy and paste a YAML or JSON file into the "Create resource" dialog box. For more information about creating a Kubernetes batch job by using a YAML file, see [https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#running-an-example-job ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#running-an-example-job){: new_window}.
<p>**Note:** If you want to use images from your private image registry that are in a different namespace, you must have access to that namespace and provide the **imagePullSecrets** value for that namespace in the YAML file. See [Creating imagePullSecrets for a specific namespace](../manage_images/imagepullsecret.md).
</p>
3. Click **Create**.
