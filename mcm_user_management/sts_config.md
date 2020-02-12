---

copyright:
  years: 2019
lastupdated: "2019-09-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Configure secure token service

**{{site.data.keyword.tech_prev}}**

Configure secure token service (STS).
{:shortdesc}


## Prerequisites
{: #prereq}

Secure token service requires Istio mixer to function properly.

You must manually install Istio Version 1.2.2. For more information, see [Installing Red Hat OpenShift Service Mesh ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/4.2/service_mesh/service_mesh_install/installing-ossm.html). 

Update the `global` and `mixer` sections. For more information, see [Customizing the Red Hat OpenShift Service Mesh installation ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/4.2/service_mesh/service_mesh_install/customizing-installation-ossm.html#customize-installation-ossm). Set the following parameters:

  - Set the `global.disablePolicyChecks:` global parameter to `false`.
  - Set the `mixer.enabled:` mixer parameter to `true`.

## Configure STS

Complete the following steps to configure STS:

1. [Get an API key](#key)
2. [Create cluster role binding](#role)
3. [Install STS by using the Helm chart](#helm)
4. [Create a deployment YAML file](#yaml)

### Get an API key
{: #key}

API key is required for other services to use the secure token service. The API key is used for identity mapping, and must have a base64-encoded value. It must be bound to the service ID. The service ID must have a proper access policy that is defined for the service request. If you do not have an API key for your service, you can skip this step for now. You can create the API key later when you enable your service to use the secure token service.

For more information about creating an API key, see [Create an API key](../../iam/3.4.0/apis/api_keys.md#create1).

### Create cluster role binding
{: #role}

Create cluster role binding to bind the new STS user system account to the administrator role.

```
kubectl create clusterrolebinding sts --clusterrole=cluster-admin --user=system:serviceaccount:istio-system:default --namespace=istio-system
```
{: codeblock}

### Install STS by using the Helm chart
{: #helm}

You can install STS by using the `icp-sts-chart` Helm chart. You can deploy the Helm chart from the Catalog. <!--For more information, see [Managing charts and apps](../../app_center/app_center.md).-->

1. Encode the API key. You must specify `-n` option so that trailing new-line characters are not included in the encoded key.  
  ```
  echo -n <API-key>|base64
  ```
  {: codeblock}

  **Note:** If you do not have an API key for your service, you can skip this step.

2. Create an `overrides.yaml` file with the following content:  
  ```
  wellKnownURI:<https://iam.cloud.ibm.com/identity/.well-known/openid-configuration>
  cacheTimeout:<60m>
  apiKey:<encoded API key>
  ```
  {: codeblock}

  Following are the parameter descriptions:  
    - `wellKnownURI` is the Uniform Resource Identifier (URI) that is used to validate the JSON Web Token (JWT) that is sent from the source cloud provider.
    - `apiKey` is the API key that is used for identity mapping. Do not add this line of code if you do not have an API key.
    - `cacheTimeout` is the duration in minutes for which an entry in the cache is valid. The default value is 60 minutes. The format is `nnm`, where `nn` is the numeric value and `m` represents minutes. Setting the `cacheTimeout` value to zero (`0m`), keeps the entries in the cache for an infinite amount of time.

3. Deploy the Helm chart:

    You can create an `overrides.yaml` file to overwrite the default values that are defined in the `values.yaml` file. Use the following command:   
    ```
    helm install mgmt-charts/sts --tls --namespace istio-system --name sts -f path/to/overrides.yaml
    ```
    {: codeblock}

### Create a deployment YAML file
{: #yaml}

1. Create a deployment YAML file named `handler-inst-rule.yaml` with the following content:  
  ```
   apiVersion: "config.istio.io/v1alpha2"
   kind: handler
   metadata:
    name: h1
    namespace: istio-system
   spec:
    adapter: tokenadapter
    connection:
     address: "tokenadapter:9070"
   ---
   # instance for token template
   apiVersion: "config.istio.io/v1alpha2"
   kind: instance
   metadata:
    name: i1check
    namespace: istio-system
   spec:
    template: tokentemplate
    params:
      authorization: request.headers["Authorization"] | request.headers["authorization"] | "unknown"
      instanceid: request.headers["icp-instance"] | "unknown"
   ---
   # rule to dispatch to handler h1
   apiVersion: "config.istio.io/v1alpha2"
   kind: rule
   metadata:
    name: r1
    namespace: istio-system
   spec:
    match: context.reporter.kind == "outbound" && source.labels["istio"] == "ingressgateway"
    actions:
    - handler: h1.istio-system
      instances:
      - i1check
      name: a1
    requestHeaderOperations:
        - name: Authorization
          values:
          - a1.output.authorization
  ```
  {: codeblock}

2. Run the following command to deploy the file:  
  ```
  kubectl apply -f handler-inst-rule.yaml
  ```
  {: codeblock}

Next, enable the key management service to use STS. For more information, see [Enable the key management service to use secure token service](sts_request.md).
