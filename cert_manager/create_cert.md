---

copyright:
  years: 2018, 2020
lastupdated: "2020-03-24"

---

# Creating Certificate manager (cert-manager) certificates

<!--Gus created an issue to test #898-->The Certificate manager service is used to issue and manage certificates for services. Certificate manager is based on the [jetstack/cert-manager project](https://github.com/jetstack/cert-manager).
{: shortdesc}

* [Adding a certificate to a Kubernetes workload](#adding_workload)
* [Adding a certificate to a Kubernetes Ingress](#adding_ingress)
* [Customizing Certificate manager (cert-manager) certificates](create_cert_advance.md)

## Adding a certificate to a Kubernetes workload
{: #adding_workload}

1. Define an Issuer. You can define _Issuers_ (namespace-scoped) or _ClusterIssuers_ (cluster-scoped). Certificate manager service supports the following types of Issuers. For information about defining and creating Issuers, select the applicable links from the following list:
  - [Self-signed and CA Issuers ](create_issuer.md)
  - [Vault Issuer](cert_vault.md)
  - [Acme Issuer](cert_acme.md)

2. To define the Certificate, edit the `metadata` where `<name>` is associated with the certificate and the `<namespace>` is where the certificate is created. Additionally, edit the `spec` section of the following example. The following example defines a certificate that uses the Self-signed Issuer from the Self-signed Issuer instructions in step one. Notice that the `<namespace>` of the certificate matches the `<namespace>` of the Issuer:

   ```
   apiVersion: certmanager.io/v1alpha1
   kind: Certificate
   metadata:
     name: hello-deployment-tls-1
     namespace: foobar
   spec:
     # name of the tls secret to store
     # the generated certificate/key pair
     secretName: hello-deployment-tls-1
     issuerRef:
       # Issuer Name
       name: hello-myself-tls
       # The default value is Issuer (i.e.
       # a locally namespaced Issuer)
       kind: Issuer
     commonName: "foo1.bar1"
     dnsNames:
      # one or more fully-qualified domain names
      # can be defined here
     - foo1.bar1
     ipAddresses:
      # one or more IP addresses can be defined here
     - 0.0.0.0
     - 127.0.0.1
   ```

   **Notes**:
   - If the `commonName` field is specified, then the `dnsNames` field is not mandatory and vice-versa.
   - The value for `commonName` or the first value of `dnsNames` must be fewer than 64 characters long.
   - The `secretName` must be unique to the namespace in which the certificate is created. In other words, it cannot have the same `secretName` as any other cert-manager certificate that exists in the same namespace.

3. Mount the Secret to the Deployment, DaemonSet, or StatefulSet.

  The Kubernetes Secret that contains the certificate is mounted to the file system in the same manner as any other secret. For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets-as-files-from-a-pod).

## Adding a certificate to Kubernetes Ingress  
{: #adding_ingress}

The Ingress Kubernetes resource type is used to expose services to an external network. Cert-manager-generated certificates can be added to Ingress resources. An NGINX Kubernetes Ingress point is provided for immediate use.

### Handling Multiple Domain Names

Requests to multiple virtual hosts are handled by the same Ingress. Each virtual host can be terminated with its own certificates. In this case, the fully qualified domain name in the TLS/HTTPS request is used to identify the requested virtual host. The TLS-SNI protocol extension defines this process.

Complete the following procedure to secure the Kubernetes Ingress:

1. Define an Issuer. Certificate manager service supports the following types of Issuers. Click on the link to see how to define and create each:
   - [Self-signed and CA Issuers ](create_issuer.md)
   - [Vault Issuer](cert_vault.md)
   - [Acme Issuer](cert_acme.md)

2. To define the Certificate, edit the `metadata` where `<name>` is associated with the Certificate and the `<namespace>` is where the Certificate is created. Additionally, edit the `spec` section of the following sample, which defines a Certificate that uses the CA Issuer from the CA Issuer instructions in step one. Notice the `<namespace>` of the Certificate matches the `<namespace>` of the Issuer:

  ```
  apiVersion: certmanager.io/v1alpha1
  kind: Certificate
  metadata:
    name: hello-k8s-ingress-tls-1
    namespace: foobar
  spec:
    # name of the tls secret to store
    # the generated certificate/key pair
    secretName: hello-k8s-ingress-tls-1
    issuerRef:
      # Issuer Name
      name: hello-ca-tls
      # The default value is Issuer (i.e.
      # a locally namespaced Issuer)
      kind: Issuer
    commonName: "foo1.bar1"
    dnsNames:
     # one or more fully-qualified domain names
     # can be defined here
    - foo1.bar1
  ```

  Cert-manager creates the certificate based on the certificate resource definition and stores it as a Kubernetes Secret.

3. Add the Secret to the Kubernetes Ingress. The following example defines a TLS-enabled Kubernetes Ingress that is integrated with cert-manager. Here, `hello-k8s-ingress-tls-1` matches the `secretName` that you previously defined and `host` matches the DNS name that you previously defined in the certificate.

   ```
   apiVersion: extensions/v1beta1
   kind: Ingress
   metadata:
     name: hello-k8s-ingress-tls
     annotations:
       kubernetes.io/ingress.class: "nginx"
       ingress.kubernetes.io/rewrite-target: "/"
   spec:
     tls:
     # k8s ingress defines different tls certificates
     # for each nginx server blocks.
     # k8s ingress default cert is used if
     # no host-specific secret specified
     - hosts:
     # this is the fully-qualified domain name
     # of the first server block
       - foo1.bar1
       # certificate hello-k8s-ingress-tls-1
       # is only used by foo1.bar1
       secretName: hello-k8s-ingress-tls-1
     rules:
       # each server block redirects request
       # to its own backend service
     - host: foo1.bar1
       http:
         paths:
         - backend:
             serviceName: hello-world-svc
             servicePort: 80
           path: /fb
   ```


**Note**: Certificates that are created by cert-manager are automatically renewed before expiration. For more information, see [Replacing the root CA certificate](cert_root_ca.md).

For more Certificate manager topics, see [Using Certificate manager (cert-manager)](cert_manager.md).
