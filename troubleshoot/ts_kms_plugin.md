---

copyright:
  years: 2019
lastupdated: "2019-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Troubleshooting Key Management Service plug-in

Troubleshoot common Key Management Service plug-in issues.
{: shortdesc}

Install the Kubernetes CLI to run the troubleshooting commands. For more information, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

* [Failed to create a secret: API key could not be found](ts_kms_plugin.md#api)
* [Failed to create a secret: the connection is unavailable](ts_kms_plugin.md#connection)
* [Failed to create a secret: Request requires valid Instance Header containing a valid UUID](ts_kms_plugin.md#uuid)
* [Failed to create a secret: Client.Timeout exceeded while awaiting headers](ts_kms_plugin.md#timeout)

## Failed to create a secret: API key could not be found
{: #api}

### Symptom

Failed to create a secret by using the CLI or the {{site.data.keyword.gui}}. You see the error `Error from server (InternalError): Internal error occurred: rpc error: code = Unknown desc = BXNIM0415E:Provided API key could not be found`.

### Cause

The API key that you provided is not correct. 

### Solution

1. Specify the correct `API_Key` in the `/etc/cfc/conf/kmsplugin-config.yaml` file. 
2. Restart the KMS plug-in container after you update the file. You can restart the KMS plug-in container by deleting the existing KMS plug-in pod.
  ```
  kubectl delete pods k8s_kmsplugin-<master_node_IP_address>
  ```
  {: codeblock}

## Failed to create a secret: the connection is unavailable
{: #connection}

### Symptom
{: #symptom_connection}

Failed to create a secret by using the CLI or the {{site.data.keyword.gui}}. You see the error `Internal error occurred: rpc error: code = Unavailable desc = grpc: the connection is unavailable`.

### Cause
{: #cause_connection}

The Customer Root Key ID is not correct.

### Solution
{: #solution_connection}

1. Correct the `CRK_ID` in the `/etc/cfc/conf/kmsplugin-config.yaml` file. 
2. Restart the KMS plug-in container after you update the file. You can restart the KMS plug-in container by deleting the existing KMS plug-in pod.
  ```
  kubectl delete pods k8s_kmsplugin-<master_node_IP_address>
  ```
  {: codeblock}


## Failed to create a secret: Request requires valid Instance Header containing a valid UUID
{: #uuid}

### Symptom
{: #symptom_uuid}

Failed to create a secret by using the CLI or the {{site.data.keyword.gui}}. You see the error `Internal error occurred: rpc error: code = Unknown desc = Bad Request: Request requires valid Instance Header containing a valid UUID`.

### Cause
{: #cause_uuid}

The Key Management Service instance ID is not correct.

### Solution
{: #solution_uuid}

1. Correct the `INSTANCE_ID` in the `/etc/cfc/conf/kmsplugin-config.yaml` file.
2. Restart the KMS plug-in container after you update the file. You can restart the KMS plug-in container by deleting the existing KMS plug-in pod.
  ```
  kubectl delete pods k8s_kmsplugin-<master_node_IP_address>
  ```
  {: codeblock}


## Failed to create a secret: Client.Timeout exceeded while awaiting headers
{: #timeout}

### Symptom
{: #symptom_timeout}

Failed to create a secret by using the CLI or the {{site.data.keyword.gui}}. You see the error `Error from server (InternalError): Internal error occurred: rpc error: code = Unknown desc = Post https://kms-api.kube-system:28674/api/v2/keys/3ecbc3be-3534-41cd-9898-a224134fbb55?action=wrap: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)`.

### Cause
{: #cause_timeout}

The Key Management Service did not respond.

### Solution
{: #solution_timeout}

1. Log in to the {{site.data.keyword.gui}}.
2. From the navigation menu, select **Workloads** > **Deployments**.
3. Select `key-management-api`.
4. Scroll down to Pods. 
5. Place the cursor over the only row listed under **Pods**. 
6. Click **...** > **Remove** to remove the pod and to create a new pod.



