---

copyright:
  years: 2016, 2020
lastupdated: "2020-01-01"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Configuring Key Management Service

Configure Key Management Service (KMS) to encrypt data at rest and in transit.
{: shortdesc}

## Installing the package

Install the Key Management Hardware Security Module (HSM) package `key-management-hsm-amd64.tar.gz` by following these steps:

Before you begin, you must have an installed {{site.data.keyword.product}} cluster.

1. Download the `key-management-hsm-amd64.tar.gz` compressed file from [IBM Passport Advantage® ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/software/passportadvantage/).

2. Optional: Prepare the archive dependency yaml resource file.

3. Optional: Create a directory named `resources` in your `cluster` directory and put the YAML resource file under it.
  ```
  mkdir -p cluster/resources
  mv your-resource.yaml cluster/resources/
  ```
  {: codeblock}

4. Create a directory named `addon` in your `cluster` directory by running the following command:
  ```
  mkdir -p cluster/addon
  ```
  {: codeblock}

5. Move the archive package to the directory that you created. 
  ```
  mv key-management-hsm-amd64.tar.gz cluster/addon/
  ```
  {: codeblock}

6. Update the `cluster/config.yaml` file by adding the following content. 
  ```
  archive_addons:
    software_name:
      namespace: default
      repo: local-charts
      path: addon/key-management-hsm-amd64.tar.gz

      charts:
        - name: software
          values:
            service:
            name: software-service
  ```
  {: codeblock}

    The following list describes the content in the example:
      * *namespace*: The namespace where you want to upload the image and install your chart.
      * *repo*: The Helm repo where you want to upload the chart. The repo can be either `local-charts` or `mgmt-charts`.
      * *path*: The HSM package path relative to the `cluster` directory.
      * *charts*: A list of charts that you want to install. If no charts are listed, no chart is installed.
        * *charts\[\].name*: The {{site.data.keyword.IBM_notm}} Passport Advantage chart that is installed with the installation of {{site.data.keyword.product}}.
	* *charts\[\].values*: The customized values of the Passport Advantage chart.

