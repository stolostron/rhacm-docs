---

copyright:
  years: 2019, 2020
lastupdated: "2020-02-19"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Replacing management ingress certificates

You can replace management ingress certificates.
{: shortdesc}

## Before you begin

Prepare and have your management-ingress certificates and private keys ready. If needed, you can generate a TLS certificate by using OpenSSL. If you are generating the certificate, include the following settings:

* Include the following IP addresses and domain names to your cert Subject Alternative Name (SAN) list:
  ```
  127.0.0.1
  <cluster_CA_domain>   # The Red Hat Advanced Cluster Management for Kubernetes cluster Certificate Authority (CA) domain.
  <cluster_lb_address>  # Your cluster load balancer IP address.
  <cluster_vip>         # Your Virtual IP address, if applicable. 
  ```
  {: codeblock}

  The cluster certificate authority (CA) domain is set in the `config.yaml` file during installation. The default value is `mycluster.icp`. This value can be the same as the <cluster_lb_address> if you use the domain name of your load balancer as the CA domain.  
   
  If you configure a cluster load balancer (LB) and it is a hostname, include the hostname in the `DNS` setting for your certificate. If your cluster load balancer (LB) is not a hostname, include the IP address in the `IP` settings. 

* Set the common name `CN` on the certificate to be your Red Hat Advanced Cluster Management for Kubernetes cluster CA domain.

The following example configuration file and OpenSSL commands provide an example for how to generate a TLS certificate by using OpenSSL.

### Example configuration file for generating a certificate
  
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

### OpenSSL commands for generating a certificate

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

     Ensure that the common name on the certificate is the Red Hat Advanced Cluster Management for Kubernetes cluster CA domain.

## Replacing the management ingress certificate

Complete the following steps to replace a management ingress certificate.

1. Delete the icp-management-ingress cert-manager certificate.
   ```
   kubectl -n kube-system delete cert icp-management-ingress-cert
   ```
   {: codeblock}

2. Delete the icp-management-ingress secret that contains the certificate.
   ```
   kubectl -n kube-system delete secret icp-management-ingress-tls-secret
   ```
   {: codeblock}

3. Create the icp-management-ingress secret by using your certificate and private key.
   ```
   kubectl -n kube-system create secret tls icp-management-ingress-tls-secret --cert ./icp-router.crt --key ./icp-router.key
   ```
   {: codeblock}

4. Verify that the secret is created in the correct namespace.
   ```
   kubectl get secret -n kube-system | grep icp-management-ingress-tls-secret
   ```
   {: codeblock}

5. Restart all pods by using the icp-management-ingress secret.
   ```
	secretName=icp-management-ingress-tls-secret
	kubectl get po --field-selector=status.phase!=Completed,status.phase!=Succeeded,status.phase!=Unknow --no-headers -o=custom-columns=:metadata.name,:metadata.namespace --all-namespaces | while read pod; do
	   podName=$(echo $pod | awk '{print $1}')
	   namespace=$(echo $pod | awk '{print $2}')
		has_secret=$(kubectl get pod -o yaml $podName -n $namespace | grep $secretName)
		if [[ ! -z "$has_secret" ]] ; then
		echo "Restarting pod $podName"
		kubectl delete pod -n $namespace $podName --grace-period=0 --force &>/dev/null
		fi
	done
   ```
   {: codeblock}

6. After all pods are restarted, navigate to the Red Hat Advanced Cluster Management for Kubernetes console from your browser. Verify that the current certificate is your certificate, and that all console access and login functionality remain the same.   

**Note:** Several functions are affected by using your own certificate for management ingress. For example, when you use the Helm command to add a Helm repository. If you are adding the repository for your cluster, specify the management ingress CA file as the value for `--ca-file` instead of the Helm CA file. For example,
```
helm repo add mgmt-charts https://mycluster.icp:8443/mgmt-repo/charts --ca-file <installer directory>/cluster/cfc-certs/router/icp-router-ca.crt --cert-file ~/.helm/cert.pem --key-file ~/.helm/key.pem
```
{: codeblock}

