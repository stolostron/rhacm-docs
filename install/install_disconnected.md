# Install on disconnected networks 

You might need to install Red Hat Advanced Cluster Management for Kubernetes on Red Hat OpenShift Clusters that are not connected to the Internet. The procedure to install on a disconnected hub requires some of the same steps as the connected installation. You must download copies of the packages in order to access them during the installation, rather than accessing them directly from the network during the installation.

## Prerequisites for a disconnected installation

You must meet the following requirements before you install Red Hat Advanced Cluster Management for Kubernetes: 

* Red Hat OpenShift Container Platform version 4.3, or later, must be deployed in your environment, and you must be logged into it with the command line interface (CLI). See the [OpenShift version 4.3 documentation](https://docs.openshift.com/container-platform/4.3/welcome/index.html) or [OpenShift version 4.4 documentation](https://docs.openshift.com/container-platform/4.4/welcome/index.html).

* A preconfigured StorageClass in Red Hat OpenShift Container Platform that can be used to create storage for Red Hat Advanced Cluster Management for Kubernetes.

* Your Red Hat OpenShift Container Platform CLI must be version 4.3, or later, and configured to run `oc` commands. See [Getting started with the CLI](https://docs.openshift.com/container-platform/4.3/cli_reference/openshift_cli/getting-started-cli.html) for information about installing and configuring the Red Hat OpenShift CLI.

* Your Red Hat OpenShift Container Platform permissions must allow you to create a namespace. 

* You must have a workstation with Internet connection to download the dependencies for the operator.

* Your Red Hat OpenShift Container Platform must have access to the Red Hat Advanced Cluster Management operator in the OperatorHub catalog. 

## Installing Red Hat Advanced Cluster Management for Kubernetes in a disconnected environment

Follow these steps to install Advanced Cluster Management for Kubernetes in a disconnected environment:

1. Create a mirror registry, if necessary.

   If you do not already have a mirror registry, create one by completing the procedure in the [Creating a mirror registry for installation in a restricted network](https://docs.openshift.com/container-platform/4.4/installing/install_config/installing-restricted-networks-preparations.html#installing-restricted-networks-preparations) topic of the Red Hat OpenShift Container Platform documentation.

   If you already have a mirror registry, you can configure and use your existing one. 

   **Note:** Red Hat Advanced Cluster Management for Kubernetes must deploy the Community Operator catalog, so the container image must support the Kubernetes V1 container specification. See [Container v1 core](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.11/#container-v1-core) in the Kubernetes documentation for more information about the V1 container specification.

2. Enable the disconnected Operator Lifecycle Manager (OLM) Red Hat Operators and Community Operators. 

   Advanced Cluster Management for Kubernetes is included in the OLM Red Hat Operator catalog, and has a dependency on the Community Operator catalog for the `etcd` operator.

   **Tip:** Make sure that your default storageClass is configured. See [Change the default storageClass](https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/) for more information about setting your default storageClass. 

3. Configure the disconnected OLM for the Red Hat Operator catalog and the Community Operator catalog. Follow the steps in the Using Operator Lifecycle Manager on restricted networks topic of the Red Hat OpenShift Container Platform documentation.

4. Now that you have the image in the disconnected OLM, continue to install Advanced Cluster Management for Kubernetes from the OLM catalog. See the steps in [Installing Red Hat Advanced Cluster Management for Kubernetes when connected](install_connected.md) for the required steps.

