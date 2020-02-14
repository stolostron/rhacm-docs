---

copyright:
  years: 2016, 2019
lastupdated: "2019-12-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Reconfiguring Kubelet in a live cluster
 
Dynamic Kubelet configuration is available as Beta in Kubernetes 1.11. 
{: shortdesc}

You can use this feature in {{site.data.keyword.icp}} to change the configuration of each Kubelet in a live Kubernetes cluster. To do so, you deploy a ConfigMap and configure each Node to use the ConfigMap.

For more information, see [Reconfigure a Node's Kubelet in a Live Cluster ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/tasks/administer-cluster/reconfigure-kubelet/). Make sure that you read the warnings.

Follow these steps to reconfigure Kubelet on a live node in your cluster:

  **Note:** In {{site.data.keyword.icp_notm}}, the `--dynamic-config-dir` is set to `/etc/cfc/kubelet/kubelet-dynamic-config` by default.

1. [Generate a file with the current configuration](reconfig_kubelet.md#gen)
2. [Edit the configuration file](reconfig_kubelet.md#edit)
3. [Push the configuration file to the control plane](reconfig_kubelet.md#push)
4. [Set the node to use the new configuration](reconfig_kubelet.md#set)
5. [Verify the updates](reconfig_kubelet.md#verify)

Before you begin, ensure that kubectl CLI is set up. For more information, see [Accessing your cluster from the Kubernetes CLI (kubectl)](../manage_cluster/cfc_cli.md).

## Generate a file with the current configuration
{: #gen}

Generate a configuration file that contains a node’s current configuration. Pick one of the following two ways: 

* Use the `/etc/cfc/kubelet/kubelet-service-config` file to create the first Kubelet ConfigMap. 

* Access the Kubelet server’s `configz` endpoint through the kubectl proxy. For more information, see [Generate the configuration file ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/tasks/administer-cluster/reconfigure-kubelet/#generate-the-configuration-file) for more information.

The `/etc/cfc/kubelet/kubelet-service-config` file is used in following sections to update the Kubelet configuration.
 
## Edit the configuration file
{: #edit}

Complete these steps to edit the configuration file:

1. Copy `/etc/cfc/kubelet/kubelet-service-config` to `./kubelet-dynamic-config`.
   ```
   cp /etc/cfc/kubelet/kubelet-service-config ./kubelet-dynamic-config
   ```
   {: codeblock}

2. Edit the `./kubelet-dynamic-config` file as required. For example, you can add resource reservations by updating the following configuration settings:
  
   ```
   systemReserved:
     cpu: "500m"
     memory: "1500Mi"
     ephemeral-storage: "1Gi"
   kubeReserved:
     cpu: "500m"
     memory: "1500Mi"
     ephemeral-storage: "1Gi"
   ```
   {: codeblock}
   
For a list of available parameters, see the *KubeletConfiguration contains the configuration for the Kubelet* section of the [Kubernetes sample file ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/kubernetes/kubernetes/blob/release-1.11/pkg/kubelet/apis/kubeletconfig/v1beta1/types.go).

## Push the configuration file to the control plane
{: #push}

Create the ConfigMap by pushing the configuration file to the control plane. 

```
kubectl -n kube-system create configmap my-node-config --from-file=kubelet=kubelet-dynamic-config --append-hash -o yaml
```
{: codeblock}

The output resembles the following code:

```
apiVersion: v1
data:
  kubelet: |
    {...}
kind: ConfigMap
metadata:
  creationTimestamp: 2017-09-14T20:23:33Z
  name: my-node-config-gkt4c2m4b2
  namespace: kube-system
  resourceVersion: "119980"
  selfLink: /api/v1/namespaces/kube-system/configmaps/my-node-config-gkt4c2m4b2
  uid: 946d785e-998a-11e7-a8dd-42010a800006
```
{: pre}

The ConfigMap is created in the `kube-system` namespace. The `--append-hash` option appends a short checksum of the ConfigMap contents to the name.

## Set the node to use the new configuration
{: #set}

Store the node name or IP address, and the ConfigMap name to two variables. See the following example commands:

  ```
  NODE_NAME=10.10.25.11
  ```
  {: codeblock}

  ```
  CONFIG_MAP_NAME=my-node-config-gkt4c2m4b2
  ```
  {: codeblock}
 
Run the following command to update the configuration of the node:
 
```
kubectl patch node ${NODE_NAME} -p "{\"spec\":{\"configSource\":{\"configMap\":{\"name\":\"${CONFIG_MAP_NAME}\",\"namespace\":\"kube-system\",\"kubeletConfigKey\":\"kubelet\"}}}}"
```
{: codeblock}

**Note:** You can write a script to update the configuration of multiple nodes.
 
## Verify the updates
{: #verify}

Retrieve the node information and check `Node.Status.Config`:

```
kubectl get node ${NODE_NAME} -o yaml
```
{: codeblock}

For more information, see [Observe that the Node begins using the new configuration![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/tasks/administer-cluster/reconfigure-kubelet/#observe-that-the-node-begins-using-the-new-configuration).

## Revert to the local default configuration

Reset the node to use the default configuration.

1. Edit the node:

   ```
   kubectl edit node ${NODE_NAME}
   ```
   {: codeblock}

2. Remove the `Node.Spec.ConfigSource` field. For example, remove all of the following lines.
   ```
    configSource:
        configMap:
            name: CONFIG_MAP_NAME
            namespace: kube-system
            kubeletConfigKey: kubelet
   ```
   {: codeblock} 

3. Verify the update.
   ```
   kubectl get node ${NODE_NAME} -o yaml
   ```
   {: codeblock}

The `Node.Status.Config` is empty because you reset all the configuration sources to `nil` when you removed the `Node.Spec.ConfigSource` field. The local default configuration is now the `assigned`, `active`, and `lastKnownGood` configuration.
