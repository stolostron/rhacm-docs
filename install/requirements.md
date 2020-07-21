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

Configure your network settings to allow the following connections:

Hub cluster:
- Outbound connectivity to cloud provider's API
- Outbound connectivity to the Kubernetes API server of theprovisioned `ManagedCluster` on port 6443
- Outbound connectivity from the Hub to the channel source, including Github, Object Store, and Helm repository. This is only required when you are using application lifecycle to connect to these sources.
- Outbound and inbound connectivity to the `WorkManager` service route on the ManagedCluster on port 443
- Inbound connectivity to the hub cluster's kube API server from the `ManagedCluster` on port 6443
- Inbound connectivity for post-commit hook from GitHub to the Hub. This setting is only required when you use certain application management functions.


Managed cluster:
- Inbound connectivity to the Kubernetes API server from the hub cluster on port 6443
- Inbound connectivity to `WorkManager` service endpoint from the hub cluster on port 443
- Outbound connectivity to the hub cluster's Kubernetes API server on port 6443
- Outbound connectivity from the Hub to channel source, including Github, Object Store, and Helm repository. This is only required when you are using application lifecycle to connect to these sources.
