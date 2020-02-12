---

copyright:
  years: 2016, 2019
lastupdated: "2019-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Encrypting Kubernetes secrets with Key Management Service plug-in

Encrypt Kubernetes secrets by using the Key Management Service (KMS) plug-in.
{:shortdesc}

**Note:** The KMS plug-in is supported only on {{site.data.keyword.ocp_tm}} version 3.11 clusters.

The KMS plug-in runs as a static pod on a Kubernetes master node. The API server uses a provider-based mechanism to communicate with the plug-in, which in turn communicates with the KMS provider to obtain the Data Encryption Key (DEK). The DEK is used to encrypt the secrets or decrypt the encrypted secrets. For more information, see [Using a KMS provider for data encryption ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/).

In {{site.data.keyword.product_tm}}, the plug-in is Federal Information Processing Standards (FIPS) 140-2 compliant. It uses Advanced Encryption Standard (AES), a FIPS-approved cryptographic algorithm, with Cipher Blocker Chaining (CBC) mode to encrypt Kubernetes secrets. KMS does not generate any key or do any cryptographic calculations. It delegates these tasks to a Hardware Security Module (HSM), which is FIPS-compliant.

**Required user type or access level:** Cluster administrator

## Prerequisites

- You must provide an HSM device that is partitioned for use by KMS. {{site.data.keyword.product}} Version {{site.data.keyword.version}} supports SafeNet Luna Network HSM 6.2.
- You must install the KMS HSM chart.
- You must obtain the instance ID and Customer Root Key (CRK) ID by following the steps that are documented in the Key Management Service section.

## Enabling KMS plug-in

