---

copyright:
  years: 2018, 2019
lastupdated: "2019-11-18"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Adding certificates by using the ECDSA algorithm for encryption

With certificate manager, you can encrypt with the ECDSA algorithm. A certificate can specify the key signing algorithm and the key size. Use the `keyAlgorithm` and `keySize` parameters to specify your customizations for the private key. If these parameters are not set, a 2048-bit RSA key is created.

* [Creating a certificate with ECDSA](#ecdsa_cert)
* [Using ECDSA with Issuers](#ecdsa_issuer)

## Creating a certificate with ECDSA
{: #ecdsa_cert}

To create a certificate that uses the ECDSA algorithm for encryption, follow the procedure in [Creating Red Hat Advanced Cluster Management for Kubernetes Certificate manager (cert-manager) certificates](create_cert.md), but use the following sample where `keyAlgorithm` and `keySize` are required:

```
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: ecdsa-ca-cert
  namespace: default
spec:
  secretName: ecdsa-ca-secret
  keyAlgorithm: ecdsa
  keySize: 521
  isCA: true
  issuerRef:
    name: ss-issuer
    kind: Issuer
  commonName: foo1.bar1
  dnsNames:
  - foo1.bar1
```  
{: codeblock}

## Using ECDSA with Issuers
{: #ecdsa_issuer}

### CA Issuer

1. See the following sample YAML, which uses Certificate manager to create a CA Issuer that uses ECDSA:

   ```
   apiVersion: certmanager.k8s.io/v1alpha1
   kind: Issuer
   metadata:
     name: ss-issuer
     namespace: default
   spec:
     selfSigned: {}
   ```
   {: codeblock}

2. Next, create a CA certificate that is issued from the self-signed Issuer and using the ECDSA key algorithm. See the following sample:

   ```
   apiVersion: certmanager.k8s.io/v1alpha1
   kind: Certificate
   metadata:
     name: ecdsa-ca-cert
     namespace: default
   spec:
     secretName: ecdsa-ca-secret
     keyAlgorithm: ecdsa
     keySize: 521
     isCA: true
     issuerRef:
       name: ss-issuer
       kind: Issuer
     commonName: foo1.bar1
     dnsNames:
     - foo1.bar1
    ```
    {: codeblock}

3. Edit the following sample to create the CA Issuer with the CA certificate:

   ```
   apiVersion: certmanager.k8s.io/v1alpha1
   kind: Issuer
   metadata:
     name: ecdsa-ca-issuer
     namespace: default
   spec:
     ca:
       secretName: ecdsa-ca-secret
   ```
   {: codeblock}

### Vault Issuer

You can create certificates from a Vault Issuer that uses ECDSA keys instead of RSA by configuring the Vault PKI endpoint certificate update role. For more information about Vault Issuer, see [Adding a certificate by using the Vault Issuer](cert_vault.md).

Go to your Vault server and run the following configuration command and edit the `key_bits` and `key_type`:

  ```
  vault write auth/approle/role/my-role secret_id_ttl=8760h token_num_uses=0 token_ttl=20m token_max_ttl=30m secret_id_num_uses=0 policies=pki_policy key_type=ec key_bits=521
  ```
  {: codeblock}

When you create certificate resources, be sure to use a `keySize` that matches, or is greater than, the `key_bits` that you specify in your Vault server:

  ```
  key_type=ec
  key_bits=256, 384 or 521
  ```
  {: pre}

See [Using Red Hat Advanced Cluster Management for Kubernetes Certificate manager (cert-manager)](cert_manager.md) for more Certificate manager topics.