You need to use the management ingress CA file since the repository is from the cluster itself `https://mycluster.icp:8443/mgmt-repo/charts` and the Helm command to add the Helm repository requires the CA of that repository. For more information about this command, see [Helm documentation ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://helm.sh/docs/howto/chart_repository_sync_example/){: new_window}.


## Restoring the default self-signed certificate for management ingress

1. Retrieve your previous Red Hat Advanced Cluster Management for Kubernetes management ingress certificate content from the Helm release: 

   1. Run the following command to list the management ingress Helm release: 
      ```
      helm list --tls | grep icp-management-ingress
      ```
      {: codeblock}

      Output: 
      ```
      icp-management-ingress     	1       	Tue Oct 29 09:42:37 2019	DEPLOYED	icp-management-ingress-3.3.0    	3.2.1         	kube-system
      ```
      {: codeblock}

   2. Run the following command to retrieve the Helm release content and locate the management ingress certificate content:
      ```
      helm get icp-management-ingress --tls
      ```
      {: codeblock}

      Output:
      ```
      # Source: icp-management-ingress/templates/cert-crd.yaml
      apiVersion: certmanager.k8s.io/v1alpha1
      kind: Certificate
      metadata:
      name: icp-management-ingress-cert
      namespace: kube-system
      labels:
         app: icp-management-ingress
         chart: icp-management-ingress-3.3.0
         heritage: Tiller
         release: icp-management-ingress
      spec:
      secretName: icp-management-ingress-tls-secret
      issuerRef:
         name: icp-ca-issuer
         kind: ClusterIssuer
      commonName: "byotest.icp"
      dnsNames:
      - icp-management-ingress
      - icp-management-ingress.kube-system
      - icp-management-ingress.kube-system.svc
      ipAddresses:
      - 127.0.0.1
      - 9.30.249.231
      - 172.16.172.238
      duration: 2160h
      renewBefore: 24h
      ```
      {: codeblock}

   3. Save the retrieved certificate content to your local file system as a `icp-management-ingress-cert.yaml` file.

2. Create your Red Hat Advanced Cluster Management for Kubernetes management ingress certificate with the following command: 

   ```
   kubectl -n kube-system apply -f icp-management-ingress-cert.yaml
   ```
   {: codeblock}

3. Delete your Red Hat Advanced Cluster Management for Kubernetes management ingress secret:
   ```
   kubectl -n kube-system delete secret icp-management-ingress-tls-secret
   ```
   {: codeblock2}

4. Restart all pods by using the icp-management-ingress secret.
   ```
    secretName=icp-management-ingress-tls-secret
    kubectl get po --field-selector=status.phase!=Completed,status.phase!=Succeeded,status.phase!=Unknow --no-headers -o=custom-columns=:metadata.name,:metadata.namespace --all-namespaces | while read pod; do
       podName=$(echo $pod | awk '{print $1}')
       namespace=$(echo $pod | awk '{print $2}')
 	   has_secret=$(kubectl get pod -o yaml $podName -n $namespace | grep $secretName)
 	   if [[ ! -z "$has_secret" ]] ; then
 	   echo "Restarting pod $podName"
 	   kubectl delete pod -n $namespace $podName --grace-period=0 --force &>/dev/null
 	   fi
    done
   ```
   {: codeblock}   

5. After all pods are restarted, navigate to the Red Hat Advanced Cluster Management for Kubernetes console from your browser. Verify that the current certificate is your certificate, and that all console access and login functionality remain the same.


**Note:** Several functions are affected by using the default self-signed certificate for management ingress. For example, when you use the Helm command to add a Helm repository. If you are adding the repository for your cluster, specify the management ingress CA file as the value for `--ca-file` instead of the Helm CA file. For example,
```
helm repo add mgmt-charts https://mycluster.icp:8443/mgmt-repo/charts --ca-file <installer directory>/cluster/cfc-certs/router/icp-router-ca.crt --cert-file ~/.helm/cert.pem --key-file ~/.helm/key.pem
```
{: codeblock}

You need to use the management ingress CA file since the repository is from the cluster itself `https://mycluster.icp:8443/mgmt-repo/charts` and the Helm command to add the Helm repository requires the CA of that repository. For more information about this command, see [Helm documentation ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://helm.sh/docs/howto/chart_repository_sync_example/){: new_window}.



   