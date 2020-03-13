---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Refreshing certificates

You can refresh certificates that are created by the installer after you install Red Hat Advanced Cluster Management for Kubernetes.
{:shortdesc}

**Required user type or access level**: Cluster administrator or team administrator

You can refresh certificates for the following components:

| Component | Directory |
|---------| ----------|
| [Root CA](#root) | `cluster/cfc-certs/root-ca` |
| [Etcd](#etcd) | `cluster/cfc-certs/etcd` |
| [Front-Proxy](#front) | `cluster/cfc-certs/front-proxy` |
| [Kubernetes](#kube) | `cluster/cfc-certs/kubernetes` |
| [IPSec](#ipsec) | `cluster/cfc-certs/ipsec` |
| [Helm](#helm) | `cluster/cfc-certs/helm` |


After the Root CA is replaced, you must refresh all certificates that are signed by the Root CA, and restart the services that use those certificates. Cert-manager creates the default ClusterIssuer from the Root CA, so all of the certificates issued by `cert-manager` and signed by the default ClusterIssuer must also be refreshed.

The following code deletes the Kubernetes Secrets associated with each `cert-manager` certificate to refresh the certificate and restart the services that use the certificate.
```bash
kubectl get cert --all-namespaces -o custom-columns=:spec.secretName,:metadata.namespace --no-headers -l certmanager.k8s.io/issuer-name=icp-ca-issuer -l certmanager.k8s.io/issuer-kind=ClusterIssuer | while read secret ; do
    name=$(echo $secret | awk '{print $1}')
    namespace=$(echo $secret | awk '{print $2}')
    kubectl delete secret $name -n $namespace
    echo "Secret $name was deleted."
done
```
{: codeblock}

<!--i think we want to remove this completely will get confirmation soon-->
