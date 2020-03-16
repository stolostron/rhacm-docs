---

copyright:
  years: 2018, 2020
lastupdated: "2020-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}


# Using ACME to issue certificates

Use the ACME protocol to issue certificates when you need proof of domain ownership. The ACME HTTP issuer sends an HTTP request to the domains specified in the certificate request. The ACME server expects a certain web page to be published on each domain name requested in the certificate. The `cert-manager` service publishes the expected web page by creating a temporary pod and ingress. When validation is completed, the temporary pod and ingress are cleaned up. Then, the ACME server issues the certificate.

The issuer is used primarily with the ACME server that is hosted at [Let's Encrypt](https://letsencrypt.org/). For more information about the ACME HTTP issuer and the letsencrypt.org certificate authority, see:

* [Let's Encrypt certificate authority documentation](https://letsencrypt.org/docs/).
* [Certificate manager ACME HTTP issuer tutorial](https://docs.cert-manager.io/en/latest/tutorials/acme/http-validation.html)

The following `Issuer` example uses a staging server that is provided by Let's Encrypt. The important details are the `server` name and the `email` address. The `solvers` field indicates which challenge provider it's using. The following example uses the `HTTP01` challenge provider.
```
apiVersion: certmanager.io/v1alpha1
kind: Issuer
metadata:
  name: letsencrypt-staging
  namespace: default
spec:
  acme:
    # The ACME server URL
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: certificates@us.ibm.com
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-staging
    # Enable the HTTP-01 challenge provider
    solvers:
    # An empty selector means that this solver matches all domains
    - selector: {}
       http01:
         ingress:
           class: nginx
```
{: codeblock}

**Note**: The `DNS-01` challenge provider is not supported.

The following `Certificate` example uses the `Issuer` defined in the previous step. The certificate `commonName` and `dnsNames` are challenged by the ACME server. The certificate manager service automatically creates a pod and ingress rules to resolve the challenges for the two `hostnames` listed in the following example.
```
apiVersion: certmanager.io/v1alpha1
kind: Certificate
metadata:
  name: cm-aws-example-com
  namespace: default
spec:
  secretName: cm-aws-example-com-secret
  issuerRef:
    name: letsencrypt-staging
    kind: Issuer
  commonName: evolving-moray-master.purple-chesterfield.com
  dnsNames:
  - www.evolving-moray.purple-chesterfield.com
```
{: codeblock}  

Each of the `hostnames` listed in the certificate under `dnsNames` and the `commonName` must also be present in the list of ACME domains.

The ACME issuer has the following limitations:
* The ECDSA keyAlgorithm is not supported. You must use the RSA keyAlgorithm.
* The `organization` field is not supported.
* The `certificate duration` field is not supported.
* The Acme Issuer does not support IP addresses as SANs.
* The node that cert-manager runs on must have outbound access to the Internet.
