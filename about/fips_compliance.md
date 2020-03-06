---

copyright:
  years: 2016, 2020
lastupdated: "2020-02-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# {{site.data.keyword.product}} platform considerations for FIPS readiness

Federal Information Processing Standards ([FIPS ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.nist.gov/topics/federal-information-standards-fips)) are information technology standards that are developed by the United States federal government related to encoding and encrypting data. 

For the ciphers that are supported by FIPS, see the following documents:

* For {{site.data.keyword.rhel}} ({{site.data.keyword.rhel_short}}), see [Security Guide ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/security_guide/sect-security_guide-federal_standards_and_regulations-federal_information_processing_standard).
* For Ubuntu, see [Computer Security Resource Center ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://csrc.nist.gov/CSRC/media/projects/cryptographic-module-validation-program/documents/security-policies/140sp2962.pdf).
* For {{site.data.keyword.sles}} ({{site.data.keyword.sles_short}}), see [Computer Security Resource Center ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://csrc.nist.gov/CSRC/media/projects/cryptographic-module-validation-program/documents/security-policies/140sp3038.pdf ).

You can meet FIPS requirements for {{site.data.keyword.product_tm}} by using the following procedures:

* Encrypting network traffic to external endpoints and the console, ingress service, image manager, Docker registry, and authentication manager.
* [Encrypting Kubernetes secrets with Key Management Service plug-in](../mcm_user_management/kms_plugin.md)



