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

# Using Red Hat Ansible Tower

{{site.data.keyword.rh_tm}} Ansible Tower automates continuous configurations and deployments.
{:shortdesc}

Red Hat Ansible Tower is an Internet-based hub that runs your automation tasks. You can configure the optional license to use Red Hat Ansible Tower with the automation capability of the {{site.data.keyword.product}} {{site.data.keyword.gui}}.

## Installing Red Hat Ansible Tower

After you install {{site.data.keyword.product}}, install Red Hat Ansible Tower on your {{site.data.keyword.open_s}} cluster. See the [Red Hat Ansible Tower download files ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://releases.ansible.com/ansible-tower/setup_openshift/){: new_window} to download the installation. For information about the installation program, see [Red Hat Ansible Tower Administration Guide ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.ansible.com/ansible-tower/latest/html/administration/openshift_configuration.html#openshift-deployment-and-configuration){: new_window}.

**Notes**:

   * When you install Red Hat Ansible Tower, your target cluster must be an {{site.data.keyword.open_s}} cluster where {{site.data.keyword.product}} is installed.

   * Create an `ansible-tower` namespace for your Red Hat Ansible installation in your {{site.data.keyword.open_s}} cluster.

## Configuring your license in Red Hat Ansible Tower

You must configure a license for your Red Hat Ansible Tower installation. Complete the following steps to apply your license to enable the usage of Red Hat Ansible Tower:

1. Obtain the `temporary-tower-license.txt` file from [{{site.data.keyword.IBM_notm}} Passport Advantage® ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www-01.ibm.com/software/passportadvantage){: new_window}.

    For more information, see the _Import a License_ section from the [Red Hat Ansible Tower documentation ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.ansible.com/ansible-tower/latest/html/quickstart/import_license.html){: new_window}.

2. Apply the temporary license file. For more information, see the _Import a License_ section of the [Red Hat Ansible Tower Quick Setup documentation ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.ansible.com/ansible-tower/latest/html/quickstart/import_license.html){: new_window}.

## Configuring single sign-on

Red Hat Ansible Tower supports single sign-on integration with an enterprise identity provider by using the Security Assertion Markup Language (SAML). Configure Red Hat Ansible Tower for single sign-on integration with the SAML identity provider that is used for your {{site.data.keyword.product}} cluster to improve the {{site.data.keyword.gui}} navigation. For more information, see _SAML Authentication Settings_ in [{{site.data.keyword.rh_tm}} Ansible Tower documentation ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.ansible.com/ansible-tower/latest/html/administration/ent_auth.html#saml-authentication-settings){: new_window}. 

**Note**: You can have multiple SAML identity providers. 

## Integrating Red Hat Ansible Tower with {{site.data.keyword.cloud_pak}} {{site.data.keyword.gui}}

Enable navigation to the Red Hat Ansible Tower {{site.data.keyword.gui}} within the {{site.data.keyword.cloud_pak}} {{site.data.keyword.gui}}. 

Complete the following steps to enable navigation to Red Hat Ansible:

1. Obtain the menu customization script, `automation-navigation-updates.sh`, from [{{site.data.keyword.IBM_notm}} Passport Advantage® ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www-01.ibm.com/software/passportadvantage/){: new_window} website. You must run the script on a {{site.data.keyword.linux_notm}} operating system. 

2. Install and authenticate `kubectl`. For more information, see [Managing your clusters with {{site.data.keyword.IBM_notm}}](../mcm/manage_cluster/intro.md). 

3. Install JQ. For more information, see [Download jq ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://stedolan.github.io/jq/download/){: new_window}.

4. Run the following commands to enable navigation to your Red Hat Ansible Tower instance:

   ```
   chmod 755 ./automatation-navigation-updates.sh
   
   ./automatation-navigation-updates.sh -t ansible-tower
   ```
   {: codeblock}

   * `-t` is a required parameter that refers to the {{site.data.keyword.open_s}} project (Kubernetes namespace), where Red Hat Ansible is installed in the {{site.data.keyword.cloud_pak}}.
  
5. Verify that the Red Hat Ansible Tower instance is in the {{site.data.keyword.cloud_pak}} {{site.data.keyword.gui}} navigation menu. From the {{site.data.keyword.cloud_pak}} navigation menu, click **Automate infrastructure** > **Ansible automation**.

Red Hat Ansible Tower is integrated with the {{site.data.keyword.cloud_pak}} {{site.data.keyword.gui}}. 
