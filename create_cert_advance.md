---

copyright:
  years: 2018,2019
lastupdated: "2019-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Customizing cert-manager certificates

Certificate manager service offers features that you can use to customize your certificates.
{: shortdesc}

- [Customizing certificate expiration](#expiration)
- [Customizing certificate private key encoding](#encoding)
- [Customizing certificate key usage](#keyUsage)


## Customizing certificate expiration
{: #expiration}

The default expiration for all certificates is 90 days. The default time before expiration when the Certificate manager service renews the certificates is 30 days.

The Certificate manager service offers custom expiration times. The feature is offered by way of the new `duration` and `renewBefore` fields in a Certificate definition.

`duration` is how long the Certificate is valid.
`renewBefore` is the time before the certificate expires when the Certificate manager service begins attempts to renew the certificate.

The following example of a Certificate definition has a validity period of 30 days (720 hours). Certificate manager service begins trying to renew this certificate 10 days (240 hours) before it expires.

  ```yaml
  apiVersion: certmanager.k8s.io/v1alpha1
  kind: Certificate
  metadata:
    name: hello-world-cert-1
    namespace: default
  spec:
    secretName: hello-world-cert-1
    issuerRef:
      name: hello-ca-tls
      kind: Issuer
    commonName: "foo2.bar2"
    dnsNames:
    - foo2.bar2
    duration: 720h
    renewBefore: 240h
  ```
  {: codeblock}

#### Notes:
* The `duration` field must be no less than `1h`.
* The `duration` field must be greater than the `renewBefore` field.
* The parameters that are used for both the `duration` and `renewBefore` fields must be in the Golang [ParseDuration](https://golang.org/pkg/time/#ParseDuration) format. Accepted time units include ["ns", "us" (or "µs"), "ms", "s", "m", "h"].
* If you specify a `duration` that is less than the default `renewBefore` time of 30 days (720 hours), then you must also specify the `renewBefore` field that is less than your `duration`.

## Customizing certificate private key encoding
{: #encoding}

This version of cert-manager supports an extra format (PKCS#8) for private key encoding. If you want your certificates to encode their private keys in PKCS#8 format, specify the `keyEncoding` parameter in the `spec` field. For example:

````yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: example-pkcs8-certificate
spec:
  secretName: example-pkcs8-certificate-secret
  issuerRef:
      name: hello-ca-tls
      kind: Issuer
  commonName: "foo2.bar2"
  dnsNames:
  - foo2.bar2
  keyEncoding: pkcs8
````
{: codeblock}

**Notes**:
1. The issuer does not have to have its key encoded in PKCS#8. In the previous example, the issuer that is created in section, Creating your own self-signed and CA issuers which has its key encoded in PKCS#1 format is used.
2. Remember that the resulting private key in the secret is generated in PKCS#8 format.
3. After you specify a certificate format, it can be changed to another format but you must refresh your certificate to have the change take effect. For more information, see Refreshing cert-manager certificates.
4. If the `keyEncoding` field is not specified, it defaults to PKCS#1 format

In addition, CA issuers can also have their private keys encoded in PKCS#8 format. Before only PKCS#1 format was supported. For more information, see Customizing issuers.

Following is a sample spec where the CA issuer is using a secret that contains a certificate and its private key. The private key is encoded in PKCS#8.

````yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Issuer
metadata:
  name: pkcs8-ca-issuer
spec:
  ca:
    secretName: pk8-ca
````
{: codeblock}

## Customizing certificate key usage
{: #keyUsage}

Certificates can now specify x509 actions are allowed/enabled for its key (key usage and extended key usage). Essentially it is one or more actions that certificates may be allowed to do. For more information about certificate key usage, see the [RFC 5280 documentation](https://tools.ietf.org/html/rfc5280#section-4.2.1.3).

Specify the actions that you want enabled by using the `usages` field. For example:

````yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: example-key-usage-certificate
  namespace: default
spec:
  secretName: example-key-usage-certificate
  issuerRef:
    name: hello-ca-tls
    kind: Issuer
  commonName: "foo2.bar2"
  dnsNames:
  - foo2.bar2
  usages:
  - digital signature
  - key encipherment
  - timestamping
````
{: codeblock}

**Notes**:
1. The `usages` field is optional. If you do not specify a value in the `usages` field, the certificate includes default values, `key encipherment`, and `digital signature`.
2. However, if the field `isCA` is set to `true`, then the certificate includes `cert sign` as a default `usages` value.
3. Only the following values can be used in the `usages` field. Failure to issue the certificate occurs when you do not use the specified values.
````
  - signing
  - digital signature
  - content commitment
  - key encipherment
  - key agreement
  - data encipherment
  - cert sign
  - crl sign
  - encipher only
  - decipher only
  - any
  - server auth
  - client auth
  - code signing
  - email protection
  - s/mime
  - ipsec end system
  - ipsec tunnel
  - ipsec user
  - timestamping
  - ocsp signing
  - microsoft sgc
  - netscape sgc
  ````
