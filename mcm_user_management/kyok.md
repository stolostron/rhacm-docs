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

# Keep Your Own Key (KYOK)

**{{site.data.keyword.tech_prev}}**

With KYOK, you can use {{site.data.keyword.mcm_notm}} Key Protect service to manage client root keys (CRKs) and to use a Hardware Security Module (HSM) for encryption.
{:shortdesc}

The CRKs can be used to encrypt data encryption keys (DEKs) that are used to encrypt data in services that run on {{site.data.keyword.Bluemix}}. Authentication and authorization to access the {{site.data.keyword.mcm_notm}} Key Protect service is done by using service tokens that are created in {{site.data.keyword.Bluemix}}. The service tokens are transformed into {{site.data.keyword.mcm_notm}} service tokens by using a policy-driven {{site.data.keyword.mcm_notm}} Secure Token Service (STS).

You must set up secure network connectivity with the required security controls to allow communication between {{site.data.keyword.Bluemix}} services and the {{site.data.keyword.mcm_notm}} Key Protect service.

{{site.data.keyword.product}} Key Protect service works in a single cluster. You can use the {{site.data.keyword.product}} Key Protect service in a multizone environment and use the STS to support the KYOK scenario.

- {: child} [Secure token service](../mcm_user_management/sts_overview.md)
- {: child} [Multiple zones](../installing/multi_zone.md)

{: childlinks}
