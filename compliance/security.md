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

# Security

Manage security and role-based access control (RBAC) of Red Hat Advanced Cluster Management for Kubernetes components.
{:shortdesc}

## Authentication

You can onboard workloads to Identity and Access Management (IAM). You must configure authentication service requirements for  Red Hat Advanced Cluster Management for Kubernetes. For more information, see _Understanding authentication_ in [OpenShift Container Platform documentation](https://docs.openshift.com/container-platform/4.3/authentication/understanding-authentication.html).

## Role-based access control (RBAC)

Red Hat Advanced Cluster Management for Kubernetes supports several roles. Your role determines the actions that you can perform. Kubernetes offers role-based access control (RBAC) authorization mechanisms, so users of the cluster platform can be grouped into teams and have namespaces dedicated to teams. For more information about RBAC, see the _RBAC_ overview in the [OpenShift Container Platform documentation](https://docs.openshift.com/container-platform/4.3/authentication/using-rbac.html){:new_window}. View the following RBAC table for Red Hat Advanced Cluster Management for Kubernetes:

<!--insert table here-->


View the following sections for information about managing your cluster security:

- {: child} [Certificates in Red Hat Advanced Cluster Management for Kubernetes](../cert_manager/certificates.md)
- {: child} [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../compliance/compliance_intro.md)
{: childlinks}
