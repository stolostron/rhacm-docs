---

copyright:
  years: 2019
lastupdated: "2019-11-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Certificates in {{site.data.keyword.product}}

Various certificates are created and used throughout {{site.data.keyword.product}}.
{:shortdesc}
More information about managing certificates created by the installer can be found in the following documents:
* [Refreshing certificates](refresh_certs.md)
* [Replacing certificates](byok_certs.md)
* [Restoring certificates](restore_certs.md)

## Using your own certificate authority (CA) (BYOK)

You can bring your own key to use inside your {{site.data.keyword.product}} cluster. For more information, see [Specifying your own certificate authority for {{site.data.keyword.product}} services](specify_cert.md).

## Creating a certificate

All certificates required by services that run on {{site.data.keyword.product}} are created during the installation of {{site.data.keyword.product}}. Certificates are either created and managed by the {{site.data.keyword.product}} installer or by the {{site.data.keyword.product}} Certificate manager (cert-manager).

<!-- Use the certificate policy controller to create and manage certificate policies. For more information, see [Certificate policy controller](../manage_policies/cert_policy_ctrl.md). -->

<!--might need remove the previous statement bc it will point the user to CP4MCM; consider checking for a doc that explains creating policy resources, or remove entire statement--LC 11/18/19 removed prev statement-->

## {{site.data.keyword.product}} Certificates
These are the certificates that are automatically created during the installation of {{site.data.keyword.product}}. 

### Created and managed by Installer
Certificates are located in the `<install_directory>/cluster/cfc-certs/` directory. All certificates have a key size of 2048 bits, except for the {{site.data.keyword.product}} Root CA, which has a key size of 4096 bits. 

#### Certificates that can be updated after installation

**Note**: All certificates use the SHA 256 algorithm for hashing.

| Component | Role | Certificate | Key File | Folder  | Issued/Signed By |  Duration (years) |
|-----------|------|-------------|----------|---------|------------------|-------------------|
| {{site.data.keyword.product}} Root CA | {{site.data.keyword.product}} Root CA | `ca.crt` | `ca.key` | root-ca/ | Itself | 2.25 |
| etcd | etcd CA | `ca.pem` | `ca-key.pem` | etcd/ | Itself | 2 |
| etcd | etcd client-server authentication | `server.pem` | `server-key.pem` | etcd/ | etcd CA | 10 |
| etcd | etcd client authentication | `client.pem` | `client-key.pem` | etcd/ | etcd CA | 2 |
| etcd | etcd peer authentication | `member-<master/etcd ip>.pem` | `member-<master/etcd ip>-key.pem` | etcd/ | etcd CA | 2 |
| Kubernetes Front Proxy | Kubernetes Front Proxy CA | `front-proxy-ca.pem` | `front-proxy-ca-key.pem` | front/ | Itself | 10 |
| Kubernetes Front Proxy | Kubernetes Front Proxy Server | `front-proxy-server.pem` | `front-proxy-server-key.pem` | front/ | Kubernetes Front Proxy CA | 2 |
| Kubernetes Front Proxy | Kubernetes Front Proxy Client | `front-proxy-client.pem` | `front-proxy-client-key.pem` | front/ | Kubernetes Front Proxy CA | 2 |
| Kubernetes | TLS for Kubernetes API Server | `server.cert` | `server.key` | kubernetes/ | {{site.data.keyword.product}} Root CA | 2 |
| Kubernetes | Kubectl CLI | `kubecfg.crt` | `kubecfg.key` | kubernetes/ | {{site.data.keyword.product}} Root CA | 2 |
| Kubernetes | Kubelet | `kubelet-<master ip>.crt` | `kubelet-<master ip>.key` | kubernetes/ | {{site.data.keyword.product}} Root CA | 2 |
| Kubernetes | Kubelet Client for Kubernetes API Server | `kubelet-client.crt` | `kubelet-client.key` | kubernetes/ | {{site.data.keyword.product}} Root CA | 2 |
| Kubernetes | Kubernetes Proxy Client | `kube-proxy.crt` | `kube-proxy.key` | kubernetes/ | {{site.data.keyword.iproduct}} Root CA | 2 |
| Kubernetes | Kubernetes Scheduler | `kube-scheduler.crt` | `kube-scheduler.key` | kubernetes/ | {{site.data.keyword.product}} Root CA | 2 |
| Kubernetes | Kubernetes Control Manager | `kube-controller-manager.crt` | `kube-controller-manager.key` | kubernetes/ | {{site.data.keyword.product}} Root CA | 2 |
| Helm-Tiller | Helm-Tiller Server | `tiller.crt` | `tiller.key` | helm/ | {{site.data.keyword.product}} Root CA | 2 |
| Helm-Tiller | Helm CLI | `admin.crt` | `admin.key` | helm/ | {{site.data.keyword.product}} Root CA | 2 |
| IPSec | IPSec (Strong Swan or Libre Swan) | `ipsec-mesh.crt` | `ipsec-mesh.key` | ipsec/ | {{site.data.keyword.product}} Root CA | 2 |

#### Accessing the {{site.data.keyword.product}} Root CA Certificate
The {{site.data.keyword.product}} Root CA Certificate is stored within the Kubernetes Secret `ibmcloud-cluster-ca-cert` in the `kube-public` namespace. The certificate can be imported into your client truststores to access {{site.data.keyword.product}} Platform APIs.

To retrieve and decode the certificate, run the following command:
```
kubectl get secret -n kube-public ibmcloud-cluster-ca-cert -o jsonpath='{.data.ca\.crt}' | base64 --decode
```
{: codeblock}

### Created and managed by {{site.data.keyword.product}} Certificate manager (cert-manager)
The following internal services use cert-manager to create and manage their certificates.
* IAM
* MongoDB
* Key Management Service
* Web Terminal
* Monitoring
* Helm
* Metrics Server
* Audit Logging
* Image Manager (Docker Registry) and Management ingress

All certificates managed by cert-manager for example, Management ingress, are managed (created, refreshed, and watched) by cert-manager.

For more information about cert-manager, see [Using {{site.data.keyword.product}} Certificate manager](cert_manager.md).
