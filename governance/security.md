# Security

Manage your security and role-based access control (RBAC) of Red Hat Advanced Cluster Management for Kubernetes components. Govern your cluster with defined policies and processes to identify and minimize risks. Use policies to define rules and set controls. 

**Prerequisite**: You must configure authentication service requirements for Red Hat Advanced Cluster Management for Kubernetes to onboard workloads to Identity and Access Management (IAM). For more information see, _Understanding authentication_ in [OpenShift Container Platform documentation](https://docs.openshift.com/container-platform/4.3/authentication/understanding-authentication.html).

## Role-based access control

Red Hat Advanced Cluster Management for Kubernetes supports several roles. Your role determines the actions that you can perform. Kubernetes offers role-based access control (RBAC) authorization mechanisms, so users of the cluster platform can be grouped into teams and have namespaces dedicated to teams. For more information about RBAC, see the _RBAC_ overview in the [OpenShift Container Platform documentation](https://docs.openshift.com/container-platform/4.3/authentication/using-rbac.html). View the following RBAC tables for components in Red Hat Advanced Cluster Management for Kubernetes:

| API | ClusterAdmin | Administrator | Editor | Viewer |
|-----|--------------|---------------|--------|--------|
|resourceview.mcm.ibm.com 	|create, read, update, delete 	|create, read, update, delete 	|read, update 	|read|
|works.mcm.ibm.com 	|create, read, update, delete 	|create, read, update, delete 	| read, update	| read |
|worksets.mcm.ibm.com 	|create, read, update, delete 	|create, read, update, delete 	| read, update	| read |
|clusterstatus.mcm.ibm.com 	|create, read, update, delete 	| read 	| read |	read |
|cluster.clusterregistry.k8s.io 	|create, read, update, delete 	| read 	 read |	read |
|endpointconfig.mcm.ibm.com 	|create, read, update, delete 	|create, read, update, delete 	| read, update	| read |
| policies.policy.mcm.ibm.com| create, read, update, delete     |create, read, update, delete     | -     | -     |
|app.k8s.io, apps.open-cluster-management.io| create, read, update, delete 	|create, read, update, delete| read	| read |
{: caption="Table 1. Role-based access control for components in Red Hat Advanced Cluster Management" caption-side="top"}

View the RBAC table for the Red Hat Advanced Cluster Management console:

| Console page | Cluster Administrator | Administrator | Editor | Viewer |
|--------|--------------|-------|--------|--------|
|Welcome    | read     | read    | read   | read     |
|Overview 	 | read 	 | read  	 | read	 | read |
|Topology 	 | read 	 | read 	 | read 	 | read |
|Clusters 	 |create, read, update, delete 	 | read 	 | 	read 	 | read |
|Manage applications 	 |create, read, update, delete 	 |create, read, update, delete 	 | read   | read |
|Govern risk 	 |create, read, update, delete 	 |create, read, update, delete 	 |- 	 |- |
| Provider conections | create, read, update, delete | create, read, update, delete | create, read, update, delete | -|
{: caption="Table 2. Role-based access control for components in Red Hat Advanced Cluster Management" caption-side="top"}

Review the following topics to learn more about securing your cluster:

- [Certificates](../cert_manager/certificates.md)
- [Governance and risk](../governance/compliance_intro.md)
