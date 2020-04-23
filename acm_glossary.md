
# Glossary
*Last update: 22 April 2020*



This glossary provides terms and definitions for Red Hat Advanced Cluster Management.

The following cross-references are used in this glossary:

- *See* refers you from a nonpreferred term to the preferred term or from an abbreviation to the spelled-out form.
- *See also* refers you to a related or contrasting term.

<!--If you do not want letter links at the top of your 
glossary, delete the
text between these comment tags.-->

[A](#glossa)
[B](#glossb)
[C](#glossc)
[D](#glossd)
[E](#glosse)
[F](#glossf)
[G](#glossg)
[H](#glossh)
[I](#glossi)
[K](#glossk)
[L](#glossl)
[M](#glossm)
[N](#glossn)
[P](#glossp)
[R](#glossr)
[S](#glosss)
[T](#glosst)
[W](#glossw)

<!--end letter link tags-->

## A
{: #glossa}

### air gap
{: #x9794218}

A security measure that consists of a physical and wireless separation between an isolated computer or network and any computer or network that is directly or indirectly connected to the internet or other insecure network.

### air gap environment
{: #x9756351}

A network environment that does not have internet access.

### API key
{: #x8051010}

A unique code that is passed to an API to identify the calling application or user. An API key is used to track and control how the API is being used, for example, to prevent malicious use or abuse of the API.

### application
{: #x2000166}

One or more computer programs or software components that provide a function in direct support of a specific business process or processes.

### applog
{: #x9756360}

See [application log](#x2178843).

### audit log
{: #x2345100}

A log file containing a record of system events and responses.

### availability zone
{: #x7018171}

An operator-assigned, functionally independent segment of network infrastructure.


## B
{: #glossb}

### boot node
{: #x9520233}

A node that is used for running installation, configuration, node scaling, and cluster updates.

### buildpack
{: #x7233925}

A collection of scripts that provide framework and runtime support for apps.


## C
{: #glossc}

### catalog
{: #x2000504}

A centralized location that can be used to browse for and install packages in a cluster.

### channel
{: #x2016483}

A custom resource definition that points to repositories where Kubernetes resources are stored, such as a namespace, object store, or Helm repository. Channels use deployable resources to represent stored Kubernetes resources and Helm charts.

### cluster
{: #x2017080}

A set of resources, worker nodes, networks, and storage devices that keep apps highly available and ready to deploy in containers.

### container
{: #x2010901}

A system construct that allows users to simultaneously run separate logical operating system instances. Containers use layers of file systems to minimize image sizes and promote reuse. See also [image](#x2024928), [layer](#x2028320), [registry](#x2064940).

### container image
{: #x8941555}

In Docker, standalone, executable software, including code and system tools, that can be used to run an application.

### container orchestration
{: #x9773849}

The process of managing the lifecycle of containers, including provisioning, deployment, and availability.


## D
{: #glossd}

### deployable
{: #x4063633}

A Kubernetes resource that contain templates that wrap other Kubernetes resources to be deployed. A deployable is also used to represent Helm charts.

### deployment
{: #x2104544}

A process that retrieves the output of a build, packages the output with configuration properties, and installs the package in a pre-defined location so that it can be tested or run.

### DevOps
{: #x5784896}

A software methodology that integrates application development and IT operations so that teams can deliver code faster to production and iterate continuously based on market feedback.

### Docker
{: #x7764788}

An open platform that developers and system administrators can use to build, ship, and run distributed applications.


## E
{: #glosse}

### ELK stack
{: #x9756373}

The three products, Elasticsearch, Logstash, and Kibana, that comprise a stack of tools that stream, store, search, and monitor data, including logs.

### endpoint
{: #x2026820}

A network destination address that is exposed by Kubernetes resources, such as services and ingresses.

### extension
{: #x2083274}

A package that contains a deployment process and its required scripts and files.


## F
{: #glossf}

### fault tolerance
{: #x2847028}

The ability of a system to continue to operate effectively after the failure of a component part. See also [high availability](#x2284708).


## G
{: #glossg}

### Grafana
{: #x9773864}

An open source analytics and visualization platform to monitor, search, analyze, and visualize metrics.


## H
{: #glossh}

### HA
{: #x2404289}

See [high availability](#x2284708).

### Helm chart
{: #x9652777}

A Helm package that contains information for installing a set of Kubernetes resources into a Kubernetes cluster.

### Helm release
{: #x9756384}

An instance of a Helm chart that runs in a Kubernetes cluster.

### Helm repository
{: #x9756389}

A collection of charts.

### high availability (HA)
{: #x2284708}

The ability of IT services to withstand all outages and continue providing processing capability according to some predefined service level. Covered outages include both planned events, such as maintenance and backups, and unplanned events, such as software failures, hardware failures, power failures, and disasters. See also [fault tolerance](#x2847028).

### hybrid cloud
{: #x4585327}

A cloud computing environment that consists of multiple public and private resources.


## I
{: #glossi}

### IBM Certified Container
{: #x9796955}

Enterprise-grade containerized software that is built with open standards and integrated with platform services for management and lifecycle operations.

### IBM Cloud Pak
{: #x9773840}

A package of one or more enterprise-grade, secure, and lifecycle-managed IBM Certified Container offerings that are packaged together and integrated in the IBM Cloud Private environment.

### image
{: #x2024928}

A file system and its execution parameters that are used within a container runtime to create a container. The file system consists of a series of layers, combined at runtime, that are created as the image is built by successive updates. The image does not retain state as the container executes. See also [container](#x2010901), [layer](#x2028320), [registry](#x2064940).

### image manager
{: #x3735328}

A centralized location for managing images inside a cluster.

### inception container
{: #x9520270}

See [installer container](#x9756395).


### ingress
{: #x7907732}

A collection of rules to allow inbound connections to the Kubernetes cluster services.

### isolation
{: #x2196809}

The process of confining workload deployments to dedicated virtual and physical resources to achieve multi-tenancy support.

### isolation segment
{: #x9611974}

A division that can be used to separate applications as if they were in different deployments without the need for redundant management and network complexity.

### Istio
{: #x9773869}

Open technology that provides a way for developers to seamlessly connect, manage and secure networks of different microservices, regardless of platform, source, or vendor.


## K
{: #glossk}

### Klusterlet
{: #x9773879}

In IBM Multicloud Manager, the agent that is responsible for a single Kubernetes cluster.

### Kubernetes
{: #x9581829}

An open-source orchestration tool for containers.


## L
{: #glossl}

### layer
{: #x2028320}

A changed version of a parent image. Images consist of layers, where the changed version is layered on top of the parent image to create the new image. See also [container](#x2010901), [image](#x2024928).

### load balancer
{: #x2788902}

Software or hardware that distributes workload across a set of servers to ensure that servers are not overloaded. The load balancer also directs users to another server if the initial server fails.


## M
{: #glossm}

### machine type (MT)
{: #x3883065}

A configuration that is used to instantiate a virtual machine.

### management console
{: #x2398932}

The graphical user interface for IBM Cloud Private.

### management logging service
{: #x9756408}

An ELK stack that is used to collect and store all Docker-captured logs.

### management node
{: #x3954437}

An optional node that only hosts management services such as monitoring, metering, and logging and can be used to prevent the master node from becoming overloaded.

### marketplace
{: #x2118141}

A list of enabled services from which users can provision resources.

### master node
{: #x4790131}

A node that provides management services and controls the worker nodes in a cluster. Master nodes host processes that are responsible for resource allocation, state maintenance, scheduling, and monitoring.

### mesh
{: #x4300240}

A network topology in which devices are connected with many redundant interconnections between network nodes. Every node has a connection to every other node in the network.

### microclimate
{: #x9756420}

An end-to-end, cloud-native solution for creating, building, testing, and deploying applications.

### microservice
{: #x8379238}

A set of small, independent architectural components, each with a single purpose, that communicate over a common lightweight API.

### Minio
{: #x9773884}

A lightweight, Amazon S3-compatible object storage server that can be used for storing unstructured data such as photos, videos, log files, backups, VMs, and container images.

### MT
{: #x2182316}

See [machine type](#x3883065).

### multicloud
{: #x9581814}

A cloud computing model in which an enterprise uses a combination of on-premises, private cloud, and public cloud architecture.


## N
{: #glossn}

### namespace
{: #x2031005}

A virtual cluster within a Kubernetes cluster that can be used to organize and divide resources across multiple users.

### Network File System (NFS)
{: #x2031282}

A protocol that allows a computer to access files over a network as if they were on its local disks.

### NFS
{: #x2031508}

See [Network File System](#x2031282).

## P
{: #glossp}

### persistent volume
{: #x9532496}

Networked storage in a cluster that is provisioned by an administrator.

### persistent volume claim
{: #x9520297}

A request for cluster storage.

### placement policy
{: #x7244520}

A policy that defines where the application components should be deployed and how many replicas there should be.

### placement rule
{: #x2904882}

A rule that defines the target clusters where subscriptions are delivered.

### pod
{: #x8461823}

A group of containers that are running on a Kubernetes cluster. A pod is a runnable unit of work, which can be a either a stand-alone application or a microservice.

### pod security policy
{: #x9520302}

A policy that is used to set up cluster-level control over what a pod can do or what it can access.

### private cloud
{: #x4585362}

A cloud computing environment in which access is limited to members of an enterprise and partner networks. See also [public cloud](#x4585370).

### Prometheus
{: #x9773892}

An open source systems monitoring and alerting toolkit.

### proxy node
{: #x6230938}

A node that transmits external requests to the services that are created inside a cluster.

### public cloud
{: #x4585370}

A cloud computing environment in which access to standardized resources, such as infrastructure, multi-tenant hardware, and services, is available to subscribers on a pay-per-use basis. See also [private cloud](#x4585362).


## R
{: #glossr}

### RBAC
{: #x5488132}

See [role-based access control](#x2403611).

### registry
{: #x2064940}

A public or private container image storage and distribution service. See also [container](#x2010901), [image](#x2024928).

### repo
{: #x7639721}

See [repository](#x2036865).

### repository (repo)
{: #x2036865}

A persistent storage area for data and other application resources.

### resource
{: #x2004267}

A physical or logical component that can be provisioned or reserved for an application or service instance. Examples of resources include database, accounts, and processor, memory, and storage limits.

### role-based access control (RBAC)
{: #x2403611}

The process of restricting integral components of a system based on user authentication, roles, and permissions.


## S
{: #glosss}

### service broker
{: #x7636561}

A component of a service that implements a catalog of offerings and service plans, and interprets calls for provisioning and deprovisioning, binding and unbinding.

### service mesh
{: #x9773874}

In Istio, an infrastructure layer that allows microservices to interact and communicate.

### Solution Pak
{: #x9773845}

See [IBM Cloud Pak](#x9773840).

### subscription
{: #x2010511}

A set of definitions that identify deployables within channels by using annotations, labels and versions. Then, the subscription places the deployables (template or referenced Helm chart) on the subscribed target clusters.

## T
{: #glosst}

### TA
{: #x9773902}

See [Transformation Advisor](#x9773897).

### team
{: #x3135729}

An entity that groups users and resources.

### Transformation Advisor (TA)
{: #x9773897}

A developer tool that is used to evaluate on-premises Java EE apps for deployment to the cloud.

## W
{: #glossw}

### worker node
{: #x5503637}

In a cluster, a physical or virtual machine that carries the deployments and services that make up an app.

### workload
{: #x2012537}

A collection of virtual servers that perform a customer-defined collective purpose. A workload generally can be viewed as a multitiered application. Each workload is associated with a set of policies that define performance and energy consumption goals.


