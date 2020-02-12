---

copyright:
  years: 2019
lastupdated: "2019-09-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Secure token service

**{{site.data.keyword.tech_prev}}**

Secure token service for multicloud environments.
{:shortdesc}

In a multicloud environment, a service in one cloud might request for a service in another cloud. Trust must be established between the two clouds before the second cloud approves the request for the service. Secure token service (STS) can be used to set up a trust association between different cloud Identity and Access Management (IAM) systems. STS does not store or share the credentials of a cloud provider. During runtime, STS provides a transparent way for a service to request and consume the service that is available in a different cloud.

In {{site.data.keyword.mcm}}, STS can be configured to allow services from {{site.data.keyword.Bluemix}} to request for key operations that are provided by the Key Management Service (KMS) in {{site.data.keyword.mcm_notm}}.

Complete the following tasks to use the secure token service:

1. [Configure secure token service](sts_config.md)
2. [Enable the key management service to use secure token service](sts_request.md)

For troubleshooting information, see [Troubleshooting the secure token service](ts_sts.md).

