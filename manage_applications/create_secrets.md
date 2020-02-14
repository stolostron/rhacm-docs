---

copyright:
  years: 2016, 2019
lastupdated: "2019-05-28"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Managing Secrets

Use Secrets to store confidential configuration settings such as passwords and API keys.
{:shortdesc}

You can use Secrets to store confidential information that can be used by multiple containers or deployments. Secrets can be referenced by containers or deployments that are running in the same namespace only.

For more information about Secrets, see [Kubernetes Secrets ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/configuration/secret/){: new_window}.

To view a list of all Secrets in the cluster, from the navigation menu, click **Configuration** > **Secrets**. From this view, you can also filter Secrets by their namespace .

**Required user type or access level**: Cluster administrator or team administrator

* [Creating Secrets](#create)
  * [Creating Secrets from the command line](#cli)
  * [Creating Secrets from the {{site.data.keyword.gui}}](#gui)
* [Updating a Secret from the {{site.data.keyword.gui}}](#update)
* [Encrypting Secrets](#encrypt)

## Creating Secrets
{: #create}

### Creating Secrets from the command line
{: #cli}

1. Set up the `kubectl` CLI. See [Accessing your cluster from the Kubernetes CLI (kubectl)](../manage_cluster/cfc_cli.md).

2. Switch to the namespace that you want to create the Secret in.
    ```
    kubectl config set-context <cluster_name>-context --user=<user_name> --namespace=<namespace_name>
    ```
    {: codeblock}

   Where, `<cluster_name>` is the name of your cluster as defined in [Cluster configuration ConfigMap](../manage_cluster/configmap_cluster.md).

3. Run the `kubectl` command for the type of Secret that you want to create.
    * To create Secrets for use with a Docker registry (Dockercfg secrets), use the `kubectl create secret docker-registry` command from the command line. See [Creating imagePullSecrets for a specific namespace](../manage_images/imagepullsecret.md) and the [kubectl create secret docker-registry command ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-secret-docker-registry-em-){: new_window}.
    * To create Secrets from a local file or directory, use the `kubectl create secret generic` command from the command line. See the [kubectl create secret generic command ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-secret-generic-em-){: new_window}.
    * To create Secrets from public/private key pairs, use the `kubectl create secret tls` command from the command line. See the [kubectl create secret tls command ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-secret-tls-em-){: new_window}.

### Creating Secrets from the {{site.data.keyword.gui}}
{: #gui}

You can use the {{site.data.keyword.icp}} {{site.data.keyword.gui}} to create Secrets from literal values. These values must be base64 encoded.

1. From the command line, encode your data values in `base64`. You must use the `-n` option to ensure that trailing new line characters `(\n)` are not appended to the string.
    ```
    echo -n "admin" | base64
    ```
    {: codeblock}

    The output resembles the following code:
    ```
    YWRtaW4=
    ```
    {: pre}

2. From the navigation menu, click **Configuration** > **Secrets**.
3. From the namespace drop-down menu, select a namespace. If a namespace is not selected, the Secret is created in the `default` namespace.
4. Click **Create Secret**.
4. Provide the details for your Secret.
   * From the **General** tab, provide a name and type for your Secret. If a type is not specified, a default type **Opaque** is assigned.
   * From the **Data** tab, enter the configuration details for your Secret as key-value pairs. Values must be encoded in base64.
5. Click **Create**.

## Updating a Secret from the {{site.data.keyword.gui}}
{: #update}

You can update secrets that are created from either the command line or the {{site.data.keyword.gui}}.

1. From the navigation menu, click **Configuration** > **Secrets**.
2. For the Secret that you want to modify, select **Action** > **Edit**. The Secret's JSON file is displayed.
3. Update the properties.
4. Click **Submit**. The Secret updates.

## Encrypting Secrets
{: #encrypt}

Before you begin, ensure that the following tasks are completed:

* Your {{site.data.keyword.icp}} cluster must be ready.
* You must set up kubectl CLI. See [Accessing your cluster from the Kubernetes CLI (kubectl)](../manage_cluster/cfc_cli.md).

### Configuring encryption

Run these commands on a master node in your cluster.

1. Generate a 32-byte random key and encode it in `base64`. Run the following command:
  ```
  head -c 32 /dev/urandom | base64
  ```
  {: codeblock}

  Your output might resemble the following content:
  ```
  7WU+F6l4JQwgiGO99CAJwHanlb2pPxwfyZpcnsPhp8k=
  ```
  {: pre}

2. Create a configuration file `encryption-config.yaml` and place it in the `/etc/cfc/conf/` folder. Use the `base64` encoded key that you generated in the previous step as the `secret`:
  ```
  kind: EncryptionConfiguration
  apiVersion: v1
  resources:
    - resources:
      - secrets
      providers:
      - aescbc:
          keys:
          - name: key1
            secret: <base64-encoded Secret>
      - identity: {}
  ```
  {: codeblock}

  Following is an example configuration file:
  ```
  kind: EncryptionConfiguration
  apiVersion: apiserver.config.k8s.io/v1
  resources:
    - resources:
      - secrets
      providers:
      - aescbc:
          keys:
          - name: key1
            secret: <base64-encoded Secret>
      - identity: {}
  ```
  {: pre}

3. In a high availability (HA) cluster, copy the `/etc/cfc/conf/encryption-config.yaml` file to all the other master nodes under the same directory.

4. On all master nodes, set the `--encryption-provider-config` flag in `/etc/cfc/pods/master.json` on the `kube-apiserver` to point to the location of the configuration file.

   1. Back up the manifest file before you edit it.

     ```
     cp /etc/cfc/pods/master.json ~/master.json.bak
     ```
     {: codeblock}

   2. Copy the `/etc/cfc/pods/master.json` file to another location.
     **Note:** Kubelet does not support editing a static pod manifest file by using an editor. To change the file content, you can copy and overwrite the file.
     ```
     cp /etc/cfc/pods/master.json /tmp
     ```
     {: codeblock}

   3. Edit the `master.json` file to add `--experimental-encryption-provider-config` option for kube-apiserver.
     ```
     "name": "apiserver",
             "image": "ibm1.mixhub.cn:8500/ibmcom/hyperkube:v1.11.1-ee",
             "imagePullPolicy": "IfNotPresent",
             "command": [
                    ......
                    "--experimental-encryption-provider-config=/etc/cfc/conf/encryption-config.yaml"
              ]
     ```
     {: codeblock}

   4. Overwrite the original static pod manifest file that is in the `/etc/cfc/pods/` directory.
     ```
     cp /tmp/master.json /etc/cfc/pods/
     ```
     {: codeblock}

5. Wait for the `apiserver` to restart.
  ```
  docker ps | grep apiserver
  ```
  {: codeblock}

  Your output might resemble the following content:
  ```
  ef72af905d72     20df5d4fd446            "/hyperkube apiserve…"   About an hour ago   Up 27 minutes    \
            k8s_apiserver_k8s-master-172.29.215.1_kube-system_09a7e75fbf8bcfa2cc56478897bf8898_0
  ```
  {: pre}

### Identifying the data that needs to be encrypted

Before you encrypt the secrets, check the kind of secret data that is stored in `etcd`. For example, check the `platform-auth-idp-credentials` secret as shown in the following step:

```
kubectl -n kube-system get secret platform-auth-idp-credentials -o yaml
```
{: codeblock}

Your output might resemble the following content:
```
apiVersion: v1
data:
  admin_password: YWRtaW4=
  admin_username: YWRtaW4=
kind: Secret
metadata:
  creationTimestamp: 2018-09-21T08:06:07Z
  name: platform-auth-idp-credentials
  namespace: kube-system
  resourceVersion: "18766"
  selfLink: /api/v1/namespaces/kube-system/secrets/platform-auth-idp-credentials
  uid: 31a7a864-bd75-11e8-831a-005056a2e128
type: Opaque

# echo YWRtaW4= | base64 -d
admin
```
{: pre}


Use the following `etcdctl` CLI commands to read the secret out of `etcd`.

1. Get the etcd container ID.
  ```
  docker ps | grep k8s_etcd_k8s-etcd
  ```
  {: codeblock}

  The output resembles the following content:
  ```
  1648a7f65373        e21fb69683f3                           "etcd --name=etcd0 -…"   4 days ago          Up 4 days                               k8s_etcd_k8s-etcd-172.29.215.1_kube-system_103986e50c5d7b82c6532bfe18dd9979_0
  ```
  {: pre}

2. Copy the etcd container to another location.
  ```
  docker cp 1648a7f65373:/usr/local/bin/etcdctl /usr/local/bin/
  ```
  {: codeblock}

3. Create an alias to connect with etcd. `endpoint` is the IP address of your master node.
  ```
  alias etcdctl3="ETCDCTL_API=3 etcdctl --endpoints=$(endpoint):4001 --cacert=/etc/cfc/conf/etcd/ca.pem --cert=/etc/cfc/conf/etcd/client.pem --key=/etc/cfc/conf/etcd/client-key.pem"
  ```
  {: codeblock}

4. Read the secret out of etcd.
  ```
  etcdctl3 get -w fields /registry/secrets/kube-system/platform-auth-idp-credentials
  ```
  {: codeblock}

  The output resembles the following content:
  ```
  "ClusterID" : 16723368499499280303
  "MemberID" : 15696589318412288662
  "Revision" : 858101
  "RaftTerm" : 5
  "Key" : "/registry/secrets/kube-system/platform-auth-idp-credentials"
  "CreateRevision" : 4595
  "ModRevision" : 850330
  "Version" : 7
  "Value" : "k8s\x00\n\f\n\x02v1\x12\x06Secret\x12\xa4\x01\nf\n\x1dplatform-auth-idp-credentials\x12\x00\x1a\vkube-system\"\x00*$31a7a864-bd75-11e8-831a-005056a2e1282\x008\x00B\b\b\xef̒\xdd\x05\x10\x00z\x00\x12\x18\n\x0eadmin_password\x12\x06admin\x12\x18\n\x0eadmin_username\x12\x06admin\x1a\x06Opaque\x1a\x00\"\x00"
  "Lease" : 0
  "More" : false
  "Count" : 1
  ```
  {: pre}

The command output indicates that the default admin user name and password are stored as plain text.

### Encrypting all secrets

Secrets are encrypted on a write operation. Therefore, when you update a secret, the secret is encrypted.

1. Before you encrypt, back up all secrets to a file.
  ```
  kubectl get secrets --all-namespaces -o json > mysecrets.json
  ```
  {: codeblock}

2. Encrypt all secrets that are in the etcd store.
  ```
  kubectl get secrets --all-namespaces -o json | kubectl replace -f -
  ```
  {: codeblock}

### Verifying that data is encrypted

Read the secret from etcd to verify that the secret is encrypted.
```
etcdctl3 get -w fields /registry/secrets/kube-system/platform-auth-idp-credentials
```
{: codeblock}

The output resembles the following content:
```
"ClusterID" : 16723368499499280303
"MemberID" : 15696589318412288662
"Revision" : 858394
"RaftTerm" : 5
"Key" : "/registry/secrets/kube-system/platform-auth-idp-credentials"
"CreateRevision" : 4595
"ModRevision" : 858338
"Version" : 8
"Value" : "k8s:enc:aescbc:v1:key1:籝\x1f\xcb\x02Oz\xcdv\xfb\x13=\xab\xaf̏\xa9翖\xe5\xda\xf5u\xc3PY\x9f\x0es\x9cO\xfc\x1d\x8a\x821TLfe\xf5\x87{z\x99\x98\x0ex\xa7\xb5\"H\xc7N\xe8\xb1\x1cq\x82\xd7\x17\xc4\xcaь<[\x9d\xef]n\x0f{\x87\x10\xd4%\xe7\x8eMm܅\x9eIf\xa9\x19\xb1\x9c\xd2(X8\xf7,\xacF~\xa5A\xee\xed5scto\r\xf7\xde\x01'\xc4E\x97\x16ζak\xba\\\x1c$\x06\x9d\x0f\n\xddkQ}-\xecd\x1cKڝ\x8ca_\xa5\x9f$\xff\xd9P\xdbb@\x10\xd2\xe5\x02\xf9\xeeVj\x19j\xc0\x02-X\xbe\x84\x05;\xad\xe9\xb9\x17\x92(\xfe\x047\xa99\U000fa669L\xe0\xdc\xc3\xd35\xd1;i\xcc>\x15\x94(\xe6\xb4=>X\x03\xc7"
"Lease" : 0
"More" : false
"Count" : 1
```
{: pre}

The command output indicates that the default admin user name and password are now encrypted.

### Rotating a decryption key

You can change the secret without incurring a downtime in your cluster.

1. Generate a new key
  - For {{site.data.keyword.linux}} and macOS, run the following command:
    ```
    head -c 32 /dev/urandom | base64
    ```
    {: codeblock}

    Your output might resemble the following content:
    ```
    qM4BeDF2CcpNJqTIOzGwkqPaeWm5XgLt6FQJM0KF4ao=
    ```
    {: pre}

2.  Add the key as a second key entry in your encryption configuration file that is located in the `/etc/cfc/conf/` folder. Add the same second key on all master nodes.

  ```
  kind: EncryptionConfig
  apiVersion: v1
  resources:
    - resources:
      - secrets
      providers:
      - aescbc:
          keys:
          - name: key1
            secret: 7WU+F6l4JQwgiGO99CAJwHanlb2pPxwfyZpcnsPhp8k=
          - name: key2
            secret: qM4BeDF2CcpNJqTIOzGwkqPaeWm5XgLt6FQJM0KF4ao=
      - identity: {}
  ```
  {: codeblock}

3. On all master nodes, restart the `kube-apiserver` process to ensure that each master node can decrypt by using the new key.
  ```
  docker stop $(docker ps | grep k8s_apiserver_k8s-master | gawk '{print $1}')
  ```
  {: codeblock}

4. Make the new key as the first entry in the keys array so that it is used for encryption.
  ```
  kind: EncryptionConfig
  apiVersion: v1
  resources:
    - resources:
      - secrets
      providers:
      - aescbc:
          keys:
          - name: key2
            secret: qM4BeDF2CcpNJqTIOzGwkqPaeWm5XgLt6FQJM0KF4ao=
          - name: key1
            secret: 7WU+F6l4JQwgiGO99CAJwHanlb2pPxwfyZpcnsPhp8k=
      - identity: {}
  ```
  {: codeblock}

5. On all master nodes, restart the `kube-apiserver` process to ensure that each master node now encrypts by using the new key.
  ```
  docker stop $(docker ps | grep k8s_apiserver_k8s-master | gawk '{print $1}')
  ```
  {: codeblock}

6. Encrypt all existing secrets with the new key.
  ```
  kubectl get secrets --all-namespaces -o json | kubectl replace -f -
  ```
  {: codeblock}

7. Read the new encrypted secrets from etcd.
  ```
  etcdctl3 get -w fields /registry/secrets/kube-system/platform-auth-idp-credentials
  ```
  {: codeblock}

  The output resembles the following code:
  ```
  "ClusterID" : 16723368499499280303
  "MemberID" : 15696589318412288662
  "Revision" : 861046
  "RaftTerm" : 5
  "Key" : "/registry/secrets/kube-system/platform-auth-idp-credentials"
  "CreateRevision" : 4595
  "ModRevision" : 860965
  "Version" : 9
  "Value" : "k8s:enc:aescbc:v1:key2:\x15=M\x99y~\x14\x8ee\x82\x85\xf0\x8d}N\x81\xac\xa8b'\xe6\xb7\xcd\xeb\xea\x93;\xaf\x0e\xafV\x16\xf3'G\x10/U\x905\xd0@Z\xe8f\r3\xe0ɥ|\"\x11\xb4\b\x1e\x9b|h\f\x02+\xdd\xe6\xa0/\xc0\x12>\x8a\x8f\xa1\x8ac\x8c\xb0\xf0\x18\xc31\ns\xf9+\xbbv\xd5d\xae\x8c\x99z)\x04\xdb'\xab\u07b8ͧ\xcd&!\x0fZ;\x8c\xdc\xd0p\x95LQSz'A\x04n\xbdZ\x84\xb1D\xda\a\x86\xa1\xe7\x064\x1c@\x1d\bt\xa6\x97\x0e*\x03\x0e/Vq\x18\x9e\x85\x83\xcaQ\xe6̌\x86\x823F\x96 \xe5z\x89Ԃ\xad5\xe7\x9b\xe1*\xedֱ(\x84b\xb8WSa\xe0ռ\x90\xd3\xdc\x142s\xdb\xce[BE\xb9\xe9\\\xe8\xe0\xb2_\x89@,\xb8j"
  "Lease" : 0
  "More" : false
  "Count" : 1
  ```
  {: pre}

  The output indicates that the secret was encrypted by using the new key `k8s:enc:aescbc:v1:key2`.

8. Verify that the secret can be decrypted by using the new key.
  1. Get the encrypted data.
    ```
    kubectl -n kube-system get secret platform-auth-idp-credentials -o yaml
    ```
    {: codeblock}

      The output resembles the following code:
      ```
      apiVersion: v1
      data:
        admin_password: YWRtaW4=
        admin_username: YWRtaW4=
      kind: Secret
      metadata:
        creationTimestamp: 2018-09-21T08:06:07Z
        name: platform-auth-idp-credentials
        namespace: kube-system
        resourceVersion: "18766"
        selfLink: /api/v1/namespaces/kube-system/secrets/platform-auth-idp-credentials
        uid: 31a7a864-bd75-11e8-831a-005056a2e128
      type: Opaque
      ```
      {: pre}

  2. Decrypt the data.  
    ```
    echo YWRtaW4= | base64 -d
    ```
    {: codeblock}

    Following is a sample output:
    ```
    admin
    ```
    {: pre}

    The output indicates that the secret can be decrypted.

9. Remove the old decryption key from the configuration file. Complete this step only after you back up etcd and update all secrets.
  ```
  kind: EncryptionConfig
  apiVersion: v1
  resources:
    - resources:
      - secrets
      providers:
      - aescbc:
          keys:
          - name: key2
            secret: qM4BeDF2CcpNJqTIOzGwkqPaeWm5XgLt6FQJM0KF4ao=
      - identity: {}
  ```
  {: codeblock}

### Decrypting all data

To disable encryption, update the configuration file `encryption-config.yaml` that is in the `/etc/cfc/conf/` folder.

1. Place the identity provider as the first entry in the configuration file.
  ```
  kind: EncryptionConfig
  apiVersion: v1
  resources:
    - resources:
      - secrets
      providers:
      - identity: {}
      - aescbc:
          keys:
          - name: key2
            secret: qM4BeDF2CcpNJqTIOzGwkqPaeWm5XgLt6FQJM0KF4ao=
  ```
  {: codeblock}

2. On all master nodes, restart the `kube-apiserver` process.
  ```
  docker stop $(docker ps | grep k8s_apiserver_k8s-master | gawk '{print $1}')
  ```
  {: codeblock}

3. Force all secrets to be decrypted.
  ```
  kubectl get secrets --all-namespaces -o json | kubectl replace -f -
  ```
  {: codeblock}

4. Verify that the secrets were decrypted.
  ```
  etcdctl3 get -w fields /registry/secrets/kube-system/platform-auth-idp-credentials
  ```
  {: codeblock}

  The output resembles the following code:
  ```
  "ClusterID" : 16723368499499280303
  "MemberID" : 15696589318412288662
  "Revision" : 862012
  "RaftTerm" : 5
  "Key" : "/registry/secrets/kube-system/platform-auth-idp-credentials"
  "CreateRevision" : 4595
  "ModRevision" : 861920
  "Version" : 10
  "Value" : "k8s\x00\n\f\n\x02v1\x12\x06Secret\x12\xa4\x01\nf\n\x1dplatform-auth-idp-credentials\x12\x00\x1a\vkube-system\"\x00*$31a7a864-bd75-11e8-831a-005056a2e1282\x008\x00B\b\b\xef̒\xdd\x05\x10\x00z\x00\x12\x18\n\x0eadmin_password\x12\x06admin\x12\x18\n\x0eadmin_username\x12\x06admin\x1a\x06Opaque\x1a\x00\"\x00"
  "Lease" : 0
  "More" : false
  "Count" : 1
  ```
  {: pre}

  The command output indicates that the default admin user name and password are stored as plain text.
