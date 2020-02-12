---

copyright:
  years: 2016, 2019
lastupdated: "2019-10-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Cluster import fails when image registry is not whitelisted

When you are importing a cluster to your hub cluster, the import can fail if your image policy is incorrectly defined and does not whitelist your image registry.  
{:shortdesc}

## Symptoms

You encounter an error when you attempt to import a cluster to your hub cluster.

The error occurs when you are using `cloudctl` and run the Kubernetes CLI (`kubectl`) on the managed cluster as part of importing a cluster. The error can result in the following error message:

  ```
  no matching repositories in ClusterImagePolicy and no ImagePolicies in the "multicluster-endpoint" namespace
  ```
  {: codeblock}

If this error occurs, you can also notice that the `multicluster-endpoint` pods are not deployed correctly on the targeted managed cluster.

## Causes

This error can occur when the {{site.data.keyword.cloud_pak_mcm}} image registry that you are using is not whitelisted in the image policy.

## Resolving the problem

Ensure that your images are valid for the `clusterimagepolicy` or `imagepolicy` namespace whenever you plan to import an {{site.data.keyword.cloud_pak_mcm}} cluster. To ensure that your image is valid, add the image registry to the whitelist for your image policy on your hub cluster before you import a cluster to your hub cluster.

Your image policy can resemble the following example policy:

```
apiVersion: securityenforcement.admission.cloud.ibm.com/v1beta1
kind: ClusterImagePolicy
metadata:
  name: ibmcloud-default-cluster-image-policy
spec:
  repositories:
    # allow all images
    - name: <your-klusterlet-image-repository>
      policy:

```
{: codeblock}

If you plan to use this example to help you model your own policy, adjust the policy configuration to meet your requirements. This example policy grants authorization for all images to be processed for your cluster.
