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

# Installing the {{site.data.keyword.cloud_pak_mcm}} on {{site.data.keyword.cloud_notm}}

Follow these steps to install the {{site.data.keyword.cloud_pak_mcm}} by using the entitled registry in {{site.data.keyword.cloud_notm}}.
{:shortdesc}

  - [Installation requirements](#prereqs)
  - [Install the {{site.data.keyword.cloud_pak_mcm}} in {{site.data.keyword.cloud_notm}}](#install)
  - [Verify the installation](#verify)
  - [Post installation tasks](#post_install)

## Installation requirements
{: #prereqs}

- Before you can install the Cloud Pak, you must purchase a license through [IBM Passport Advantage ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/software/passportadvantage/index.html). For part numbers, see [Passport Advantage part numbers](../about/part_numbers.md).

- You must have {{site.data.keyword.ocp_tm}} version 3.11 installed by using {{site.data.keyword.iks}} so that the managed {{site.data.keyword.open_s}} service is supported.

* You must have a pre-configured StorageClass in {{site.data.keyword.open_s}} that can be used for installing the {{site.data.keyword.cloud_pak_mcm}}.

### Minimum hardware requirements

| Nodes | Memory  | CPU  |
|----|---|----|
| 1 | 32 GB | 16 cores |

**Notes:** If you are going to install {{site.data.keyword.IBM_notm}} Cloud App Management and {{site.data.keyword.IBM_notm}} Cloud Automation Manager with the {{site.data.keyword.cloud_pak_mcm}}, you need another two nodes.

### Minimum storage requirements

Mandatory: 2 PV

| Component | PV |
|-----|-----|
| MongoDB | 1 |
| {{site.data.keyword.mcm_notm}} etcd | 1 |

Optional: 4 PV

| Component | PV  |
|------|------|
| Logging   |  1  |
| VA  |    3  |

## Install the {{site.data.keyword.cloud_pak_mcm}} in {{site.data.keyword.cloud_notm}}
{: #install}

For installation instructions, see [IBM the Cloud Docs ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/cloud-pak-multicloud-management?topic=cloud-pak-multicloud-management-getting-started).

## Verify the installation
{: #verify}

After the installation completes successfully, in the installation workspace, an *Offering dashboard* button appears on the page. Click the button to go to the {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}}. Use the admin user name and password that you configured during the installation to log in to the {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}}.

## Post installation tasks
{: #post_install}

Install the optional components in the {{site.data.keyword.cloud_pak_mcm}}.

- [Installing IBM Cloud App Management](https://www.ibm.com/support/knowledgecenter/SS8G7U_19.3.0/com.ibm.app.mgmt.doc/content/install_mcm.html?cp=SSFC4F_1.1.0)
- [Installing Cloud Automation Manager offline with OpenShift on IBM Cloud](https://www.ibm.com/support/knowledgecenter/SS2L37_4.1.0.0/cam_install_roks.html?cp=SSFC4F_1.2.0)
- [Installing Cloud Automation Manager offline with OpenShift on IBM Cloud](https://www.ibm.com/support/knowledgecenter/SS2L37_4.1.0.0/cam_install_online_roks.html?cp=SSFC4F_1.2.0)
