---

copyright:
  years: 2016, 2019
lastupdated: "2019-12-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Specifying your own certificate authority for Red Hat Advanced Cluster Management for Kubernetes services

All certificates required by services that run on Red Hat Advanced Cluster Management for Kubernetes are created during the installation of Red Hat Advanced Cluster Management for Kubernetes. Certificates are either created and managed by the Red Hat Advanced Cluster Management for Kubernetes installer or by the Red Hat Advanced Cluster Management for Kubernetes Certificate manager (cert-manager). These certificates are signed by a certificate authority (CA) also created during installation.
{: shortdesc}

Before you install Red Hat Advanced Cluster Management for Kubernetes, you can provide your own certificate authority (CA) to sign certificates used by Red Hat Advanced Cluster Management for Kubernetes services.

## Use your own certificate authority (CA) (BYOK)
{: #own}

You can BYOK (Bring Your Own Key) to use inside your Red Hat Advanced Cluster Management for Kubernetes cluster. Your BYOK certificate key must be exported in PEM (OpenSSL) format. 

1. Create the `cfc-certs/root-ca` directory inside your cluster directory.
    ```
    mkdir -p <installation_dir>/cluster/cfc-certs/root-ca
    ```
    {: codeblock}

2. Rename your existing CA key to `ca.key` and copy it to the installation directory.
    ```
    cp <BYOK> <installation_dir>/cluster/cfc-certs/root-ca/ca.key
    ```
    {: codeblock}

3. Rename your existing CA certificate to `ca.crt`, and copy it to the installation directory.
    ```
    cp <BYOK_cert> <installation_dir>/cluster/cfc-certs/root-ca/ca.crt
    ```
    {: codeblock}
4. If you have a certificate chain, then place the chain within the file `ca-chain.crt` in the directory `<installation_dir>/cfc-certs/root-ca/`. For example:
    ```
    cp <BYOK_cert_chain> <installation_dir>/cluster/cfc-certs/root-ca/ca-chain.crt
    ```
    {: codeblock}
    
   **NOTE**: The certificate chain must contain only the signers of the BYO CA certificate, but must not contain the BYO CA certificate itself. The order of the chain must be the immediate signer of your BYO CA, followed by the signer of that CA, etc.

5. Install your cluster.

### Accessing the Red Hat Advanced Cluster Management for Kubernetes Root CA
After you bring your own Red Hat Advanced Cluster Management for Kubernetes Root CA, the Red Hat Advanced Cluster Management for Kubernetes Root CA Certificate are accessible by way of the Kubernetes Secret `ibmcloud-cluster-ca-cert` in the `kube-public` namespace.

To retrieve and decode the certificate, run the following command:
```
kubectl get secret -n kube-public ibmcloud-cluster-ca-cert -o jsonpath='{.data.ca\.crt}' | base64 --decode
```
{: codeblock}