7. Run the {{site.data.keyword.product}} installation command. The installer uploads the specified charts and images to the Helm repository and registry. For the installation command, see [Installing the {{site.data.keyword.cloud_pak_mcm}} offline](../../install/cloud_pak_foundation.md#deploy).
 


## Set up an HSM device

Use the KMS to provision and manage encrypted keys for your applications and services. You must set up a HSM device that is partitioned for use by KMS. {{site.data.keyword.product}} version {{site.data.keyword.version}} supports SafeNet Luna Network HSM 6.2 and nCipher nShield Connect HSM 12.40.2.


  * [Configuring SafeNet Luna Network HSM 6.2](#config_lunanet)
  * [Configuring nCipher nShield Connect HSM 12.40.2](#config_nCipher)
  * [Configuring SoftHSM](#config_softhsm)
  * [Generating keys](#gen_keys)
  * [Clearing HSM Application Data](#clearing_appdata)
  * [Onboarding a service to use KMS](#onboard_serv)  
  
## Configuring SafeNet Luna Network HSM 6.2
{: #config_lunanet}

Complete these steps to configure the HSM device:

1. Set up Helm CLI. For more information, see [Installing the Helm CLI (helm)](../../helm-cli/3.4.0/create_helm_cli.md).

2. Add the `mgmt-charts` repository to your cluster.
   ```
   helm repo add mgmt-charts https://<Cluster Master Host>:<Cluster Master API Port>/mgmt-repo/charts --ca-file ~/.helm/ca.pem --cert-file ~/.helm/cert.pem --key-file ~/.helm/key.pem
   ```
   {: codeblock}

3. Update Helm repositories.
   ```
   helm repo update
   ```
   {: codeblock}

4. Create a `hsm-Secret.yaml` file with the following content:
   ```
   apiVersion: v1
   kind: Secret
   type: Opaque
   metadata:
     name: hsm-secret
     namespace: kube-system
   data:
     hsm-pass: <BASE64 ENCODED PASSWORD OF HSM>
     ServerCAFile: <BASE64 ENCODED CONTENTS OF LUNA SERVER CERTIFICATE>
     <MANAGEMENT_NODE_IP>: <BASE64 ENCODED CONTENTS OF LUNA CLIENT CERTIFICATE>
     <MANAGEMENT_NODE_IP>-key: <BASE64 ENCODED CONTENTS OF LUNA CLIENT KEY>
   ```
   {: codeblock}

5. Import the `hsm-Secret.yaml` file into the cluster.
   ```
   kubectl apply -f hsm-Secret.yaml -n kube-system
   ```
   {: codeblock}

6. Verify the creation of your secret.
   ```
   kubectl get secret hsm-secret -n kube-system -o yaml
   ```
   {: codeblock}

7. Create a `overrides_hsm.yaml` file with the following content:
   ```
   hsm:
     hsm_model: gemalto
     hsm_ip: <HSM IP ADDRESS>
   oss:
     image:
       repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-oss
       tag: <ICP_version>
   storage:
     image:
       repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-onboarding
       tag: <ICP_version>
   gemalto:
     image:
       repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-gemaltov6
       tag: <ICP_version>
   watcher:
     image:
       repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-oss-watcher
       tag: <ICP_version>
   ```
   {: codeblock}

   **Note:** The repository for all images must start with `docker- registry.default.svc:5000`. For example: `docker-registry.default.svc:5000/ibmcom/kms-oss-watcher.`

   Under the `client_certs parameter`, you must list the certificate and key pair for all management nodes. All certificates and keys must be base64 encoded.

   **Note:** As the `overrides_hsm.yaml` file contains sensitive information, you must encrypt it or delete it when the file is not in use.

8. Run the following command:
   ```
   helm install mgmt-charts/key-management-hsm --tls --namespace kube-system --name key-management-hsm -f path/to/overrides_hsm.yaml
   ```
   {: codeblock}


## Configuring nCipher nShield Connect HSM 12.40.2
{: #config_nCipher}

Complete these steps to configure the HSM device:

1. Set up Helm CLI. For more information, see [Installing the Helm CLI (helm)](../../helm-cli/3.4.0/create_helm_cli.md).

2. Add the `mgmt-charts` repository to your cluster.
   ```
   helm repo add mgmt-charts https://<Cluster Master Host>:<Cluster Master API Port>/mgmt-repo/charts --ca-file ~/.helm/ca.pem --cert-file ~/.helm/cert.pem --key-file ~/.helm/key.pem
   ```
   {: codeblock}

3. Update Helm repositories.
   ```
   helm repo update     
   ```
   {: codeblock}

4. Create a `hsm-Secret.yaml` file with the following content:
   ```
   apiVersion: v1
   kind: Secret
   type: Opaque
   metadata:
     name: hsm-secret
   namespace: kube-system
   data:
     hsm-pass: <BASE64 ENCODED PASSWORD OF HSM>
   ```
   {: codeblock}

5. Import the `hsm-Secret.yaml` file into the cluster.
   ```
   kubectl apply -f hsm-Secret.yaml -n kube-system
   ```
   {: codeblock}  

6. Verify the creation of your secret.
   ```
   kubectl get secret hsm-secret -n kube-system -o yaml
   ```
   {: codeblock}

7. Create a `overrides_hsm.yaml` file with the following content:
   ```
    hsm:
      hsm_model: thales
      hsm_ip: <HSM IP ADDRESS>
      rfs_ip: <RFS IP ADDRESS>
      slotId: <HSM slot ID string, i.e. "492971158">
    oss:
      image:
        repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-oss
        tag: <ICP_version>
    storage:
      image:
        repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-onboarding
        tag: <ICP_version>
    thales:
      image:
        repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-thalesv12
        tag: <ICP_version>
    watcher:
      image:
        repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-oss-watcher
        tag: <ICP_version>
   ```
   {: codeblock}

   **Note:** The repository for all images must start with `docker- registry.default.svc:5000`. For example: `docker-registry.default.svc:5000/ibmcom/kms-oss-watcher.`

   Under the `client_certs parameter`, you must list the certificate and key pair for all management nodes. All certificates and keys must be base64 encoded.

   **Note:** As the `overrides_hsm.yaml` file contains sensitive information, you must encrypt it or delete it when the file is not in use.

8. Run the following command:
    ```
    helm install mgmt-charts/key-management-hsm --tls --namespace kube-system --name key-management-hsm -f path/to/overrides_hsm.yaml
    ```
    {: codeblock}

## Configuring SoftHSM
{: #config_softhsm}

SoftHSM is a virtualized HSM that displays the functions of the key management system that is available. SoftHSM can be used only for demonstration purpose. You can test the APIs in a non-production environment to understand what might be possible with a real hardware security module.

### Limitations

- You cannot import root keys.
- If a pod is restarted, the KMS becomes invalid.

Complete these steps to install SoftHSM:

1. Set up Helm CLI. For more information, see [Installing the Helm CLI (helm)](../../helm-cli/3.4.0/create_helm_cli.md).

2. Add the `mgmt-charts` repository to your cluster.
   ```
   helm repo add mgmt-charts https://<Cluster Master Host>:<Cluster Master API Port>/mgmt-repo/charts --ca-file ~/.helm/ca.pem --cert-file ~/.helm/cert.pem --key-file ~/.helm/key.pem
   ```
   {: codeblock}

3. Update Helm repositories.
   ```
   helm repo update
   ```
   {: codeblock}

4. Create a `hsm-Secret.yaml` file with the following content:
   ```
   apiVersion: v1
   kind: Secret
   metadata:
     name: hsm-secret
     namespace: kube-system
   data:
     hsm-pass: <ANY BASE64 ENCODED string, i.e. cGFzc3dvcmQ=>
   ```
   {: codeblock}

5. Import the `hsm-Secret.yaml` file into the cluster.
   ```
   kubectl apply -f hsm-Secret.yaml -n kube-system
   ```
   {: codeblock}  

6. Verify the creation of your secret.
   ```
   kubectl get secret hsm-secret -n kube-system -o yaml
   ```
   {: codeblock}    

7. Create a `overrides_hsm.yaml` file with the following content:
   ```
   hsm:
     hsm_model: softhsm
   oss:
     image:
       repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-oss
       tag: <ICP_version>
   storage:
     image:
       repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-onboarding
       tag: <ICP_version>
   softhsm:
     image:
       repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-softhsm
       tag: <ICP_version>
   watcher:
     image:
       repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-oss-watcher
       tag: <ICP_version>
   ```
   {: codeblock}

   **Note:** The repository for all images must start with `docker- registry.default.svc:5000`. For example: `docker-registry.default.svc:5000/ibmcom/kms-oss-watcher.`

   Under the `client_certs parameter`, you must list the certificate and key pair for all management nodes. All certificates and keys must be base64 encoded.

   **Note:** As the `overrides_hsm.yaml` file contains sensitive information, you must encrypt it or delete it when the file is not in use.

8. Run the following command:
   ```
   helm install mgmt-charts/key-management-hsm --tls --namespace kube-system --name key-management-hsm -f path/to/overrides_hsm.yaml
   ```
   {: codeblock}


## Clearing HSM Application Data
{: #clearing_appdata}

If you are switching over to a new HSM model, HSM Application Data can be cleared by adding `clear_data: true` into the `overrides.yaml` configuration file under `hsm`. This value is by default set to false. For example:
```
hsm:
  hsm_model: <HSM MODEL>
  clear_data: true
  hsm_ip: <HSM IP ADDRESS>
  hsm_pw: <HSM PARTITION PASSWORD>
```
{: codeblock}

## Generating keys
{: #gen_keys}

KMS uses two types of keys.

  - Root keys: Root keys are symmetric key-wrapping keys that you completely manage. You can use a root key to protect other cryptographic keys with advanced encryption.
  - Standard keys: Standard keys are symmetric keys that are used for cryptography. You can use a standard key to directly encrypt and decrypt data.

For more information about adding root keys, see [Adding root keys to instances](kms_guide_add_keys.md).

## Onboarding a service to use KMS
{: #onboard_serv}

To use KMS for your service, complete the following tasks:

1. Set up the Kubernetes CLI. For more information, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

2. Provision your KMS instance. For more information, see [Setting up an instance](kms_guide_su_instance.md#prov_kmsinst).

3. Create a service ID for your service. For more information, see [Setting up Service IDs](kms_guide_su_instance.md#service-id).

4. Assign an access policy for the service ID to interact with the service. Use the  [Create an access policy for a service ID](../../iam/3.4.0/apis/service_policy.md#create1) API to assign an access policy.

  Following is a sample request for assigning an access policy:

  ```
  {
  	  "resources": [
		  {
              "namespaceId": "kube-system",
              "serviceName": "kms",
              "serviceInstance": "<INSTANCE_ID>,
              "resource": "<KEY_ID>",
              "resourceType": "key"
		  }
	  ],
	  "roles": [
		  {
			  "id": "crn:v1:icp:private:iam::::role:<ROLE>"
		  }
	  ]
  }
  ```
  {: codeblock}


