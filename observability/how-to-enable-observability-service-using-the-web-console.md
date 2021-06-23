# Enable observability service using the web console

## Prerequisites

- You must install Red Hat Advanced Cluster Management for Kubernetes.
- You must configure an object store to create a storage solution. Red Hat Advanced Cluster Management only supports cloud providers with stable object stores, such as Amazon S3 (or other S3 compatible object stores like Ceph), Google Cloud Storage, Azure Storage, and OpenShift Container Storage.
  
## Enabling observability

Complete the following steps to enable the observability service using the web console:

1. Log in to your Red Hat Advanced Cluster Management hub cluster console, create the `Project`:

   - Navigate to `Home -> Projects`:

    <p align="center">
        <img src="./images/project-page.png" alt="Project page" width="1600" height="300" />
    </p>

   - Click `Create Project` and enter your project name `open-cluster-management-observability`. Click `Create`:

    <p align="center">
        <img src="./images/create-project.png" alt="Create project" width="600" height="400" />
    </p>

    You must use `open-cluster-management-observability` as the project name. Observability service does not support installation to other projects.

2. Create your image pull secret `multiclusterhub-operator-pull-secret` in `open-cluster-management-observability` project:

   - Navigate to `Workloads -> Secrets`. Click `Create -> Image Pull Secret`:

    <p align="center">
        <img src="./images/secret-page-for-img-pull.png" alt="image pull secret page" width="1600" height="390" />
    </p>

   - If Red Hat Advanced Cluster Management is installed in the `open-cluster-management` namespace, you can get the image pull secret from the `open-cluster-management` namespace. Otherwise you can get the image pull secret `pull-secret` from the `openshift-config` namespace. Enter your image pull secret details. Click `Create`:

    <p align="center">
        <img src="./images/create-pull-secret.png" alt="Create image pull secret" width="900" height="720" />
    </p>

3. Create your object storage secret `thanos-object-storage` in `open-cluster-management-observability` project, more details about object storage please refer to the [product page](https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/2.2/html/observing_environments/observing-environments-intro#enabling-observability). In this step, we will create a Amazon S3 object storage secret for observability service:

   - Navigate to `Workloads -> Secrets`. Click `Create -> From YAML`:

    <p align="center">
        <img src="./images/secret-page-for-obj-storage.png" alt="Object storage secret page" width="1600" height="400" />
    </p>

   - Enter your object stroage secret details. Click `Create`:

    <p align="center">
        <img src="./images/create-obj-storage-secret.png" alt="Create object storage secret" width="1100" height="600" />
    </p>

4. Create the `MultiClusterObservability` custom resource (CR):

   - Navigate to `Home -> Explore`. Search the `MultiClusterObservability` API resource:

    <p align="center">
        <img src="./images/search-mco-api.png" alt="Object storage secret page" width="1600" height="350" />
    </p>

   - Click the `v1beta2`  `MultiClusterObservability` API resource:

    <p align="center">
        <img src="./images/mco-details.png" alt="MCO details" width="900" height="600" />
    </p>

   - Click the `Instances -> Create MultiClusterObservability` to create a `MultiClusterObservability` instance:

    <p align="center">
        <img src="./images/create-mco-cr-1.png" alt="create MCO CR" width="800" height="500" />
    </p>

   - Enter your `MultiClusterObservability` instance details. Click `Create`:

    <p align="center">
        <img src="./images/create-mco-cr-2.png" alt="create MCO CR" width="1100" height="700" />
    </p>

   - Check the `MultiClusterObservability` instance status. If you get this message: `Observability components are deployed and running`. Now your observability service has enable successully:

    <p align="center">
        <img src="./images/mco-cr-status.png" alt="MCO CR status" width="1500" height="600" />
    </p>
