# Install on disconnected networks 

**Important:** Technical preview only. Do not use in a production environment

You might need to install Red Hat Advanced Cluster Management for Kubernetes on Red Hat OpenShift Clusters that are not connected to the Internet. The procedure to install on a disconnected hub requires some of the same steps as the connected installation. The main difference is that you must download copies of the packages in order to access them during the installation, rather than accessing them directly from the network during the installation.

## Prerequisites

You must meet the following requirements before installing Red Hat Advanced Cluster Management for Kubernetes: 

* Red Hat OpenShift Container Platform version 4.3, or later, must be deployed in your environment, and you must be logged into it with the CLI. See the [OpenShift version 4.3 documentation](https://docs.openshift.com/container-platform/4.3/welcome/index.html) or [OpenShift version 4.4 documentation](https://docs.openshift.com/container-platform/4.4/welcome/index.html).

* A pre-configured StorageClass in Red Hat OpenShift Container Platform is available that can be used to create storage for Red Hat Advanced Cluster Management for Kubernetes.

* Your Red Hat OpenShift Container Platform CLI must be version 4.3, or later, and configured to run `oc` commands. See [Getting started with the CLI](https://docs.openshift.com/container-platform/4.3/cli_reference/openshift_cli/getting-started-cli.html) for information about installing and configuring the Red Hat OpenShift CLI.

* Your Red Hat OpenShift Container Platform permissions must allow you to create a namespace. 

* You must have a workstation with Internet connection to download the dependencies for the operator.

* Your Red Hat OpenShift Container Platform must have access to the Red Hat Advanced Cluster Management operator in the OperatorHub catalog. 

* You must have the `skopeo` tool to mirror the image.

## Installing Red Hat Advanced Cluster Management for Kubernetes in a disconnected environment

Follow these steps to install Advanced Cluster Management for Kubernetes in a disconnected environment:

1. Create a mirror registry, if necessary.

If you do not already have a mirror registry, create one by completing the procedure in the [Creating a mirror registry for installation in a restricted network](https://docs.openshift.com/container-platform/4.4/installing/install_config/installing-restricted-networks-preparations.html#installing-restricted-networks-preparations) topic of the Red Hat OpenShift Container Platform documentation.

<!--CD: If they do have one, is there a setup step here? Something to make it default, or similar?-->

2. Enable the disconnected Operator Lifecycle Manager (OLM) Red Hat Operators and Community Operators. 

Follow the steps in the [Using Operator Lifecycle Manager on restricted networks](https://docs.openshift.com/container-platform/4.4/operators/olm-restricted-networks.html) topic of the Red Hat OpenShift Container Platform documentation to configure disconnected OLM for the Red Hat Operator catalog and the Community Operator catalog.

3. Manually mirror the Advanced Cluster Management for Kubernetes images. This step installs Advanced Cluster Management for Kubernetes in a disconnected environment before Advanced Cluster Management for Kubernetes is added to the OLM catalog.

  1. Clone this GitHub repository: https://github.com/cdoan1/tech-preview.git

  ```
  git clone https://github.com/cdoan1/tech-preview.git
  ```

  2. Create a pull secret that provides access to your mirror registry and the `quay.io/acm-d` registry. Your pull secret should look similar to the following example, when your mirror registry location is `registry.example.com`:

  ```
  cat acmd-pull-secret.json
  {
  "auths": {
      "registry.example.com:5000": {
       "auth": "REDACTED"
      },
      "quay.io": {
       "auth": "REDACTED"
      },
      ...
  }
  ```
  
  3. Run the `mirror-image.py` python script to mirror the images into your registry. The script is in the root directory of the GitHub repository that you cloned in step 1.

  ```
  ./mirror-image.py -p acmd-pull-secret.json -m registry.example.com:5000
  ```
   
  4. Apply the generated `ImageContentSourcePolicy` manifest file.

  **Important:** Applying the `ImageContentSourcePolicy` updates and reboots all of the nodes in your cluster.

  ```
  oc apply -f 99-acm-images-icsp.yaml
  ```

4. Continue by completing the steps in [Installing Red Hat Advanced Cluster Management for Kubernetes when connected](install_connected.md) to install Advanced Cluster Management for Kubernetes, replacing the references to the network locations with references to your mirror registry.

