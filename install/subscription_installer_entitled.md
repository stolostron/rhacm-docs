---

copyright:
  years: 2019
lastupdated: "2019-11-11"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

{{site.data.keyword.tech_prev}}

Follow these steps to install {{site.data.keyword.product}} by using the online subscription installer.
{:shortdesc}

# Online installation

   1. [Complete the prerequisites](#prerequisites)
   2. [Get the manifest](#manifest)
   3. [Set up the environment variables](#variables)
     1. [Set up the default username and password](#defaults)
     2. [Set up the entitled registry credential](#credentials)
   4. [Update the `ibmservices` operator custom resource (CR)](#ibmservices-operator-cr)
   5. [Install the services](#install)
   6. [Uninstall the services](#uninstall)


1. Complete the following prerequisites.
{: #prerequisites}

  - You must have an {{site.data.keyword.ocp_tm}} cluster before you start the installation.

  To learn more about {{site.data.keyword.ocp}}, see the [Getting started documentation ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.openshift.com/learn/get-started/).

  - You must have the `kubectl` version that is greater or equal to 1.14 installed. You apply the manifests with the Kubernetes Kustomize tool. To download the v1.14 tool, run the following command:

  ```bash
  curl -O https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl
  ```
  {: codeblock}

2. Get the manifest.
{: #manifest}

  You can get the manifest from the following GitHub repository by running the following command:

  ```bash
  git clone git@github.ibm.com:IBMPrivateCloud/cp4mcm-manifest.git
  cd cp4mcm-manifest
  ```
  {: codeblock}

3. Set up the environment variables.
{: #variables}

  1. Set up the default username and password.
  {: #defaults}

    In this manifest, the variables `DEFAULT_ADMIN_USERNAME` and `DEFAULT_ADMIN_PASSWORD` represent the default username and password. For example, if you want to set `admin` as username and `aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa` as the password, run the following command:

    ```bash
    export DEFAULT_ADMIN_USERNAME=admin
    export DEFAULT_ADMIN_PASSWORD=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    ```
    {: codeblock}

    **Note:** The default password enforcement rule is `'^([a-zA-Z0-9\-]{32,})$'`. This rule specifies that a password must meet the following conditions:

      - The password must have a minimum length of 32 characters.
      - The password can include lowercase letters, uppercase letters, numbers, and hyphens.

    If you want to custom set of password rules, you can set up a `PASSWORD_RULES` variable. For example, the following settings define two password rules:

    ```bash
    export PASSWORD_RULES=('^.{10,}' '.*[!@#\$%\^&\*].*')
    ```
    {: codeblock}

    To disable the password_rule, add `(.*)`

    ```bash
    export PASSWORD_RULES=('(.*)')
    ```
    {: codeblock}

  2. Set up the entitled registry credential.
  {: #credentials}

    Since the manifest pulls images from a Docker repository, you must set `DOCKER_USERNAME`, `DOCKER_PASSWORD`, and `DOCKER_REPO` as the credential of the Docker repository.

4. Update the `ibmservices` operator custom resource (CR).
{: #ibmservices-operator-cr}

  Update the `cr.yaml` with inline comment instructions:

  ```bash
  vim overlays/staging/cr.yaml
  ```
  {: codeblock}

  Example `cr.yaml` file:

  ```bash
  apiVersion: app.ibm.com/v1alpha1
  kind: Deployable
  metadata:
    labels:
      app: common-service
    annotations:
      app.ibm.com/is-local-deployable: "false"
    name: ibmservices-operator-cr
    namespace: ibmservices-channel
  spec:
    template:
      apiVersion: operator.ibm.com/v1alpha1
      kind: IBMServicesPlatform
      metadata:
        name: default
        namespace: ibmplatform-service
      spec:
        version: 3.2.2
        storageClass: default
        imagePullSecretRef: ibmplatform-image-pull-secret
        adminCredentialSecretRef: admin-credential
        externalKubeApiserver: your-ocp-api-server
        dedicatedNodes:
        - your-ocp-node
        services:
        - name: app-monitoring
          state: present
        - name: metering
          state: present
        - name: licensing
          state: absent
        - name: audit-logging
          state: absent
        - name: service-health
          state: present
        - name: webconsole
          state: present
        - name: visual-webterminal
          state: present
        - name: app-ingress-controller
          state: present
        - name: catalog
          state: present
  ```
  {: codeblock}

  Parameter descriptions:
  - `version` of the service you install.
  - `storageClass` that is used for the services. You can get the storage class by running the following command:
    ```bash
    kubectl get sc
    ```
    {: codeblock}

  - `imagePullSecretRef` is the secret that is combined with `DOCKER_USERNAME`, `DOCKER_PASSWORD`, and `DOCKER_REPO` to pull images from the Docker repository.
  - `adminCredentialSecretRef` is the secret to save the services admin credential including `DEFAULT_ADMIN_USERNAME` and `DEFAULT_ADMIN_PASSWORD`.
  - `externalKubeApiserver` is the `openshift apiserver`. You can get the parameter from running the following the command:
    ```bash
    kubectl cluster-info 2>/dev/null | awk '/Kubernetes master/ {print $NF}
    ```
    {: codeblock}
  - `dedicatedNodes` are the worker nodes that you want to deploy services on. You can check the available nodes by running the following command:
    ```bash
    kubectl get node
    ```
    {: codeblock}
  - `services` is the section. You can choose to enable or disable a service. If you want to install the service, set its state to `present`. If you want to remove the service, set its state to `absent`.

5. Install the {{site.data.keyword.cloud_pak_mcm}}
{: #install}

  1. Run `./start.sh` to install the services:
  ```bash
  ./start.sh
  ```
  {: codeblock}
  2. When prompted, click **Yes**, to install the {{site.data.keyword.cloud_pak_mcm}}.

## Uninstall the {{site.data.keyword.cloud_pak_mcm}}
{: #uninstall}

  To uninstall {{site.data.keyword.cloud_pak_mcm}}, run `./uninstall.sh` to uninstall the services:
  ```bash
  ./uninstall.sh
  ```
  {: codeblock}
