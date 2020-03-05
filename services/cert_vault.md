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


# Using Vault to issue certificates

Certificate manager Issuer supports using the [HashiCorp Vault ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.vaultproject.io/docs/install/) server to create and issue certificates. To use the Vault Issuer, you must have setup a Vault server that is accessible to Certificate manager.

**Important:** Certificate manager attempts to create certificates with a 90 day expiration when using the Vault Issuer, so the _max_ttl_ needs to be at least 90 days (2160 hours). Do not use a _max_ttl_ that is less than 30 days because Certificate Manager attempts to renew certificates when the expiration is within 30 days.

## Configuring the certificate engine in Vault

Complete the following configuration on your Vault server:

1. Enable the PKI (Certificates) Secrets engine by running the following command:

   ```
   vault secrets enable pki
   ```
   {: codeblock}

2. Run the following command to tune the secret engine so that your certificates satisfy the Certificate manager 90-day duration request:

    ```
    vault secrets tune -max-lease-ttl=8760h pki
    ```
    {: codeblock}

3. Run the following command to create a self-signed CA certificate and key pair with a customized expiration.

    ```
    vault write pki/root/generate/internal common_name=ibm.com ttl=8760h
    ```
    {: codeblock}

    The previous command is used for root CA, but can be extended to use an intermediate CA. The HashiCorp Vault product documentation provides more information on this scenario.

4. Configure URLs for creating the certificates with the following command, where `vault_server` is your Vault server IP address. Run the following command:
    ```
     vault write pki/config/urls issuing_certificates="http://<vault_server>:8200/v1/pki/ca" crl_distribution_points="http://<vault_server>:8200/v1/pki/crl"
    ```
    {: codeblock}
5. Create a role that can process the certificate signing requests. Run the following command:

   ```
   vault write pki/roles/my-role allowed_domains=ibm.com allow_subdomains=true allow_any_name=true allow_localhost=true enforce_hostnames=false max_ttl=8760h
   ```
   {: codeblock}

After the Vault server is configured to issue certificates, Kubernetes resources can be created that refer to the Vault server for certificate creation.

## Authenticate with the Vault server

The Vault Server support in Certificate manager supports two authentication methods. The Certificate manager Issuer must use one of the following authentication methods.

   - Token Authentication

   - AppRole Authentication

   **Note**: If TLS is enabled on your Vault server, include the `caBundle` parameter under the `vault` section. Set the `caBundle` value to the base64 encoded CA cert in PEM format. For more information, see the [HashiCorp Vault Server TLS Listener ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.vaultproject.io/docs/configuration/listener/tcp.html) documentation.


### Create Issuers by using the Token Authentication

Using Vault with token authentication requires a Kubernetes Secret that contains the Vault authentication token. The authentication token must be `base64` encoded when stored in the Secret. Create this resource in the same namespace where you want the Issuer. If you are using a ClusterIssuer, you must create this Secret in the `kube-system` namespace.

Tokens can be created by using the Vault APIs. Be aware that you need to renew tokens that expire, since Certificate manager is not aware of token expirations. The [HashiCorp Vault ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.vaultproject.io/docs/auth/token.html) documentation contains more details on token authentication.

Complete the following configuration on your Vault server:

1. Create a policy that enables usage of the PKI Vault APIs. Your policy must include the following capabilities: _create_, _read_, _update_, _delete_, _list_, and _sudo_.

  - Create a policy file and name it similar to `pki_policy.hcl`. Add the following contents to your policy file:

    ```
    path "pki*" {  capabilities = ["create", "read", "update", "delete", "list", "sudo"]}
    ```
    {: codeblock}

  - Run the following command to create the policy where `pki_policy` is the policy name and `pki_policy.hcl` is the file name:

    ```
    vault policy write pki_policy pki_policy.hcl
    ```
    {: codeblock}

2. Create a token that uses the policy that you just created. Run the following command, where `pki_policy` is the name of the policy that you just created. Be sure that the `ttl` setting is longer than the period that you want to issue renewals against the token that you created:

    ```
    vault write /auth/token/create policies=<"pki_policy"> no_parent=true no_default_policy=true renewable=true ttl=767h num_uses=0
    ```
    {: codeblock}

3. Create a Kubernetes Secret that contains your base64 encoded authentication token. You can encode the token with the following command, where `abe02917-7494-c94c-a4f1-99890caf06d7` is your token:

    ```
    echo abe02917-7494-c94c-a4f1-99890caf06d7 | base64
    ```
    {: codeblock}

    See the following YAML sample, which defines a Secret with a Vault token:

    ```
    apiVersion: v1
    kind: Secret
    type: Opaque
    metadata:
      name: my-vault-token
      namespace: default
    data:
      token: "YWJlMDI5MTctNzQ5NC1jOTRjLWE0ZjEtOTk4OTBjYWYwNmQ3Cg=="
    ```
    {: pre}

  Important: Tokens in Vault will expire. Certificate manager does not refresh the token to keep it from expiring, so be sure to address token renewals. A root token does not expire, but should not be used except in a development or test environment.

  To renew the token, run a Vault command similar to the following command, where `abe02917-7494-c94c-a4f1-99890caf06d7` is your token:

  ```
  vault write /auth/token/renew token=abe02917-7494-c94c-a4f1-99890caf06d7
  ```
  {: codeblock}

