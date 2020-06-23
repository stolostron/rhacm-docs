# Requirements and recommendations

Before you install the Red Hat Advanced Cluster Management for Kubernetes, review the system configuration requirements and settings.

# Supported operating systems and platforms

See the following table for supported operating systems:

|Platform|Operating system| OpenShift Container Platform version
|--------|----------------|---|
|   Linux x86_64       | Red Hat Enterprise Linux 7.6, or later | 4.3, 4.4 (bare metal features only supported on 4.4) |
{: caption="Table 1. Supported operating systems" caption-side="top"}

# Supported browsers

You can access the Red Hat Advanced Cluster Management for Kubernetes console from Mozilla Firefox, Google Chrome, Microsoft™ Edge, and Safari. See the following versions that are tested and supported:


|Platform|Supported browsers|
|--------|------------------|
|Microsoft Windows|Microsoft Edge - latest, Mozilla Firefox - 74.0 or later, Google Chrome - Version 80.0 and later|
|Linux |Mozilla Firefox - 74.0 and later, Google Chrome - Version 80.0 and later|
|macOS|Mozilla Firefox - 74.0 and later, Google Chrome - Version 80.0 and later, Safari - 13.0.5 and later|
{: caption="Table 1. Supported browsers" caption-side="top"}

See the [Red Hat Advanced Cluster Management for Kubernetes Support matrix](https://access.redhat.com/articles/5058921) for additional information. 

# Networking configuration

Hub cluster:
- outbound connectivity to cloud provider's API, port 443 for Google Cloud Platfrom Amazon Web Service
- outbound connectivity to the Kubernetes API server of the Hive provisioned managed cluster (so Hive-driven `openshift-install` is successful)
- outbound connectivity to the `WorkManager` service endpoint on the managed cluster (for gathering logs)
- inbound connectivity to the hub cluster's Kubernetes API server from the managed cluster (for Klusterlet/KlusterletAddon)

Managed cluster:
- inbound connectivity to the Kubernetes API server from the hub cluster (Hive)
- inbound connectivity to `WorkManager` service endpoint from the hub cluster (for logging)
- outbound connectivity to the hub cluster's Kubernetes API server (for Klusterlet/KlusterletAddon)

Hive:
- outbound connectivity from Hub to the cloud provider's API
- inbound/outbound connectivity from Hub to the kube API server of the provisioned cluster

Klusterlet/KlusterletAddon
- inbound connectivity from ManagedCluster to Hub's kube API server

WorkManager log feature:
- inbound/outbound connectivity from Hub to ManagedCluster's WorkManager endpoint

