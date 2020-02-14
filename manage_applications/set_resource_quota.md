---

copyright:
  years: 2016, 2019
lastupdated: "2019-04-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Setting resource quota

Set resource quota to limit the sum of compute and storage resources that can be requested by an application. Resource quotas can also be used to limit the number of objects of a specified type that is available in a single namespace.
{:shortdesc}

For more information about setting resource quota, see _Resource Quotas_ on the [Kubernetes concepts page ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/admin/resourcequota){: new_window}.

To view a list of quotas, from the navigation menu, click **Manage** > **Quotas**.

**Required user type or access level**: Cluster administrator or team administrator

## Creating a quota by using the Create ResourceQuota window

1. From the navigation menu, click **Manage** > **Quotas**.
2. Click **Create ResourceQuota**.
3. Enter the resource quota details. <!--Resource quotas are entered as key-value pairs.-->
4. Click **Create**.

## Creating a quota by using the "Create resource" window

1. From the dashboard, click **Create resource**.
2. Copy and paste a YAML or JSON file into the "Create resource" dialog box. For more information about creating a quota by using a YAML file, see [https://kubernetes.io/docs/concepts/policy/resource-quotas/#viewing-and-setting-quotas ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/policy/resource-quotas/#viewing-and-setting-quotas){: new_window}.

  When creating a quota from the "Create resource" window, remember to specify the namespace in the `metadata` section.

  For GPU resource quotas, you can set resource requests for specific namespaces by running the `requests.nvidia.com/gpu` parameter.

  The following sample code sets a GPU request quota of 2 GPUs for the `myspace` namespace.

  ```
  apiVersion: v1
  kind: ResourceQuota
  metadata:
    name: compute-resources
    namespace: myspace
  spec:
    hard:
      requests.cpu: "1"
      requests.memory: 1Gi
      limits.cpu: "2"
      limits.memory: 2Gi
      requests.nvidia.com/gpu: "2"
  ```
  {: codeblock}  

**Note:** Due to Kubernetes limitation, you must set `requests.nvidia.com/gpu` to allow the GPU quota to set resource requests. 

3. Click **Create**.

After the deployment completes, a new quota is displayed on the Quotas page.
