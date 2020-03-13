---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Certificates in Red Hat Advanced Cluster Management for Kubernetes

Various certificates are created and used throughout Red Hat Advanced Cluster Management for Kubernetes.
{:shortdesc}

More information about managing certificates created by the installer can be found in the following documents:
* [Refreshing certificates](refresh_certs.md)
* [Replacing certificates](byok_certs.md)
* [Restoring certificates](restore_certs.md)

## Using your own certificate authority (CA) (BYOK)

You can bring your own key to use inside your Red Hat Advanced Cluster Management for Kubernetes cluster. For more information, see [Specifying your own certificate authority for Red Hat Advanced Cluster Management for Kubernetes services](specify_cert.md).

## Creating a certificate

All certificates required by services that run on Red Hat Advanced Cluster Management for Kubernetes are created during the installation of Red Hat Advanced Cluster Management for Kubernetes. Certificates are either created and managed by the Red Hat Advanced Cluster Management for Kubernetes installer or by the Red Hat Advanced Cluster Management for Kubernetes Certificate manager (`cert-manager`).

Use the certificate policy controller to create and manage certificate policies. For more information, see [Certificate policy controller](../compliance/cert_policy_ctrl.md).

## Red Hat Advanced Cluster Management for Kubernetes Certificates

These are the certificates that are automatically created during the installation of Red Hat Advanced Cluster Management for Kubernetes. <!--validate-->

### Created and managed by Installer

Certificates are located in the `<install_directory>/cluster/cfc-certs/` directory. All certificates have a key size of 2048 bits, except for the Red Hat Advanced Cluster Management for Kubernetes Root CA, which has a key size of 4096 bits. <!--verify-->

#### Certificates that can be updated after installation

**Note**: All certificates use the SHA 256 algorithm for hashing.

| Component | Role | Certificate | Key File | Folder  | Issued/Signed By |  Duration (years) |
|-----------|------|-------------|----------|---------|------------------|-------------------|
| Red Hat Advanced Cluster Management for Kubernetes Root CA | Red Hat Advanced Cluster Management for Kubernetes Root CA | `ca.crt` | `ca.key` | root-ca/ | Itself | 2.25 |
| etcd | etcd CA | `ca.pem` | `ca-key.pem` | etcd/ | Itself | 2 |
| etcd | etcd client-server authentication | `server.pem` | `server-key.pem` | etcd/ | etcd CA | 10 |
| etcd | etcd client authentication | `client.pem` | `client-key.pem` | etcd/ | etcd CA | 2 |
| etcd | etcd peer authentication | `member-<master/etcd ip>.pem` | `member-<master/etcd ip>-key.pem` | etcd/ | etcd CA | 2 |
| Kubernetes Front Proxy | Kubernetes Front Proxy CA | `front-proxy-ca.pem` | `front-proxy-ca-key.pem` | front/ | Itself | 10 |
| Kubernetes Front Proxy | Kubernetes Front Proxy Server | `front-proxy-server.pem` | `front-proxy-server-key.pem` | front/ | Kubernetes Front Proxy CA | 2 |
| Kubernetes Front Proxy | Kubernetes Front Proxy Client | `front-proxy-client.pem` | `front-proxy-client-key.pem` | front/ | Kubernetes Front Proxy CA | 2 |
| Kubernetes | TLS for Kubernetes API Server | `server.cert` | `server.key` | kubernetes/ | Red Hat Advanced Cluster Management for Kubernetes Root CA | 2 |
| Kubernetes | Kubectl CLI | `kubecfg.crt` | `kubecfg.key` | kubernetes/ | Red Hat Advanced Cluster Management for Kubernetes Root CA | 2 |
| Kubernetes | Kubelet | `kubelet-<master ip>.crt` | `kubelet-<master ip>.key` | kubernetes/ | Red Hat Advanced Cluster Management for Kubernetes Root CA | 2 |
| Kubernetes | Kubelet Client for Kubernetes API Server | `kubelet-client.crt` | `kubelet-client.key` | kubernetes/ | Red Hat Advanced Cluster Management for Kubernetes Root CA | 2 |
| Kubernetes | Kubernetes Proxy Client | `kube-proxy.crt` | `kube-proxy.key` | kubernetes/ | Red Hat Advanced Cluster Management for Kubernetes Root CA | 2 |
| Kubernetes | Kubernetes Scheduler | `kube-scheduler.crt` | `kube-scheduler.key` | kubernetes/ | Red Hat Advanced Cluster Management for Kubernetes Root CA | 2 |
| Kubernetes | Kubernetes Control Manager | `kube-controller-manager.crt` | `kube-controller-manager.key` | kubernetes/ | Red Hat Advanced Cluster Management for Kubernetes Root CA | 2 |
| Helm-Tiller | Helm-Tiller Server | `tiller.crt` | `tiller.key` | helm/ | Red Hat Advanced Cluster Management for Kubernetes Root CA | 2 |
| Helm-Tiller | Helm CLI | `admin.crt` | `admin.key` | helm/ | Red Hat Advanced Cluster Management for Kubernetes Root CA | 2 |
| IPSec | IPSec (Strong Swan or Libre Swan) | `ipsec-mesh.crt` | `ipsec-mesh.key` | ipsec/ | Red Hat Advanced Cluster Management for Kubernetes Root CA | 2 |

#### Accessing the Red Hat Advanced Cluster Management for Kubernetes Root CA Certificate

The Red Hat Advanced Cluster Management for Kubernetes Root CA Certificate is stored within the Kubernetes Secret `cloud-cluster-ca-cert` in the `kube-public` namespace. The certificate can be imported into your client truststores to access Red Hat Advanced Cluster Management for Kubernetes Platform APIs.

To retrieve and decode the certificate, run the following command: <!--verify the command-->

```
kubectl get secret -n kube-public rcm-cluster-ca-cert -o jsonpath='{.data.ca\.crt}' | base64 --decode
```
{: codeblock}

### Created and managed by Red Hat Advanced Cluster Management for Kubernetes Certificate manager (_cert-manager_)

The following internal services use `cert-manager` to create and manage their certificates: <!--verify-->

* IAM
* MongoDB
* Key Management Service
* Web Terminal
* Monitoring
* Helm
* Metrics Server
* Audit Logging
* Image Manager (Docker Registry) and Management ingress

All certificates managed by `cert-manager` for example, Management ingress, are managed (created, refreshed, and watched) by `cert-manager`.

For more information about cert-manager, see [Using Red Hat Advanced Cluster Management for Kubernetes Certificate manager](cert_manager.md).
