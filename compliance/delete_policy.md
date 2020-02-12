---

copyright:
  years: 2018, 2019
lastupdated: "2019-12-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Deleting an {{site.data.keyword.mcm_notm}} policy

Delete your {{site.data.keyword.mcm_notm}} security policy.
{: shortdesc}

## Deleting an {{site.data.keyword.mcm_notm}} policy from the command line (CLI)

Complete the following steps to delete your policy:

1. Delete a policy by running the following command:

    ```
    kubectl delete policy <policy-name> -n <mcm namespace>  
    ```
    {: codeblock}

    After your policy is deleted, it is removed from your target cluster or clusters.

2. Verify that your policy is removed by running the following command:

    ```
    kubectl get policy <policy-name> -n <mcm namespace>
    ```
    {: codeblock}

## Deleting an {{site.data.keyword.mcm_notm}} policy from the {{site.data.keyword.gui}}

Complete the following steps to delete your policy:

1. From the navigation menu, click **Govern risk**.
2. Click the _Policies_ tab. 
3. Click the **Options** icon (<img src="../images/icons/menu-overflow_16.svg" alt="Options icon">) for the policy you want to delete in the policy violation table.
4. Click **Remove**.
5. From the _Remove policy_ dialog box, click **Remove policy**. 

Your policy is deleted.

See [{{site.data.keyword.mcm_notm}} Governance and risk](compliance_intro.md) for more policy topics.
