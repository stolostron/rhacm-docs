---

copyright:
  years: 2016, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating CronJobs

Cron Jobs are used to manage time-based batch jobs. These jobs run once at a specified point in time or repeatedly at a specified point in time.
{:shortdesc}

For more information about Cron Jobs, see [CronJob ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/user-guide/cron-jobs){: new_window}.

Two formats are available for you to create an application from the {{site.data.keyword.gui}}.

You can create CronJobs either by entering the parameter values in the Create CronJob window or by pasting a YAML file into the "Create resource" window.

**Required user type or access level**: Cluster administrator or team administrator

## Creating a CronJob by using the Create CronJob window

Create a CronJob by following the tasks:

1. From the navigation menu, click **Workloads** > **Jobs**, and then click the **Cron Jobs** tab.
2. Click **Create CronJob**.
3. Provide the job details. Provide individual values in the Create CronJob window.

    * On the General tab, provide these values:
        * **Name**
        * **Schedule** - The deployment schedule in Cron format.
    * On the Container settings tab, provide these values:
        * **Name** - The container name.
        * **Image** - The image to use for the containers. If you use an image from the private image registry, you must provide the image name in the following format. `<cluster_CA_domain>` is the certificate authority (CA) domain that was set in the `config.yaml` file during installation. Your command might resemble the following:
        
          ```
          <cluster_CA_domain>:8500/namespace/imagename
          ```
          {: codeblock}

        * **Protocol** and **Port** - The communications protocol and port number for the container.

        **Note:** Values for other parameters are optional.

5. Attach PersistentVolume storage to the container. See [Attaching volume to an application](../manage_cluster/attach_volume_app.md).

6. Click **Create**.

## Creating a CronJob by using the "Create resource" window

1. From the dashboard, click **Create resource**.

2. Copy and paste a YAML or JSON file into the "Create resource" dialog box. For more information about creating a Kubernetes CronJob by using a YAML file, see [https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#creating-a-cron-job ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#creating-a-cron-job){: new_window}.

**Note:** If you want to use images from your private image registry that are in a different namespace, you must have access to that namespace and provide the **imagePullSecrets** value for that namespace in the YAML file. See [Creating imagePullSecrets for a specific namespace](../manage_images/imagepullsecret.md).

3. Click **Create**.
