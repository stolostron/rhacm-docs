---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Role-based access control (RBAC)

{{site.data.keyword.product_tm}} supports several roles. Your role determines the actions that you can perform.
{:shortdesc}

Kubernetes offers role-based access control (RBAC) authorization mechanisms, which are extended on the cluster. Users of the cluster platform can be grouped into teams and have namespaces dedicated to teams.

With {{site.data.keyword.product}}, you can create a team and add users, user groups, and resources to that team. All users in a team have access to the team resources. A user, user group, or resource can be assigned to multiple teams.

{{site.data.keyword.product}} has one _Cluster Administrator_ with cluster-wide access, while other users can be classified as _Account Administrator_, _Administrator_, _Editor_, _Operator_, _Auditor_, and _Viewer_, assigned to various namespaces. Based on the role that is assigned to a user or user group, the level of access to each logical resource on the cluster is defined.

  - [Platform roles and actions](#platform)
  - [IAM roles and actions](#iam)
  - [RBAC for Kubernetes resources](#kube)
  - [RBAC for IAM resources](#resources)
  - [RBAC for resources in OpenShift clusters](#os)


## Platform roles and actions
{: #platform}

{{site.data.keyword.product}} supports the Cluster Administrator role. The Cluster Administrator has complete access to the {{site.data.keyword.product}} platform. Learn about roles in the following list:

**Cluster Administrator access:** The Cluster administrator has complete access for all operations.

* Connect to an LDAP directory
* Create teams, add users, and assign them the IAM roles
* Manage workloads, infrastructure, and applications across all namespaces
* Create namespaces
* Assign quotas
* Add pod security policies
* Add an internal Helm repository
* Delete an internal Helm repository
* Add Helm charts to the internal Helm repository
* Remove Helm charts from the internal Helm repository
* Synchronize internal and external Helm repositories
* Manage storage classes and persistent volumes across all namespaces
* Add, remove, and update image security enforcement policies
* Add, remove, and update service IDs in the cluster
* Register and add Service Broker to fetch ClusterServiceClasses and ClusterServicePlans
* Deploy Service Broker chart to fetch ClusterServiceClasses and ClusterServicePlans

**Account Administrator access:** The Account Administrator has all the privileges of the Administrator, and has add, update, view, and delete access for namespace.

**Administrator access:** The Administrator has add, update, view, and delete access.

**Editor access:** The Editor has read and edit access to team resources.

**Operator access:** The Operator has create, read, and edit access to team resources.

**Auditor access:** The Auditor can view logs within namespaces if given access to those namespaces.

**Viewer access:** The Viewer has read-only access. By default, users have Viewer access when they are added to a team.

## IAM roles and actions
{: #iam}

You can assign an IAM role to users or user groups when you add them to a team. Within a team, each user or user group can have only one role. However, a user might have multiple roles within a team when you add a user individually and also as a member of a team's group. If so, the user can act based on the highest role that is assigned to the user. For example, if you add the user as an administrator and you assign a _Viewer_ role to the user's group, the user can act as an administrator for the team.

A user or user group can be a member of multiple teams and have different roles on each team.

An IAM role defines the actions that a user can perform on the team resources.

{{site.data.keyword.product}} supports the following IAM roles:

**Note:** Only the Cluster Administrator and Administrator can manage teams, users, and roles. The Administrator cannot assign the Cluster Administrator role to any user or group.

|Role|Description|Actions|
|--------|-------|---------|
|Viewer|Has read-only access.|The following actions can be completed by a Viewer: <ul><li>View information about the team resources</li><li>View metering data</li></ul> <br/> The Viewer cannot view the following {{site.data.keyword.gui}} pages: <ul><li>Dashboard</li><li>Secrets</li><li>Nodes</li><li>Identity & Access</li><li>Resource Security</li></ul>|
|Editor|Has read and edit access.|The following actions can be completed by an Editor: <ul><li>View metering data</li></ul> <br/> The Editor cannot view the following {{site.data.keyword.gui}} pages: <ul><li>Dashboard</li><li>Nodes</li><li>Identity & Access</li><li>Resource Security</li></ul>|
|Auditor|Has read access.|The following actions can be completed by an Auditor: <ul><li>View logs</li><li>View metering data</li></ul> <br/> The Auditor cannot view the following {{site.data.keyword.gui}} pages: <ul><li>Dashboard</li><li>Nodes</li><li>Identity & Access</li><li>Resource Security</li></ul>|
|Operator </br> (Also referred to as `Team Operator`)|Has read, edit, and create access.|The following actions can be completed by an Operator: <ul><li>Access monitoring dashboards and data</li><li>View the metering data</li><li>Access monitoring service APIs</li></ul><br/> The Operator cannot view the following {{site.data.keyword.gui}} pages: <ul><li>Dashboard</li><li>Nodes</li><li>Identity & Access</li><li>Pod Security</li></ul> **Note**: Operators cannot create or delete an image policy.|
|Administrator </br> (Also referred to as `Team Administrator`)|Has add, update, view, and delete access.|You must be assigned to an LDAP directory team by the cluster administrator to complete the following actions: <ul><li>Create teams</li><li>Assign resources to other teams</li>  **Note:** Administrators can assign resources to teams that the Cluster Administrator has assigned to them.<li>Manage users, groups, and roles for their teams</li> **Note:** Administrators cannot assign the cluster administrator role to any user or group.<li>Read, update, and delete resources of a team</li><li>Access monitoring dashboards and data</li><li>Access the Metering page to view metering data and the API keys page </li><li>Access monitoring service APIs</li></ul> <br/> The Administrator cannot view the following {{site.data.keyword.gui}} pages: <ul><li>Dashboard</li><li>Nodes</li><li>Pod Security</li></ul> **Note**: Administrators can view, create, or delete an image policy.|
|Cluster Administrator|Has complete access to {{site.data.keyword.product}} platform.|See [Platform role and actions](assign_role.md#platform)|
{: caption="Table 1. IAM roles and actions" caption-side="top"}

**Note:** Viewers and editors cannot view logs on any of the {{site.data.keyword.product}} {{site.data.keyword.gui}} pages.


### RBAC for Kubernetes resources
{: #kube}

The IAM role that you assign to a user also defines the actions that the user can do on the Kubernetes resources that are assigned to the team. For example, if user1 is an operator in team1, and team1 has namespace1 resource, then user1 can view and update namespace1 information. User1 can also create resources, for example pods, in namespace1. If you remove user1 from team1, you remove user1's role binding for the resources in team1. If user1 is part of another team, say team2, that has the same namespace, then user1's role binding to the namespace in team2 is not affected when you remove the user from team1.

| **Action**        | **Administrator**  | **Operator** | **Editor** | **Viewer** |
|-------------------|--------------------|--------------|------------|------------|
| get               | X                  | X            | X          | X          |
| list              | X                  | X            | X          | X          |
| watch             | X                  | X            | X          | X          |
| update            | X                  | X            | X          |            |
| patch             | X                  | X            | X          |            |
| create            | X                  | X            |            |            |
| delete            | X                  |              |            |            |
| deletecollection  | X                  |              |            |            |
{: caption="Table 2. Allowed actions based on IAM role" caption-side="top"}

**Note:** For the `imagepolicies` resource, the Operator has `get`, `list`, and `watch` permissions. The Operator cannot `update`, `patch`, or `create` the resource. In an OpenShift environment, the Operator has all the permissions as listed in Table 4 for the `imagepolicies` resource.

Resource | Administrator | Operator | Editor |  Viewer
-- | -- | -- | -- | --
clusterrolebindings.rbac.authorization.k8s.io | X |   |   |     
clusterservicebrokers.servicecatalog.k8s.io       (only view access) | X | X | X |  X
clusterserviceclasses.servicecatalog.k8s.io       (only view access) | X | X | X |  X
clusterserviceplans.servicecatalog.k8s.io       (only view access) | X | X | X |  X
configmaps | X | X | X |  X
cronjobs.batch | X | X | X |  X
daemonsets.apps | X | X | X |  X
daemonsets.extensions | X | X | X |  X
deployments.apps | X | X | X |  X
deployments.extensions | X | X | X |  X
deployments.apps/rollback | X | X |   |
deployments.extensions/rollback | X | X |   |
deployments.apps/scale | X | X | X |
deployments.extensions/scale | X | X | X |  X
endpoints | X | X | X |  X
events | X | X | X |  X
horizontalpodautoscalers.autoscaling | X | X | X |  X
images.icp.ibm.com | X | X | X |  X
imagepolicies | X | X | X | X  
ingresses.extensions | X | X | X |  X
jobs.batch | X | X | X |  X
limitranges | X | X | X |  X
localsubjectaccessreviews.authorization.k8s.io | X |   |   |    
namespaces | X | X | X |  X
namespaces/status | X | X | X |  X
networkpolicies.extensions | X | X | X |  X
networkpolicies.networking.k8s.io | X | X | X |  X
persistentvolumeclaims | X | X | X |  X
poddisruptionbudgets.policy | X |   |   |   
pods | X | X | X |  X
pods/attach | X | X | X |  X   
pods/exec | X | X | X |  X
pods/log | X | X | X |  X
pods/portforward | X | X | X |  X
pods/proxy | X | X | X |   
pods/status | X | X | X |
replicasets.apps | X | X | X |  X
replicasets.extensions | X | X | X |  X
replicasets.apps/scale | X | X | X |  X
replicasets.extensions/scale | X | X | X |  X
replicationcontrollers | X | X | X |  X
replicationcontrollers/scale | X | X | X |  X
replicationcontrollers.extensions/scale | X | X | X |  X
replicationcontrollers/status | X | X | X |  X
resourcequotas | X | X | X |  X
resourcequotas/status | X | X | X |  X
rolebindings.rbac.authorization.k8s.io | X |   |   |   
roles.rbac.authorization.k8s.io | X |   |   |    
scheduledjobs.batch | X |   |   |   
secrets | X | X | X |   
serviceaccounts | X | X | X |  X
servicebindings.servicecatalog.k8s.io | X | X | X |  X
servicebindings.servicecatalog.k8s.io/status | X | X | X |  X
serviceinstances.servicecatalog.k8s.io | X | X | X |  X
serviceinstances.servicecatalog.k8s.io/status | X | X | X |  X
services | X | X | X |  
services/proxy | X | X | X |  X
statefulsets.apps | X | X | X |  X
{: caption="Table 3. Allowed resource permissions by role" caption-side="top"}

### RBAC for IAM resources
{: #resources}

| **IAM resource** | **Action**  | **Administrator**    | **Operator**    | **Editor**     | **Auditor** | **Viewer** |
|-----------|-------------|----------------------|-----------------|----------------|-------------|------------|
|| Identity Management API explorer | X | X | X | X | X |
| **Certificate: /idmgmt/identity/api/v1/certificates** |
|| Create user certificate | X | X | X | X | X |
|| Read user certificate | X | X | X | X | X |
|| Delete user certificate | X | X | X | X | X |
| **Account: /idmgmt/identity/api/v1/account** |
|| Read {{site.data.keyword.product}} default account | X | X | X | X | X |
|| Create {{site.data.keyword.product}} default account | X |  |  |  |  |
|| Update {{site.data.keyword.product}} default account | X |  |  |  |  |
|| Delete {{site.data.keyword.product}} default account | X |  |  |  |  |
| **Directory: /idmgmt/identity/api/v1/directory/ldap** |
|| Read LDAP directory details| X |  |  |  |  |
| **User: /idmgmt/identity/api/v1/users** |
|| Create user details | X |  |  |  |  |
|| Read user details | X | X | X | X | X |
|| Update user details | X |  |  |  |  |
|| Delete user details | X |  |  |  |  |
| **User group: /idmgmt/identity/api/v1/usergroup** |
|| Create user group details | X |  |  |  |  |
|| Read user group details | X | X | X | X | X |
|| Update user group details | X |  |  |  |  |
|| Delete user group details | X |  |  |  |  |
| **Team: /idmgmt/identity/api/v1/teams** |
|| Create team details | X |  |  |  |  |
|| Read team details | X | X | X | X | X |
|| Update team details | X |  |  |  |  |
|| Delete team details | X |  |  |  |  |
| **Resource: /idmgmt/identity/api/v1/resources** |
|| Create resource details | X |  |  |  |  |
|| Read resource details | X | |  |  |  |
|| Update resource details | X |  |  |  |  |
|| Delete resource details | X |  |  |  |  |
| **User Preferences: /idmgmt/identity/api/v1/userpreferences** |
|| Create user preferences | X | X | X | X | X |
|| Read user preferences | X | X | X | X | X |
|| Update user preferences | X | X | X | X | X |
| **Security Assertion Markup Language (SAML) authentication: /idmgmt/v1/saml** |
|| Get SAML status | X |  |  |  |  |
|| Update or reconfigure SAML authentication | X |  |  |  |  |
|| Create or configure SAML authentication | X |  |  |  |  |
| **Service ID: /iam-token/serviceids** |
|| Create a service ID | X | X | X | X | X |
|| List Service ID details | X | X | X | X | X |
|| Update a service ID | X | X | X | X | X |
|| Delete a service ID  | X | X | X | X | X |
| **API key: /iam-token/apikeys** |
|| Create an API key | X | X | X | X | X |
|| List all API keys | X | X | X | X | X |
|| Update an API key | X | X | X | X | X |
|| Delete an API key | X | X | X | X | X |
| **Service policy: /v1/scopes/{scope}/service_ids/{serviceId}/policies** |
|| Create service policy details | X | X | X | X | X |
|| Read service policy details | X | X | X | X | X |
|| Update service policy details | X | X | X | X | X |
|| Delete service policy details | X | X | X | X | X |
{: caption="Table 4. RBAC for IAM resources" caption-side="top"}

**Note:** A user can create Service ID policies with the same level of access that the user has. The user cannot create or assign policies with a higher role to a service ID.

### RBAC for resources in OpenShift clusters
{: #os}

OpenShift clusters use the Cluster Administrator, Administrator, Operator or Editor, and Viewer roles. The Cluster Administrator has complete access to all the resources. For the Administrator, Operator or Editor, and Viewer roles, the following tables list the resources and the actions that are allowed on the resources.

|Resource | Get | List | Watch|Update | Patch| Create|Delete | Delete collection|Edit| View|Impersonate|Admin|
|---------|-----|------|------|-------|------|-------|-------|------------------|-----|------|------|----|
|app.ibm.com|X|X|X|X |X |X |X |X || |||
|apps/controllerrevisions|X|X|X| | | | | || |||
|apps/daemonsets|X|X|X|X |X |X |X | X|| |||
|apps/deployments|X|X|X|X |X |X |X | X|| |||
|apps/deployments/rollback||||X |X |X |X | X|| |||
|apps/deployments/scale|X|X|X|X |X |X |X | X|| |||
|apps/replicasets|X|X|X|X |X |X |X | X|| |||
|apps/replicasets/scale|X|X|X|X |X |X |X | X|| |||
|apps/statefulsets|X|X|X|X |X |X |X | X|| |||
|apps/statefulsets/scale|X|X|X|X |X |X |X | X|| |||
|apps.openshift.io/deploymentconfigs|X|X|X|X |X |X |X | X|| |||
|apps.openshift.io/deploymentconfigs/instantiate| ||| | |X | | || |||
|apps.openshift.io/deploymentconfigs/rollback| ||| | |X | | || |||
|apps.openshift.io/deploymentconfigs/scale|X|X|X|X |X |X |X | X|| |||
|apps.openshift.io/deploymentconfigs/log|X|X|X| | | | | || |||
|apps.openshift.io/deploymentconfigs/status|X|X|X| | | | | || |||
|apps.openshift.io/deploymentconfigrollbacks |||| | | X| | || |||
|authorization.k8s.io/localsubjectaccessreviews| ||| | | X| | || |||
|authorization.openshift.io/localresourceaccessreviews |||| | | X| | || |||
|authorization.openshift.io/localsubjectaccessreviews |||| | |X | | || |||
|authorization.openshift.io/rolebindings |X|X|X|X |X |X |X | X|| |||
|authorization.openshift.io/rolebindingrestrictions |X|X|X| | | | | || |||
|authorization.openshift.io/roles |X|X|X|X |X |X |X | X|| |||
|authorization.openshift.io/resourceaccessreviews |||| | | X| | || |||
|authorization.openshift.io/subjectaccessreviews |||| | | X| | || |||
|authorization.openshift.io/subjectrulesreviews |||| | | X| | || |||
|autoscaling/horizontalpodautoscalers|X|X|X|X |X |X |X | X|| |||
|batch/cronjobs|X|X|X| X|X | X| X|X || |||
|batch/jobs|X|X|X|X | X|X |X | X|| |||
|bindings|X|X|X| | | | | || |||
|build.openshift.io/builds|X|X|X| X| X|X | X| X|| |||
|build.openshift.io/builds/details| ||| X| | | | || |||
|build.openshift.io/builds/log|X|X|X| | | | | || |||
|build.openshift.io/buildconfigs|X|X|X| X| X|X | X| X|| |||
|build.openshift.io/buildconfigs/instantiate| ||| | |X | | || |||
|build.openshift.io//instantiatebinary| ||| | |X | | || |||
|build.openshift.io//clone| ||| | |X | | || |||
|build.openshift.io/buildconfigs/webhooks|X|X|X|X | X| X|X |X || |||
|build.openshift.io/buildlogs|X|X|X|X | X| X|X |X || |||
|build.openshift.io/jenkins| ||| | | | | |X| X|||
|certmanager.k8s.io/certificates|X|X|X|X | X|X |X |X || |||
|certmanager.k8s.io/issuers|X|X|X|X | X|X|X | X|| |||
|clusterloggings.logging.openshift.io/customresourcedefinitions|X| |X| | | | | || |||
|clusters|X|X|X|X |X |X |X | X|| |||
|configmaps|X|X|X|X |X | X| X|X || |||
|elasticsearches.logging.openshift.io/customresourcedefinitions|X| | | | | | | || |||
|endpoints|X|X|X|X |X | X| X|X || |||
|events|X|X|X| | | | | || |||
|extensions/daemonsets|X|X|X|X |X |X |X | X|| |||
|extensions/deployments|X|X|X|X |X |X |X | X|| |||
|extensions/deployments/rollback|||| X| X|X |X | X|| |||
|extensions/deployments/scale|X|X|X|X |X |X |X | X|| |||
|extensions/ingresses|X|X|X|X |X |X |X | X|| |||
|extensions/networkpolicies|X|X|X|X |X |X |X | X| | |||
|extensions/replicasets|X|X|X|X |X |X |X | X|| |||
|extensions/replicasets/scale|X|X|X|X |X |X |X | X|| |||
|extensions/replicationcontrollers/scale|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreamimages|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreamimports| ||| | | X| | || |||
|image.openshift.io/imagestreammappings|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreams|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreamtags|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreams/layers|X| || X| | | | || |||
|image.openshift.io/imagestreams/secrets|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreams/status|X|X|X| | | | | || |||
|limitranges|X|X|X| | | | | || |||
|logging.openshift.io/clusterloggings|X|X|X|X |X | X| X| || |||
|logging.openshift.io/elasticsearches|X|X|X|X | X| X|X | || |||
|metrics.k8s.io/pods|X|X|X| | | | | || |||
|monitoringcontroller.cloud.ibm.com/alertrules|X|X|X|X |X |X |X | X|| |||
|monitoringcontroller.cloud.ibm.com/monitoringdashboards|X|X|X|X |X |X |X | X|| |||
|namespaces|X|X|X| | | | | || |||
|namespaces/status|X|X|X| | | | | || |||
|networking.k8s.io/ingresses|X|X|X|X |X |X |X | X|| |||
|networking.k8s.io/networkpolicies|X|X|X|X |X |X |X | X| | |||
|oidc.security.ibm.com/clients|X|X|X| X|X | X|X | || |||
|operators.coreos.com/catalogsources|X|X|X| | | |X | || |||
|operators.coreos.com/clusterserviceversions|X|X|X| | | |X | || |||
|operators.coreos.com/installplans|X|X|X| | | |X | || |||
|operators.coreos.com/operatorgroups|X|X|X| | | | | || |||
|operators.coreos.com/subscriptions|X|X|X| X| X|X |X | || |||
|packages.operators.coreos.com/packagemanifests|X|X|X| X| X|X |X  || | |||
|packages.operators.coreos.com/packagemanifests/icon|X|X|X| | | | | || |||
|persistentvolumeclaims|X|X|X|X |X |X |X | X|| |||
|pods|X|X|X|X |X |X |X | X|| |||
|pods/attach|X|X|X|X |X |X |X | X|| |||
|pods/exec|X|X|X|X |X |X |X | X|| |||
|pods/log|X|X|X| | | | | || |||
|pods/portforward|X|X|X|X |X |X |X | X|| |||
|pods/proxy|X|X|X|X |X |X |X | X|| |||
|pods/status|X|X|X| | | | | || |||
|policy/poddisruptionbudgets|X|X|X|X |X |X |X | X|| |||
|project.openshift.io/projects|X| || X|X | | X| || |||
|quota.openshift.io/appliedclusterresourcequotas|X|X|X| | | | | || |||
|rbac.authorization.k8s.io/rolebindings |X|X|X|X |X |X |X | X|| |||
|rbac.authorization.k8s.io/roles |X|X|X|X |X |X |X | X|| |||
|replicationcontrollers|X|X|X|X |X |X |X | X|| |||
|replicationcontrollers/scale|X|X|X|X |X |X |X | X|| |||
|replicationcontrollers/status|X|X|X| | | | | || |||
|resourcequotas|X|X|X| | | | | || |||
|resourcequotas/status|X|X|X| | | | | || |||
|resourcequotausages|X|X|X| | | | | || |||
|route.openshift.io/routes|X|X|X|X |X |X |X | X|| |||
|route.openshift.io/routes/custom-host| | | | | |X | | || |||
|route.openshift.io/routes/status |X|X|X| X| | | | || |||
|secrets|X|X|X|X |X |X |X | X|| |||
|security.openshift.io/podsecuritypolicyreviews| | | | | |X | | || |||
|security.openshift.io/podsecuritypolicyselfsubjectreviews| | | | | | X| | || |||
|security.openshift.io/podsecuritypolicysubjectreviews| | || | |X | | || |||
|serviceaccounts|X|X|X|X |X |X |X | X|| |X||
|services|X|X|X|X |X |X |X | X|| |||
|services/proxy|X|X|X|X |X |X |X | X|| |||
|template.openshift.io/processedtemplates|X|X|X|X |X |X |X | X|| |||
|template.openshift.io/templates|X|X|X|X |X |X |X | X|| |||
|template.openshift.io/templateconfigs|X|X|X|X |X |X |X | X|| |||
|template.openshift.io/templateinstances|X|X|X|X |X |X |X | X|| || |
{: caption="Table 5. Allowed resources for the Administrator role in OpenShift clusters" caption-side="top"}

|Resource | Get | List | Watch|Update | Patch| Create|Delete | Delete collection|Edit| View|Impersonate|Admin|
|-------- | --- | ---- | -----| ------|----- |------ |------ |----------------- |-----|------|------|----|
|apps/controllerrevisions|X|X|X| | | | | || |||
|apps/daemonsets|X|X|X|X |X |X |X | X|| |||
|apps/deployments|X|X|X|X |X |X |X | X|| |||
|apps/deployments/rollback||||X |X |X |X | X|| |||
|apps/deployments/scale|X|X|X|X |X |X |X | X|| |||
|apps/replicasets|X|X|X|X |X |X |X | X|| |||
|apps/replicasets/scale|X|X|X|X |X |X |X | X|| |||
|apps/statefulsets|X|X|X|X |X |X |X | X|| |||
|apps/statefulsets/scale|X|X|X|X |X |X |X | X|| |||
|apps.openshift.io/deploymentconfigs|X|X|X|X |X |X |X | X|| |||
|apps.openshift.io/deploymentconfigs/instantiate|||| | |X | | || |||
|apps.openshift.io/deploymentconfigs/rollback|||| | |X | | || |||
|apps.openshift.io/deploymentconfigs/scale|X|X|X|X |X |X |X | X|| |||
|apps.openshift.io/deploymentconfigs/log|X|X|X| | | | | || |||
|apps.openshift.io/deploymentconfigs/status|X|X|X| | | | | || |||
|apps.openshift.io/deploymentconfigrollbacks |||| | | X| | || |||
|autoscaling/horizontalpodautoscalers|X|X|X|X |X |X |X | X|| |||
|batch/cronjobs|X|X|X| X|X | X| X|X || |||
|batch/jobs|X|X|X|X | X|X |X | X|| |||
|bindings|X|X|X| | | | | || |||
|build.openshift.io/builds|X|X|X| X| X|X | X| X|| |||
|build.openshift.io/builds/details|||| X| | | | || |||
|build.openshift.io/builds/log|X|X|X| | | | | || |||
|build.openshift.io/buildconfigs|X|X|X| X| X|X | X| X|| |||
|build.openshift.io/buildconfigs/instantiate|||| | |X | | || |||
|build.openshift.io//instantiatebinary|||| | |X | | || |||
|build.openshift.io//clone|||| | |X | | || |||
|build.openshift.io/buildconfigs/webhooks|X|X|X|X | X| X|X |X || |||
|build.openshift.io/buildlogs|X|X|X| | | | | || |||
|build.openshift.io/jenkins|||| | | | | |X| X|||
|certmanager.k8s.io/certificates|X|X|X|X | X|X | ||| |||
|certmanager.k8s.io/issuers|X|X|X|X | X|X| | || |||
|clusterloggings.logging.openshift.io/customresourcedefinitions|X||| | | | | || |||
|configmaps|X|X|X|X |X | X| X|X || |||
|elasticsearches.logging.openshift.io/customresourcedefinitions|X||| | | | | || |||
|endpoints|X|X|X|X |X | X| X|X || |||
|events|X|X|X| | | | | || |||
|extensions/daemonsets|X|X|X|X |X |X |X | X|| |||
|extensions/deployments|X|X|X|X |X |X |X | X|| |||
|extensions/deployments/rollback|||| X| X|X |X | X|| |||
|extensions/deployments/scale|X|X|X|X |X |X |X | X|| |||
|extensions/ingresses|X|X|X|X |X |X |X | X|| |||
|extensions/networkpolicies|X|X|X|X |X |X |X | X| | |||
|extensions/replicasets|X|X|X|X |X |X |X | X|| |||
|extensions/replicasets/scale|X|X|X|X |X |X |X | X|| |||
|extensions/replicationcontrollers/scale|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreamimages|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreamimports|||| | | X| | || |||
|image.openshift.io/imagestreammappings|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreams|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreamtags|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreams/layers|X||| X| | | | || |||
|image.openshift.io/imagestreams/secrets|X|X|X|X |X |X |X | X|| |||
|image.openshift.io/imagestreams/status|X|X|X| | | | | || |||
|limitranges|X|X|X| | | | | || |||
|logging.openshift.io/clusterloggings|X|X|X|X |X | X| X| || |||
|logging.openshift.io/elasticsearches|X|X|X|X | X| X|X | || |||
|metrics.k8s.io/pods|X|X|X| | | | | || |||
|monitoringcontroller.cloud.ibm.com/alertrules|X|X|X|X |X |X | | || |||
|monitoringcontroller.cloud.ibm.com/monitoringdashboards|X|X|X|X |X |X | | || |||
|namespaces|X|X|X| | | | | || |||
|namespaces/status|X|X|X| | | | | || |||
|networking.k8s.io/ingresses|X|X|X|X |X |X |X | X|| |||
|networking.k8s.io/networkpolicies|X|X|X|X |X |X |X | X| | |||
|oidc.security.ibm.com/clients|X|X|X| X|X | X|X | || |||
|operators.coreos.com/catalogsources|X|X|X| | | |X | || |||
|operators.coreos.com/clusterserviceversions|X|X|X| | | |X | || |||
|operators.coreos.com/installplans|X|X|X| | | |X | || |||
|operators.coreos.com/operatorgroups|X|X|X| | | | | || |||
|operators.coreos.com/subscriptions|X|X|X| X| X|X |X | || |||
|packages.operators.coreos.com/packagemanifests|X|X|X| X| X|X |X  || | |||
|packages.operators.coreos.com/packagemanifests/icon|X|X|X| | | | | || |||
|persistentvolumeclaims|X|X|X|X |X |X |X | X|| |||
|pods|X|X|X|X |X |X |X | X|| |||
|pods/attach|X|X|X|X |X |X |X | X|| |||
|pods/exec|X|X|X|X |X |X |X | X|| |||
|pods/log|X|X|X| | | | | || |||
|pods/portforward|X|X|X|X |X |X |X | X|| |||
|pods/proxy|X|X|X|X |X |X |X | X|| |||
|pods/status|X|X|X| | | | | || |||
|policy/poddisruptionbudgets|X|X|X|X |X |X |X | X|| |||
|project.openshift.io/projects|X||| | | | | || |||
|quota.openshift.io/appliedclusterresourcequotas|X|X|X| | | | | || |||
|replicationcontrollers|X|X|X|X |X |X |X | X|| |||
|replicationcontrollers/scale|X|X|X|X |X |X |X | X|| |||
|replicationcontrollers/status|X|X|X| | | | | || |||
|resourcequotas|X|X|X| | | | | || |||
|resourcequotas/status|X|X|X| | | | | || |||
|resourcequotausages|X|X|X| | | | | || |||
|route.openshift.io/routes|X|X|X|X |X |X |X | X|| |||
|route.openshift.io/routes/custom-host|||| | |X | | || |||
|route.openshift.io/routes/status |X|X|X| | | | | || |||
|secrets|X|X|X|X |X |X |X | X|| |||
|serviceaccounts|X|X|X|X |X |X |X | X|| |X||
|services|X|X|X|X |X |X |X | X|| |||
|services/proxy|X|X|X|X |X |X |X | X|| |||
|template.openshift.io/processedtemplates|X|X|X|X |X |X |X | X|| |||
|template.openshift.io/templates|X|X|X|X |X |X |X | X|| |||
|template.openshift.io/templateconfigs|X|X|X|X |X |X |X | X|| |||
|template.openshift.io/templateinstances|X|X|X|X |X |X |X | X|| || |
{: caption="Table 6. Allowed resources for the Operator/Editor role in OpenShift clusters" caption-side="top"}


|Resource | Get | List | Watch|View |
|-------- | --- | ---- | -----| ------|
|apps/controllerrevisions|X|X|X| |
|apps/daemonsets|X|X|X| |
|apps/deployments|X|X|X| |
|apps/deployments/scale|X|X|X| | 
|apps/replicasets|X|X|X| | 
|apps/replicasets/scale|X|X|X| |
|apps/statefulsets|X|X|X| |
|apps/statefulsets/scale|X|X|X| |
|apps.openshift.io/deploymentconfigs|X|X|X| |
|apps.openshift.io/deploymentconfigs/scale|X|X|X| | 
|apps.openshift.io/deploymentconfigs/log|X|X|X| |
|apps.openshift.io/deploymentconfigs/status|X|X|X| |
|autoscaling/horizontalpodautoscalers|X|X|X| | 
|batch/cronjobs|X|X|X| |
|batch/jobs|X|X|X|| 
|bindings|X|X|X| |
|build.openshift.io/builds|X|X|X| | 
|build.openshift.io/builds/log|X|X|X| | 
|build.openshift.io/buildconfigs|X|X|X| | 
|build.openshift.io/buildconfigs/webhooks|X|X|X| | 
|build.openshift.io/buildlogs|X|X|X| |
|build.openshift.io/jenkins|||| X|
|clusterloggings.logging.openshift.io/customresourcedefinitions|X||| |
|configmaps|X|X|X| | 
|elasticsearches.logging.openshift.io/customresourcedefinitions|X||| | 
|endpoints|X|X|X| |
|events|X|X|X| | 
|extensions/daemonsets|X|X|X| |
|extensions/deployments|X|X|X| |
|extensions/deployments/scale|X|X|X| | 
|extensions/ingresses|X|X|X| |
|extensions/networkpolicies|X|X|X| |
|extensions/replicasets|X|X|X| | 
|extensions/replicasets/scale|X|X|X| |
|extensions/replicationcontrollers/scale|X|X|X| | 
|image.openshift.io/imagestreamimages|X|X|X| | 
|image.openshift.io/imagestreammappings|X|X|X| |
|image.openshift.io/imagestreams|X|X|X| |
|image.openshift.io/imagestreamtags|X|X|X| | 
|image.openshift.io/imagestreams/layers|X||| |
|image.openshift.io/imagestreams/status|X|X|X| |
|limitranges|X|X|X| |
|logging.openshift.io/clusterloggings|X|X|X| |
|logging.openshift.io/elasticsearches|X|X|X| |
|metrics.k8s.io/pods|X|X|X| |
|monitoringcontroller.cloud.ibm.com/alertrules|X|X|X| |
|monitoringcontroller.cloud.ibm.com/monitoringdashboards|X|X|X| | 
|namespaces|X|X|X| |
|namespaces/status|X|X|X| |
|networking.k8s.io/ingresses|X|X|X| |
|networking.k8s.io/networkpolicies|X|X|X| |
|operators.coreos.com/catalogsources|X|X|X| | 
|operators.coreos.com/clusterserviceversions|X|X|X| |
|operators.coreos.com/installplans|X|X|X| | 
|operators.coreos.com/operatorgroups|X|X|X| |
|operators.coreos.com/subscriptions|X|X|X| | 
|packages.operators.coreos.com/packagemanifests|X|X|X| | 
|packages.operators.coreos.com/packagemanifests/icon|X|X|X| | 
|persistentvolumeclaims|X|X|X| | 
|pods|X|X|X| |
|pods/log|X|X|X| |
|pods/status|X|X|X| |
|policy/poddisruptionbudgets|X|X|X| |
|project.openshift.io/projects|X||| | 
|quota.openshift.io/appliedclusterresourcequotas|X|X|X| |
|replicationcontrollers|X|X|X| |
|replicationcontrollers/scale|X|X|X| |
|replicationcontrollers/status|X|X|X| |
|resourcequotas|X|X|X| | 
|resourcequotas/status|X|X|X| | 
|resourcequotausages|X|X|X| |
|route.openshift.io/routes|X|X|X| | 
|route.openshift.io/routes/status |X|X|X| | 
|serviceaccounts|X|X|X| |
|services|X|X|X| |
|template.openshift.io/processedtemplates|X|X|X| |
|template.openshift.io/templates|X|X|X| | 
|template.openshift.io/templateconfigs|X|X|X| |
|template.openshift.io/templateinstances|X|X|X| |
{: caption="Table 7. Allowed resources for the Viewer role in OpenShift clusters" caption-side="top"}