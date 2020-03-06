---

copyright:
  years: 2019
lastupdated: "2019-12-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Using CloudForms 

CloudForms is a management platform to control and manage cloud infrastructures.
{:shortdesc}

CloudForms is provided as part of the optional license of the automation capability of the {{site.data.keyword.product}}. If you have a license for the automation capability, you are entitled to install and use CloudForms.

## Installing CloudForms

The CloudForms management engine appliance can be installed on several virtual infrastructure platforms. Download the installation images for the supported platforms [IBM Passport Advantage® ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www-01.ibm.com/software/passportadvantage/){: new_window}.

For more information about CloudForms installation on your virtual infrastructure platform, see the [CloudForms product documentation ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://access.redhat.com/documentation/en-us/red_hat_cloudforms/5.0/){: new_window}.

## Configuring single sign-on

CloudForms provides support for single sign-on integration with an enterprise identity provider through use of the Security Assertion Markup Language (SAML).

Configure CloudForms to enable SAML authentication with the same identity provider used for {{site.data.keyword.product}}. For more information, see _Configuring Federated Authentication with SAML_ in the [Managing Authentication for CloudForms guide ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://access.redhat.com/documentation/en-us/red_hat_cloudforms/5.0/html/managing_authentication_for_cloudforms/external_auth#SAML){: new_window}.

## Integrating CloudForms with {{site.data.keyword.cloud_pak}} console

Enable navigation to CloudForms with {{site.data.keyword.cloud_pak}} console.

Complete the following steps to enable navigation to CloudForms:

1. Obtain the menu customization script, `automation-navigation-updates.sh`, from [IBM Passport Advantage® ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www-01.ibm.com/software/passportadvantage/){: new_window} website. You must run the script on a {{site.data.keyword.linux_notm}} operating system.

2. Install and authenticate `kubectl`. For more information, see [Managing your clusters with {{site.data.keyword.mcm_notm}}](../mcm/manage_cluster/intro.md).

3. Install JQ. For more information, see [Download jq ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://stedolan.github.io/jq/download/){: new_window}.

4. Run the following commands to enable navigation to your CloudForms instance:

   ```
   chmod 755 ./automatation-navigation-updates.sh

   ./automatation-navigation-updates.sh -c <CloudForms URL>
   ```
   {: codeblock}

   * `-c` is a required parameter that refers to the URL for the CloudForms console.

5. Verify that the CloudForms instance is in the {{site.data.keyword.cloud_pak}} console navigation menu. From the {{site.data.keyword.cloud_pak}} navigation menu, click **Automate infrastructure** > **CloudForms automation**.

CloudForms is integrated with the {{site.data.keyword.cloud_pak}} console.
