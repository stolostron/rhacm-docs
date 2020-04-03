---

copyright:
  years: 2019, 2020
lastupdated: "2020-04-03"

---

# Security

Manage security and role-based access control (RBAC) of Red Hat Advanced Cluster Management for Kubernetes components.

## Authentication

You can onboard workloads to Identity and Access Management (IAM). You must configure authentication service requirements for  Red Hat Advanced Cluster Management for Kubernetes. For more information, see _Understanding authentication_ in [OpenShift Container Platform documentation](https://docs.openshift.com/container-platform/4.3/authentication/understanding-authentication.html).

## Role-based access control (RBAC)

Red Hat Advanced Cluster Management for Kubernetes supports several roles. Your role determines the actions that you can perform. Kubernetes offers role-based access control (RBAC) authorization mechanisms, so users of the cluster platform can be grouped into teams and have namespaces dedicated to teams. For more information about RBAC, see the _RBAC_ overview in the [OpenShift Container Platform documentation](https://docs.openshift.com/container-platform/4.3/authentication/using-rbac.html). View the following RBAC tables for components in Red Hat Advanced Cluster Management for Kubernetes:

| API | ClusterAdmin | Administrator | Operator | Editor | Viewer |
|-----|--------------|---------------|----------|--------|--------|
|resourceview.mcm.ibm.com 	|create, read, update, delete 	|create, read, update, delete 	|create, read, update 	|read, update 	|read|
|works.mcm.ibm.com 	|create, read, update, delete 	|create, read, update, delete 	|create, read, update 	| read, update	| read |
|worksets.mcm.ibm.com 	|create, read, update, delete 	|create, read, update, delete 	|create, read, update 	| read, update	| read |
|clusterstatus.mcm.ibm.com 	|create, read, update, delete 	| read 	| read 	| read |	read |
|cluster.clusterregistry.k8s.io 	|create, read, update, delete 	| read 	 read |	read |	read |
|endpointconfig.mcm.ibm.com 	|create, read, update, delete 	|create, read, update, delete 	|create, read, update 	| read, update	| read |
| policies.policy.mcm.ibm.com| create, read, update, delete     |create, read, update, delete     | -     | -     | -     |
|app.k8s.io, apps.open-cluster-management.io| create, read, update, delete 	|create, read, update, delete| 	read 	| read	| read |
|resourceview.mcm.ibm.com | create, read, update, delete    |create, read, update, delete     |create, read, update    |  read, update   | read     |
|works.mcm.ibm.com | create, read, update, delete    |create, read, update, delete     |create, read, update    |  read, update   | read     |
|worksets.mcm.ibm.com | create, read, update, delete    |create, read, update, delete     |create, read, update    |  read, update   | read     |
|clusterstatus.mcm.ibm.com | create, read, update, delete    | read   | read    |  read  | read     |
|cluster.clusterregistry.k8s.io | create, read, update, delete    | read   | read    |  read   | read    |
{: caption="Table 1. Role-based access control for components in Red Hat Advanced Cluster Management" caption-side="top"}

View the RBAC table for the Red Hat Advanced Cluster Management console:

| Console page | Cluster Administrator | Administrator | Operator | Editor | Viewer |
|--------|--------------|-------|----------|--------|--------|
|Welcome    | read     | read    | read   | read   | read     |
|Overview 	 | read 	 | read  	 | read	 | read	 | read |
|Topology 	 | read 	 | read 	 | read	 | read 	 | read |
|Clusters 	 |create, read, update, delete 	 | read 	 | read | 	read 	 | read |
|Bare metal assets | 	create, read, update, delete 	 | read 	 | read 	 | read | read |
|Manage applications 	 |create, read, update, delete 	 |create, read, update, delete 	 | read   | read | 	read |
|Govern risk 	 |create, read, update, delete 	 |create, read, update, delete 	 |- 	 |- 	 |- |
{: caption="Table 2. Role-based access control for components in Red Hat Advanced Cluster Management" caption-side="top"}

View the following sections for information about managing your cluster security:

- [Certificates in Red Hat Advanced Cluster Management for Kubernetes](../cert_manager/certificates.md)
- [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../governance/compliance_intro.md)

