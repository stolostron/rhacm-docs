---

copyright:
<<<<<<< HEAD
  years: 2020
lastupdated: "2020-03-16"
=======
  years: 2019, 2020
lastupdated: "2020-03-13"
>>>>>>> doc_stage

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

<<<<<<< HEAD
# Preparing to install Red Hat Advanced Cluster Management for Kubernetes
=======
# Preparing to install the Red Hat Advanced Cluster Management for Kubernetes
>>>>>>> doc_stage

Before you install Red Hat Advanced Cluster Management for Kubernetes, review the following installation requirements.
{:shortdesc}

<<<<<<< HEAD
## Red Hat OpenShift

* You must have a supported OpenShift Container Platform version, including the registry and storage services, installed and working in your cluster. For more information about installing the OpenShift Container Platform, see the Red Hat OpenShift documentation. 

  * For OpenShift Container Platform version 4.3, see [OpenShift Container Platform 4.3 Documentation](https://docs.openshift.com/container-platform/4.3/welcome/index.html).
  * For OpenShift Container Platform version 4.2, see [OpenShift Container Platform 4.2 Documentation](https://docs.openshift.com/container-platform/4.2/welcome/index.html).
  * For OpenShift Container Platform version 3.11, see [OpenShift Container Platform 3.11 Documentation](https://docs.openshift.com/container-platform/3.11/welcome/index.html0.
  
* To ensure that the OpenShift cluster is set up correctly, access the OpenShift Container Platform web console.

=======
## OpenShift Container Platform

* You must have a supported OpenShift Container Platform version, including the registry and storage services, installed and working in your cluster.
* To ensure that the OpenShift Container Platform cluster is set up correctly, access the OpenShift Container Platform web console.

>>>>>>> doc_stage
  The OpenShift Container Platform web console can be found by running the `kubectl -n openshift-console get route` command. You can see a similar output to the following example:
    ```
    openshift-console          console             console-openshift-console.apps.new-coral.purple-chesterfield.com                       console                  https   reencrypt/Redirect     None
    ```
    {:codeblock}
<<<<<<< HEAD
    
	The console URL in this example is `https:// console-openshift-console.apps.new-coral.purple-chesterfield.com`. Open the URL in your browser and check the result. If the console URL is like `console-openshift-console.router.default.svc.cluster.local`, set `openshift_master_default_subdomain` when you install the OpenShift Container Platform. 
=======
    The console URL in this example is `https:// console-openshift-console.apps.new-coral.purple-chesterfield.com`. Open the URL in your browser and check the result. If the console URl is like `console-openshift-console.router.default.svc.cluster.local`, set `openshift_master_default_subdomain` when you install the OpenShift Container Platform. For more information, see [Configuring Your Inventory File for OpenShift Container Platform 3.11](https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html).

* For a metrics server, you must ensure that the OpenShift Container Platform metrics server has been installed before you install the Red Hat Advanced Cluster Management for Kubernetes. For more information about creating the OpenShift Container Platform metrics server, see [install the OpenShift Container Platform 3.11 metrics server](https://docs.openshift.com/container-platform/3.11/dev_guide/pod_autoscaling.html).

* {: #auth} If you are installing your cluster on a public cloud, you can enable authentication with Red Hat OpenShift. By default, your cluster uses OpenID Connect (OIDC) to authenticate users with Kubernetes. To enable authentication with OpenShift, add the authentication parameters to the `config.yaml` file. For more information, see [Authentication settings](../install/config_yaml.md#auth).
>>>>>>> doc_stage

### Admission webhooks

Ensure that the admission webhooks are enabled on the OpenShift Container Platform master node.
{: #admission_webhooks}

<<<<<<< HEAD
  * Option 1: Before you install Red Hat OpenShift Container Platform:

    To enable the `Admission and Validating Webhooks` on your OpenShift Container Platform installation, follow these steps:

    1. Add the following customization to the `openshift_master_admission_plugin_config ` variable in your OpenShift `hosts` file before installing OpenShift Container Platform. For more information, see [Configuring Cluster Variables](https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html#configuring-cluster-variables).
=======
  * Option 1: Before you install OpenShift Container Platform:

    To enable the `Admission and Validating Webhooks` on your OpenShift Container Platform installation, follow these steps:

    1. Add the following customization to the `openshift_master_admission_plugin_config ` variable in your openshift `hosts` file before installing OpenShift Container Platform. For more information, see the [Configuring Cluster Variables](https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html#configuring-cluster-variables){:new_window}.
>>>>>>> doc_stage
       ```
       openshift_master_admission_plugin_config={"MutatingAdmissionWebhook":{"configuration": {"apiVersion": "apiserver.config.k8s.io/v1alpha1","kubeConfigFile": "/dev/null","kind": "WebhookAdmission"}},"ValidatingAdmissionWebhook": {"configuration": {"apiVersion": "apiserver.config.k8s.io/v1alpha1","kubeConfigFile": "/dev/null","kind": "WebhookAdmission"}},"BuildDefaults": {"configuration": {"apiVersion": "v1","env": [],"kind": "BuildDefaultsConfig","resources": {"limits": {},"requests": {}}}},"BuildOverrides": {"configuration": {"apiVersion": "v1","kind": "BuildOverridesConfig"}},"openshift.io/ImagePolicy": {"configuration": {"apiVersion": "v1","executionRules": [{"matchImageAnnotations": [{"key": "images.openshift.io/deny-execution","value": "true"}],"name": "execution-denied","onResources": [{"resource": "pods"},{"resource": "builds"}],"reject": true,"skipOnResolutionFailure": true}],"kind": "ImagePolicyConfig"}}}
       ```
       {: codeblock}

        **Note**: The default configuration that gets created during installation as well as any custom configuration (MutatingAdmissionWebhook and ValidatingAdmissionWebhook) are added to this variable. The variable requires that any default configuration be present since the variable completely overrides the resulting value.

    2. Run the OpenShift Container Platform installer to install.

       During the OpenShift Container Platform installation, the file `/etc/origin/master/master-config.yaml` is created on your master node. The additional configurations in the file for the variable `openshift_master_admission_plugin_config` can look like the following example:
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
  * Option 2: After you install OpenShift Container Platform:
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

<<<<<<< HEAD
Ensure that you have a pre-configured StorageClass in OpenShift Container Platform that can be used for creating storage for Advanced Cluster Management for Kubernetes.
=======
Ensure that you have a pre-configured StorageClass in OpenShift Container Platform that can be used for creating storage for Red Hat Advanced Cluster Management for Kubernetes.
>>>>>>> doc_stage

## Networking

* The port number 8445 is required to be open on every node in the OS environment for the node exporter in the monitoring service. This port is configurable and 8445 is the default value.
<<<<<<< HEAD
* If OpenShift Container Platform master nodes are used for Advanced Cluster Management for Kubernetes master nodes, you must have different ports for the nginx ingress controller if you deploy nginx ingress to the OpenShift Container Platform master node. Ports 80 and 443 are used by OpenShift Container Platform services. Ports for the nginx ingress controller can be set in the `config.yaml` file.
=======
* If OpenShift Container Platform master nodes are used for Red Hat Advanced Cluster Management for Kubernetes master nodes, you must have different ports for the nginx ingress controller if you deploy nginx ingress to the OpenShift Container Platform master node. Ports 80 and 443 are used by OpenShift Container Platform services. Ports for the nginx ingress controller can be set in the `config.yaml` file.
>>>>>>> doc_stage
For example:
  ```
  ingress_http_port: 3080
  ingress_https_port: 3443
  ```
  {: codeblock}
<<<<<<< HEAD
=======

## Image registry
<!--I believe this section should be removed-->
Expose the OpenShift Container Platform image registry with a route. Taking the OpenShift Container Platform as an example, you can use the following command to expose the `docker-registry` service:
  ```
  oc -n default create route --service=docker-registry --hostname=<your-image-registry-hostname> reencrypt
  ```
  {: codeblock}

If the Docker registry has multiple pods, add the annotation `haproxy.router.openshift.io/balance: source` into the route:
  ```
  oc -n default annotate route/docker-registry haproxy.router.openshift.io/balance=source
  ```
  {: codeblock}

For more information about creating an OpenShift Container Platform image registry route, see [OpenShift 3.11 route documentation](https://docs.openshift.com/container-platform/3.11/architecture/networking/routes.html).

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
>>>>>>> doc_stage
