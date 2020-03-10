---

copyright:
  years: 2019
lastupdated: "2019-09-27"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Image signing support for image policies

Configure image signing to enable image enforcement.
{: shortdesc}

**{{site.data.keyword.tech_prev}}**

Image signing works with Docker content trust and Docker notary service to ensure that the pods are created with the trusted image. By adding the trust policy to the repository, only the signed image with the correct signature can be successfully deployed.
```
apiVersion:  securityenforcement.admission.cloud.ibm.com/v1beta1
kind:         ImagePolicy
metadata:
   name:  icp-services-ns-image-policy
spec:
    repositories:
    - name: <<image repository name, such as mycluster.icp:8500/kube-system/*>
      policy:
        trust:
          enabled: true
          signerSecrets:
          - name: signername
          trustServer: https://<ICP cluster IP>:8443/notary
```
{: codeblock}

* `enabled` Set to true to enable image signing.

* `signerSecrets` A list of secrets that stores the signer's public key and name. The name must match the role name that is registered with the notary server for this image. Use the following command to create the secret.
```
kubectl create secret generic <secret_name> --from-literal=name=<signer_name> --from-file=publicKey=<key.pub>
```
{: codeblock}

* `trustServer` The notary server URL.

## Enable image policy enforcement and image signing on {{site.data.keyword.open_s}} 3.11

1. Deploy CRDs for image policy and cluster image policy.
   ```
      apiVersion: apiextensions.k8s.io/v1beta1
      kind: CustomResourceDefinition
      metadata:
        name: imagepolicies.securityenforcement.admission.cloud.ibm.com
      spec:
        group: securityenforcement.admission.cloud.ibm.com
        names:
          kind: ImagePolicy
          listKind: ImagePolicyList
          plural: imagepolicies
          singular: imagepolicy
        scope: Namespaced
        version: v1beta1
      ---
      apiVersion: apiextensions.k8s.io/v1beta1
      kind: CustomResourceDefinition
      metadata:
        name: clusterimagepolicies.securityenforcement.admission.cloud.ibm.com
      spec:
        group: securityenforcement.admission.cloud.ibm.com
        names:
          kind: ClusterImagePolicy
          listKind: ClusterImagePolicyList
          plural: clusterimagepolicies
          singular: clusterimagepolicy
        scope: Cluster
        version: v1beta1
   ```
   {: codeblock}

2. Create default cluster-wide image policy with whitelisted repositories. The following example resembles the `image-security-enforcement` that you need to append to your `/etc/origin/master/master-config.yaml`.

   ```
   image-security-enforcement:
   clusterImagePolicy:
    - name: "docker.io/*"
      policy:
    - name: "mycluster.icp:8500/*"
      policy:
    - name: "quay.io/*"
      policy:
   ```
   {: codeblock}
   
3. Update the `admissionConfig` section in `/etc/origin/master/master-config.yaml` to include `ValidatingAdmissionWebhook` and `MutatingAdmissionWebhook`.

   ```
   admissionConfig:
     pluginConfig:
       ValidatingAdmissionWebhook:
         configuration:
           apiVersion: v1
           disable: false
           kind: DefaultAdmissionConfig
       MutatingAdmissionWebhook:
         configuration:
           apiVersion: v1
           disable: false
           kind: DefaultAdmissionConfig
       BuildDefaults:
         configuration:
           apiVersion: v1
           env: []
           kind: BuildDefaultsConfig
           resources:
             limits: {}
             requests: {}
   ```
   {: codeblock}
   
4. Restart the apiserver.

   ```
   /usr/local/bin/master-restart api
   /usr/local/bin/master-restart controllers
   ```
   {: codeblock}

## Troubleshooting errors during image deployment

* [Name or public key is not defined in the signer secret](#noname_pk)
* [Image is not signed, or the trust content is not in the notary server](#img_nosign)
* [Repository is not whitelisted in the image policy](#no_wl)

## Issue 1: Name or public key is not defined in the signer secret
{: #noname_pk}

### Symptom of issue 1
`Internal error occurred: admission webhook "trust.hooks.securityenforcement.admission.cloud.ibm.com" denied the request: Deny "hyc-cloud-private-scratch-docker-local.artifactory.swg-devops.com/ibmcom/stsapp/stsapp:0.1", could not get signerSecret from your cluster, name, or publicKey field in secret yannisigner is empty`

### Cause for issue 1
The name or public key is not defined in the signer secret.

### Solution for issue 1
Make sure that the secret has both `name` and `publicKey` attributes defined. The attribute name is case-sensitive.

## Issue 2: Image is not signed, or the trust content is not in the notary server
{: #img_nosign}

### Symptom of issue 2

`Error from server (InternalError): error when creating "stsapp-deployment.yaml": Internal error occurred: admission webhook "trust.hooks.securityenforcement.admission.cloud.ibm.com" denied the request:
Deny "hyc-cloud-private-scratch-docker-local.artifactory.swg-devops.com/ibmcom/stsapp/stsapp:0.1", failed to get content trust information: 9.46.78.45:8443 does not have trust data for hyc-cloud-private-scratch-docker-local.artifactory.swg-devops.com/ibmcom/stsapp/stsapp-nosign`

### Cause for issue 2

The image is not signed, or the trust content is not in the notary server that is specified in the image policy.

### Solution for issue 2

The image must be signed, and the trust content must be pushed to the specified notary server.

## Issue 3: Repository is not whitelisted in the image policy
{: #no_wl}

### Symptom of issue 3

`Error from server (InternalError): error when creating "stsapp-nosign-deployment.yaml": Internal error occurred: admission webhook "trust.hooks.securityenforcement.admission.cloud.ibm.com" denied the request:
Deny "hyc-cloud-private-scratch-docker-local.artifactory.swg-devops.com/ibmcom/stsapp/stsapp-nosign:0.1", no matching repositories in ClusterImagePolicy and no ImagePolicies in the "kube-system" namespace`

### Cause for issue 3

`hyc-cloud-private-scratch-docker-local.artifactory.swg-devops.com` is not whitelisted at the cluster level or the namespace kube-system (no image policy defined for it in kube-system).

### Solution for issue 3

Whitelist the repository in the image policy.
