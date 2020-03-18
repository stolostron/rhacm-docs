---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-16" 

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

## Updating your security policy from the console

1. From the navigation menu, click **Govern risk**.
2. Click the _Policies_ tab.
3. Select a policy and click the **Options** icon. 
4. Click **Edit**. The YAML file appears in the _Edit policy_ modal.
5. Click **Submit**.

Your policy is updated. 

## Viewing policy violations from the console

1. From the navigation menu, click **Govern risk**.
2. From the _Overview_ tab, select the number of policy violations to view a table list of the policy violations.  
3. Filter the information in the table by selecting _Policies_.
4. Click **Expand summary** to view the summary cards. You can filter your _Summary_ view by categories or standards. 
5. From the _Summary_ section, select **Policy violations** to view a table of the policies. **Note**: When you select **Policy violations** from a specific summary card, a filter is applied and the summary collapses. Click **Collapse summary** to see less information.
6. From the _Policies_ tab, view more details about a policy by clicking the **Options** icon > **View Details**. A details window appears with details about the rule violations. Expand the row to view the message and reason for the policy violation. 
7. Click **Launch Cluster** to open the console for your cluster.

## Viewing cluster violations from the console

1. From the navigation menu, click **Govern risk**.
2. From the _Overview_ tab, select the number of cluster violations to view a table list of the policy violations.  
3. Filter the information in the table by selecting _Cluster violations_.
4. Click **Expand summary** to view the summary cards. You can filter your _Summary_ view by categories or standards. 
5. From the _Summary_ section, select **Cluster violations** to view a table of the cluster policy violations. **Note**: When you select **Cluster violations** from a specific summary card, a filter is applied and the summary collapses. Click **Collapse summary** to see less information.
6. From the _Policies_ tab, view more details about a cluster violation by clicking the **Options** icon > **View policies**. A modal appears with details about the rule violations in your cluster policies. Expand the row to view the message and reason for the cluster policy violation.

## Viewing application violations from the console

1. From the navigation menu, click **Governance and risk**.
2. From the _Overview_ tab, select the _Applications_ tab in the _Top violations_ card.
3. Select an application to view the policy violations.
4. Click **Expand summary** to view the summary cards. You can filter your _Summary_ view by categories or standards. 
5. From the _Summary_ section, select **Applications** to view a table of the policies. **Note**: When you select **Applications** from a specific summary card, a filter is applied and the summary collapses. Click **Collapse summary** to see less information.
6. From the _Policies_ tab, view more details about a policy by clicking the **Options** icon > **View application**. A modal appears with details about the rule violations. Expand the row to view the message and reason for the policy violation. 

## Disabling your security policy from the console

After you create a security policy, it is enabled by default. Complete the following steps to disbale your policy:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

2. From the navigation menu, click **Govern risk**.

3. Click the _Policies_ tab to view a table list of your policies.

4. Disable your policy by clicking the **Options** icon > **Disable**. The _Disable Policy_ dialog box appears.

5. Click **Disable policy**. 

Your policy is disbaled. 

## Deleting an Red Hat Advanced Cluster Management for Kubernetes policy

Delete your Red Hat Advanced Cluster Management for Kubernetes security policy.

### Deleting an Red Hat Advanced Cluster Management for Kubernetes policy from the command line (CLI)

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

### Deleting an Red Hat Advanced Cluster Management for Kubernetes policy from the console

Complete the following steps to delete your policy:

1. From the navigation menu, click **Govern risk**.
2. Click the _Policies_ tab. 
3. Click the **Options** icon for the policy you want to delete in the policy violation table.
4. Click **Remove**.
5. From the _Remove policy_ dialog box, click **Remove policy**. 

Your policy is deleted.

See [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](compliance_intro.md) for more policy topics.




