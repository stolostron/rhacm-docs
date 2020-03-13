---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-12"

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


## Before you begin:
Verify that your Red Hat Advanced Cluster Management for Kubernetes cluster is running.

**Note:** When you run the command to refresh a certificate, the related management services might be unavailable for a short duration of time. The command has no impact on the applications in your cluster.

Complete the following steps to back up the existing certificates:

1. Log in to the boot node.
2. Change to the cluster directory and create a backup of all the certificates by running the following commands:
    ```bash
    cd <installation_directory>/cluster/
    cp -r cfc-certs cfc-certs.bak
    ```
    {: codeblock}

## Refreshing root CA certificates
{: #root}

1. Update the old Certificate Authority (CA):
     Delete the old CA cert `ca.crt` by running the following command:

      ```bash
      rm -rf <cluster_dir>/cfc-certs/root-ca
      ```
      {: codeblock}

2. Delete the certificates and keys that are related with the old CA. For example:

     ```bash
      rm -rf <cluster_dir>/cfc-certs/kubernetes
      rm -rf <cluster_dir>/cfc-certs/helm
      rm -rf <cluster_dir>/cfc-certs/ipsec
      ```
    {: codeblock}

3. Run the following command to refresh the `root-ca` certificates:
   - For Red Hat Advanced Cluster Management for Kubernetes:
     - For Linux, run the following command:
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

      **Note**: When you refresh the Root CA, all certificates that are signed by the Root CA are automatically refreshed. These certificates include the Kubernetes, IPSec, and Helm.

4. Manually restart the services by reloading the them.
All default tokens and related services must reload. For more information, see [Reloading services](#reload).

5. Manually recreate the image pull secret. For more information, see [Recreate image pull secret](#recreate)
6. Refresh all cert-manager certificates that use the CA. For more information, see [Refreshing Cert-Manager Certificates](#refresh).

7. Restart Docker
    ```bash
    sudo systemctl restart docker
    ```
    {: codeblock}

8. Run the following command to restart Kubelet on your master node.
    ```bash
    sudo systemctl restart kubelet
    ```
    {: codeblock}

## Refreshing etcd certificates
{: #etcd}

1. Delete the old certificates by running the following command:

     ```bash
      rm -rf <cluster_dir>/cfc-certs/etcd
      ```
      {: codeblock}

2. Run the following command to replace the `etcd` certificates:

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

  - For Linux on IBM Z and LinuxONE, run the following command:
    ```bash
    sudo docker run --net=host -t -e LICENSE=accept \
    -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
    replace-certificates --tags "etcd-certs"
    ```
    {: codeblock}

## Refreshing front proxy certificates
{: #front}

1. Delete the old certificates by running the following command:
    ```bash
    rm -rf <cluster_dir>/cfc-certs/front
    ```
    {: codeblock}

2. Run the following command to replace the `front proxy` certificates:

    - For Linux, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
      replace-certificates --tags "front-proxy-certs"
      ```
        {: codeblock}

    - For Linux on Power (ppc64le), run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
      replace-certificates --tags "front-proxy-certs"
      ```
        {: codeblock}

    - For Linux on IBM Z and LinuxONE, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
      replace-certificates --tags "front-proxy-certs"
      ```
        {: codeblock}

## Refreshing kubernetes certificates
{: #kube}

1. Delete the old certificates by running the following command:
    ```bash
    rm -rf <cluster_dir>/cfc-certs/kubernetes
    ```
    {: codeblock}

2. Run the following command to replace the `kubernetes` certificates:

    - For Linux, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
      replace-certificates --tags "kubernetes-certs"
      ```
      {: codeblock}

    - For Linux on Power (ppc64le), run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
      replace-certificates --tags "kubernetes-certs"
      ```
      {: codeblock}

    - For Linux on IBM Z and LinuxONE, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
      replace-certificates --tags "kubernetes-certs"
      ```
      {: codeblock}

## Refreshing IPSec certificates
{: #ipsec}

1. Delete the old certificates by running the following command:
    ```bash
    rm -rf <cluster_dir>/cfc-certs/ipsec
    ```
    {: codeblock}

2. Run the following command to replace the `ipsec` certificates:

    - For Linux, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
      replace-certificates --tags "ipsec-certs"
      ```
      {: codeblock}
    - For Linux on Power (ppc64le), run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
      replace-certificates --tags "ipsec-certs"
      ```
      {: codeblock}
    - For Linux on IBM Z and LinuxONE, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
      replace-certificates --tags "ipsec-certs"
      ```
      {: codeblock}

## Refreshing helm certificates
{: #helm}

1. Delete the old certificates by running the following command:
    ```bash
    rm -rf <cluster_dir>/cfc-certs/helm
    ```
    {: codeblock}

2. Run the following command to replace the `helm` certificates:

    - For Linux, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
      replace-certificates --tags "helm-certs"
      ```
      {: codeblock}

    - For Linux on Power (ppc64le), run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
      replace-certificates --tags "helm-certs"
      ```
      {: codeblock}

    - For Linux on IBM Z and LinuxONE, run the following command:
      ```bash
      sudo docker run --net=host -t -e LICENSE=accept \
      -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
      replace-certificates --tags "helm-certs"
      ```
      {: codeblock}

## Reloading services
{: #reload}

### Reloading default token
After Root CA is replaced, you must delete the default token from all namespaces, and restart related services. You can use the following code to delete the default token from all namespaces and restart the related services.

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
{: codeblock}

### Recreate image pull secret
{: #recreate}

  - For Linux, run the following command:
    ```bash
    sudo docker run --net=host -t -e LICENSE=accept \
    -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.2-rhel-ee \
    image-pull-secret
    ```
    {: codeblock}

  - For Linux on Power (ppc64le), run the following command:
    ```bash
    sudo docker run --net=host -t -e LICENSE=accept \
    -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.2-rhel-ee \
    image-pull-secret
    ```
    {: codeblock}

  - For Linux on IBM Z and LinuxONE, run the following command:
    ```bash
    sudo docker run --net=host -t -e LICENSE=accept \
    -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.2-rhel-ee \
    image-pull-secret
    ```
    {: codeblock}

## Refreshing cert-manager certificates
{: #refresh}

After the Root CA is replaced, you must refresh all certificates that are signed by the Root CA, and restart the services that use those certificates. Cert-manager creates the default ClusterIssuer from the Root CA, so all of the certificates issued by cert-manager and signed by the default ClusterIssuer must also be refreshed.

The following code deletes the Kubernetes Secrets associated with each cert-manager certificate to refresh the certificate and restart the services that use the certificate.
```bash
kubectl get cert --all-namespaces -o custom-columns=:spec.secretName,:metadata.namespace --no-headers -l certmanager.k8s.io/issuer-name=icp-ca-issuer -l certmanager.k8s.io/issuer-kind=ClusterIssuer | while read secret ; do
    name=$(echo $secret | awk '{print $1}')
    namespace=$(echo $secret | awk '{print $2}')
    kubectl delete secret $name -n $namespace
    echo "Secret $name was deleted."
done
```
{: codeblock}
