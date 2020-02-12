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

# Preparing to install the {{site.data.keyword.cloud_pak_mcm}}

Before you install {{site.data.keyword.cloud_pak_mcm}}, review the following installation requirements.
{:shortdesc}

## {{site.data.keyword.ocp_tm}}

* You must have a supported {{site.data.keyword.ocp}} version, including the registry and storage services, installed and working in your cluster.
* To ensure that the {{site.data.keyword.ocp}} cluster is set up correctly, access the {{site.data.keyword.ocp}} web console.

  The {{site.data.keyword.ocp}} web console can be found by running the `kubectl -n openshift-console get route` command. You can see a similar output to the following example:
    ```
    openshift-console          console             console-openshift-console.apps.new-coral.purple-chesterfield.com                       console                  https   reencrypt/Redirect     None
    ```
    {:codeblock}
    The console URL in this example is `https:// console-openshift-console.apps.new-coral.purple-chesterfield.com`. Open the URL in your browser and check the result. If the console URl is like `console-openshift-console.router.default.svc.cluster.local`, set `openshift_master_default_subdomain` when you install the {{site.data.keyword.ocp}}. For more information, see [Configuring Your Inventory File for OpenShift Container Platform 3.11 ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html).
* For an {{site.data.keyword.ocp_ibmcloud}} cluster, you must have a supported {{site.data.keyword.ocp}} version installed by using {{site.data.keyword.iks}} so that the managed {{site.data.keyword.ocp}} service is supported. For more information, see [Tutorial: Creating an IBM Cloud Red Hat OpenShift Container Platform Cluster ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/containers?topic=containers-openshift_tutorial).

* For a metrics server, you must ensure that the {{site.data.keyword.ocp}} metrics server has been installed before you install the {{site.data.keyword.cloud_pak_mcm}}. For more information about creating the {{site.data.keyword.ocp}} metrics server, see [install the OpenShift Container Platform 3.11 metrics server ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/3.11/dev_guide/pod_autoscaling.html).

