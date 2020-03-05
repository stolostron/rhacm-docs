---

copyright:
  years: 2019
lastupdated: "2019-11-18"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Replacing image manager certificates

You can replace image manager certificates.
{: shortdesc}

## Before you begin

Prepare and have your management-ingress certificates and private keys ready. Two certificates are required. If needed, you can generate a TLS certificate by using OpenSSL. If you are generating the certificate, include the following settings:

* Include the following IP addresses and domain names to your cert Subject Alternative Name (SAN) list:
  ```
  127.0.0.1
  <cluster_CA_domain>   # The {{site.data.keyword.product}} cluster Certificate Authority (CA) domain.
  <cluster_lb_address>  # Your cluster load balancer IP address.
  <cluster_vip>         # Your Virtual IP address, if applicable. 
  ```
  {: codeblock}

  The cluster certificate authority (CA) domain is set in the `config.yaml` file during installation. The default value is `mycluster.icp`. This value can be the same as the <cluster_lb_address> if you use the domain name of your load balancer as the CA domain.  
   
  If you configure a cluster load balancer (LB) and it is a hostname, include the hostname in the `DNS` setting for your certificate. If your cluster load balancer (LB) is not a hostname, include the IP address in the `IP` settings. 

* Set the common name `CN` on the certificate to be your {{site.data.keyword.product}} cluster CA domain.

The following example configuration file and OpenSSL commands provide an example for how to generate a TLS certificate by using OpenSSL.

#### Example configuration file for generating a certificate
  
The following `csr.cnf` configuration file defines the configuration settings for generating certificates with OpenSSL. 
  ```
  # cat csr.cnf
  [ req ]               # Main settings
  default_bits = 2048       # Default key size in bits.
  prompt = no               # Disables prompting for certificate values so the configuration file values are used.
  default_md = sha256       # Specifies the digest algorithm.
  req_extensions = req_ext  # Specifies the configuration file section that includes any extensions.
  distinguished_name = dn   # Specifies the section that includes the distinguished name information.

  [ dn ]               # Distinguished name settings
  C = US                    # Country
  ST = New York             # State or province
  L = Armonk                # Locality
  O = IBM Cloud Private     # Organization
  OU = IBM Cloud Pak        # Organizational unit
  CN = <cluster_CA_domain>  # Common name. 

  [ req_ext ]          # Extensions
  subjectAltName = @alt_names # Subject alternative names

  [ alt_names ]        # Subject alternative names
  DNS.1 = <cluster_CA_domain>   
  IP.1 = <cluster_vip>          
  IP.2 = <cluster_lb_address> 
  IP.3 = 127.0.0.1

  [ v3_ext ]          # x509v3 extensions
  authorityKeyIdentifier=keyid,issuer:always  # Specifies the public key that corresponds to the private key that is used to sign a certificate.
  basicConstraints=CA:FALSE                   # Indicates whether the certificate is a CA certificate during the certificate chain verification process. 
  keyUsage=keyEncipherment,dataEncipherment   # Defines the purpose of the key that is contained in the certificate. 
  extendedKeyUsage=serverAuth,clientAuth      # Defines the purposes for which the public key can be used. 
  subjectAltName=@alt_names                   # Identifies the subject alternative names for the identify that is bound to the public key by the CA.
  ```
  {: codeblock}

#### OpenSSL commands for generating a certificate

The following OpenSSL commands are used with the preceding configuration file to generate the required TLS certificate.

  1. Generate your certificate authority (CA) RSA private key:
     ```
     openssl genrsa -out ca.key 2048
     ```
     {: codeblock}

  2. Generate a self-signed CA certificate by using your CA key:
     ```
     openssl req -x509 -new -nodes -key ca.key -subj "/C=US/ST=New York/L=Armonk/O=IBM Cloud  Private" -days 100 -out ca.crt
     ```
     {: codeblock}

  3. Generate the RSA private key for your certificate:
     ```
     openssl genrsa -out icp-router.key 2048
     ```
     {: codeblock}

  4. Generate the Certificate Signing request (CSR) by using the private key:
     ```
     openssl req -new -key icp-router.key -out icp-router.csr -config csr.cnf
     ```
     {: codeblock}

  5. Generate a signed certificate by using your CA certificate and key and CSR: 
     ```
     openssl x509 -req -in icp-router.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out icp-router.crt -days 1000 -extensions v3_ext -extfile csr.cnf
     ```
     {: codeblock}

  6. Examine the certificate contents: 
     ```
     openssl x509  -noout -text -in ./icp-router.crt
     ```
     {: codeblock}  

     Ensure that the common name on the certificate is the {{site.data.keyword.icp_notm}} cluster CA domain.

## Replace image manager certificates

Complete the following steps to replace image manager certificates.

1. Delete the image manager cert-manager certificates.
   ```
   kubectl delete cert -n kube-system $(kubectl get cert -o custom-columns=:metadata.name -n kube-system | grep image-manager-cert)
   kubectl delete cert -n kube-system $(kubectl get cert -o custom-columns=:metadata.name -n kube-system | grep image-manager-registry-cert)
   ```
   {: codeblock}

2. Delete the image manager secrets that contain the certificates.
   ```
   kubectl delete secret -n kube-system $(kubectl get secret -o custom-columns=:metadata.name -n kube-system | grep image-manager-tls)
   kubectl delete secret -n kube-system $(kubectl get secret -o custom-columns=:metadata.name -n kube-system | grep image-manager-registry-tls)
   ```
   {: codeblock}

3. Create the image manager secret by using your certificate and private key.
   ```
   kubectl create secret tls image-manager-tls-secret --cert ./icp-router.crt --key ./icp-router.key -n kube-system 
   kubectl create secret tls image-manager-registry-tls-secret --cert ./icp-router.crt --key ./icp-router.key -n kube-system
   ```
   {: codeblock}   

4. Delete all image manager pods, including the init pods. For example, `image-manager-init-certs-k2n5c`, `image-manager-init-certs-kr6xp`, and `image-manager-init-certs-ntsmq`.
   ```
   kubectl -n kube-system get pods -o custom-columns=:metadata.name | grep image-manager | while read po ; do kubectl -n kube-system delete pod $po ; done
   ```
   {: codeblock}

5. After all pods are restarted, check the following:
   - Log in to your private image registry to verify that you are able to `push` and `pull` images to and from the {{site.data.keyword.product}} private registry.
     ```
     docker login mycluster.icp:8500
     ```
     {: codeblock}

   - If Vulnerability Advisor (VA) is enabled, verify that images that are pushed into the registry are being scanned by VA.
   - Verify that images that are pushed to the registry are viewable from the {{site.data.keyword.product}} {{site.data.keyword.gui}}.
