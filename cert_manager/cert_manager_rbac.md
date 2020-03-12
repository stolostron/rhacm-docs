---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Red Hat Advanced Cluster Management for Kubernetes Certificate Manager role-based access control (RBAC) support

In Red Hat Advanced Cluster Management for Kubernetes 4.4.0 and previous, RBAC support exists for Red Hat Advanced Cluster Management for Kubernetes Certificate Manager resources. For more information, see [RBAC for Certificate Manager resources](#cm). All existing RBAC rules for other resources within Red Hat Advanced Cluster Management for Kubernetes apply in addition to the Certificate Manager rules.

The ability to access Certificate Manager resources differs from the open source version of cert-manager.

Learn what each of the following roles can do with Certificate Manager:

* [Cluster Administrator role](#clusteradmin)
* [Administrator role](#admin)
* [Operator role](#operator)
* [Other roles](#other)

## Cluster Administrator role
{: #clusteradmin}

Cluster Administrators within Red Hat Advanced Cluster Management for Kubernetes can create, read/get/list, update, and delete all Certificate Manager resources (Certificates, Issuers, ClusterIssuers) within any namespace.

The implications include the ability to:
* Create Certificates that are signed by a ClusterIssuer
* Install or delete Helm charts that contain Certificate Manager resources


## Administrator role
{: #admin}

Administrators within Red Hat Advanced Cluster Management for Kubernetes can create, read/get/list, update, and delete only the Certificates and Issuers within the namespaces they are Administrators in.

For the namespaces that the user is an `Administrator` in, the implications include:
* Administrators cannot create Certificates that are signed by any ClusterIssuer
* The ability to deploy Helm charts:
    * Containing Certificates signed only by Issuers
    * Containing Issuers
    * Not containing ClusterIssuers
    * Not containing Certificates signed by a ClusterIssuer
* The ability to delete Helm charts:
    * Containing Certificates that are signed by both Issuers and ClusterIssuers
    * Containing Issuers
    * Containing ClusterIssuers, but the ClusterIssuers are not removed with the rest of the resources in the Helm chart when the release is deleted


## Operator role
{: #operator}

Operators within Red Hat Advanced Cluster Management for Kubernetes can create, read/get/list, and update only the Certificates and Issuers within the namespaces they are Operators in.

For the namespaces that the user is an `Operator` in, the implications include:
* Operators cannot create Certificates that are signed by any ClusterIssuer
* The ability to deploy Helm charts:
    * Containing Certificates signed only by Issuers
    * Containing Issuers
    * Not containing ClusterIssuers
    * Not containing Certificates signed by a ClusterIssuer


## Other roles
{: #other}

All other roles, including but not limited to editors, viewers, and auditors, cannot create, read/get/list, update, or delete any Certificate Manager resources (Certificates, Issuers, and ClusterIssuers) within any namespace.

## RBAC for Certificate Manager resources
{: #cm}

Red Hat Advanced Cluster Management for Kubernetes supports several roles. Your role determines the actions that you can perform.
{:shortdesc}

| Resource | Action | Administrator | Operator | Editor | Viewer |
|----------|--------|---------------|----------|--------|--------|
| Certificates | Create | X | X | | |
| Certificates| Read/Get/List | X | X | | |
| Certificates | Update/Edit | X | X | | |
| Certificates | Delete | X | | | |
| Issuers | Create | X | X | | |
| Issuers | Read/Get/List | X | X | | |
| Issuers | Update/Edit | X | X | | |
| Issuers | Delete | X | | | |
| ClusterIssuers | Create, Read/Get/List, Update, Delete | | | | |
{: caption="Table 1. RBAC for Certificate Manager resources" caption-side="top"}
