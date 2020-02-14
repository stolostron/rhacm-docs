---

copyright:
  years: 2016, 2018
lastupdated: "2018-10-26"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating a deployment with attached GPU resources

Learn how to create a container with attached GPU resources.
{:shortdesc}

* For an overview of Nvidia GPU support in {{site.data.keyword.icp}}, see [Nvidia GPU support](../manage_resources/gpu_support.md).

* Ensure that GPU drivers are installed on worker nodes. You can use the `kubectl describe nodes` command to indicate that `nvidia.com/gpu` is using a GPU resource.

{{site.data.keyword.icp_notm}} offers built-in GPU support for the images in the [nvidia-docker ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/NVIDIA/nvidia-docker){: new_window} project. To specify GPU resources, your deployments must specify images from the `nvidia-docker` project.

* For {{site.data.keyword.ppc}} nodes, use the images in the [nvidia/cuda-ppc64le ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://hub.docker.com/r/nvidia/cuda-ppc64le){: new_window} Docker Hub repository or images that you derive from contents.
* For {{site.data.keyword.linux}} nodes, use the images in the [nvidia/cuda ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://hub.docker.com/r/nvidia/cuda/){: new_window} Docker Hub repository or images that you derive from contents.

Two formats are available for you to create a deployment from the {{site.data.keyword.gui}}.

You can create deployments either by entering the parameter values in the Create Deployment window or by pasting a YAML file into the "Create resource" window.

**Required user type or access level**: Cluster administrator or team administrator

Before you begin, ensure that the nodes are ready for deployment. For more information, see [Configuring a GPU worker node](../manage_cluster/verify_gpu.md).

### Known issues and limitations

{{site.data.keyword.zsys}} (s390x) node does not support GPU.

If you run {{site.data.keyword.icp_notm}} in a mixed environment that has {{site.data.keyword.linux}} (x86_64), {{site.data.keyword.ppc}}, and {{site.data.keyword.zsys}}(s390x) nodes, `nvidia-device-plugin DaemonSet` only runs on {{site.data.keyword.linux}} (x86_64) and {{site.data.keyword.ppc}} cluster nodes.

## Creating a deployment with GPU resources attached by using the Create Deployment window

  1. From the navigation menu, click **Workloads** > **Deployments** > **Create Deployment**.
  2. From the **Container settings** tab, specify the number of GPU requested for the deployment. Ensure that this value is a positive integer.
  3. Enter all the other parameters options that are needed for your deployment.
  4. Click **Create**.

## Creating a deployment by using the "Create resource" window

1. Create a `gpu-demo.yaml` file. This sample `gpu-demo.yaml` file creates a container deployment with a single attached GPU resource.

    This sample deployment uses the `nvidia/cuda:7.5-runtime` image, which is a `nvidia-docker` image for {{site.data.keyword.linux}} systems. You can obtain this image from the [nvidia/cuda ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://hub.docker.com/r/nvidia/cuda/){: new_window} Docker Hub repository. For Power Systems, use one of the `nvidia/cuda-ppc64le` images that are available in the [nvidia/cuda-ppc64le ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://hub.docker.com/r/nvidia/cuda-ppc64le){: new_window} Docker Hub repository.

  ```
  apiVersion: apps/v1beta2
  kind: Deployment
  metadata:
    name: gpu-demo
  spec:
    replicas: 1
    selector:
      matchLabels:
        run: gpu-demo
    template:
      metadata:
        labels:
          run: gpu-demo
      spec:
        containers:
        - name: gpu-demo
          image: nvidia/cuda:7.5-runtime
          command:
          - "/bin/sh"
          - "-c"
          args:
          - nvidia-smi && tail -f /dev/null
          resources:
            limits:
              nvidia.com/gpu: 1
   ```
   {: codeblock}


2. From the dashboard, click **Create resource**.
3. Copy and paste the `gpu-demo.yaml` file into the "Create resource" dialog box.
4. Click **Create**.

## Check whether the GPU resource is detected inside the container

1. Install the `kubectl` command line interface. See [Accessing your cluster from the Kubernetes CLI (kubectl)](../manage_cluster/cfc_cli.md).

2. To view a list of running containers, run this command:
  ```
  kubectl get pods
  ```
  {: codeblock}

  From the returned output, you can locate the `gpu-demo` deployment.
2. Access the logs for the `gpu-demo` deployment. For example,
  ```
  kubectl logs gpu-demo-3638364752-zkqel
  ```
  {: codeblock}

  The output resembles the following code:
  ```
  Tue Feb  7 08:38:11 2017
  +------------------------------------------------------+
  | NVIDIA-SMI 352.63     Driver Version: 352.63         |
  |-------------------------------+----------------------+----------------------+
  | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
  | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
  |===============================+======================+======================|
  |   0  GeForce GT 730      Off  | 0000:01:00.0     N/A |                  N/A |
  | 36%   41C    P8    N/A /  N/A |      4MiB /  1023MiB |     N/A      Default |
  +-------------------------------+----------------------+----------------------+

  +-----------------------------------------------------------------------------+
  | Processes:                                                       GPU Memory |
  |  GPU       PID  Type  Process name                               Usage      |
  |=============================================================================|
  |    0                  Not Supported                                         |
  +-----------------------------------------------------------------------------+
  ```
  {: pre}

After the deployment completes, a new deployment is displayed on the Deployments page. The **DESIRED**, **CURRENT**, **READY**, and **AVAILABLE** columns all display the same value, which is the number of pods or replica that you specified during the deployment.

Click the deployment name to view detailed information about the deployment. Review the deployment properties and ensure that they are accurate.

To access your deployment from the Internet, you must expose your deployment as a service. See [Creating services](expose_app.md).
