---

copyright:
  years: 2019
lastupdated: "2019-12-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Key Management Service adoption guide

The Key Management Service (KMS) helps keep data secure. It integrates with user-owned hardware security modules (HSM). A root key is used for envelope encryption to secure the data encryption keys used inside of your applications.
{: shortdesc}

Incorporating KMS into your applications, includes the following tasks:

 - Provisioning an instance of the KMS
 - Configuring a service ID with `Administrator` privileges for the instance
 - Configuring a service ID with `Viewer` privileges for your application
 - Generating or importing a root key into the KMS
 - Using root key to encrypt and decrypt the data encryption keys that are used in your application.

See the following configurations:

- {: child} [Configuring Key Management Service](kms_server.md) <br />
- {: child} [Encrypting Kubernetes secrets with Key Management Service plug-in](kms_plugin.md) <br />
- {: child} [Upgrading Key Management Service Helm charts](../installing/upgrade_kms.md) <br />
{: childlinks}
