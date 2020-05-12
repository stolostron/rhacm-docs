# Creating and managing placement rules

You can create and manage placement rules to define where and how Helm charts and deployables are deployed. Placement rules help you facilitate multi-cluster deployments of your deployables. Samples for all resources, including placement rules, are located in the [Application resource samples](app_resource_samples.md) documentation.

  - Create a placement rule
  - Assign a placement rule
  - Placement rule status
  - Update a placement rule
  - Delete a placement rule
  - Placement rule definition
  * [Placement rule status definition](#placement-rule-sample-files)

The custom resource definition (CRD) and controller for placement rules replaces the placement policies that were used for applications in previous versions of Red Hat Advanced Cluster Management for Kubernetes. Placement policies are still used for governance and risk policies.

Placement rules can be defined for subscriptions and for deployables. Define the placement rule at the subscription level for multi-cluster deployments. Define the placement rule for a specific deployable for single-cluster deployments or to override placement settings.  

## Create a placement rule

Placement rules can be defined for subscriptions and for deployables. Define the placement rule at the subscription level for multi-cluster deployments. Define the placement rule for a specific deployable for single-cluster deployments or to override placement settings.

**Prerequisite:** Be sure the `endpoint-appmgr` is running. You can run `oc get pods -n multicluster-endpoint` to check for pods.

1. Compose the definition YAML content for your placement rule. Samples for all resources, including placement rules, are located in the [Application resource samples](app_resource_samples.md) documentation.

2. Create the placement rule within Red Hat Advanced Cluster Management for Kubernetes. You can define a placement rule as a separate resource or define the rule within the definition for a deployable or subscription. As a best practice, define placement rules as a separate resource when the rule might need to be referenced by multiple resources.

   For more information about creating the definition for a deployable or subscriptions, see:
    * [Creating and managing deployables](managing_deployables.md)
    * [Creating and managing subscriptions](managing_subscriptions.md)

   To create a placement rule as a separate resource, you can use the console, the Kubernetes CLI (`kubectl`) tool, or REST API:

   * To use the console:

     1. Open the console.
     2. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
     3. Click the **Resources** tab.
     4. Scroll to the _Resource pipeline_ section. From the list of buttons, find and click **Placement Rule**. The _Create a placement rule_ editor is displayed.
     5. Enter the YAML content to define your placement rule or directly update the default YAML template to meet your requirements.
     6. When you are finished adding or editing the YAML, click **Save** to create the placement rule.
     7. From the list of resource summary cards, click the _PLACEMENT RULES_ card. The _Search_ dashboard is displayed and lists all placement rules that are used by the applications that are selected on the _Applications_ dashboard. Your new placement rule does not display in this list until the rule is referenced by a subscription that is used by an application. To verify that your new placement rule is created, enter `kind:placementrule` in the search box and run your search. Ensure that your new rule is displayed in the search results list.

   * To use the Kubernetes CLI tool:

     1. Run the following command to apply your file to an apiserver. Replace `filename` with the name of your file:
        ```
        kubectl apply -f filename.yaml
        ```

     2. Verify that your placement rule is created, by running the following command:
        ```
        kubectl get PlacementRule
        ```

        Ensure that your new placement rule is listed in the resulting output.

   * To use REST API, you need to use the [placement rule POST API](../apis/placementrules.json).

## Assign a placement rule

You can assign a placement rule to a deployable or subscription. To assign a placement rule, you need to update the spec for the deployable or subscription to reference the placement rule.

Include the following `placement` fields in your deployable or subscription spec with the values to reference the placement rule:

```
placement:
  placementRef:
    name:
    kind: PlacementRule
```

Include the name of your placement rule as the value for the `name` field.  

For more information about updating the definition for a deployable or subscription, see:

* [Creating and managing deployables](managing_deployables.md)
* [Creating and managing subscriptions](managing_subscriptions.md)

When a placement rule is assigned to a subscription, you can view the assignment on the Applications dashboard within the console. To view the assignment:  

1. Open the console.
2. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
3. Click the **Resources** tab.
4. Scroll to the **Resource pipeline** section. Within the table that lists your applications, expand the row for the application that includes the subscription that is assigned the placement rule.
5. From the expanded view for the application, you can see the available subscriptions for each channel. The details for each subscription include any assigned placement rule. If needed, you can select to view or edit the YAML for the placement rule, subscription, and channel from this resource pipeline table.

## Placement rule status

When a placement rule is created and in use, you can view the status details for the rule. This status is appended to the YAML definition for a placement rule and indicates the target clusters where the rule is used for placing deployables. For more information about the available status fields, see [Placement rule status definition](#placement-rule-sample-files).

To view the status fields for a placement rule, you can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API.

* To use the console,

  1. Open the console.
  2. Click the **Search** icon in the Header.
  3. Within the search box, filter by `kind:placementrule` to view all placement rules.
  4. Within the list of all placement rules, click the placement rule that you want review. The YAML for that rule is displayed.
  5. Review the fields and values within the `status` section of the YAML content.

* To use the Kubernetes CLI tool, run the following command. Replace `name` and `namespace` with the name of the placement rule and the target namespace:

  1. Run the following command

     ```
     kubectl get PlacementRule <name> -n <namespace>
     ```

  2. Review the fields and values within the `status` section of the YAML content.

* To use REST API, you need to use the [placement rule GET API](../apis/placementrules.json).

## Update a placement rule

To update a placement rule that is a separate resource, you can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API.  

* To use the console to edit a placement rule, complete the following steps:

  1. Open the console.
  2. Click the **Search** icon in the Header.
  3. Within the search box, filter by `kind:placementrule` to view all placement rules.
  4. Within the list of all placement rules, click the placement rule that you want to update. The YAML for the rule is displayed.
  5. Click **Edit** to enable editing the YAML content.
  6. When you are finished your edits, click **Save**. Your changes are saved and applied automatically.

  Alternatively, you can select to edit the YAML from the Applications dashboard resource pipeline table.

  1. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
  2. Click the **Resources** tab.
  3. Scroll to the **Resource pipeline** section. Within the table that lists your applications, expand the row for the application that includes the subscription that is assigned the placement rule.
  4. From the expanded view for the application, you can see the available subscriptions for each channel. The details for each subscription include any assigned placement rule. Click the link for the placement rule to open the _Edit placement rule_ editor. The YAML for the rule is displayed.
  5. When you are finished your edits, click **Save**. Your changes are saved and applied automatically.  

* To use the Kubernetes CLI tool, the steps are the same as for creating a placement rule.

* To use REST API, you need to use the [placement rule PATCH API](../apis/placementrules.json).

To update a placement rule that is defined within the definition for a deployable or subscription, the steps are the same as for updating that resource. For more information, see:

  * [Creating and managing deployables](managing_deployables.md)
  * [Creating and managing subscriptions](managing_subscriptions.md)

## Delete a placement rule

To delete a placement rule that is a separate resource, you can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API.  

* To use the console, use the console search to find and delete a placement rule:

   1. Open the console.
   2. Click the **Search** icon in the Header.  
   3. Within the search box, filter by `kind:placementrule` to view all placement rules.
   4. Within the list of all placement rules, expand the _Options_ menu for the placement rule that you want to delete. Click **Delete placement rules**.
   5. When the list of all placement rules is refreshed, the placement rule is no longer displayed.

* To use the Kubernetes CLI tool, complete the following steps:

  1. Run the following command to delete the placement rule from a target namespace. Replace `name` and `namespace` with the name of your placement rule and your target namespace:

     ```
     kubectl delete PlacementRule <name> -n <namespace>
     ```

  2. Verify that your placement rule resource is deleted by running the following command:

     ```
     kubectl get PlacementRule <name>
     ```

* To use REST API, you need to use the placement rule DELETE API:
  * [Placement rule APIs](../apis/placementrules.json).

To delete a placement rule that is defined within the definition for a deployable or subscription, edit the definition for that resource to remove the placement rule definition. The steps are the same as for updating that resource. For more information, see:

* [Creating and managing deployables](managing_deployables.md)
* [Creating and managing subscriptions](managing_subscriptions.md)