1. Log on to the master node as a cluster administrator.
2. Restart the KMS plug-in by deleting the existing KMS plug-in container. For more information about installing `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).
    ```
    kubectl kill <KMS plug-in container ID>
    ```
    {: codeblock}

3. Add the following piece of code to the `/etc/origin/master/master-config.yaml` file.
  ```kubernetesMasterConfig:
  apiServerArguments:
    storage-backend:
    - etcd3
    experimental-encryption-provider-config:
    - /etc/origin/master/encryption-config.yaml
    storage-media-type:
    - application/vnd.kubernetes.protobuf
  controllerArguments:
    cluster-signing-cert-file:
    - /etc/origin/master/ca.crt
  ```
  {: codeblock}
  
4. Ensure that the `/etc/cfc/conf/encryption-config.yaml` file exists on all master nodes. The KMS plug-in provider must be the first provider in the provider list. The content resembles the following code:
    ```
    kind: EncryptionConfiguration
    apiVersion: apiserver.config.k8s.io/v1
    resources:
      - resources:
          - secrets
        providers:
          - kms:
              name: KmsPlugin
              endpoint: unix:///etc/origin/master/keyprotectprovider.sock
              cachesize: 100
          - identity: {}
    ```
    {: pre}

5. Copy the `/etc/cfc/conf/encryption-config.yaml` file to the `/etc/origin/master` directory.
  ```
  cp /etc/cfc/conf/encryption-config.yaml /etc/origin/master
  ```
  {: codeblock}
  
6. Change the location to the root directory.
  ```
  cd /root
  ```
  {: codeblock}
  
7. Create a `kmsplugin` folder.
  ```
  mkdir kmsplugin
  ```
  {: codeblock}
  
8. Change location to the `kmsplugin` folder.
  ```
  cd kmsplugin
  ```
  {: codeblock}
  
9. Copy the CA certificate to the current location.
  ```
  cp /root/cluster/cfc-certs/root-ca/ca.crt .
  ```
  {: codeblock}
  
10. Create a `kmsplugin-config.yaml` file with the following content. Update the `API_KEY`, `INSTANCE_ID`, and `CRK_ID` parameters in the `kmsplugin-config.yaml` file.
  ```
  SERVER_CONFIG:
    REGION: "IBMCloudPakForMCM"
    NUM_LEN_BYTES: 4
    CACHE_TIMEOUT_IN_HOURS: 1
    RESTART_DELAY_IN_SECONDS: 30
    UNIX_SOCKET_PATH: "/etc/origin/master/keyprotectprovider.sock"
    TOKEN_URL: "https://iam-token-service.kube-system:10443/oidc/token"
    TOKEN_URL_CA_FILE: "/root/kmsplugin/ca.crt"
    API_KEY: "<API_KEY>"
    HEALTHZ_PATH: "/healthz"
    HEALTHZ_PORT: ":20358"
    NEW_DEK: false
    MAX_RETRIES: 0
  KP_CONFIG:
    VERSION: 1
    CRK_ID: "<CRK_ID"
    URL: "https://kms-api.kube-system:28674"
    KP_CA_FILE: "/root/kmsplugin/ca.crt"
    INSTANCE_ID: "<INSTANCE_ID>"
  LOGGER:
    LOG_LEVEL: "info"
    LOG_ALL_VALUES: false
  ```
  {: codeblock}
  
11. Create a `kmsplugin.yaml` file with the following content. Replace the image repository name and the image pull secret with the correct values.
  ```
  apiVersion: v1
  kind: Pod
  metadata:
    name: k8s-kmsplugin
    namespace: kube-system
    annotations:
      scheduler.alpha.kubernetes.io/critical-pod: ''
  spec:
    hostNetwork: true
    dnsPolicy: ClusterFirstWithHostNet
    imagePullSecrets:
    - name: secret
    containers:
    - name: kms-plugin
      env:
      - name: config_file
        value: "/etc/origin/master/kmsplugin/kmsplugin-config.yaml"
      image: hyc-cloud-private-integration-docker-local.artifactory.swg-devops.com/ibmcom/kmsplugin-amd64:latest
      imagePullPolicy: IfNotPresent
      livenessProbe:
        failureThreshold: 3
        httpGet:
          path: "/healthz/liveness"
          port: 20358
          scheme: HTTP
        initialDelaySeconds: 120
        periodSeconds: 300
        successThreshold: 1
        timeoutSeconds: 1
      readinessProbe:
        failureThreshold: 3
        httpGet:
          path: "/healthz/readiness"
          port: 20358
          scheme: HTTP
        initialDelaySeconds: 5
        periodSeconds: 30
        successThreshold: 1
        timeoutSeconds: 1
      resources:
        requests:
          cpu: 5m
          memory: 10Mi
        limits:
          cpu: 12m
          memory: 15Mi
      volumeMounts:
      - name: kms-socket
        mountPath: "/etc/origin/master"
      - name: data
        mountPath: "/root/kmsplugin"
    volumes:
    - name: data
      hostPath:
        path: "/root/kmsplugin"
    - name: kms-socket
      hostPath:
        path: "/etc/origin/master"
  ```
  {: codeblock}
  
12. Copy the `kmsplugin.yaml` file to `/etc/origin/node/pods`.
  ```
  cp kmsplugin.yaml /etc/origin/node/pods
  ```
  {: codeblock}
  
13. Kubelet automatically starts the Docker container. If the container does not start, verify that the content in the `kmsplugin.yaml` is correct.

14. Restart the API server.
  ```
  /usr/local/bin/master-restart api
  /usr/local/bin/master-restart controllers
  ```
  {: codeblock}
  

## Verifying whether the KMS plug-in is enabled

Check the KMS plug-in container log. The log must have messages that indicate that the plug-in successfully started. Following is a sample log:

```
{"level":"info","ts":"Oct 29 22:55:01.615","msg":"signals.go:40: SIGTERM signal handler started.  Watching for SIGTERM signals."}
{"level":"info","ts":"Oct 29 22:55:01.847","msg":"server.go:140: The Provider server is started."}
```
{: pre}

## Verifying whether secrets are encrypted by using the KMS plug-in

Secrets are stored in etcd. You can use etcdctl to view secrets. For more information about etcdctl, see [etcdctl ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/etcd-io/etcd/tree/master/etcdctl).

Consider the example where you create a secret that is named `secret1` in the `default` namespace. When you enable the KMS plug-in is enabled, all new secrets are encrypted with the KMS plug-in.

1. Log on to the `etcd` pod.

2. Add an alias etcdctl3. {{site.data.keyword.product}} uses etcdctl API version 3.
  ```
  / # alias etcdctl3="ETCDCTL_API=3 etcdctl --endpoints https://<master node IP address>:4001 --cacert /etc/cfc/conf/etcd/ca.pem --cert /etc/cfc/conf/etcd/client.pem --key /etc/cfc/conf/etcd/client-key.pem"
  ```
  {: codeblock}

3. Run the following `etcdctl3` command to retrieve the secret. Direct the output to hex dump.
  ```
  / # etcdctl3 get /registry/secrets/default/secret1 |hexdump -C
  ```
  {: codeblock}

  Following is a sample output:
  ```
  00000000  2f 72 65 67 69 73 74 72  79 2f 73 65 63 72 65 74  |/registry/secret|
  00000010  73 2f 64 65 66 61 75 6c  74 2f 73 65 63 72 65 74  |s/default/secret|
  00000020  31 0a 6b 38 73 3a 65 6e  63 3a 6b 6d 73 3a 76 31  |1.k8s:enc:kms:v1|
  00000030  3a 4b 6d 73 50 6c 75 67  69 6e 3a 02 74 50 50 2b  |:KmsPlugin:.tPP+|
  00000040  42 41 77 45 42 42 6c 4e  6c 59 33 4a 6c 64 41 48  |BAwEBBlNlY3JldAH|
  00000050  2f 67 67 41 42 41 77 45  4a 53 33 42 57 5a 58 4a  |/ggABAwEJS3BWZXJ|
  00000060  7a 61 57 39 75 41 51 51  41 41 51 70 58 63 6d 46  |zaW9uAQQAAQpXcmF|
  00000070  77 63 47 56 6b 52 45 56  4c 41 51 6f 41 41 51 5a  |wcGVkREVLAQoAAQZ|
  00000080  44 61 58 42 6f 5a 58 49  42 44 41 41 41 41 50 34  |DaXBoZXIBDAAAAP4|
  00000090  42 6c 2f 2b 43 41 51 49  42 2f 67 45 30 5a 58 6c  |Bl/+CAQIB/gE0ZXl|
  000000a0  4b 61 6d 46 59 51 6d 39  61 57 45 6f 77 57 6c 68  |KamFYQm9aWEowWlh|
  000000b0  6f 4d 45 6c 71 62 32 6c  53 56 6b 5a 77 57 56 56  |oMElqb2lSVkZwWVV|
  000000c0  77 56 6c 64 74 65 48 42  4e 4d 32 52 78 54 31 68  |wVldteHBNM2RxT1h|
  000000d0  4b 62 46 6c 71 57 58 70  61 52 7a 52 33 55 57 78  |KbFlqWXpaRzR3UWx|
  000000e0  76 65 6d 4a 55 5a 46 4a  56 56 6b 70 51 57 6c 68  |vemJUZFJVVkpQWlh|
  000000f0  73 65 6d 46 58 5a 48 68  61 53 46 6b 30 56 44 4a  |semFXZHhaSFk0VDJ|
  00000100  30 52 55 78 36 55 6c 4e  68 52 56 70 68 59 6d 35  |0RUx6UlNhRVphYm5|
  00000110  4f 56 6c 52 45 61 45 64  4d 4d 47 78 43 56 57 30  |OVlREaEdMMGxCVW0|
  00000120  35 54 6c 4a 75 62 46 6c  4e 51 30 6c 7a 53 57 31  |5TlJubFlNQ0lzSW1|
  00000130  6f 61 47 4d 79 5a 32 6c  50 61 55 6c 35 56 57 74  |oaGMyZ2lPaUl5VWt|
  00000140  30 52 57 56 58 64 7a 46  4f 4d 55 70 57 54 54 46  |0RWVXdzFOMUpWTTF|
  00000150  53 55 6c 45 7a 57 6d 39  5a 62 56 4a 73 5a 46 64  |SUlEzWm9ZbVJsZFd|
  00000160  4a 64 6b 31 55 55 6a 5a  4d 4d 30 35 70 56 30 5a  |Jdk1UUjZMM05pV0Z|
  00000170  73 59 55 31 36 5a 46 5a  5a 56 56 4a 4a 56 57 31  |sYU16ZFZZVVJJVW1|
  00000180  4f 56 30 35 75 53 6c 56  68 61 7a 68 79 5a 44 42  |OV05uSlVhazhyZDB|
  00000190  47 57 46 5a 47 53 6e 46  58 56 6e 42 50 59 7a 4a  |GWFZGSnFXVnBPYzJ|
  000001a0  77 4d 56 5a 74 61 7a 56  53 4d 56 5a 68 5a 46 5a  |wMVZtazVSMVZhZFZ|
  000001b0  73 65 55 31 71 54 6e 5a  6b 57 46 59 30 55 6b 55  |seU1qTnZkWFY0UkU|
  000001c0  78 59 56 56 73 51 6d 78  4c 4d 55 5a 47 55 30 52  |xYVVsQmxLMUZGU0R|
  000001d0  43 63 56 46 55 4d 44 6c  4a 61 58 64 70 59 56 68  |CcVFUMDlJaXdpYVh|
  000001e0  5a 61 55 39 70 53 6b 4a  57 4d 6c 70 7a 5a 57 74  |ZaU9pSkJWMlpzZWt|
  000001f0  47 4d 6c 46 72 64 47 78  53 61 32 52 33 5a 47 70  |GMlFrdGxSa2R3ZGp|
  00000200  4f 61 56 6c 74 53 6c 4a  4e 62 55 35 43 55 46 51  |OaVltSlJNbU5CUFQ|
  00000210  77 61 55 78 44 53 6a 4a  61 57 45 70 36 59 56 63  |waUxDSjJaWEp6YVc|
  00000220  35 64 55 6c 71 62 32 6c  4e 61 54 52 33 54 47 70  |5dUlqb2lNaTR3TGp|
  00000230  42 61 57 5a 52 50 54 30  42 57 45 74 75 56 48 64  |BaWZRPT0BWEtuVHd|
  00000240  4c 59 6a 52 36 65 6e 55  77 4d 57 77 79 5a 54 42  |LYjR6enUwMWwyZTB|
  00000250  6d 4d 45 31 79 57 46 6c  77 54 6e 64 72 4e 55 68  |mME1yWFlwTndrNUh|
  00000260  36 56 57 74 42 4d 55 6c  4c 4e 30 68 33 57 54 52  |6VWtBMUlLN0h3WTR|
  00000270  59 55 46 46 44 57 6d 35  53 4e 6c 4e 56 4e 57 52  |YUFFDWm5SNlNVNWR|
  00000280  6a 65 6c 5a 31 54 46 56  57 4f 48 4a 6d 52 30 6c  |jelZ1TFVWOHJmR0l|
  00000290  31 55 30 52 6e 65 45 64  4c 4e 6d 5a 5a 62 45 74  |1U0RneEdLNmZZbEt|
  000002a0  6b 54 33 6c 4e 5a 58 46  47 5a 33 52 6e 50 54 30  |kT3lNZXFGZ3RnPT0|
  000002b0  41 e4 52 d5 5e 7f f2 f4  97 58 79 e5 3b 26 3a 97  |A.R.^....Xy.;&:.|
  000002c0  b0 bc 3b e8 1d 92 82 97  aa e5 89 5d ba 98 51 9a  |..;........]..Q.|
  000002d0  69 42 16 3b e7 56 7f 32  1b 89 a3 a4 7e 3e 03 7c  |iB.;.V.2....~>.||
  000002e0  59 7f b5 56 ca 2c 0d 84  66 ee c0 af d8 bd 24 e2  |Y..V.,..f.....$.|
  000002f0  fc 1e b6 f6 0b a8 8b c1  b6 ee 98 45 93 85 34 2b  |...........E..4+|
  00000300  1d 67 29 c5 4e dd e4 4f  92 59 29 cc 5d d7 6c c7  |.g).N..O.Y).].l.|
  00000310  24 ac 97 f2 36 36 47 30  f6 5f a1 4c 9e 99 13 46  |$...66G0._.L...F|
  00000320  c9 23 75 71 5f de b4 6e  5b 96 c8 44 f1 2b 4e 3e  |.#uq_..n[..D.+N>|
  00000330  80 48 cd eb 08 66 50 4d  86 a0 67 66 45 19 5f af  |.H...fPM..gfE._.|
  00000340  9f 0a                                             |..|
  ```
  {: pre}

To encrypt a secret that was added before you enabled the KMS plug-in, use the following update command. You must set up kubectl CLI to run this command. <!--See [Accessing your cluster from the Kubernetes CLI (kubectl)](../../manage_cluster/cfc_cli.md).-->

```
kubectl get secret <secret name> -n <name space> -o json |kubectl replace -f -
```
{: codeblock}

## KMS plug-in configuration parameters

Two files are used for configuring KMS plug-in encryption. The `/etc/cfc/conf/encryption-config.yaml` is used by the Kubernetes API server and the `/root/kmsplugin-config.yaml` is used by the KMS plug-in.

### Parameters in the encryption-config.yaml file

- `name`: Name of the KMS plug-in.
- `endpoint`: The UNIX socket endpoint. This value must match the one specified for the `UNIX_SOCKET_PATH` parameter in the `kmsplugin-config.yaml` file.
- `cachesize`: The number of secrets cached by the API server.

### Parameters in the kmsplugin-config.yaml file

#### SERVER_CONFIG section

- `REGION`: Name of the region.
- `NUM_LEN_BYTES`: Number of bytes to specify the DEK length. Do not change this value until you consult with the IBM support team.
- `CACHE_TIMEOUT_IN_HOURS`: Specify after how much time the cache times out. Specify an integer value. After the cache times out, all the wrapped DEK entries in the cache are cleaned up. Specify the number zero if you do not want to cache the DEKs.
- `RESTART_DELAY_IN_SECONDS`: Time to delay before the KMS plug-in service is restarted. Specify an integer value.
- `UNIX_SOCKET_PATH`: The gRPC UNIX socket path. This path must match the one that you specified in the `encryption-config.yaml`file. Do not change this value until you consult with the IBM support team.
- `TOKEN_URL`: The URL of the IAM token service. Do not change this value.
- `TOKEN_URL_CA_FILE`: The TLS certificate file that is used for secure communication with IAM token service. Do not change this value.
- `API_KEY`: The API key that is used for obtaining the access token. Specify the API key that you use.
- `HEALTHZ_PATH`: Path that is used to construct the health URL. Do not change this value.
- `HEALTHZ_PORT`: Port that is used to construct the health URL. Default value is 20358. This value must match the port value that is set in the `livenessProbe` and `readinessProble` sections of the `kmsplugin.json` file.
- `NEW_DEK`: Specify a Boolean value. A value of `true` indicates that a new DEK is used to encrypt each secret. A value of `false` indicates that a DEK is reused to encrypt each secret.
- `MAX_RETRIES`: The maximum number of connection retries if the KMS plug-in cannot connect with the KMS service.

#### KP_CONFIG section:

- `VERSION`: Default value is 1. Do not change this value.
- `CRK_ID` : The Customer Root Key ID. Add the CRK ID that you use.
- `URL`: The URL to the KMS API service. Do not change this value.
- `KP_CA_FILE`: The TLS certificate that is used for secure communication with the KMS API service. Do not change this value.
- `INSTANCE_ID`: The instance ID of the HSM. Add the HSM ID that you use.

#### LOGGER section:

- `LOG_LEVEL`: Set the log level at `info` or `debug`.
- `LOG_ALL_VALUES`: Specify a Boolean value. A value of `true` indicates that all values are logged. These logs might include sensitive information. If you do not want to include sensitive information in the logs, set the value to `false`.
