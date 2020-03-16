---

copyright:
  years: 2020
lastupdated: "2020-03-11"

---


# Visual Web Terminal

You can use the Visual Web Terminal to run many commands across your environment. When categorized data is returned, such as when you enter a `search` command, it is returned in an interactive tabular format.

The Visual Web Terminal is particularly useful when troubleshooting issues that require running multiple commands, and navigating the results of the commands in an easy way. The information that is provided in the Visual Web Terminal is limited by the permissions of the user. When you run a command, only the items that you have permission to view are displayed. If there are over ten sessions that are running at the same time, there might be a slower response time when running commands.

  - [Starting a session](#start)
  - [Supported command list](#commands)
  - [Searching with Visual Web Terminal](#search)

## Starting a session
{: #start}

You can access the Visual Web Terminal by completing the following steps:

To get started, log in to your console and select the **Visual Web Terminal** icon.

**Note:** The Visual Web Terminal connects to the cloud that you are already logged into with the hub cluster console.

## Supported command list
{: #commands}

The following table provides information and examples for the command types that are supported by the Visual Web Terminal:

| Command | Description | Example |
| ---------|--------------|------- |
| `!!` | Run the previous command again | `!!` |
| `bash` commands | Run the following basic `bash` commands: `base64`, `basename`, `cat`, `cksum`, `cp`, `cut`, `date`, `dirname`, `echo`, `grep`, `head`, `ls`, `mkdir`, `mv`, `printf`, `readlink`, `rm`, `sed`, `tail`, `touch`, `uname`, `vi`, and `vim`  | `mkdir new_directory` |
| `cd` | Change the current working directory for local filesystem changes | `cd dir_name` |
| `clear` | Clear the screen of previous commands and output | `clear` |
| `export` | Export the output of the command to an external file | `export search search_criteria` |
| `helm` | Run supported `helm` commands. **Tip:** See the [helm commands](https://v2.helm.sh/docs/helm/#helm) topic in the Helm documentation for more information about the Helm commands. | `helm list --chart-name` |
| `help` | Display additional information about a command that is supported in the Visual Web Terminal | `help` |
| `history` | Displays the previous 25 commands that were run during the current session. **Tip:** You can limit the search criteria by adding it to the end of the command. For example, `history help` displays the last 25 commands that contained the string *help*. | `history` |
| `istioctl` | Run supported `istioctl` commands. **Tip:** See the [Istioctl](https://istio.io/docs/reference/commands/istioctl/) topic in the Istio documentation for more information about the `istioctl` commands. | `istioctl get policy` |
| `kubectl` | Run supported `kubectl` commands. **Tip:** See the [Kubectl reference](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands) for more information about the `kubectl` commands. | `kubectl get pods`  |
| `oc` | Runs Red Hat OpenShift `oc` commands. **Tip:** See [Red Hat OpenShift CLI Operations](https://docs.openshift.com/enterprise/3.0/cli_reference/basic_cli_operations.html) for more information about the `oc` commands. | `oc get svc` |
| `run` | Runs an external script | `run script_name` |
| `search` | Searches your Kubernetes resources for those that match the specified search filters and parameters| `search pod` |
| `savedsearches` | Displays your saved searches that you created and saved by using the console.| `savedsearches` **Tip:** You can specify a string after the `savedsearches` command to limit the data that is returned. For example, `savedsearches projectA` displays the saved searches that contain the string *projectA*. |
| `sleep` | Pauses activity during a session. **Note:** Requires a `sleepTime` parameter that identifies the number of seconds that it pauses | `sleep 20` |
| `themes` |  Displays the contrast theme options of the interface, which you can set to either `light` or `dark` | `themes` |

## Searching with Visual Web Terminal
{: #search}

The Visual Web Terminal search function provides visibility into your resources across all your clusters.

You can only search for resources based on your role-based access control level assignment. If you save and share a search query with another user, returned results for that user depend on his or her access level.

1. Start a Visual Web Terminal session.
2. In the command entry field of the Visual Web Terminal, type: `search`. When you run a `search` command, the Visual Web Terminal verifies that the search function is available. If it is not available, a message indicates that either the search function is not installed, or that it is just not available. If it is installed, but not available, it might be a network issue.
3. Add a space after the `search` command. The list of filters that are available for the search is displayed. The list of filters might be empty because it is dependent on the resources that are available in your environment and your role permissions.
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

You can use a search that was saved in the console by entering the `savedsearches` command and selecting the search that you want to run.
