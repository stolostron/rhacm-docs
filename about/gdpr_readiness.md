---

copyright:
  years: 2016, 2020
lastupdated: "2020-02-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# {{site.data.keyword.product}} platform considerations for GDPR readiness

## Notice
{: #notice}
<!-- This is boilerplate text provided by the GDPR team. It cannot be changed. -->

This document is intended to help you in your preparations for GDPR readiness. It provides information about features of the {{site.data.keyword.product}} platform that you can configure, and aspects of the product's use, that you should consider to help your organization with GDPR readiness. This information is not an exhaustive list, due to the many ways that clients can choose and configure features, and the large variety of ways that the product can be used in itself and with third-party applications and systems.

<p class="ibm-h4 ibm-bold">Clients are responsible for ensuring their own compliance with various laws and regulations, including the European Union General Data Protection Regulation. Clients are solely responsible for obtaining advice of competent legal counsel as to the identification and interpretation of any relevant laws and regulations that may affect the clients' business and any actions the clients may need to take to comply with such laws and regulations.</p>

<p class="ibm-h4 ibm-bold">The products, services, and other capabilities described herein are not suitable for all client situations and may have restricted availability. IBM does not provide legal, accounting, or auditing advice or represent or warrant that its services or products will ensure that clients are in compliance with any law or regulation.</p>

## Table of Contents

* [GDPR](#overview)
* [Product Configuration for GDPR](#productconfig)
* [Data Life Cycle](#datalifecycle)
* [Data Collection](#datacollection)
* [Data Storage](#datastorage)
* [Data Access](#dataaccess)
* [Data Processing](#dataprocessing)
* [Data Deletion](#datadeletion)
* [Data Monitoring](#datamonitoring)
* [Capability for Restricting Use of Personal Data](#datasubjectrights)
* [Appendix](#appendix)

## GDPR
{: #overview}

<!-- This is boilerplate text provided by the GDPR team. It cannot be changed. -->
General Data Protection Regulation (GDPR) has been adopted by the European Union ("EU") and applies from May 25, 2018.

### Why is GDPR important?

GDPR establishes a stronger data protection regulatory framework for processing of personal data of individuals. GDPR brings:
* New and enhanced rights for individuals
* Widened definition of personal data
* New obligations for processors
* Potential for significant financial penalties for non-compliance
* Compulsory data breach notification

### Read more about GDPR
* [EU GDPR Information Portal ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.eugdpr.org/){:new_window}
* [ibm.com/GDPR website ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/data-responsibility/gdpr/){:new_window}

## Product Configuration – considerations for GDPR Readiness
{: #productconfig}

The following sections describe aspects of data management within the {{site.data.keyword.product}} platform and provide information on capabilities to help clients with GDPR requirements.

## Data Life Cycle
{: #datalifecycle}

{{site.data.keyword.product}} is an application platform for developing and managing on-premises, containerized applications. It is an integrated environment for managing containers that includes the container orchestrator Kubernetes, a private image registry, a management console, and monitoring frameworks.

As such, the {{site.data.keyword.product}} platform deals primarily with technical data that is related to the configuration and management of the platform, some of which might be subject to GDPR. The {{site.data.keyword.product}} platform also deals with information about users who manage the platform. This data will be described throughout this document for the awareness of clients responsible for meeting GDPR requirements.

This data is persisted on the platform on local or remote file systems as configuration files or in databases. Applications that are developed to run on the {{site.data.keyword.product}} platform might deal with other forms of personal data subject to GDPR. The mechanisms that are used to protect and manage platform data are also available to applications that run on the platform. Additional mechanisms might be required to manage and protect personal data that is collected by applications run on the {{site.data.keyword.product}} platform.

To best understand the {{site.data.keyword.product}} platform and its data flows, you must understand how Kubernetes, Docker, and Helm work. These open source components are fundamental to the {{site.data.keyword.product}} platform. You use Kubernetes deployments to place instances of applications, which are built into Helm charts that reference Docker images. The Helm charts contain the details about your application, and the Docker images contain all the software packages that your applications need to run.

{{site.data.keyword.product}} includes a catalog of containerized software and services from IBM in the default {{site.data.keyword.product}} repository list. To view a list of all the {{site.data.keyword.product}} charts, see [IBM/charts ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/IBM/charts/tree/master/stable){:new_window}. For considerations regarding GDPR for the products in the catalog, consult the documentation for those products.
Some of the applications available in the catalog are open source software. It is the client’s responsibility to determine and implement any appropriate GDPR controls for open source software. Information on these packages is included in the catalog entry.

Documentation on {{site.data.keyword.product}} platform can be found in the [{{site.data.keyword.product}} collection](https://www.ibm.com/support/knowledgecenter/SSFC4F/product_welcome_cloud_pak.html) in {{site.data.keyword.IBM_notm}} Knowledge Center.

### What types of data flow through {{site.data.keyword.product}} platform

As a platform, {{site.data.keyword.product}} deals with several categories of technical data that could be considered as personal data, such as an administrator user ID and password, service user IDs and passwords, IP addresses, and Kubernetes node names. The {{site.data.keyword.product}} platform also deals with information about users who manage the platform. Applications that run on the platform might introduce other categories of personal data unknown to the platform.

Information on how this technical data is collected/created, stored, accessed, secured, logged, and deleted is described in later sections of this document.

### Personal data used for online contact with IBM

{{site.data.keyword.product}} clients can submit online comments/feedback/requests for information about {{site.data.keyword.product}} subjects in a variety of ways, primarily:
* The public {{site.data.keyword.product}} Slack Community
* Public comments area on pages of {{site.data.keyword.product}} product documentation in the {{site.data.keyword.IBM_notm}} Knowledge Center
* Public comments in the {{site.data.keyword.product}} space of dW Answers

Typically, only the client name and email address are used, to enable personal replies for the subject of the contact, and the use of personal data conforms to the [Red Hat Online Privacy Statement ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.needtofindthecorrectlinkifthereisone.com/privacy/us/en/){:new_window}.

## Data Collection
{: #datacollection}

The {{site.data.keyword.product}} platform does not collect sensitive personal data. It does create and manage technical data, such as an administrator user ID and password, service user IDs and passwords, IP addresses, and Kubernetes node names, which might be considered personal data. The {{site.data.keyword.product}} platform also deals with information about users who manage the platform. All such information is only accessible by the system administrator through a management console with role-based access control or by the system administrator though login to a {{site.data.keyword.product}} platform node.

Applications that run on the {{site.data.keyword.product}} platform might collect personal data.

When you assess the use of the {{site.data.keyword.product}} platform running containerized applications and your need to meet the requirements of GDPR, you must consider the types of personal data that are collected by the application and aspects of how that data is managed, such as:
* How is the data protected as it flows to and from the application? Is the data encrypted in transit?
* How is the data stored by the application? Is the data encrypted at rest?
* How are credentials that are used to access the application collected and stored?
* How are credentials that are used by the application to access data sources collected and stored?
* How is data collected by the application removed as needed?

This is not a definitive list of the types of data that are collected by the {{site.data.keyword.product}} platform. It is provided as an example for consideration. If you have any questions about the types of data, contact IBM.


## Data storage
{: #datastorage}

The {{site.data.keyword.product}} platform persists technical data that is related to configuration and management of the platform in stateful stores on local or remote file systems as configuration files or in databases. Consideration must be given to securing all data at rest. The {{site.data.keyword.product}} platform supports encryption of data at rest in stateful stores that use `dm-crypt`.

The following items highlight the areas where data is stored, which you might want to consider for GDPR.

* **Platform Configuration Data:** The {{site.data.keyword.product}} platform configuration can be customized by updating a configuration YAML file with properties for general settings, Kubernetes, logs, network, Docker, and other settings. This data is used as input to the {{site.data.keyword.product}} platform installer for deploying one or more nodes. The properties also include an administrator user ID and password that are used for bootstrap. For more information, see [Customizing the cluster](../installer/3.2.2/config_yaml.md).
* **Kubernetes Configuration Data:** Kubernetes cluster state data is stored in a distributed key-value store, `etcd`. 
* **User Authentication Data, including User IDs and passwords:** User ID and password management are handled through a client enterprise LDAP directory. Users and groups that are defined in LDAP can be added to {{site.data.keyword.product}} platform teams and assigned access roles. {{site.data.keyword.product}} platform stores the email address and user ID from LDAP, but does not store the password. {{site.data.keyword.product}} platform stores the group name and upon login, caches the available groups to which a user belongs. Group membership is not persisted in any long-term way. Securing user and group data at rest in the enterprise LDAP must be considered. {{site.data.keyword.product}} platform also includes an authentication service, Open ID Connect (OIDC) that interacts with the enterprise directory and maintains access tokens. This service uses MongoDB as a backing store.
* **Service authentication data, including user IDs and passwords:** Credentials that are used by {{site.data.keyword.product}} platform components for inter-component access are defined as Kubernetes Secrets. All Kubernetes resource definitions are persisted in the `etcd` key-value data store. Initial credentials values are defined in the platform configuration data as Kubernetes Secret configuration YAML files. For more information, see [Managing Secrets](../applications/managing_secrets.md).
* **Helm chart data:** {{site.data.keyword.product}} platform includes a catalog of containerized software and services that you can browse and install in your cluster from Helm charts. The Helm service persists configuration data in a MongoDB backing store.
* **GlusterFS storage file system:** You can use GlusterFS storage in your clusters. Consideration must be given to encrypting the volumes where GlusterFS storage is deployed. 
* **Monitoring Data:** You can use {{site.data.keyword.product}} platform monitoring to monitor the status of your cluster and applications. This service uses Grafana and Prometheus to present detailed information about cluster nodes and containers. Additional monitoring stacks can be deployed for application monitoring. Monitoring data might be persisted using Kubernetes `PersistentVolumes`.
* **Metering Data:** You can use the {{site.data.keyword.product}} metering service to view and download detailed usage metrics for your applications and cluster. The metering service uses MongoDB as a backing data store to persist metric data.
* **Logging Data:** {{site.data.keyword.product}} platform uses an ELK stack for system logs. ELK is an abbreviation for three products, Elasticsearch, Logstash, and Kibana, that are built by Elastic and together comprise a stack of tools that you can use to stream, store, search, and monitor logs. The ELK stack that is provided with {{site.data.keyword.product}} platform uses the official ELK stack images that are published by Elastic. Logging is configured by default for the {{site.data.keyword.product}} platform services. Additional ELK stacks can be deployed for application logging.

## Data access
{: #dataaccess}

{{site.data.keyword.product}} platform data can be accessed through the following defined set of product interfaces.
* Web user interface (the {{site.data.keyword.gui}})
* Kubernetes `kubectl` CLI
* {{site.data.keyword.product}} CLI
* Helm CLI

These interfaces are designed to allow you to make administrative changes to your {{site.data.keyword.product}} cluster. Administration access to {{site.data.keyword.product}} can be secured and involves three logical, ordered stages when a request is made: authentication, role-mapping, and authorization.

### Authentication

The {{site.data.keyword.product}} platform authentication manager accepts user credentials from the {{site.data.keyword.gui}} and forwards the credentials to the backend OIDC provider, which validates the user credentials against the enterprise directory. The OIDC provider then returns an authentication cookie (`auth-cookie`) with the content of a JSON Web Token (`JWT`) to the authentication manager. The JWT token persists information such as the user ID and email address, in addition to group membership at the time of the authentication request. This authentication cookie is then sent back to the {{site.data.keyword.gui}}. The cookie is refreshed during the session. It is valid for 12 hours after you sign out of the {{site.data.keyword.gui}} or close your web browser.

For all subsequent authentication requests made from the {{site.data.keyword.gui}}, the front-end NGINX server decodes the available authentication cookie in the request and validates the request by calling the authentication manager.

The {{site.data.keyword.product}} platform CLI requires the user to provide credentials to log in.

The `kubectl` CLI also requires credentials to access the cluster. These credentials can be obtained from the management console and expire after 12 hours. Access through service accounts is supported.

Helm CLI access utilizes certificates to access the cluster.

### Role Mapping

{{site.data.keyword.product}} platform supports role-based access control (RBAC). In the role mapping stage, the user name that is provided in the authentication stage is mapped to a user or group role. The roles are used when authorizing which administrative activities can be carried out by the authenticated user.

### Authorization

{{site.data.keyword.product}} platform roles control access to cluster configuration actions, to catalog and Helm resources, and to Kubernetes resources. Several IAM (Identity and Access Management) roles are provided, including Cluster Administrator, Administrator, Operator, Editor, Viewer. A role is assigned to users or user groups when you add them to a team. Team access to resources can be controlled by namespace.

### Pod Security

Pod security policies are used to set up cluster-level control over what a pod can do or what it can access. 

## Data Processing
{: #dataprocessing}

Users of {{site.data.keyword.product}} can control the way that technical data that is related to configuration and management is processed and secured through system configuration.

**Role-based access control** (RBAC) controls what data and functions can be accessed by users.

**Pod security policies** are used to set up cluster-level control over what a pod can do or what it can access.

**Data-in-transit** is protected by using `TLS`. `HTTPS` (`TLS` underlying) is used for secure data transfer between user client and back end services. Users can specify the root certificate to use during installation. 

**Data-at-rest** protection is supported by using `dm-crypt` to encrypt data.

**Data retention** periods for logging (ELK) and monitoring (Prometheus) are configurable and deletion of data is supported through provided APIs.

These same platform mechanisms that are used to manage and secure {{site.data.keyword.product}} platform technical data can be used to manage and secure personal data for user-developed or user-provided applications. Clients can develop their own capabilities to implement further controls.

## Data Deletion
{: #datadeletion}

{{site.data.keyword.product}} platform provides commands, application programming interfaces (APIs), and user interface actions to delete data that is created or collected by the product. These functions enable users to delete technical data, such as service user IDs and passwords, IP addresses, Kubernetes node names, or any other platform configuration data, as well as information about users who manage the platform.

Areas of {{site.data.keyword.product}} platform to consider for support of data deletion:
* The data retention period for logging data (ELK) is configurable.
* The data retention period for monitoring data (Prometheus) is configurable.
* Logging data can be deleted from the ELK stack by using Elasticsearch APIs.
* Monitoring data can be deleted from Prometheus by using Prometheus APIs.
* All technical data that is related to platform configuration can be deleted through the management console or the Kubernetes `kubectl` API.

Areas of {{site.data.keyword.product}} platform to consider for support of account data deletion:
* All technical data that is related to platform configuration can be deleted through the {{site.data.keyword.product}} or the Kubernetes `kubectl` API.

Function to remove user ID and password data that is managed through an enterprise LDAP directory would be provided by the LDAP product used with {{site.data.keyword.product}} platform.

Personal data that is persisted by platform logging and monitoring consists of IP addresses of cluster components and some user names and user IDs. User-developed or user-provided applications might include other personal data in their use of logging and monitoring. The same mechanisms that are used for deletion of system logging or monitoring data can be used for application logging and monitoring data. Personal data that is collected by applications outside of these services will require application provided mechanisms to delete data. For more information, see

* [Prometheus Documentation![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://prometheus.io/docs/introduction/overview/){:new_window}


## Data monitoring
{: #datamonitoring}

* {{site.data.keyword.product}} platform provides a monitoring service to monitor the status of your cluster and applications. This service uses Grafana and Prometheus to present detailed information about cluster nodes and containers. Monitoring can be configured to generate alerts or integrated with external alert providers. Platform monitoring is enabled by default. Additional monitoring stacks can be deployed for application monitoring. 
* {{site.data.keyword.product}} provides a metering service to view and download detailed usage metrics for your applications and cluster. Metering is enabled by default for all deployed container applications.
* {{site.data.keyword.product}} platform provides a logging service that is based on the ELK stack to stream, store, search, and monitor logs. The ELK stack that is provided with {{site.data.keyword.product}} platform uses the official ELK stack images that are published by Elastic. Logging is configured by default to collect system logs for the {{site.data.keyword.product}} platform services. Additional ELK stacks can be deployed for application logging.

## Capability for Restricting Use of Personal Data
{: #datasubjectrights}

Using the facilities summarized in this document, {{site.data.keyword.product}} platform enables an end user to restrict usage of any technical data within the platform that is considered personal data.

Under GDPR, users have rights to access, modify, and restrict processing. Refer to other sections of this document to control the following:
* Right to access
  * {{site.data.keyword.product}} platform administrators can use {{site.data.keyword.product}} platform features to provide individuals access to their data.
  * {{site.data.keyword.product}} platform administrators can use {{site.data.keyword.product}} platform features to provide individuals information about what data {{site.data.keyword.product}} platform holds about the individual.
* Right to modify
  * {{site.data.keyword.product}} platform administrators can use {{site.data.keyword.product}} platform features to allow an individual to modify or correct their data.
  * {{site.data.keyword.product}} platform administrators can use {{site.data.keyword.product}} platform features to correct an individual's data for them.
* Right to restrict processing
  * {{site.data.keyword.product}} platform administrators can use {{site.data.keyword.product}} platform features to stop processing an individual's data.

## Appendix - Data logged by {{site.data.keyword.product}} platform
{: #appendix}

As a platform, {{site.data.keyword.product}} deals with several categories of technical data that could be considered as personal data, such as an administrator user ID and password, service user IDs and passwords, IP addresses, and Kubernetes node names. {{site.data.keyword.product}} platform also deals with information about users who manage the platform. Applications that run on the platform might introduce other categories of personal data that are unknown to the platform.

This appendix includes details on data that is logged by the platform services.

### {{site.data.keyword.product}} security

* What data is logged
  * User ID, user name, and IP address of logged in users
* When data is logged
  * With login requests
* Where data is logged
  * In the audit logs at `/var/lib/icp/audit`
  * In the audit logs at `/var/log/audit`
* How to delete data
  * Search for the user specific data and delete the record from the audit log


  For more information, see:
* [High availability {{site.data.keyword.product}} clusters](../installing/mcm_ha.md)

### {{site.data.keyword.product}} platform API

* What data is logged
  * User ID, user name, and IP address of client in container logs
  * Kubernetes cluster state data in the `etcd` server
  * OpenStack and VMware credentials in the `etcd` server
* When data is logged
  * With API requests
  * Credentials stored from `credentials-set` command
* Where data is logged
  * In container logs, Elasticsearch, and `etcd` server.
* How to delete data
  * Delete container logs (`platform-api`, `platform-deploy`) from containers or delete the user specific log entries from Elasticsearch.
  * Clear the selected `etcd` key-value pairs by using the `etcdctl rm` command.
  * Remove credentials by calling the `credentials-unset` command.


For more information, see
  * [Kubernetes Logging ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/cluster-administration/logging/){:new_window}
  * [etcdctl ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/coreos/etcd/blob/master/etcdctl/READMEv2.md){:new_window}

### {{site.data.keyword.product}} monitoring

* What data is logged
  * IP address, names of pods, release, image
  * Data scraped from client-developed applications could include personal data
* When data is logged
  * When Prometheus scrapes metrics from configured targets
* Where data is logged
  * In the Prometheus server or configured persistent volumes
* How to delete data
  * Search for and delete data by using the Prometheus API


  For more information, see:
  
  * [Prometheus Documentation ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://prometheus.io/docs/introduction/overview/){:new_window}


### {{site.data.keyword.product}} Kubernetes

* What data is logged
  * Cluster deploy topology (node information for master, worker, proxy, va)
  * Service configuration (k8s configuration map) and secrets (k8s secrets)
  * User ID in api-server log
* When data is logged
  * When you deploy a cluster
  * When you deploy an application from the Helm catalog
* Where data is logged
  * Cluster deploy topology in `etcd`
  * Configuration and secret for deployed applications in `etcd`
* How to delete data
  * Use the {{site.data.keyword.product}} {{site.data.keyword.gui}}
  * Search for and delete data by using the k8s {{site.data.keyword.gui}} (`kubectl`) or `etcd` REST API
  * Search for and delete api-server log data by using the Elasticsearch API


  Use caution when modifying Kubernetes cluster configuration or deleting cluster data.

  For more information, see:
  * [Kubernetes kubectl ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/reference/kubectl/overview/){:new_window}

### {{site.data.keyword.product}} Helm API

* What data is logged
  * User name and role
* When data is logged
  * When a user retrieves charts or repositories that are added to a team
* Where data is logged
  * helm-api deployment logs, Elasticsearch
* How to delete data
  * Search for and delete helm-api log data by using the Elasticsearch API

### {{site.data.keyword.product}} Service Broker

* What data is logged
  * User ID (only at debug log level 10, not at default log level)
* When data is logged
  * When API requests are made to the service broker
  * When the service broker accesses the service catalog
* Where data is logged
  * Service broker container log, Elasticsearch
* How to delete data
  * Search for and delete the api-server log using Elasticsearch API
  * Search for and delete the log from the api-server container
      ```
      kubectl logs $(kubectl get pods -n kube-system | grep  service-catalogapiserver | awk '{print $1}') -n kube-system | grep admin
      ```
      {: codeblock}


  For more information, see:
  * [Kubernetes kubectl ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/reference/kubectl/overview/){:new_window}
