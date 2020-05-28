# Managing Security Context Constraints policies

Learn to create, apply, view, and update your Security Context Constraints (SCC) policies.

## Creating a SCC policy 

You can create a YAML file for your SCC policy from the command line interface (CLI) or from the console. View the following sections to create a SCC policy:

### Creating a SCC policy from the CLI

See [Creating Security Context Constraints](https://docs.openshift.com/container-platform/4.3/authentication/managing-security-context-constraints.html#security-context-constraints-creating_configuring-internal-oauth) from the OpenShift Container Platform documentation for more details.

#### Viewing your SCC policy from the CLI

See [Examining an SCC](https://docs.openshift.com/container-platform/4.3/authentication/managing-security-context-constraints.html#examining-a-security-context-constraints-object_configuring-internal-oauth) from the OpenShift Container Platform documentation for more details.

### Creating a SCC policy from the console

As you create a SCC policy from the console, a YAML file is also created in the YAML editor. Complete the following steps to create a SCC policy from the console:

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk**.
3. Click **Create policy**.
4. Enter or select the appropriate values for the following fields:
   * Name
   * Specifications
   * Cluster selector
   * Remediation action
   * Standards
   * Categories
   * Controls
   * Disabled

5. Click **Create**.

A SCC policy is created.

#### Viewing your SCC policy from the console

You can view any SCC policy and its status from the console.

1. Log in to your cluster from the console.
2. From the navigation menu, click **Governance and risk** to view a table list of your policies.
   
   **Note**: You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab.

4. Select one of your policies to view more details.
5. View the SCC policy violations by selecting the _Violations_ tab.

## Updating SCC policies

Learn to update SCC policies by viewing the following sections. 

### Deleting a SCC policy

Delete the SCC policy from the CLI or the console. 

See [Deleting a SCC](https://docs.openshift.com/container-platform/4.3/authentication/managing-security-context-constraints.html#deleting-security-context-constraints_configuring-internal-oauth) from the OpenShift Container Platform documentation to learn more on deleting a SCC policy from the CLI.

* Delete a SCC policy from the console:

  1. From the navigation menu, click **Govern risk** to view a table list of your policies.
  2. Click the **Options** icon for the policy you want to delete in the policy violation table.
  3. Click **Remove**.
  4. From the _Remove policy_ dialog box, click **Remove policy**.

Your SCC policy is deleted.

View a sample of a SCC policy, see _Security context constraint policy sample_ on the [Security context constraint policy](create_scc_policy.md) page. See [Kubernetes configuration policy controller](config_policy_ctrl.md) to learn about other configuration policies. See [Manage security policies](manage_policy_overview.md) to manage other policies.