4. Create the Vault Issuer that uses the Vault token Secret. The Vault Issuer references the Secret that you just created, the URL for the Vault server, and the path to a role:

    ```
    apiVersion: certmanager.k8s.io/v1alpha1
    kind: Issuer
    metadata:
      name: my-vault-issuer
      namespace: default
    spec:
      vault:
        path: pki/sign/my-role
        server: http://192.168.44.241:8200
        auth:
          tokenSecretRef:
            name: my-vault-token
            key: token
    ```
    {: codeblock}

5. Create a certificate that uses the Vault Issuer. The following example defines a certificate that uses the Issuer, which is referenced in the previous step:

    ```
    apiVersion: certmanager.k8s.io/v1alpha1
    kind: Certificate
    metadata:
      name: my-cert1-com
      namespace: default
    spec:
      secretName: my-cert1-tls
      issuerRef:
        name: my-vault-issuer
      commonName: myhostname.ibm.com
      dnsNames:
      - myhostname.ibm.com
    ```
    {: codeblock}

### Create issuers by using AppRole authentication

Vault supports AppRole authentication, which allows Certificate manager to connect to Vault by using an AppRole secret identifier instead of a token. Complete the following configuration on your Vault server to configure AppRole authentication.  

See the [HashiCorp Vault ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.vaultproject.io/docs/auth/approle.html) documentation for more information.

1. Enable AppRole Authentication with the following command:

   ```
   vault auth enable approle
   ```
   {: codeblock}

2. Create a policy that enables usage of the PKI Vault APIs. Your policy must include the following capabilities: _create_, _read_, _update_, _delete_, _list_, and _sudo_.

  - Create a policy file and name it similar to `pki_policy.hcl`. Add the following contents to your policy file:

    ```
    path "pki*" {  capabilities = ["create", "read", "update", "delete", "list", "sudo"]}
    ```
    {: codeblock}

  - Run the following command to create the policy where `pki_policy` is the policy name and `pki_policy.hcl` is the file name:

    ```
    vault policy write pki_policy pki_policy.hcl
    ```
    {: codeblock}

3. Run the following command to create a named role that uses the policy that you created:

    ```
    vault write auth/approle/role/my-role secret_id_ttl=8760h token_num_uses=0 token_ttl=20m token_max_ttl=30m secret_id_num_uses=0 policies=pki_policy
    ```
    {: codeblock}

    Important: The _secret_id_ttl_ expiration is similar to token expiration except the secret_id cannot be renewed.

4. Get the _role_id_ of the AppRole with the following command:

    ```
    vault read auth/approle/role/my-role/role-id
    ```
    {: codeblock}

5. Get a _secret_id_ for the AppRole with the following command:

    ```
    vault write -f auth/approle/role/my-role/secret-id
    ```
    {: codeblock}

6. Next, you need to create a Kubernetes Secret that contains your base64 encoded AppRole secret_id. Using Vault with AppRole authentication requires a Kubernetes Secret that contains the Vault AppRole `secret_id`.

   The AppRole `secret_id` must be base64 encoded when stored in the Secret. Create this resource in the same namespace where you want the Issuer. If you are using a ClusterIssuer, you must create this Secret in the `kube-system` namespace.

   ```
   echo abe02917-7494-c94c-a4f1-99890caf06d7 | base64
   ```
   {: codeblock}

   See the following YAML sample, which defines a Kubernetes Secret that contains your base64 encoded AppRole `secret_id`:

   ```
   apiVersion: v1
   kind: Secret
   type: Opaque
   metadata:
     name: cm-vault-approle
     namespace: default
   data:
     secretId: "ZmNlODI5OWUtNjlkNi1hZjY1LWRhYTItYWYxODI4OWZkYjVjCg=="
   ```
   {: pre}

7. Next, create the Vault Issuer that uses the AppRole Secret. Edit the following YAML sample.

   ```
   apiVersion: certmanager.k8s.io/v1alpha1
   kind: Issuer
   metadata:
     name: cm-vault-issuer
     namespace: default
   spec:
     vault:
       path: pki/sign/my-role
       server: http://192.168.230.158:8200
       auth:
         appRole:
           path: approle
           roleId: "92b6d857-6917-b2cf-6a51-94a44989d2b2"
           secretRef:
             name: cm-vault-approle
             key: secretId
   ```
   {: codeblock}

   Here, the Certificate manager Vault Issuer references the Secret that you just created, which contains the `secret_id` of the AppRole authentication. The Issuer specifies the `role_id`. The Vault server and URL path for processing certificate signing requests is also provided.

   Important: When using AppRole authentication, be careful to not confuse the two roles. One role is used for the certificate signing, which is specified in the Issuer `vault` `path`.  The other role is for authorizing certain capabilities within the AppRole.

8. Create a certificate that uses the Vault Issuer.

   The following sample defines a certificate that uses the Issuer, which is referenced in the previous step:

   ```
   apiVersion: certmanager.k8s.io/v1alpha1
   kind: Certificate
   metadata:
     name: vault-approle-aludel1-cert
     namespace: default
   spec:
     secretName: vault-approle-aludel1-cert-secret
     issuerRef:
       name: cm-vault-issuer
     commonName: myhostname.ibm.com
     dnsNames:
     - myhostname.ibm.com
   ```
   {: codeblock}

If the `secret_id_ttl` is set too small and that value expires, a new `secret_id` must be created. The Issuer and the referenced Secret need to be edited to configure the new `secret_id`.

See [Using {{site.data.keyword.product}} Certificate manager (cert-manager)](cert_manager.md) for more Certificate manager topics.