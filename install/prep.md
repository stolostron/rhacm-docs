---

copyright:
  years: 2020
lastupdated: "2020-03-25"

---

# Preparing to install Red Hat Advanced Cluster Management for Kubernetes

Before you install Red Hat Advanced Cluster Management for Kubernetes, review the following installation requirements.

## Red Hat OpenShift Container Platform

* You must have a supported Red Hat OpenShift Container Platform version, including the registry and storage services, installed and working in your cluster. For more information about installing the Red Hat OpenShift Container Platform, see the Red Hat OpenShift documentation. 

  * For Red Hat OpenShift Container Platform version 4.3, see [Red Hat OpenShift Container Platform 4.3 Documentation](https://docs.openshift.com/container-platform/4.3/welcome/index.html).
  * For Red Hat OpenShift Container Platform version 4.2, see [Red Hat OpenShift Container Platform 4.2 Documentation](https://docs.openshift.com/container-platform/4.2/welcome/index.html).
  * For Red Hat OpenShift Container Platform version 3.11, see [Red Hat OpenShift Container Platform 3.11 Documentation](https://docs.openshift.com/container-platform/3.11/welcome/index.html0.
  
* To ensure that the Red Hat OpenShift Container Platform cluster is set up correctly, access the Red Hat OpenShift Container Platform web console.

  Run the `kubectl -n openshift-console get route` command to access the Red Hat OpenShift Container Platform web console. See the following example output:
  
    ```
    openshift-console          console             console-openshift-console.apps.new-coral.purple-chesterfield.com                       console                  https   reencrypt/Redirect     None
    ```

	The console URL in this example is `https:// console-openshift-console.apps.new-coral.purple-chesterfield.com`. Open the URL in your browser and check the result. If the console URL displays `console-openshift-console.router.default.svc.cluster.local`, set `openshift_master_default_subdomain` when you install the Red Hat OpenShift Container Platform. 

* For a metrics server, you must ensure that the Red Hat OpenShift Container Platform metrics server is installed before you install the Red Hat Advanced Cluster Management for Kubernetes. For more information about creating the Red Hat OpenShift Container Platform metrics server, see [install the OpenShift Container Platform 3.11 metrics server](https://docs.openshift.com/container-platform/3.11/dev_guide/pod_autoscaling.html).

* {: #auth} If you are installing your cluster on a public cloud, you can enable authentication with Red Hat OpenShift Container Platform. By default, your cluster uses OpenID Connect (OIDC) to authenticate users with Kubernetes. To enable authentication with Red Hat OpenShift Container Platform, add the authentication parameters to the `config.yaml` file. For more information, see [Authentication settings](../install/config_yaml.md#auth).

### Admission webhooks

Ensure that the admission webhooks are enabled on the Red Hat OpenShift Container Platform master node.
{: #admission_webhooks}

  * Option 1: Before you install Red Hat OpenShift Container Platform:

    To enable the `Admission and Validating Webhooks` on your Red Hat OpenShift Container Platform installation, follow these steps:

    1. Add the following customization to the `openshift_master_admission_plugin_config ` variable in your Red Hat OpenShift Container Platform `hosts` file before installing Red Hat OpenShift Container Platform. For more information, see [Configuring Cluster Variables](https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html#configuring-cluster-variables).

       ```
       openshift_master_admission_plugin_config={"MutatingAdmissionWebhook":{"configuration": {"apiVersion": "apiserver.config.k8s.io/v1alpha1","kubeConfigFile": "/dev/null","kind": "WebhookAdmission"}},"ValidatingAdmissionWebhook": {"configuration": {"apiVersion": "apiserver.config.k8s.io/v1alpha1","kubeConfigFile": "/dev/null","kind": "WebhookAdmission"}},"BuildDefaults": {"configuration": {"apiVersion": "v1","env": [],"kind": "BuildDefaultsConfig","resources": {"limits": {},"requests": {}}}},"BuildOverrides": {"configuration": {"apiVersion": "v1","kind": "BuildOverridesConfig"}},"openshift.io/ImagePolicy": {"configuration": {"apiVersion": "v1","executionRules": [{"matchImageAnnotations": [{"key": "images.openshift.io/deny-execution","value": "true"}],"name": "execution-denied","onResources": [{"resource": "pods"},{"resource": "builds"}],"reject": true,"skipOnResolutionFailure": true}],"kind": "ImagePolicyConfig"}}}
       ```

        **Note**: The default configuration that gets created during installation as well as any custom configuration (MutatingAdmissionWebhook and ValidatingAdmissionWebhook) are added to this variable. The variable requires that any default configuration be present since the variable completely overrides the resulting value.

    2. Run the Red Hat OpenShift Container Platform installer to install.

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
  
  * Option 2: After you install Red Hat OpenShift Container Platform:
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

## Storage

Ensure that you have a pre-configured StorageClass in Red Hat OpenShift Container Platform that can be used for creating storage for Red Hat Advanced Cluster Management for Kubernetes.

## Networking

* The port number 8445 is required to be open on every node in the OS environment for the node exporter in the monitoring service. This port is configurable and 8445 is the default value.
* If Red Hat OpenShift Container Platform master nodes are used for Advanced Cluster Management for Kubernetes master nodes, you must have different ports for the nginx ingress controller if you deploy nginx ingress to the Red Hat OpenShift Container Platform master node. Ports 80 and 443 are used by Red Hat OpenShift Container Platform services. Ports for the nginx ingress controller can be set in the `config.yaml` file.

For example:
  ```
  ingress_http_port: 3080
  ingress_https_port: 3443
  ```

