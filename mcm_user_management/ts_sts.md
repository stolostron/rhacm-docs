---

copyright:
  years: 2019
lastupdated: "2019-09-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Troubleshooting the secure token service

**{{site.data.keyword.tech_prev}}**

Troubleshoot frequently encountered errors.
{:shortdesc}


## Issue 1: Internal service error

During secure token service (STS) configuration, you might see the following error:

`Internal service error: rpc error: code = Unknown desc = validation failed: [unable to recognize “”: no matches for kind ”adapter”`

### Cause for issue 1

Istio is not installed. 

Installing Istio is a prerequisite for configuring the secure token service.

### Resolve issue 1

Install Istio.

For more information, see [Prerequisites](sts_config.md#prereq).

## Issue 2: 401 unauthorized error

You might see a `Response 401 unauthorized error`.

### Cause for issue 2

There are multiple reasons that might cause this error. Check the STS token adapter log to identify the cause.

### Resolve issue 2

Depending on the cause that you identified, obtain a JSON Web Token (JWT) token or make sure that the policy is properly defined.

## Issue 2: Unauthorized: Error retrieving key

You might see a `Unauthorized: Error retrieving key from https://icp-management-ingress.kube-system:8443/iam-token/oidc/keys` error.

### Cause for issue 3

Proper access is not defined for the API key that is bound to a Cloud Resource Name (CRN).

### Resolve issue 3

Use the correct API key. 

For more information, see [Get an API key](sts_config.md#key).


## Issue 4: ImagePullBackOff error

When you enable the STS service during installation, the audit service pod might show an `ImagePullBackOff` error.

### Cause for issue 4

The audit service image name in the deployment does not match the actual image name.

### Resolve issue 4

1. Check the correct Docker image name.
  ```
  docker images|grep audit-service
  ```
  {: codeblock}
  
2. Update the image name in the deployment file. You need `kubectl` to run the command. For more information about installing `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

  1. Open the deployment file for editing.
  ```
  kubectl edit deployment tokenadapter -n istio-system
  ```
  {: codeblock}
  
  2. In the `containers` section, update the audit service image name with the correct Docker image name.

