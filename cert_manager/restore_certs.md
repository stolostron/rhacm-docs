---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Restoring certificates

You can restore certificates that are created by the installer after you refresh or replace them.

{:shortdesc}

You can restore certificates for the following components:

| Component | Directory |
|---------| ----------|
| [Root CA](#root) | `cluster/cfc-certs/root-ca` |
| [Etcd](#etcd)| `cluster/cfc-certs/etcd` |
| [Front Proxy](#front) | `cluster/cfc-certs/front` |
| [Kubernetes](#kube) | `cluster/cfc-certs/kubernetes` |
| [IPsec](#ipsec) | `cluster/cfc-certs/ipsec` |
| [Helm](#helm) | `cluster/cfc-certs/helm` |

## Before you begin:
 - Ensure that your Red Hat Advanced Cluster Management for Kubernetes cluster is running.
 - Make sure that you have a backup of all of the certificates that you want to restore.

## Restoring root CA certificates
{: #root}

1. Copy the `cfc-certs` root backup directory to the `cfc-certs` directory. For example:
     
     ```bash
     cp -rf cfc-certs.bak/root-ca cfc-certs/
     ```
     {: codeblock}

2. Run the following command to restore the `root-ca` certificates:
   - For Red Hat Advanced Cluster Management for Kubernetes:
     - For Linux&reg;, run the following command:
       ```bash
       sudo docker run --net=host -t -e LICENSE=accept \
       -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
       replace-certificates --tags "root-ca-certs"
       ```
       {: codeblock}

     - For Linux&reg; on Power&reg; (ppc64le), run the following command:
       ```bash
       sudo docker run --net=host -t -e LICENSE=accept \
       -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
       replace-certificates --tags "root-ca-certs"
       ```
       {: codeblock}

     - For Linux&reg; on IBM&reg; Z and LinuxONE, run the following command:
       ```bash
       sudo docker run --net=host -t -e LICENSE=accept \
       -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
       replace-certificates --tags "root-ca-certs"
       ```
       {: codeblock}


     **Note**: When you restore the Root CA, all certificates that are signed by the Root CA will automatically be refreshed as well. These certificates include the Kubernetes, IPSec, and Helm.

3. Root CA certificates have changed. You must reload all default tokens and related service. For more information, see [Reloading services](#reload).
4. Manually recreate the image pull secret. For more information, see [Recreate image pull secret](#recreate).
5. Refresh all cert-manager certificates that use the CA. For more information, see [Refreshing Cert-Manager Certificates](#refresh).

6. Restart Docker.
    ```bash
    sudo systemctl restart docker
    ```
    {: codeblock}

7. Run the following command to restart Kubelet on your master node:
    ```bash
    sudo systemctl restart kubelet
    ```
    {: codeblock}

## Restoring etcd certificates
{: #etcd}

1. Copy the `cfc-certs` etcd backup directory to the `cfc-certs` directory. For example:
    ```bash
    cp -rf cfc-certs.bak/etcd cfc-certs/
    ```
    {: codeblock}

2. Run the following command to restore the `etcd` certificates:
  - For Red Hat Advanced Cluster Management for Kubernetes:
    - For Linux, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
      replace-certificates --tags "etcd-certs"
      ```
        {: codeblock}

    - For Linux on Power (ppc64le), run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
      replace-certificates --tags "etcd-certs"
      ```
        {: codeblock}

    - For Linux&reg; on IBM&reg; Z and LinuxONE, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
      replace-certificates --tags "etcd-certs"
      ```
        {: codeblock}

## Restoring front proxy certificates
{: #front}

1. Copy the `cfc-certs` front proxy backup directory to the `cfc-certs` directory. For example:
    ```
    cp -rf cfc-certs.bak/front cfc-certs/
    ```
     {: codeblock}

2. Run the following command to restore the `front proxy` certificates:
  - For Red Hat Advanced Cluster Management for Kubernetes:
    - For Linux, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
      replace-certificates --tags "front-proxy-certs"
      ```
        {: codeblock}

    - For Linux&reg; on Power&reg; (ppc64le), run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
      replace-certificates --tags "front-proxy-certs"
      ```
      {: codeblock}

    - For Linux&reg; on IBM&reg; Z and LinuxONE, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
      replace-certificates --tags "front-proxy-certs"
      ```
        {: codeblock}

## Restoring Kubernetes certificates
{: #kube}

**Note**: Kubernetes certificates depend on the Root CA. If the Root CA has changed, you cannot restore the Kubernetes certificates. Follow the steps in [Restoring Root CA certificates](#root) to restore all of the related certificates.

1. Copy the `cfc-certs` Kubernetes backup directory to the `cfc-certs` directory. For example:
    ```bash
    cp -rf cfc-certs.bak/kubernetes cfc-certs/
    ```
    {: codeblock}

2. Run the following command to restore the Kubernetes certificates:
  - For Red Hat Advanced Cluster Management for Kubernetes:
    - For Linux, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
      replace-certificates --tags "kubernetes-certs"
      ```
        {: codeblock}

    - For Linux&reg; on Power&reg; (ppc64le), run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
      replace-certificates --tags "kubernetes-certs"
      ```
        {: codeblock}

    - For Linux&reg; on IBM&reg; Z and LinuxONE, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
      replace-certificates --tags "kubernetes-certs"
      ```
        {: codeblock}

## Restoring IPsec certificates
{: #ipsec}

**Note**: The IPsec certificates depend on the Root CA. If the Root CA has changed, you cannot restore the IPsec certificates. Follow the steps in [Restoring Root CA certificates](#root) to restore all of the related certificates.

1. Copy the `cfc-certs` IPsec backup directory to the `cfc-certs` directory. For example:
    ```bash
    cp -rf cfc-certs.bak/ipsec cfc-certs/
    ```
    {: codeblock}

2. Run the following command to restore the `ipsec` certificates:
  - For Red Hat Advanced Cluster Management for Kubernetes:
    - For Linux, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
      replace-certificates --tags "ipsec-certs"
      ```
        {: codeblock}

    - For Linux&reg; on Power&reg; (ppc64le), run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
      replace-certificates --tags "ipsec-certs"
      ```
        {: codeblock}

    - For Linux&reg; on IBM&reg; Z and LinuxONE, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
      replace-certificates --tags "ipsec-certs"
      ```
        {: codeblock}

## Restoring Helm certificates
{: #helm}

**Note**: The Helm certificates depend on the Root CA. If the Root CA has changed, you cannot restore the Helm certificates. Follow the steps in [Restoring Root CA certificates](#root) to restore all of the related certificates.

1. Copy the `cfc-certs` helm backup directory to the `cfc-certs` directory. For example:
    ```bash
    cp -rf cfc-certs.bak/helm cfc-certs/
    ```
    {: codeblock}

2. Run the following command to restore the `helm` certificates:
  - For Red Hat Advanced Cluster Management for Kubernetes:
    - For Linux, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
      replace-certificates --tags "helm-certs"
      ```
        {: codeblock}

    - For Linux&reg; on Power&reg; (ppc64le), run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
      replace-certificates --tags "helm-certs"
      ```
        {: codeblock}

    - For Linux&reg; on IBM&reg; Z and LinuxONE, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
      replace-certificates --tags "helm-certs"
      ```
        {: codeblock}

## Reloading services
{: #reload}

### Reloading default tokens
After you replace Root CA, you must delete the default token from all namespaces, and restart related services. You can use the following code to delete the default token from all namespaces, and restart the related services.

```bash
kubectl get secret --no-headers --all-namespaces -o=custom-columns=NAME:.metadata.name,NAMESPACE:.metadata.namespace | grep default-token | while read token; do
    secret_name=$(echo $token | awk '{print $1}')
    secret_namespace=$(echo $token | awk '{print $2}')
    echo "-----------------------------------------------------------------------"
    echo "|                      Token: ${secret_name}"
    echo "|                  Namespace: ${secret_namespace}"
    echo "-----------------------------------------------------------------------"
    echo "Deleteing default token ..."
    kubectl -n ${secret_namespace} delete secret ${secret_name} &>/dev/null
    echo "Reloading services ..."
    kubectl -n ${secret_namespace} get po --field-selector=status.phase!=Completed,status.phase!=Succeeded,status.phase!=Unknow --no-headers -o=custom-columns=NAME:.metadata.name | while read pod; do
    secret_used=$(kubectl -n ${secret_namespace} get po ${pod} -oyaml | egrep 'secretName: default-token|secretName: calico-node-token' &>/dev/null || echo no && echo yes)
    if [[ "$secret_used" == "yes" ]]; then
        echo "    - Restarting pod ${pod} ..."
        kubectl -n ${secret_namespace} delete po ${pod} --grace-period=0 --force &>/dev/null
    fi
    done
    echo
done
```
### Recreate image pull secrets
{: #recreate}
  - For Red Hat Advanced Cluster Management for Kubernetes:
    - For Linux, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
      image-pull-secret
      ```
      {: codeblock}

    - For Linux&reg; on Power&reg; (ppc64le), run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
      image-pull-secret
      ```
      {: codeblock}

    - For Linux&reg; on IBM&reg; Z and LinuxONE, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
      image-pull-secret
      ```
      {: codeblock}

## Refreshing cert-manager certificates
{: #refresh}

After the Root CA is replaced, you must refresh all certificates that are signed by the Root CA, and restart the services that use those certificates. You can use the following code to delete the Kubernetes Secrets associated with each cert-manager certificate to refresh the certificate, and restart the services that use the certificate.
```bash
kubectl get cert --all-namespaces -o custom-columns=:spec.secretName,:metadata.namespace --no-headers -l certmanager.k8s.io/issuer-name=icp-ca-issuer -l certmanager.k8s.io/issuer-kind=ClusterIssuer | while read secret ; do
    name=$(echo $secret | awk '{print $1}')
    namespace=$(echo $secret | awk '{print $2}')
    kubectl delete secret $name -n $namespace
    echo "Secret $name was deleted."
done
```
{: codeblock}
