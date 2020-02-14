---

copyright:
  years: 2018,2019
lastupdated: "2019-05-31"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Customizing {{site.data.keyword.icp_notm}} cert-manager certificates

{{site.data.keyword.icp}} Certificate manager service offers features that you can use to customize your certificates.
{: shortdesc}

## Customizing certificate expiration
{: #expiration}

The default expiration for all certificates is 90 days. The default time before expiration when the {{site.data.keyword.icp}} Certificate manager service renews the certificates is 30 days.

The {{site.data.keyword.icp_notm}} Certificate manager service offers custom expiration times. The feature is offered by way of the new `duration` and `renewBefore` fields in a Certificate definition.

`duration` is how long the Certificate is valid.
`renewBefore` is the time before the certificate expires when the {{site.data.keyword.icp_notm}} Certificate manager service begins attempts to renew the certificate.

The following Certificate definition in the example below has a validity period of 30 days (720 hours). {{site.data.keyword.icp_notm}} Certificate manager service begins trying to renew this certificate 10 days (240 hours) before it expires.

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

**Notes:**
* The `duration` field must be no less than `1h`.
* The `duration` field must be greater than the `renewBefore` field.
* The parameters that are used for both the `duration` and `renewBefore` fields must be in the Golang [ParseDuration](https://golang.org/pkg/time/#ParseDuration) format. Accepted time units include ["ns", "us" (or "µs"), "ms", "s", "m", "h"].
* If you specify a `duration` that is less than the default `renewBefore` time of 30 days (720 hours), then you must also specify the `renewBefore` field that is less than your `duration`.
