---

copyright:
  years: 2019
lastupdated: "2019-12-01"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Replacing the root CA certificate

You can replace the root CA certificate for the following components:
{: shortdesc}

| Component | Directory |
|---------| ----------|
| [Root CA](#root) | `cluster/cfc-certs/root-ca` |

## Before you begin
{: #bybreq3}

Verify that your Red Hat Advanced Cluster Management for Kubernetes cluster is running.

Complete the following steps to back up the existing certificates:

1. Log in to the boot node.
2. Change to the cluster directory and create a back up of all the certificates by running the following commands:
    ```bash
    cd <installation_directory>/cluster/
    cp -r cfc-certs cfc-certs.bak
    ```
    {: codeblock}
3. You must have your full certificate chain if the CA certificate you bring is not self-signed. That means the CA certificate that you bring is issued by another CA. The full certificate chain includes all the CA certificates that signed each intermediate CA certificate that signed your CA certificate. It does not include your CA certificate.

4. If you updated your macOS system to the latest version (Catalina) or greater, you must complete the following steps to access permission for your certificate. Complete the following steps only if you are unable to reach the management console after you replace your CA.

   1. Extract the Red Hat Advanced Cluster Management for Kubernetes Root CA Certificate from the `cluster-ca-cert.pem` file by running the following command:
   
      * For macOS, run the following command:
     
        ```
        kubectl get secret cluster-ca-cert -n kube-system -o jsonpath="{.data['tls\.crt']}" | base64 -D > cluster-ca-cert.pem
        ```
        {: codeblock}

      * For {{site.data.keyword.linux_notm}}, run the following command:

        ```
        kubectl get secret cluster-ca-cert -n kube-system -o jsonpath="{.data['tls\.crt']}" | base64 --decode > cluster-ca-cert.pem
        ```
        {: codeblock}

      * When you set the `NavTLSGEnerate` parameter to `True`, in the namespace where Red Hat Advanced Cluster Management for Kubernetes is installed, run the following command to extract the Root CA Certificate:
      
        ```
        kubectl get secret icip-navigator-tls-secret -n cp4int -o jsonpath="{.data['tls.crt']}" | base64 -D > cluster-ca-cert.pem
        ```
        {: codeblock}

   2. Add the certificate file to your local file system.

   3. Update the trust store for your macOS. Select the **Launch Pad** application. 

   4. Locate and select the **Keychain Access** application.

   5. Move your `cluster-ca-cert.pem` certificate file into the `Keychain Access` application.

   6. From the _Certificates_ section, verify that the certificate is added.

   7. Update the access permissions by double-clicking the certificate that you added. Update the `When using this certificate` parameter to `Always Trust`.

   8. Return to your Chrome browser and refresh the console. 

      You can log in to your console with access to the product. For more information, see [Requirements for trusted certificates in iOS 13 and macOS 10.15 ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://support.apple.com/en-us/HT210176){: new_window}.

## Replacing root ca certificates
{: #root}

1. Update the old Certificate Authority (CA). Copy the prepared CA certificate `ca.crt`, CA key `ca.key`, and PKCS1 format CA key `ca.key.p1` to the `<cluster_dir>/cfc-certs/root-ca/` directory to override the old CA. For example:
    ```bash
    cp <certificate_location>/ca.crt <cluster_dir>/cfc-certs/root-ca
    cp <certificate_location>/ca.key <cluster_dir>/cfc-certs/root-ca
    cp <certificate_location>/ca.key.p1 <cluster_dir>/cfc-certs/root-ca
    ```
     {: codeblock}

2. Remove the file `ca-chain.crt` in the `<cluster_dir>/cfc-certs/root-ca/` if the file exists. If you have a certificate chain (see [requirement 3 in the Before you begin section](#bybreq3)), then place the chain within the file `ca-chain.crt` in the `<cluster_dir>/cfc-certs/root-ca/`. For example:
    ```bash
    rm -rf <cluster_dir>/cfc-certs/root-ca/ca-chain.crt
    cp <certificate_location>/<certificate chain file> <cluster_dir>/cfc-certs/root-ca/ca-chain.crt
    ```
    {: codeblock}

3. Delete the certificates and keys that are related with the old CA. For example:
    ```bash
    rm -rf <cluster_dir>/cfc-certs/kubernetes
    rm -rf <cluster_dir>/cfc-certs/helm
    rm -rf <cluster_dir>/cfc-certs/ipsec
    ```
    {: codeblock}

4. Replace the `root-ca` certificates.

 - For {{site.data.keyword.linux&reg}} x86_64, run the following command:
   ```bash
   sudo docker run --net=host -t -e LICENSE=accept \
   -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.0-ee \
   replace-certificates --tags "root-ca-certs"
   ```
   {: codeblock}

 - For Linux&reg; on Power&reg; (ppc64le), run the following command:
   ```bash
   sudo docker run --net=host -t -e LICENSE=accept \
   -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.0-ee \
   replace-certificates --tags "root-ca-certs"
   ```
   {: codeblock}

 - For Linux on IBM Z and LinuxONE, run the following command:
   ```bash
   sudo docker run --net=host -t -e LICENSE=accept \
   -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.0-ee \
   replace-certificates --tags "root-ca-certs"
   ```
   {: codeblock}

  **Note**: When you replace the Root CA, all certificates that are signed by the Root CA are automatically refreshed. These certificates include the Kubernetes, IPSec, and Helm.

5. Manually restart the services by reloading them.
All default tokens and related services must reload. For more information, see [Reloading services](#reload).

6. Manually recreate the image pull secret. For more information, see [Recreate image pull secret](#recreate).
7. Refresh all cert-manager certificates that use the CA. For more information, see [Refreshing cert-manager certificates](#refresh).

8. Run the following command to restart Docker.
    ```bash
    sudo systemctl restart docker
    ```
    {: codeblock}
9. Run the following command to restart Kubelet on your master node.
    ```bash
    sudo systemctl restart kubelet
    ```
    {: codeblock}

## Reloading services
{: #reload}

### Reloading default token
After Root CA is replaced, the default token must be deleted from all namespaces, and related services must restart. The following code deletes the default token from all namespaces and restarts the related services easily.

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
### Recreate image pull secret
{: #recreate}

 - For {{site.data.keyword.linux&reg}} x86_64, run this command:
   ```bash
   sudo docker run --net=host -t -e LICENSE=accept \
   -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.2.0-ee \
   image-pull-secret
   ```
   {: codeblock}
 - For Linux&reg; on Power&reg; (ppc64le), run this command:
   ```bash
   sudo docker run --net=host -t -e LICENSE=accept \
   -v "$(pwd)":/installer/cluster ibmcom/icp-inception-ppc64le:3.2.0-ee \
   image-pull-secret
   ```
   {: codeblock}
 - For Linux on IBM Z and LinuxONE, run this command:
   ```bash
   sudo docker run --net=host -t -e LICENSE=accept \
   -v "$(pwd)":/installer/cluster ibmcom/icp-inception-s390x:3.2.0-ee \
   image-pull-secret
   ```
   {: codeblock}

## Refreshing cert-manager certificates
{: #refresh}

After the Root CA is replaced, all certificates that are signed by the Root CA must be refreshed and the services that use those certificates must be restarted. Cert-manager creates the default ClusterIssuer from the Root CA, so all of the certificates issued by cert-manager and signed by the default ClusterIssuer must also be refreshed.

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
