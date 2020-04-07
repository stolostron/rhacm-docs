# Installing Red Hat Advanced Cluster Management for Kubernetes when connected

Red Hat Advanced Cluster Management for Kubernetes is installed using a main operator that deploys all of the required sub-operators such as etcd, multicloud subscription, Apache Hive, and so on. 

There are two methods that you can use to install, both require the same prerequisites and preparations. 

  - Method 1 is an easier method, which leverages a `start.sh` installer script to automate the installation to get running quickly. 

  - Method 2 is more customizable if you want to use commands to complete each required step, but is not as easy as Method 1.   

- [Prerequisites](#prerequisites)
- [Preparing to install](#preparing-to-install)
- [Method 1: Installing by using the `start.sh` script](#method-1-installing-by-using-the-startsh-script)
- [Method 2: Installing by using commands](#method-2-installing-by-using-commands)

## Prerequisites

See the following prerequisites before installing Red Hat Advanced Cluster Management for Kubernetes: 

* Red Hat OpenShift Container Platform version 4.3 or 4.4 must be deployed in your environment, and you must be logged into it with the CLI. See the [OpenShift version 4.3 documentation](https://docs.openshift.com/container-platform/4.3/welcome/index.html) or the [OpenShift version 4.4 documentation](https://docs.openshift.com/container-platform/4.4/welcome/index.html).

* A pre-configured StorageClass in Red Hat OpenShift Container Platform that can be used to create storage for Red Hat Advanced Cluster Management for Kubernetes.

* Your Red Hat OpenShift Container Platform CLI must be version 4.3, or later, and configured to run `oc` commands. See [Getting started with the CLI](https://docs.openshift.com/container-platform/4.3/cli_reference/openshift_cli/getting-started-cli.html) for information about installing and configuring the Red Hat OpenShift CLI.

* You also need the Kubernetes CLI, `kubectl` version 1.6, or later. See [Overview of kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) for information about `kubectl`.

* Your Red Hat OpenShift Container Platform permissions must allow you to create a namespace. 

* You must have an Internet connection to access the dependencies for the operator.

* If you are using macOS, you must install `gsed`. If you do not already have `gsed` installed, you can install it by entering `brew install gnu-sed` in a terminal window.

## Preparing to install

Complete the following preparations before you complete either of the installation procedures. **Note:** Only run the steps in this section once.

1. Download the required files by cloning the `open-cluster-management/deploy` Git repository with the following command:

  ```
  git clone https://github.com/open-cluster-management/deploy.git
  ```

  Cloning the repository provides the required files for installing Red Hat Advanced Cluster Management for Kubernetes. The repository contains three directories:

  * `prereqs`: Contains `.yaml` definitions that define the required objects, such as namespaces and pull-secrets. 
  
  * `multiclusterhub-operator`: Contains `.yaml` definitions for setting up a `CatalogSource` for the operator.
  
  * `multiclusterhub`: Contains `yaml` definitions for creating an instance of `MultiClusterHub`.
  
  Each directory contains a `kustomization.yaml` file with settings that you can update to create your environment. If you update the files, you can apply the changes by entering the `kubectl apply -k` command.
  
2. Change to the `deploy` directory that you just cloned.
  
3. Generate a pull-secret.

    1. Ensure you have access to the Red Hat Quay.io organization by signing in to [open-cluster-management](https://quay.io/repository/open-cluster-management/multiclusterhub-operator-index?tab=tags).
  
      If you do not have access to the `open-cluster-management` organization in Quay.io, you can request access on the internal `#forum-acm` Slack channel.

    2. Visit the following link, but replace `<your_username>` with your Quay.io username: https://quay.io/user/<your_username>?tab=settings.
  
    3. Select **Generate Encrypted Password**.
  
    4. Enter your Quay.io password.
  
    5. Select **Kubernetes Secret** from the navigation menu.
    
    6. Select **Download <your_username>-secret.yml** with your Quay username in place of `<your_username>`.
  
    7. Save your secret file in the `prereqs` directory of the cloned Git repository with the name of `pull-secret.yaml`. **Notice:** If the pull secret file has a *.yml* extension when you download it, update it to *.yaml* when you rename it.
  
    8. Edit the contents of the `pull-secret.yaml` file and replace the name of the `Secret metadata: name` entry with `multiclusterhub-operator-pull-secret`, as shown in the following example:
  
    ```
    apiVersion: v1
    kind: Secret
    metadata:
      name: multiclusterhub-operator-pull-secret
    ...
    ```
    
4. Select either [Method 1](#method-1-installing-by-using-the-startsh-script) or [Method 2](#method-2-installing-by-using-commands) to continue installing Red Hat Advanced Cluster Management for Kubernetes.

## Method 1: Installing by using the `start.sh` script
{: #script}

You can install Red Hat Advanced Cluster Management for Kubernetes by making some updates to a script file and deploying the cluster. This is the easiest way to get started, but the other method is provided if you prefer to use `oc` commands to install. 

1. Run the `start.sh` script that is in the cloned `open-cluster-management/deploy` repository. The following options are available to use when you run the script, but you cannot use multiple options with a single command:

  * `-t`: Modifies the `.yaml`, but exits before applying the resources. You can verify or update the settings in the `.yaml` file before you apply them.  

  * `--silent`: Skips all prompting and uses the settings from the previous configuration.

  * `--watch`: Monitors the main Red Hat Advanced Cluster Management for Kubernetes pod deployments for up to 10 minutes to ensure that they start correctly. 
  
  The command format should be similar to the following example: 
  
  ```
  ./start.sh --watch
  ```
 
2. Provide the SNAPSHOT tag. You can either press `Enter` to use the tag that was used on the previous installation, or provide a new tag. You can find a list of available tags in the [Quay.io multiclusterhub-operator-index](https://quay.io/open-cluster-management/multiclusterhub-operator-index). 
  **Tip:** You can change the default SNAPSHOT value in the `start.sh` script by editing the value for `snapshot.ver` to the new version. Updating the default SNAPSHOT value in the script is useful when using the `--silent` option.
  
  The following text shows the format of the snapshot:

  ```
  SNAPSHOT-2020-03-31-02-16-43
  ```
  **Remember:** If you enter a snapshot value, the value that you enter overwrites the existing default value and is stored as the default value for future installation attempts. The last snapshot value that was entered is the default value.

3. Enter the `watch oc -n open-cluster-management get pods` command to view the progress of the deployment of the `OCM`. Depending on the option that you used when you ran the script, `OCM` is either deployed or deploying. 

4. When the deployment is complete, visit the `Open Cluster Management` URL that is provided in the `start.sh` script file.

  **Note:** You can run this script multiple times, and it attempts to continue where it left off. If you have a failure and have installed multiple times, run the `uninstall.sh` script to clean up the directories before you run the installation again.
  
5. Follow the link that is included at the end of the installation output to your installed cluster. 

## Method 2: Installing by using commands

1. Create the required objects by applying the `.yaml` definitions that are contained in the `deploy/prereqs` directory: 

  ```
  kubectl apply --openapi-patch=true -k prereqs/
  ```

2. Update the `kustomization.yaml` file that is in the `multiclusterhub-operator` directory so the `newTag` setting contains the tag for your snapshot. You can find a snapshot tag by viewing the list of tags available in the [Quay.io index](https://quay.io/open-cluster-management/multiclusterhub-operator-index). You must use a tag that has the word SNAPSHOT in it, as shown in the following example:

  ```
  namespace: open-cluster-management

  images: # updates operator.yaml with the dev image
    - name: multiclusterhub-operator-index
      newName: quay.io/open-cluster-management/multiclusterhub-operator-index
      newTag: "SNAPSHOT-2020-03-31-02-16-43"
  ```

3. Create the multiclusterhub-operator objects by applying the `.yaml` definitions in the `deploy/multiclusterhub-operator` directory. Enter the following command:

  ```
  kubectl apply -k multiclusterhub-operator/
  ```

4. Run the following command to determine whether the subscription is healthy:

  ```
  oc get subscription multiclusterhub-operator-bundle --namespace open-cluster-management -o yaml
  ```

  A healthy subscription returns a `true` status value for the `healthy` entry, as shown in the following example: 
  
  ```
  ...
  status:
    catalogHealth:
    - catalogSourceRef:
        apiVersion: operators.coreos.com/v1alpha1
        kind: CatalogSource
        name: open-cluster-management
        namespace: open-cluster-management
        resourceVersion: "1123089"
        uid: f6da232b-e7c1-4fc6-958a-6fb1777e728c
      healthy: true
      ...
  ```

  Continue with the next step when your subscription is healthy.
  
5. Edit the `example-multiclusterhub-cr.yaml` file in the `mulitclusterhub` directory. Set the `imageTagSuffix` to the snapshot value that you used in the `kustomization.yaml` file in the `multiclusterhub-operator` directory in step 2. Remove the `VERSION 1.0.0-,` from the `newTag` value taken from the `kustomization.yaml` file.

  The output should look similar to the following example:

  ```
  apiVersion: operators.open-cluster-management.io/v1alpha1
  kind: MultiClusterHub
  metadata:
    name: example-multiclusterhub
    namespace: open-cluster-management
  spec:
    version: latest
    imageRepository: "quay.io/open-cluster-management"
    imageTagSuffix: "SNAPSHOT-2020-03-31-02-16-43"
    imagePullPolicy: Always
    imagePullSecret: multiclusterhub-operator-pull-secret
    foundation:
      apiserver:
        configuration:
          http2-max-streams-per-connection: "1000"
        replicas: 1
        apiserverSecret: "mcm-apiserver-self-signed-secrets"
        klusterletSecret: "mcm-klusterlet-self-signed-secrets"
      controller:
        configuration:
          enable-rbac: "true"
          enable-service-registry: "true"
        replicas: 1
    mongo:
      endpoints: mongo-0.mongo.open-cluster-management
      replicaSet: rs0
    hive:
      additionalCertificateAuthorities:
        - name: letsencrypt-ca
      managedDomains:
        - s1.openshiftapps.com
      globalPullSecret:
        name: private-secret
      failedProvisionConfig:
        skipGatherLogs: true
  ```

6. Create the `example-multiclusterhub` objects by applying the `.yaml` definitions that are contained in the `deploy/multiclusterhub` directory:

  ```
  kubectl apply -k multiclusterhub/
  ```

7. Verify that your installation is successful and access your URL by running the following command, where `namespace-from-install` is the namespace where you installed the product:	
  
  ```	
  oc get routes -n <namespace-from-install>	
  ```
  
  See the following example command:	

  ```	
  oc get routes -n <open-cluster-management>	
  ```
  
8. Find the `multicloud-console` name and the `Host/Port` columns to get your URL. See the following example:	

  ```	
  https://multicloud-console.apps.<HOST/PORT>	
  ``` 
