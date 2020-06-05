# Observability in the console 

Learn more about console components that you can use to view, manage, or customize your console. 

## Red Hat Advanced Cluster Management for Kubernetes console components

Red Hat Advanced Cluster Management for Kubernetes console components:

- [Access your console](#access-your-console)
- [Welcome page](#welcome-page) 
- [Observe environment details](#observe-environment-details)
- [Automate Infrastructure](#automate-infrastructure)
- [Manage applications](#manage-applications)
- [Governance and risk dashboard](#governance-and-risk-dashboard)
- [Topology page](#topology-page)

To learn about Search, see [Search in the console](search.md)

## Access your console

- Access from the Red Hat OpenShift console:

  1. From the left-hand navigation, click **Networking** > **Routes**

  2. From the _Project_ menu, select the namespace where Red Hat Advanced Cluster Management for Kubernetes is installed.

  3. Find `multicloud-console` and click the URL from the `Location` column.

- Access the console from the Red Hat OpenShift CLI:

  1. While logged in to OpenShift, run the following command to find the route, where `<namespace-from-install>` is the namespace where you installed Red Hat Advanced Cluster Management for Kubernetes:

  ```
  oc get routes -n <namespace-from-install>
  ```
  2. Find the `multicloud-console` name and the `Host/Port` columns to get your URL.

## Welcome page

From the Red Hat Advanced Cluster Management for Kubernetes Welcome page, you get more information about the product and you can access header features, such as _Search_ and _Create resource_. Also from the _Header_, you can click the **Help** (?) icon to view the _About_ page and the documentation. From the _User_ menu, you can access the _Configure Client_ page. Additionally, you can use the [Visual Web Terminal](vwt_search.md). 

## Observe environment details

Reorganize your dashboard. You can personalize your view of the Overview dashboard by reorganizing the resource overview cards. You can view the following information about your clusters:  

* Name of the cloud service with the number of clusters
* Cluster compliance
* Pod details
* Pod status
* Cluster resources (VCPU/Memory usage)
* Storage usage

Additionally, the Heatmap displays color-coordinated boxes that represent the VCPU usage threshold of your nodes. 

### Filtering your results

You can personalize your view of the page by using the filtering feature. Click **Filter results** to specify what information is displayed on your page.

## Automate infrastructure

Create clusters or import existing clusters. Scale up or down and delete clusters as needed. For more information, see [Managing your clusters with Red Hat Advanced Cluster Management for Kubernetes](../manage_cluster/intro.md)

## Manage applications

Click **New application** to edit a `.yaml` file and create your application. Click Resources to view the information of each application. For more information about application resources, see [Application management (Technology preview)](../manage_applications/app_management_overview.md).

### Viewing your pod health 

View the pod health for all of your clusters by expanding the Heatmap.

Click **Show details** to view the map. The size of the color-coordinated boxes represents the number of nodes on your cluster. Hover your cursor over the box to view the response time of your cluster. 

## Topology page 

The Topology page uses information from Weave Scope probe to display Kubernetes objects within a cluster. You can view hub cluster resources. As you configure managed clusters, you see more clusters in the Topology view. 

To reduce the graphics on the page, you can filter the view by Clusters, Namespaces, and Labels. You can also filter the design by selecting the icon that represents the Kubernetes objects.

Learn more about the tabs that are available from the Topology page:

  - Clusters: You can monitor your cluster network, object network, and security policies in a graphical format. View your hub clusters, all your managed clusters, and monitor security violations.

  - Networking: View Kubernetes objects for each cluster and any networks between your Kubernetes objects. Objects display changes if they were recently started. Pods also indicate `pending` and `failed` status.

  - Policies: View the policy, policy placement, and clusters that are being validated. Check for violations for the selected policy.

## Governance and risk dashboard

Use the Governance and risk dashboard to create and manage policies and policy controllers. For more information, see [Governance and risk](../security/compliance_intro.md).
