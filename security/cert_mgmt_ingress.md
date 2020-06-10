# Replacing the management ingress certificates

You can replace management ingress certificates. If you replace the default ingress certificate for OpenShift Container Platform, you need to make modifications to the management ingress. For more information see, _500 Internal error during login to the console_ in the [Security known issues](#security-known-issues).

## Prerequisites to replace management ingress certificate

Prepare and have your `management-ingress` certificates and private keys ready. If needed, you can generate a TLS certificate by using OpenSSL. Set the common name parameter,`CN`, on the certificate to `manangement-ingress`. If you are generating the certificate, include the following settings:

* Include the following IP addresses and domain names in your certificate Subject Alternative Name (SAN) list:
  * The service name for the management ingress: `management-ingress`.
  * Include the route name for Red Hat Advanced Cluster Management for Kubernetes. Recieve the route name by running the following command:

     ```
     oc get route -n open-cluster-management
     ```

     You might receieve the following response:

     ```
     multicloud-console.apps.grchub2.dev08.red-chesterfield.com
     ```
  * Add the localhost IP address: `127.0.0.1`.
  * Add the localhost entry: `localhost`.

### Example configuration file for generating a certificate

The following example configuration file and OpenSSL commands provide an example for how to generate a TLS certificate by using OpenSSL. View the following `csr.cnf` configuration file, which defines the configuration settings for generating certificates with OpenSSL.

   ```
   [ req ]               # Main settings
   default_bits = 2048       # Default key size in bits.
   prompt = no               # Disables prompting for certificate values so the configuration file values are used.
   default_md = sha256       # Specifies the digest algorithm.
   req_extensions = req_ext  # Specifies the configuration file section that includes any extensions.
   distinguished_name = dn   # Specifies the section that includes the distinguished name information.

   [ dn ]               # Distinguished name settings
   C = US                    # Country
   ST = North Carolina             # State or province
   L = Raleigh                # Locality
   O = Red Hat Open Shift     # Organization
   OU = Red Hat Advanced Container Management        # Organizational unit
   CN = management-ingress  # Common name.

   [ req_ext ]          # Extensions
   subjectAltName = @alt_names # Subject alternative names

   [ alt_names ]        # Subject alternative names
   DNS.1 = management-ingress
   DNS.2 = multicloud-console.apps.grchub2.dev08.red-chesterfield.com
   DNS.3 = localhost
   DNS.4 = 127.0.0.1

   [ v3_ext ]          # x509v3 extensions
   authorityKeyIdentifier=keyid,issuer:always  # Specifies the public key that corresponds to the private key that is used to sign a certificate.
   basicConstraints=CA:FALSE                   # Indicates whether the certificate is a CA certificate during the certificate chain verification process.
   #keyUsage=keyEncipherment,dataEncipherment   # Defines the purpose of the key that is contained in the certificate.
   extendedKeyUsage=serverAuth                 # Defines the purposes for which the public key can be used.
   subjectAltName=@alt_names                   # Identifies the subject alternative names for the identify that is bound to the public key by the CA.
   ```

   **Note:** Be sure to update the SAN labeled, `DNS.2` with the correct hostname for your management ingress.


### OpenSSL commands for generating a certificate

The following OpenSSL commands are used with the preceding configuration file to generate the required TLS certificate.

  1. Generate your certificate authority (CA) RSA private key:

     ```
     openssl genrsa -out ca.key 4096
     ```

  2. Generate a self-signed CA certificate by using your CA key:

     ```
     openssl req -x509 -new -nodes -key ca.key -subj "/C=US/ST=North Carolina/L=Raleigh/O=Red Hat OpenShift" -days 400 -out ca.crt
     ```

  3. Generate the RSA private key for your certificate:

     ```
     openssl genrsa -out ingress.key 4096
     ```

  4. Generate the Certificate Signing request (CSR) by using the private key:

     ```
     openssl req -new -key ingress.key -out ingress.csr -config csr.cnf
     ```

  5. Generate a signed certificate by using your CA certificate and key and CSR:

     ```
     openssl x509 -req -in ingress.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out ingress.crt -sha256 -days 300 -extensions v3_ext -extfile csr.cnf
     ```

  6. Examine the certificate contents:

     ```
     openssl x509  -noout -text -in ./ingress.crt
     ```

## Replace the Bring Your Own (BYO) ingress certificate

Complete the following steps to replace your BYO ingress certificate:

1. Create the `byo-ingress-tls` secret by using your certificate and private key. Run the following command:

   ```
   kubectl -n open-cluster-management create secret tls byo-ingress-tls-secret --cert ./ingress.crt --key ./ingress.key
   ```

2. Verify that the secret is created in the correct namespace.

   ```
   kubectl get secret -n open-cluster-management | grep byo-ingress | grep tls
   ```

3. Create a secret containing the CA certificate by running the following command:

     ```
     kubectl -n open-cluster-management create secret tls ingress-ca-cert --cert ./ca.crt --key ./ca.key
     ```

4. Edit the management ingress deployment. Get the name of the deployment. Run the following commands:

   ```
   oc get deployment -n open-cluster-management

   oc edit deployment management-ingress -n open-cluster-management
   ```

   * Replace the string similar to `multicloud-ca-cert` with `ingress-ca-cert`.

   * Replace the string similar to `management-ingress-b6417-tls-secret` with `byo-ingress-tls-secret`.

   * Save your deployment and close the editor. The management ingress automatically restarts.

5. After the management ingress pod has restarted, navigate to the Red Hat Advanced Cluster Management for Kubernetes console from your browser. Verify that the current certificate is your certificate, and that all console access and login functionality remain the same.

## Restore the default self-signed certificate for management ingress

1. Edit the management ingress deployment. Replace the string `multicloud-ca-cert` with `ingress-ca-cert`. Get the name of the deployment. Run the following commands:

      ```
      oc get deployment -n open-cluster-management

      oc edit deployment management-ingress -n open-cluster-management
      ```

   1. Replace the `ingress-ca-cert` string  with `multicloud-ca-cert`.

   2. Replace the `byo-ingress-tls-secret` string with the correct secret name similar to `management-ingress-b6417-tls-secret`.
   3. Save your deployment and close the editor. The management ingress automatically restarts.

2. After all pods are restarted, navigate to the Red Hat Advanced Cluster Management for Kubernetes console from your browser. Verify that the current certificate is your certificate, and that all console access and login functionality remain the same.

3. Delete the Bring Your Own (BYO) ingress secret by running the following command:

   ```
   oc delete secret -n open-cluster-management byo-ingress-tls-secret
   ```

See [Certificates](certificates.md) for more information about certificates that are created and managed by Red Hat Advanced Cluster Management for Kubernates. Return to the [Security page](security_intro.md) for more information on securing your cluster.
