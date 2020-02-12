---

copyright:
  years: 2018, 2019
lastupdated: "2019-12-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# {{site.data.keyword.mcm_notm}} Governance and risk

Use the Governance and risk dashboard to view and manage the number of security risks and policy violations in your clusters and applications. 
{:shortdesc}

From the _Overview_ tab, you can view the total number of policy violations and cluster violations, and a number of security findings categorized by severity in the _Recent activity_ section. View the _Top violations_ card to view specific violations and the amount of clusters with the violation. You can filter the view of the _Top violations_ by policies or clusters. View the _Top security findings_ card to view the policies with frequent findings. **Note**: You can view your top four security findings from the _Top security findings_ card. 

View the _Most impacted controls_ radar chart of the policy violations and security findings. You can filter the radar chart to view all standards, specific standards, or other standards. You can customize your radar chart by showing more or less controls.

View the _Policy summary_ card to see the total number of standards, categories, policies, and controls.


From the _Policies_ tab, you can view a summary of cluster and policy violations. You can customize your _Summary_ view by filtering the violations by categories or standards. Collapse the summary to see less information. 

View a table list of violations. The following details are provided in the table: description, resources, severity, cluster, standards, controls, categories, and update time. You can filter the violation table view by policies or cluster violations.


From the _Security findings_ tab, you can view a summary of cluster security findings. You can customize your _Summary_ view by filtering the violations by categories or standards. Collapse the summary to see less information.

View a table list of security findings. The following details are provided in the table: the policy name, remediation, cluster violations, standards, controls, and categories. You can filter the violation table view by security findings or cluster findings.

Learn about the structure of an {{site.data.keyword.mcm_notm}} policy, and how to use {{site.data.keyword.mcm_notm}} Governance and risk dashboard.

- {: child} [{{site.data.keyword.mcm_notm}} policy overview](policy_overview.md)
- {: child} [{{site.data.keyword.mcm_notm}} policy controllers](policy_controllers.md)
- {: child} [{{site.data.keyword.mcm_notm}} policy example](policy_example.md)
- {: child} [{{site.data.keyword.mcm_notm}} policy samples](../manage_policies/policy_samples.md)
- {: child} [Creating an {{site.data.keyword.mcm_notm}} policy](create_policy.md)
- {: child} [{{site.data.keyword.mcm_notm}} security findings](../manage_cluster/security_advisor.md)
- {: child} [Managing a security policy](../manage_cluster/manage_grc_policy.md)
- {: child} [Deleting an {{site.data.keyword.mcm_notm}} policy](delete_policy.md)
{: childlinks}
