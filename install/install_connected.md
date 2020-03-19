# Installing Red Hat Advanced Cluster Management for Kubernetes when connected

Red Hat Advanced Cluster Management for Kubernetes is installed using a main operator that deploys all of the required sub-operators such as etcd, multicloud subscription, Apache Hive, and so on.  

## Prerequisites

The following prerequisites must be met before installing Red Hat Advanced Cluster Management for Kubernetes: 

* Red Hat OpenShift Container Platform version 4.3 must be deployed in your environment. See the [OpenShift version 4.3 documentation](https://docs.openshift.com/container-platform/4.3/welcome/index.html) for the required steps for installing OpenShift Container Platform. 

* Your CLI must be configured to run `oc` commands.

* Your OpenShift Container Platform must have access to the Red Hat Advanced Cluster Management operator in the OperatorHub catalog. 

* You must have an Internet connection to access the dependencies for the operator.

## Installing Red Hat Advanced Cluster Management for Kubernetes

1. Create a namespace:

  ```
  oc create namespace $NAMESPACE
  ```

2. Switch to the new namespace: 

  ```
  oc project $NAMESPACE
  ```  

3. Create an Apache Hive namespace: 

  ```
  oc create namespace hive  
  ```
  
4. Generate a pull secret called `quay-secret` to access the entitled content on Quay.io:
  
  1. Create a pull secret by running the following command: 
  
    ```
    oc create secret docker-registry quay-secret --docker-server=$(SECRET_REGISTRY) --docker-username=$(DOCKER_USERNAME) --docker-password=$(DOCKER_PASSWORD)
    ```
  
    SECRET_REGISTRY should be the path to your Quay.io server. For example,  `quay.io/`.
    
  2. Visit [https://quay.io/user/*your_quay_id*?tab=settings](https://quay.io/user/quay_id?tab=settings).
  
    **Note:** Replace *quay_id* with the ID that you use to access Quay.io.
  
  3. Select **Generate Encrypted Password**.
  
  4. Enter your Quay.io password.
  
  5. Select **Kubernetes Secret** from navigation menu.
  
  6. Select **Download username-secret.yaml**
  
    **Note:** The *username* part of the filename is replaced with your Quay.io username.
  
  7. Save your downloaded secret file in the `local` directory as `quay-secret.yaml`. 
  
  8. Change the `name` value in the `local/quay-secret.yaml` file to `quay-secret`, as shown in the following example:
 
    ```bash
    ...
    kind: Secret
    metadata:
      name: quay-secret
    ...
    ```

5. Associate your secret to your installation process:

  ```
  oc apply -f local/quay-secret.yaml
  ```
  
13. Create an operator group. 
 
  1. Create a file in the `local` directory called `operator-group.yaml` with the following content:
  
  ```bash
  apiVersion: operators.coreos.com/v1
  kind: OperatorGroup
  metadata:
    name: default
  spec:
    targetNamespaces:
    - your_namespace
  ```

  Replace *your_namespace* with the namespace that you created in step 1.  
  
  2. Apply the operator group:
  
  ```
  oc apply -f local/operator-group.yaml
  ```
  
14. Prepare the resources that are required for multicloudhub.
   
  1. Copy the `subscription.yaml` file to the `local` directory. 
  
  ```
  cp build/_output/olm/subscription.yaml local/subscription.yaml
  ```
  
  2. Replace the values of `namespace` and `sourceNamespace` in the `local/subscription.yaml` file with the namespace that you created in step 1:

  ```
  ...
  metadata:
    name: multicloudhub-operator
    namespace: your_namespace
  spec:
    channel: alpha
    installPlanApproval: Automatic
    name: multicloudhub-operator
    source: multicloudhub-operator-registry
    sourceNamespace: your_namespace
  ...  
  ```
	
  3. Apply the subscription:
	
  ```
  oc apply -f local/subscription.yaml
  ```

  4. Copy the `operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml` file to the `local` directory. 
  
  ```
  cp build/_output/olm/operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml local/operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml
  ```
	
  5. Replace the values of `default` in the `local/operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml` file with the namespace that you created in step 1.
  
15. Create the operator instance by entering the following command: 

  ```
  oc apply -f local/operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml
  ```
  
  **Note:** If step 18 fails with the following error, the resources are still being created and applied:
  
  ```
  error: unable to recognize "operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml": no matches for kind "MultiCloudHub" in version "operators.multicloud.ibm.com/v1alpha1"
  ```
  
  Run the command again in a few minutes when the resources are created.
