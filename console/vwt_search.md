---

copyright:
  years: 2019
lastupdated: "2019-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Searching with {{site.data.keyword.kui}}

The {{site.data.keyword.kui}} Search function provides visibility into your {{site.data.keyword.product}} resources across all your clusters. **Remember:** The search commands are only available when the Cloud Pak for Multicloud Management is installed. 

You can only search for resources based on your role-based access control level assignment. If you save and share a Search query with another user, returned results for that user depend on his or her access level. For more information on role access, see [Role-based access control](../iam/3.4.0/assign_role.md). 

1. Start a {{site.data.keyword.kui}} session.
2. In the command entry field of the {{site.data.keyword.kui}}, type: `search`. When you run a `search` command, the {{site.data.keyword.kui}} verifies that the search function is available. If it is not available, a message indicates that either the search function is not installed, or that it is just not available. The search function is installed with the Cloud Pak for Multicloud Management, so the Cloud Pak for Multicloud Management must be installed for the {{site.data.keyword.kui}} to run the search commands. If it is installed, but not available, it might be a network issue. 
3. Add a space after the `search` command. The list of filters that are available for the search is displayed. **Remember:** The list of filters might be empty, because it is dependent on the resources that are available in your environment and your role permissions. 
4. Select one of the filters from the list. The selected filter is added to the search criteria on your command line, and the next level of filters for that selection are displayed. **Tip:** You can also enter a string after the `search` command, rather than selecting a filter from the list. 
5. Optional: Add filters by entering a single space after each filter entry until your command contains all of the required filters. 	 
6. When you are finished adding your search criteria, press **Enter** to run the search. 

You can refine your results with specific fields. See the following example:

  - Search for a single field, such as `kind:pod` to find all pod resources.
  - Search for multiple fields, such as `kind:pod namespace:default` to find the pods in the default namespace.

You can also search with conditions using characters, such as (>, >=, <, <=, !=).

See the following examples:

  - Search for `kind:pod status:!Running` to find all pod resources where the status is not `Running`.
  - Search for `kind:pod restarts:>1` to find all pods that have restarted at least twice.

The search returns resources that meet the criteria of your search request, as well as links to view related resources. Viewing all of them helps you visualize how the resources interact with other resources in the system. 
   
Your search results are grouped by `kind` and each resource `kind` is grouped in a table. You can reorder the data in the tables by selecting the row and column headings.

You can use a search that was saved in the {{site.data.keyword.gui}} by entering the `savedsearches` command and selecting the search that you want to run. **Remember:** You cannot save a search directly that you created in the {{site.data.keyword.kui}}.