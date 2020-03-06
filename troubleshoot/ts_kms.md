---

copyright:
  years: 2019
lastupdated: "2019-12-11"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Troubleshooting Key Management Service

Troubleshoot common Key Management Service issues.
{:shortdesc}

Install the Kubernetes CLI to run the troubleshooting commands. For more information, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

* [`ContainerCreating` status on `key-management-hsm-middleware` pod](ts_kms.md#31986b)
* [Secret hsm-secret not found error](ts_kms.md#31986)
* [UPGRADE FAILED error](ts_kms.md#upgrade)
* [Key rotation does not work - shows 501 Not Implemented Error](ts_kms.md#no-implement)
* [Key operations do not work - show 400 Bad Request Error](ts_kms.md#key_400)
* [Key operations do not work - show 500 Internal Server Error](ts_kms.md#internal-server)
* [Key operations do not work - show 503 Unavailable Experiencing delays error](ts_kms.md#key_503)
* [HSM connection does not work on all management nodes](ts_kms.md#hsm)
* [Cannot import root key](ts_kms.md#root)
* [key-management-persistence log reports errors after Key Management Service configuration](ts_kms.md#log)
* [Kubernetes Ingress Controller Fake Certificate is returned by NGINX ingress controller](ts_kms.md#fake_cert)
* [key-management-pep pod not running](ts_kms.md#kmp_pod)

## `ContainerCreating` status on `key-management-hsm-middleware` pod
{: #31986b}

### Symptom: `ContainerCreating` status on `key-management-hsm-middleware` pod

When you upgrade to {{site.data.keyword.product_tm}} {{site.data.keyword.version}}, `ContainerCreating` status shows on the `key-management-hsm-middleware` pod.

### Cause: `ContainerCreating` status on `key-management-hsm-middleware` pod

The existing `hsm-secret` is removed when you upgrade to `key-management` Helm chart version {{site.data.keyword.version}}.

### Solution: `ContainerCreating` status on `key-management-hsm-middleware` pod
Create the secret after you upgrade the `key-management-hsm` Helm chart. For more information, see [Upgrading KMS Helm charts](../installing/upgrade_kms.md).

## Secret *hsm-secret* not found error
{: #31986}

### Symptom: Secret *hsm-secret* not found error

Installing {{site.data.keyword.product}} {{site.data.keyword.version} does not work. You see error `Secret` _hsm-secret_ `not found`.

### Cause: Secret *hsm-secret* not found error

Secret configuration is removed from the `key-management-chart`. You must now create the secret before you install a Helm chart.

### Solution: Secret *hsm-secret* not found error
Create the secret before you install the `key-management-hsm` Helm chart. For more information, see [Configuring Key Management Service](../mcm_user_management/kms_server.md).

## UPGRADE FAILED error
{: #upgrade}

### Symptom: UPGRADE FAILED error

Upgrading the Helm chart from {{site.data.keyword.previous}} to {{site.data.keyword.version}} does not work. You see the error `Error : UPGRADE FAILED`.

### Cause: UPGRADE FAILED error

You did not specify the `overrides.yaml` configuration file during Helm upgrade.

### Solution: UPGRADE FAILED error

1. Create a separate `overrides.yaml` configuration file and specify the new image path for {{site.data.keyword.product}}{{site.data.keyword.version}} in the file.

Following is a sample `overrides.yaml` file:
```
api:
  image:
    repository: mycluster.icp:8500/ibmcom/kms-api-amd64
    tag: <ICP_VERSION, like 4.1.0>

persistence:
  image:
    repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-persistence
    tag: <ICP_VERSION, like 4.1.0>

storage:
  image:
    repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-onboarding
    tag: <ICP_VERSION, like 4.1.0>

lifecycle:
  image:
    repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-lifecycle
    tag: <ICP_VERSION, like 4.1.0>

pep:
  image:
    repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-pep
    tag: <ICP_VERSION, like 4.1.0>

crypto:
  image:
    repository: <CLUSTER_NAME>.icp:8500/ibmcom/kms-crypto
    tag: <ICP_VERSION, like 4.1.0>

auditService:
  image:
    repository: <CLUSTER_NAME>.icp:8500/ibmcom/icp-audit-service
    tag: <ICP_VERSION, like 4.1.0>
```
{: pre}

2. Specify the file when you run the `helm upgrade` command.

```
helm upgrade -f overrides.yaml
```
{: codeblock}

## Key rotation does not work - shows 501 Not Implemented Error
{: #no-implement}

### Symptom: Key rotation does not work - shows 501 Not Implemented Error
{: #symptom_no-implement}
After you install the `key-management-hsm` Helm chart, key rotation does not work with Hardware Security Module (HSM). You see the error `501 Not Implemented Error`.

### Cause: Key rotation does not work - shows 501 Not Implemented Error
{: #cause_no-implement}

Key rotation is supported from {{site.data.keyword.version}} version.

### Solution: Key rotation does not work - shows 501 Not Implemented Error
{: #solution_no-implement}

Install the `key-management-4.1.0.tgz` Helm chart or upgrade the release.

## Key operations do not work - show 400 Bad Request Error
{: #key_400}

### Symptom: Key operations do not work - show 400 Bad Request Error
{: #symptom_key_400}

After upgrading the key management Helm chart, the operations for creating keys, wrapping keys, or unwrapping keys are not working with HSM. The log contains the following error: `400 Bad Request Error: "Provided API key could not be found".`

### Cause: Key operations do not work - show 400 Bad Request Error
{: #cause_key_400}

The `kms-api-key` data that is contained in the `key-management-secret` was overwritten to an invalid value of “default_kms_api_key”.

### Solution: Key operations do not work - show 400 Bad Request Error
{: #solution_key_400}

1. Create a new `api-key` by following the instructions in [Key management service APIs](../../apis/kms_apis.md).

2. Encode the key with base64 encryption.

3. Overwrite the existing data in the `kms-api-key` section of the secret by using the {{site.data.keyword.console}}.

4. Restart the pod by removing the `key-management-pep` pod.

## Key operations do not work - show 500 Internal Server Error
{: #internal-server}

### Symptom: Key operations do not work - show 500 Internal Server Error
{: #symptom_internal-server}

After you install the `key-management-hsm` Helm chart, you cannot create keys, or wrap or unwrap keys with HSM. You see the error `500 Internal Server Error`.

### Cause: Key operations do not work - show 500 Internal Server Error
{: #cause_internal-server}

Cleaning up job is not complete due to mismatch of image repository path.

### Solution: Key operations do not work - show 500 Internal Server Error
{: #solution_internal-server}

1. Remove `key-management-hsm-cleanup` batch job.

  1. Log in to the console.
  2. From the navigation menu, select **Workloads** > **Jobs** > **Batch Jobs**.
  3. Place the cursor on the `key-management-hsm-cleanup` batch job.
  4. Click **...** > **Remove** to remove the batch job.

2. Redeploy the `key-management-hsm` Helm chart.

## Key operations do not work - show 503 Unavailable Experiencing delays error
{: #key_503}

### Symptom: Key operations do not work - show 503 Unavailable Experiencing delays error
{: #symptom_key_503}

After upgrading the key management Helm chart, the operations for creating keys, wrapping keys, or unwrapping keys are not working with HSM. The log contains the following error: `503 Service Error “Unavailable Experiencing delays. Please try again in few minutes.”`

### Cause: Key operations do not work - show 503 Unavailable Experiencing delays error
{: #cause_key_503}

The HSM that is connected to `key-management-hsm-middleware` is unavailable or shut down.

### Solution: Key operations do not work - show 503 Unavailable Experiencing delays error
{: #solution_key_503}

1. Check the status of the HSM to determine if it is offline or if its configuration has been changed.

2. Restore the original configuration settings to the HSM, if they were changed.

3. Restart the HSM.

## HSM connection does not work on all management nodes
{: #hsm}

### Symptom: HSM connection does not work on all management nodes
{: #symptom_hsm}

HSM connection works on some but not all management nodes.

### Cause: HSM connection does not work on all management nodes
{: #cause_hsm}

The certificate and key pairs are not found on the management nodes on which HSM does not work.

### Solution: HSM connection does not work on all management nodes
{: #solution_hsm}

1. Install `kubectl`. For more information, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).
2. Check the HSM secret to confirm whether the certificate and key pairs are listed for all management nodes.
  ```
  kubectl get secret hsm-secret -o yaml --namespace kube-system
  ```
  {: codeblock}

  The information is available in the following format:
  ```
  <master-node-IP>: <BASE64_ENCODED_CERTIFICATE>
  <master-node-IP-key>: <BASE64_ENCODED_KEY>
  ```
  {: pre}

## Cannot import root key
{: #root}

You can import root keys only when you use a supported HSM model. SoftHSM is not supported.

For the supported HSM models, see [Configuring Key Management Service](../mcm_user_management/kms_server.md).

## key-management-persistence log reports errors after Key Management Service configuration
{: #log}

### Symptom: key-management-persistence log reports errors after Key Management Service configuration
{: #symptom_log}

After you configure the Key Management Service, you see errors in the `key-management-persistence` log.
```
kubectl logs key-management-persistence-5d6974bf8c-vxxwl --namespace kube-system
```
{: codeblock}

Following is a sample output:
```
2018/11/27 14:31:13 maxprocs: Leaving GOMAXPROCS=8: CPU quota undefined
{“caller”:“config.go:402",“component”:“config”,“file”:“/opt/keyprotect/config//production”,“location”:“local”,“msg”:“config loaded from local”,“ts”:“2018-11-27T14:31:13.891450032Z”}
{“caller”:“root.go:104",“commit”:“5bbc1228",“component”:“root”,“semver”:“2.1.0",“ts”:“2018-11-27T14:31:15.157576488Z”}
Creating MongoDB session with options: [mongodb:27017],  rs0
Failed to create session:  no reachable servers
Creating MongoDB session with options: [mongodb:27017],  rs0
Failed to create session:  no reachable servers
Creating MongoDB session with options: [mongodb:27017],  rs0
Failed to create session:  no reachable servers
Creating MongoDB session with options: [mongodb:27017],  rs0
```
{: pre}

### Cause: key-management-persistence log reports errors after Key Management Service configuration
{: #cause_log}

Containers on the management node failed to look up other services on the master node. The routing table was not configured properly because of a configuration issue with the `kube-controller`.

### Solution: key-management-persistence log reports errors after Key Management Service configuration
{: #solution_log}

Update the `kube-controller` configuration.

## Kubernetes Ingress Controller fake certificate is returned by the NGINX ingress controller
{: #fake_cert}

### Symptom: Kubernetes Ingress Controller fake certificate is returned by the NGINX ingress controller
When calling https://proxy_ip/, a Kubernetes Ingress Controller Fake Certificate is returned.

### Cause: Kubernetes Ingress Controller fake certificate is returned by the NGINX ingress controller
Kubernetes Ingress Controller Fake Certificate is used as the default SSL certificate in NGINX ingress controller.

### Solution: Kubernetes Ingress Controller fake certificate is returned by the NGINX ingress controller
You can configure [`--default-ssl-certificate`](https://kubernetes.github.io/ingress-nginx/user-guide/cli-arguments/) in daemonset nginx-ingress-controller to replace "Kubernetes Ingress Controller Fake Certificate”.

For example:
1. Create a secret that contains a SSL certificate:
    ```
    openssl genrsa -out ing-tls.key 4096
    openssl req -new -key ing-tls.key -out ing-tls.csr -subj "/CN=TTTEEESSSTTT”
    openssl x509 -req -days 36500 -in ing-tls.csr -signkey ing-tls.key -out ing-tls.crt
    kubectl create secret tls ing-tls-secret --cert=ing-tls.crt --key=ing-tls.key -n kube-system
    ```
2. Set `--default-ssl-certificate` in the daemonset nginx-ingress-controller. For example:
    ```
    kubectl edit ds -n kube-system nginx-ingress-controller
    ```
    ```
          containers:
          - args:
            - /nginx-ingress-controller
            - --default-backend-service=$(POD_NAMESPACE)/default-http-backend
            - --configmap=$(POD_NAMESPACE)/nginx-ingress-controller
            - --annotations-prefix=ingress.kubernetes.io
            - --enable-ssl-passthrough=true
            - --publish-status-address=172.16.247.161
            - --default-ssl-certificate=$(POD_NAMESPACE)/ing-tls-secret
    ```
3. Check the result. For example:

    ```
    # ps -ef | grep nginx-ingress-controller | grep default-ssl-certificate
    33       23251 23207  0 22:45 ?        00:00:00 /usr/bin/dumb-init -- /nginx-ingress-controller --default-backend-service=kube-system/default-http-backend --configmap=kube-system/nginx-ingress-controller --annotations-prefix=ingress.kubernetes.io --enable-ssl-passthrough=true --publish-status-address=172.16.247.161 --default-ssl-certificate=kube-system/ing-tls-secret
    33       23308 23251  0 22:45 ?        00:00:02 /nginx-ingress-controller --default-backend-service=kube-system/default-http-backend --configmap=kube-system/nginx-ingress-controller --annotations-prefix=ingress.kubernetes.io --enable-ssl-passthrough=true --publish-status-address=172.16.247.161 --default-ssl-certificate=kube-system/ing-tls-secret
    ```
    ```
    # curl -kv  https://172.16.247.161
    * About to connect() to 172.16.247.161 port 443 (#0)
    *   Trying 172.16.247.161...
    * Connected to 172.16.247.161 (172.16.247.161) port 443 (#0)
    * Initializing NSS with certpath: sql:/etc/pki/nssdb
    * skipping SSL peer certificate verification
    * SSL connection using TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
    * Server certificate:
    *       subject: CN=TTTEEESSSTTT
    *       start date: May 05 05:44:02 2019 GMT
    *       expire date: Apr 11 05:44:02 2119 GMT
    *       common name: TTTEEESSSTTT
    *       issuer: CN=TTTEEESSSTTT
    > GET / HTTP/1.1
    > User-Agent: curl/7.29.0
    > Host: 172.16.247.161
    > Accept: */*
    >
    < HTTP/1.1 404 Not Found
    < Date: Sun, 05 May 2019 05:49:49 GMT
    < Content-Type: text/plain; charset=utf-8
    < Content-Length: 21
    < Connection: keep-alive
    < Strict-Transport-Security: max-age=15724800; includeSubDomains
    <
    * Connection #0 to host 172.16.247.161 left intact
    ```

## key-management-pep pod not running
{: #kmp_pod}

### Symptom: key-management-pep pod not running
{: #symptom_kmp_pod}

The `key-management-pep` pod is not running, and displays `“CreateContainerConfigError”`.

### Cause: key-management-pep pod not running
{: #cause_kmp_pod}

The `kms-api-key` data inside of the value of the `key-management-secret` is not valid.

### Solution: key-management-pep pod not running
{: #solution_kmp_pod}

1. Check the status of secret-watcher pod.

2. If the pod is running, restart it.

3. If it is not running, see the troubleshooting guide for the secret watcher service.

For more information, see [Pods are not scheduled](../../iam/3.4.0/troubleshoot/pods_no_schedule.md).