* {: #auth} If you are installing your cluster on a public cloud, such as {{site.data.keyword.iks_ocp}}, you can enable authentication with Red Hat OpenShift. By default, your cluster uses OpenID Connect (OIDC) to authenticate users with Kubernetes. To enable authentication with OpenShift, add the authentication parameters to the `config.yaml` file. For more information, see [Authentication settings](../installer/3.2.2/config_yaml.md#auth).

### Admission webhooks

Ensure that the admission webhooks are enabled on the {{site.data.keyword.ocp}} master node.
{: #admission_webhooks}

  * Option 1: Before you install {{site.data.keyword.ocp}}:

    To enable the `Admission and Validating Webhooks` on your {{site.data.keyword.ocp}} installation, follow these steps:

    1. Add the following customization to the `openshift_master_admission_plugin_config ` variable in your openshift `hosts` file before installing {{site.data.keyword.ocp}}. For more information, see the [Configuring Cluster Variables ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html#configuring-cluster-variables).
       ```
       openshift_master_admission_plugin_config={"MutatingAdmissionWebhook":{"configuration": {"apiVersion": "apiserver.config.k8s.io/v1alpha1","kubeConfigFile": "/dev/null","kind": "WebhookAdmission"}},"ValidatingAdmissionWebhook": {"configuration": {"apiVersion": "apiserver.config.k8s.io/v1alpha1","kubeConfigFile": "/dev/null","kind": "WebhookAdmission"}},"BuildDefaults": {"configuration": {"apiVersion": "v1","env": [],"kind": "BuildDefaultsConfig","resources": {"limits": {},"requests": {}}}},"BuildOverrides": {"configuration": {"apiVersion": "v1","kind": "BuildOverridesConfig"}},"openshift.io/ImagePolicy": {"configuration": {"apiVersion": "v1","executionRules": [{"matchImageAnnotations": [{"key": "images.openshift.io/deny-execution","value": "true"}],"name": "execution-denied","onResources": [{"resource": "pods"},{"resource": "builds"}],"reject": true,"skipOnResolutionFailure": true}],"kind": "ImagePolicyConfig"}}}
       ```
       {: codeblock}

        **Note**: The default configuration that gets created during installation as well as any custom configuration (MutatingAdmissionWebhook and ValidatingAdmissionWebhook) are added to this variable. The variable requires that any default configuration be present since the variable completely overrides the resulting value.

    2. Run the {{site.data.keyword.ocp}} installer to install.

       During the {{site.data.keyword.ocp}} installation, the file `/etc/origin/master/master-config.yaml` is created on your master node. The additional configurations in the file for the variable `openshift_master_admission_plugin_config` can look like the following example:
       ```
       admissionConfig:
         pluginConfig:
           MutatingAdmissionWebhook:
             configuration:
               apiVersion: apiserver.config.k8s.io/v1alpha1
               kubeConfigFile: /dev/null
               kind: WebhookAdmission
           ValidatingAdmissionWebhook:
             configuration:
               apiVersion: apiserver.config.k8s.io/v1alpha1
               kubeConfigFile: /dev/null
               kind: WebhookAdmission
       ```
       {: codeblock}
  * Option 2: After you install {{site.data.keyword.ocp}}:
    1. Add the following to your `/etc/origin/master/master-config.yaml` file on your master node:
        ```
        admissionConfig:
          pluginConfig:
            MutatingAdmissionWebhook:
              configuration:
                apiVersion: apiserver.config.k8s.io/v1alpha1
                kubeConfigFile: /dev/null
                kind: WebhookAdmission
            ValidatingAdmissionWebhook:
              configuration:
                apiVersion: apiserver.config.k8s.io/v1alpha1
                kubeConfigFile: /dev/null
                kind: WebhookAdmission
        ```
    2. Save your file.
    3. Restart your apiserver and controllers:
        ```
        /usr/local/bin/master-restart api
        /usr/local/bin/master-restart controllers
        ```
        {: codeblock}

## Storage

Ensure that you have a pre-configured StorageClass in {{site.data.keyword.ocp}} that can be used for creating storage for {{site.data.keyword.mcm_notm}}. For an {{site.data.keyword.ocp_ibmcloud}} cluster, `ibmc-file-gold` is always available.

## Networking

* The port number 8445 is required to be open on every node in the OS environment for the node exporter in the monitoring service. This port is configurable and 8445 is the default value.
* If {{site.data.keyword.ocp}} master nodes are used for {{site.data.keyword.mcm_notm}} master nodes, you must have different ports for the nginx ingress controller if you deploy nginx ingress to the {{site.data.keyword.ocp}} master node. Ports 80 and 443 are used by {{site.data.keyword.ocp}} services. Ports for the nginx ingress controller can be set in the `config.yaml` file.
For example:
  ```
  ingress_http_port: 3080
  ingress_https_port: 3443
  ```
  {: codeblock}

## Image registry

Expose the {{site.data.keyword.ocp}} image registry with a route. Taking the {{site.data.keyword.ocp}} on {{site.data.keyword.iks}} as an example, you can use the following command to expose the `docker-registry` service:
  ```
  oc -n default create route --service=docker-registry --hostname=<your-image-registry-hostname> reencrypt
  ```
  {: codeblock}

If the Docker registry has multiple pods, add the annotation `haproxy.router.openshift.io/balance: source` into the route:
  ```
  oc -n default annotate route/docker-registry haproxy.router.openshift.io/balance=source
  ```
  {: codeblock}

For more information about creating an {{site.data.keyword.ocp}} image registry route, see [OpenShift 3.11 route documentation ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/3.11/architecture/networking/routes.html).

## Elasticsearch

For Elasticsearch, ensure that the `vm.max_map_count` setting is at least `262144` on all nodes. Run the following command to check:
  ```
  sudo sysctl -a | grep vm.max_map_count
  ```
  {: codeblock}

  If the `vm.max_map_count` setting is not at least `262144`, run the following commands to set the value to `262144`:
  ```
  sudo sysctl -w vm.max_map_count=262144
  echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
  ```
   {: codeblock}
