---

copyright:
  years: 2019
lastupdated: "2019-12-10" 

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Managing a security policy

Manage your cluster policy to remediate and edit your security policy. 
{:shortdesc}

## Updating your security policy from the {{site.data.keyword.gui}}

1. From the navigation menu, click **Govern risk**.
2. Click the _Policies_ tab.
3. Select a policy and click the **Options** icon (<img src="../../images/icons/menu-overflow_16.svg" alt="Options icon">). 
4. Click **Edit**. The YAML file appears in the _Edit policy_ modal.
5. Click **Submit**.

Your policy is updated. 

## Viewing policy violations from the {{site.data.keyword.gui}}

1. From the navigation menu, click **Govern risk**.
2. From the _Overview_ tab, select the number of policy violations to view a table list of the policy violations.  
3. Filter the information in the table by selecting _Policies_.
4. Click **Expand summary** to view the summary cards. You can filter your _Summary_ view by categories or standards. 
5. From the _Summary_ section, select **Policy violations** to view a table of the policies. **Note**: When you select **Policy violations** from a specific summary card, a filter is applied and the summary collapses. Click **Collapse summary** to see less information.
6. From the _Policies_ tab, view more details about a policy by clicking the **Options** icon (<img src="../../images/icons/menu-overflow_16.svg" alt="Options icon">) > **View Details**. A details window appears with details about the rule violations. Expand the row to view the message and reason for the policy violation. 
7. Click **Launch Cluster** to open the {{site.data.keyword.gui}} for your cluster.

## Viewing cluster violations from the {{site.data.keyword.gui}}

1. From the navigation menu, click **Govern risk**.
2. From the _Overview_ tab, select the number of cluster violations to view a table list of the policy violations.  
3. Filter the information in the table by selecting _Cluster violations_.
4. Click **Expand summary** to view the summary cards. You can filter your _Summary_ view by categories or standards. 
5. From the _Summary_ section, select **Cluster violations** to view a table of the cluster policy violations. **Note**: When you select **Cluster violations** from a specific summary card, a filter is applied and the summary collapses. Click **Collapse summary** to see less information.
6. From the _Policies_ tab, view more details about a cluster violation by clicking the **Options** icon (<img src="../../images/icons/menu-overflow_16.svg" alt="Options icon">) > **View policies**. A modal appears with details about the rule violations in your cluster policies. Expand the row to view the message and reason for the cluster policy violation.

## Viewing application violations from the {{site.data.keyword.gui}}

1. From the navigation menu, click **Governance and risk**.
2. From the _Overview_ tab, select the _Applications_ tab in the _Top violations_ card.
3. Select an application to view the policy violations.
4. Click **Expand summary** to view the summary cards. You can filter your _Summary_ view by categories or standards. 
5. From the _Summary_ section, select **Applications** to view a table of the policies. **Note**: When you select **Applications** from a specific summary card, a filter is applied and the summary collapses. Click **Collapse summary** to see less information.
6. From the _Policies_ tab, view more details about a policy by clicking the **Options** icon (<img src="../../images/icons/menu-overflow_16.svg" alt="Options icon">) > **View application**. A modal appears with details about the rule violations. Expand the row to view the message and reason for the policy violation.

## Viewing security findings from the {{site.data.keyword.gui}}

**Note**: Policy data for non-compliant policies is not available in the _Security findings_ tab from the {{site.data.keyword.gui}}.

1. From the navigation menu, click **Govern risk**.
2. Click the _Security findings_ tab. A summary of your security findings appears. You can filter your _Summary_ view by categories or standards.
3. Click **Collapse summary** to see less information.
4. From the _Summary_ section, select **Cluster violations** to view a table of the security findings. **Note**: When you select **Cluster violations** from a specific summary card, a filter is applied and the summary collapses.
5. From the security findings table, filter the information in the table by _Security findings_, _Cluster findings_, or _Applications_.
6. Select a security finding from the table to view more details. A details window appears with the following details:
   
   * Finding number
   * Detection time
   * Description
   * Source
   * Resource description
   * Resolution 

## Disabling your security policy from the {{site.data.keyword.gui}}

After you create a security policy, it is enabled by default. Complete the following steps to disbale your policy:

1. Log in to your {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}}.

2. From the navigation menu, click **Govern risk**.

3. Click the _Policies_ tab to view a table list of your policies.

4. Disable your policy by clicking the **Options** icon (<img src="../../images/icons/menu-overflow_16.svg" alt="Options icon">) > **Disable**. The _Disable Policy_ dialog box appears.

5. Click **Disable policy**. 

Your policy is disbaled. 

## Deleting an {{site.data.keyword.mcm_notm}} policy

Delete your {{site.data.keyword.mcm_notm}} security policy.

### Deleting an {{site.data.keyword.mcm_notm}} policy from the command line (CLI)

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

### Deleting an {{site.data.keyword.mcm_notm}} policy from the {{site.data.keyword.gui}}

Complete the following steps to delete your policy:

1. From the navigation menu, click **Govern risk**.
2. Click the _Policies_ tab. 
3. Click the **Options** icon (<img src="../images/icons/menu-overflow_16.svg" alt="Options icon">) for the policy you want to delete in the policy violation table.
4. Click **Remove**.
5. From the _Remove policy_ dialog box, click **Remove policy**. 

Your policy is deleted.

See [{{site.data.keyword.mcm_notm}} Governance and risk](compliance_intro.md) for more policy topics.




