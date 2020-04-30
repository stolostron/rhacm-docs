# Installing Red Hat Advanced Cluster Management for Kubernetes when connected

Red Hat Advanced Cluster Management for Kubernetes is installed using a main operator that deploys all of the required sub-operators such as etcd, multicloud subscription, Apache Hive, and so on.  

## Prerequisites

The following prerequisites must be met before installing Red Hat Advanced Cluster Management for Kubernetes: 

* Red Hat OpenShift Container Platform version 4.3 must be deployed in your environment, and you must be logged into it with the CLI. See the [OpenShift version 4.3 documentation](https://docs.openshift.com/container-platform/4.3/welcome/index.html).

* A pre-configured StorageClass in Red Hat OpenShift Container Platform is available that can be used to create storage for Red Hat Advanced Cluster Management for Kubernetes.

* Your Red Hat OpenShift Container Platform CLI must be version 4.3, or later, and configured to run `oc` commands. See [Getting started with the CLI](https://docs.openshift.com/container-platform/4.3/cli_reference/openshift_cli/getting-started-cli.html) for information about installing and configuring the Red Hat OpenShift CLI.

* You also need the Kubernetes CLI, `kubectl` version 1.13, or later. See [Install and Set Up kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-macos) for information.

* Your Red Hat OpenShift Container Platform permissions must allow you to create a namespace. 

* You must have an Internet connection to access the dependencies for the operator.

* Your Red Hat OpenShift Container Platform must have access to the Red Hat Advanced Cluster Management operator in the OperatorHub catalog. 

* You must have `jq` installed. If you do not have `jq` installed, and you are using macOS, enter `breq install jq` in a terminal window. 

* If you are using macOS, you must install `gsed`. If you do not already have `gsed` installed, you can install it by entering `brew install gnu-sed` in a terminal window.

* Optional: If you are using macOS and want to view the progress of your pods starting, you must install `watch`. If you do not already have `watch` installed, you can install it by entering `brew install watch` in a teminal window. You must have `watch` if you use the `--watch` option with your installation command.

## Installing Red Hat Advanced Cluster Management for Kubernetes by using the CLI

1. Create a namespace where the operator requirements are contained:

  ```
  oc create namespace <namespace>
  ```
  
  Replace <namespace> with a name for your namespace.
  **Remember:** The multiclusterhub operator must be intalled in its own namespace.
  
2. Switch your default namespace to the one that you created:

  ```
  oc project <namespace>
  ```  
  
  Replace <namespace> with the name of the namespace that you created in step 1.

3. Create a namespace called `hive` to contain the Hive components:

  ```
  oc create namespace hive  
  ```
  
4. Generate a pull secret called `quay-secret` to access the entitled content from the Quay.io repository. **Important:** pull secrets are namespace-specific, so make sure that you are in the namespace that you created in step 1.
  
  1. Create a pull secret by running the following command: 
  
  ```
  oc create secret docker-registry quay-secret --docker-server=quay.io --docker-username=<DOCKER_USERNAME> --docker-password=<DOCKER_PASSWORD>
  ```
  
  Replace <DOCKER_USERNAME> with your username for the Docker repository that you identified as the `docker-server`. 
  Replace <DOCKER_PASSWORD> with your password for the Docker repository that you identified as the `docker-server`.
  
  2. Visit [https://quay.io/user/*your_quay_id*?tab=settings](https://quay.io/user/*your_quay_id*?tab=settings).
  
  3. Select **Generate Encrypted Password**.
  
  4. Enter your Quay.io password.
  
  5. Select **Kubernetes Secret** from navigation menu.
  
  6. Select **Download *your_username*-secret.yaml**
  
  7. Save your downloaded secret file in the `local` directory as `quay-secret.yaml`. **Note:** If the secret is downloaded with an extension of `.yml`, change it to `.yaml` when you rename it. 
  
  8. Change the `name` value in the `local/quay-secret.yaml` file to `quay-secret`, as shown in the following example:
 
    ```
    ...
    kind: Secret
    metadata:
      name: quay-secret
    ...
    ```
	
5. Generate a pull secret called `multiclusterhub-operator-pull-secret` to access the entitled content from the Quay.io repository. **Important:** pull secrets are namespace-specific, so make sure that you are in the namespace that you created in step 1.
  
  1. Create a pull secret by running the following command: 
  
  ```
  oc create secret docker-registry multiclusterhub-operator-pull-secret --docker-server=quay.io --docker-username=<DOCKER_USERNAME> --docker-password=<DOCKER_PASSWORD>
  ```
  
  Replace <DOCKER_USERNAME> with your username for the Docker repository that you identified as the `docker-server`. 
  Replace <DOCKER_PASSWORD> with your password for the Docker repository that you identified as the `docker-server`.
  
  2. Visit [https://quay.io/user/*your_quay_id*?tab=settings](https://quay.io/user/*your_quay_id*?tab=settings).
  
  3. Select **Generate Encrypted Password**.
  
  4. Enter your Quay.io password.
  
  5. Select **Kubernetes Secret** from navigation menu.
  
  6. Select **Download *your_username*-secret.yaml**
  
  7. Save your downloaded secret file in the `local` directory as `multiclusterhub-operator-pull-secret.yaml`. **Note:** If the secret is downloaded with an extension of `.yml`, change it to `.yaml` when you rename it.
  
  8. Change the `name` value in the `local/multiclusterhub-operator-pull-secret.yaml` file to `multiclusterhub-operator-pull-secret`, as shown in the following example:
 
    ```
    ...
    kind: Secret
    metadata:
      name: multiclusterhub-operator-pull-secret
    ...
    ```

6. Create an operator group. Each namespace can have only one operator group.
 
  1. Create the file that defines the operator group by entering the following command:
  
    ```
	envsubst < .local/operator-group.yaml >> dev-og.yaml
	```
	
  2. Open the `dev-og.yaml` file and update the values to your values:
  
    ```
    apiVersion: operators.coreos.com/v1
    kind: OperatorGroup
    metadata:
      name: default
    spec:
      targetNamespaces:
      - <namespace>
    ```
  
    Replace <namespace> with the name of the namespace that you created in step 1. 
  
  3. Associate the operator group:
  
  ```
  oc apply -f local/dev-og.yaml
  ```


7. Apply the subscription.

  1. Create a new `dev-sub` file from the existing `subscription.yaml` file:
  
    ```
	envsubst < .local/subscription.yaml >> dev-sub.yaml
    ```
	
  2. Replace the `sourceNamespace` value in the `local/dev-sub.yaml` file with the namespace that you created, as shown in the following example:

    ```
    cat local/dev-sub.yaml
  	```
  
    Your subscription entry looks similar to the following example:

    ```
    apiVersion: operators.coreos.com/v1alpha1
      kind: Subscription
    metadata:
      name: multiclusterhub-operator-bundle
    spec:
      channel: alpha
      installPlanApproval: Automatic
      name: multiclusterhub-operator-bundle
      source: open-cluster-management
      sourceNamespace: <namespace>
      startingCSV: multiclusterhub-operator.v1.0.0	
	```
	
	Replace <namespace> with the name of the namespace that you created in step 1.
			
  3. Apply the subscription:

    ```
    oc apply -f local/dev-sub.yaml
    ```

8. Create the multiclusterhub operator instance by entering the following command:

  ```
  oc apply -f local/operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml
  ```
  **Note:** If step 8 fails with the following error, the resources are still being created and applied: 
  
  ```
  error: unable to recognize "operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml": no matches for kind "MultiCloudHub" in version "operators.multicloud.ibm.com/v1alpha1"
  ```
  
  Run the command again in a few minutes when the resources are created.
  
  **Tips:** 
    If you have `watch` installed, you can track the status of your pods by entering: `watch oc get pod`.
    You can access the logs for the operator by entering: `oc get logs`.	
  
## Installing Red Hat Advanced Cluster Management for Kubernetes by using the console

1. Create a namespace for the operator requirements:

  1. In the Red Hat OpensShift Container Platform console navigation, select **Administration** > **Namespaces**.
  
  2. Select **Create Namespace**.
  
  3. Provide a name for your namespace.  This is the namespace that you use throughout the installation process.
  
  4. Select **Create**.
  
2. Create a namespace for the Hive requirements.

  1. In the Red Hat OpensShift Container Platform console navigation, select **Administration** > **Namespaces**.
  
  2. Select **Create Namespace**.
  
  3. Enter `hive` as the name of your namespace. This is the namespace that contains the Hive requirements, but is not your main installation namespace. 
  
  4. Select **Create**.
  
3. Switch your default namespace to the one that you createsd in step 1. This ensures that the steps are completed in the correct namespace. Some are namespace-specific.

  1. In the Red Hat OpensShift Container Platform console navigation, select **Administration** > **Namespaces**.
  
  2. In the *Projects* field, select the namespace that you created in step 1 from the dropdown list. 
  
4. Create a Quay.io pull secret that provides the entitlement to the downloads.

  1. In the Red Hat OpensShift Container Platform console navigation, select **Workloads** > **Secrets**. 
  
  2. Select **Create**. 
  
  3. Enter `quay-secret` as the name of your secret.
  
  4. Select **Image Registry Credentials** as the authentication type.
  
  5. In the *Registry Server Address* field, enter the address of the Docker server that contains your image. In most cases, it is `quay.io`.
  
  6. Enter your username and password for the Docker server that contains the image. 
  
  7. Select **Create** to create the pull secret. 
  ???CD Is it automatically loaded, or do you have to copy it somewhere?
  
5. Subscribe to the operator.

  1. In the Red Hat OpensShift Container Platform console navigation, select **Operators** > **OperatorHub**.
  
  2. Select **Multiclusterhub Operator**.
  
  3. Select **Install**.
  
  4. Update the values, if necessary. 
  
  5. Select **Subscribe**.
  
6. Create the Multicluster hub instance.

  1. In the Red Hat OpensShift Container Platform console navigation, select **Installed Operators** > **Multicluster Hub Operator**. 
  
  2. Select **Create Multicluster Hub**. 
  
  3. Update the default values in the `.yaml` file, according to your needs. The following example shows some sample input:
  
    ```
	name:Multiclusterhub	
	namespace: <namespace>
	imagePullPolicy
	imagePullSecret: quay-secret
	imageReport
    ```
	
    Replace <namespace> with the name of the namespace that you created in step 1.
   
  4. Select **Create** to start the hub. It can take up to 10 minutes for the cluster to build and start.
   
     After the hub is created, the status for the operator is *Running* on the *OperatorHub* page.
	 
7. Access the console for the hub.

  1. In the Red Hat OpensShift Container Platform console navigation, select **Networking** > **Routes**.
  
  2. View the URL for your hub cluster in the list. 
  
