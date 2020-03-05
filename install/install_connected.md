# Installing Red Hat Advanced Cluster Management when connected

Red Hat Advanced Cluster Management for Kubernetes is installed using a main operator that deploys all of the required sub-operators such as etcd, multicloud subscription, Apache Hive, and so on.  

## Prerequisites

Red Hat OpenShift Container Platform version 4.3 must be deployed in your environment. See the [OpenShift version 4.3 documentation](https://docs.openshift.com/container-platform/4.3/welcome/index.html) for the required steps for installing OpenShift Container Platform. 

## Installing Red Hat Advanced Cluster Management for Kubernetes

1. Clone the `multicloudhub-operator` git repository by running the following command:

  ```bash
  git clone --single-branch --branch master https://github.com/open-cluster-management/multicloudhub-operator.git
  ```

2. Change to the `multicloudhub-operator` directory:

  ```bash
  cd multicloudhub-operator
  ```
	
3. Create a `local` directory:

  ```bash
  mkdir local
  ```

4. Create a file that contains local variables. 

  1. Switch to your `local` directory. 
    
	```
	cd local
	```
	  
  2. In your `local` directory, create a file called `local.rc` by entering the following command:
  
    ```
    cat <<EOF >>local.rc
    #!/usr/bin/env bash

    export GITHUB_USER=xxxx     # github username
    export GITHUB_TOKEN=xxxx    # github token with repo scope (see https://github.com/settings/tokens)

    export DOCKER_USERNAME=xxxx # quay.io username
    export DOCKER_PASS=xxxx     # quay.io encrypted password (see https://quay.io/user/your_name?tab=settings)

    export NAMESPACE=xxxx       # namespace to be used to run multicloudhub-operator
    EOF
    ```
	
	Note: Replace `xxxx` with the information that is specific to your environment.

  3. Specify the `local.rc` as the source of your environment variables:
  
    ```
	source local.rc
	```
	
5. Update the build dependencies of the multicloudhub-operator:

  ```
  make deps
  ```

6. Update the value for `namespace` in the `deploy/kustomization.yaml` file with the value that you used for `NAMESPACE` in the `local.rc` file. 

7. Create a catalog based on your new setting: 

  ```
  make olm-catalog
  ```

8. Create a namespace: (1)

  ```
  oc create namespace $NAMESPACE
  ```

9. Switch to the new namespace: (2)

  ```
  oc project $NAMESPACE
  ```  

10. Create an Apache Hive namespace: (3)

  ```
  oc create namespace hive  
  ```
  
11. Generate a pull secret to access the entitled content on Quay.io:
  
  1. Create a pull secret by running the following command: 
  
  ```
  oc create secret docker-registry quay-secret --docker-server=$(SECRET_REGISTRY) --docker-username=$(DOCKER_USERNAME) --docker-password=$(DOCKER_PASSWORD)
  ```
  SECRET_REGISTRY should be the path to your Quay.io server. For example,  `quay.io/`.
  (4)
  
  1. Visit [https://quay.io/user/*your_quay_id*?tab=settings](https://quay.io/user/*your_quay_id*?tab=settings).
  
  2. Select **Generate Encrypted Password**.
  
  3. Enter your your Quay.io password.
  
  4. Select **Kubernetes Secret** from navigation menu.
  
  5. Select **Download *your_username*-secret.yaml**
  
  6. Save your downloaded secret file in the `local` directory as `quay-secret.yaml`. 
  
  7. Change the `name` value in the `local/quay-secret.yaml` file to `quay-secret`, as shown in the following example:
 
    ```bash
    ...
    kind: Secret
    metadata:
      name: quay-secret
    ...
    ```

12. Associate your secret to your installation process:

  ```
  oc apply -f local/quay-secret.yaml
  ```
  
13. Create an operator group. (5)
 
  1. Create the file by entering the following command:
  
  ```bash
  cat <<EOF >>local/operator-group.yaml
  apiVersion: operators.coreos.com/v1
  kind: OperatorGroup
  metadata:
    name: default
  spec:
    targetNamespaces:
    - *your_namespace*
  EOF
  ```
  
  2. Associate the operator group:
  
  ```
  oc apply -f local/operator-group.yaml
  ```
  
14. Create a role:

  ```
  oc apply -f build/_output/olm/role.yaml
  ```
  
15. Create a service account: 

  ```
  oc apply -f build/_output/olm/service_account.yaml
  ```

16. Configure role binding.
  
  1. Copy the role binding definition to the `local` directory:

  ```
  cp build/_output/olm/role_binding.yaml local/role_binding.yaml
  ```

  2. Update the value of *namespace* in the `role_binding.yaml` file with the namespace that you used in the `local.rc` file, as shown in the following example:

  ```
  ...
  subjects:
  - kind: ServiceAccount
  name: multicloudhub-operator
  namespace: *your_namespace*
  ...
  ```

  3. Apply the role binding:

  ```
  oc apply -f local/role_binding.yaml
  ```

17. Prepare the resources that are required for multicloudhub. (6)
   
  1. Create the multicloudhub resources:
  
  ```
  oc apply -f build/_output/olm/multicloudhub.resources.yaml
  ```
  
  2. Copy the `subscription.yaml` file to the `local` directory. 
  
  ```
  cp build/_output/olm/subscription.yaml local/subscription.yaml
  ```
  
  3. Replace the values of `namespace` and `sourceNamespace` in the `local/subscription.yaml` file with the namespace that you listed in the `local.rc` file, as shown in the following example:

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
	
  4. Apply the subscription: (7)
	
  ```
  oc apply -f local/subscription.yaml
  ```

  5. Copy the `operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml` file to the `local` directory. 
  
  ```
  cp build/_output/olm/operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml local/operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml
  ```
	
  6. Replace the values of `default` in the `local/operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml` file with the namespace that you listed in the `local.rc` file.
  
18. Create the operator instance by entering the following command: (8)

  ```
  oc apply -f local/operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml
  ```
  **Note:** If step 18 fails with the following error, the resources are still being created and applied:run the command again in a few minutes when the resources are:
  
  ```
  error: unable to recognize "operators.multicloud.ibm.com_v1alpha1_multicloudhub_cr.yaml": no matches for kind "MultiCloudHub" in version "operators.multicloud.ibm.com/v1alpha1"
  ```
  
