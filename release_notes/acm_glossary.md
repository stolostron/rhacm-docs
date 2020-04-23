
# Glossary
*Last update: 22 April 2020*



This glossary provides terms and definitions for Red Hat Advanced Cluster Management.

The following cross-references are used in this glossary:

- *See* refers you from a nonpreferred term to the preferred term or from an abbreviation to the spelled-out form.
- *See also* refers you to a related or contrasting term.

<!--If you do not want letter links at the top of your 
glossary, delete the
text between these comment tags.-->
Click the arrow for each letter-specific glossary to expand the list of words:

[A](#a)
[B](#b)
[C](#c)
[D](#d)
[E](#e)
[F](#f)
[G](#g)
[H](#h)
[I](#i)
[K](#k)
[L](#l)
[M](#m)
[N](#n)
[P](#p)
[R](#r)
[S](#s)
[T](#t)
[W](#w)

<!--end letter link tags-->

## A
<details><summary>Click to expand.</summary>
<p>

### API key

A unique code that is passed to an API to identify the calling application or user. An API key is used to track and control how the API is being used, for example, to prevent malicious use or abuse of the API.

### application

One or more computer programs or software components that provide a function in direct support of a specific business process or processes.

### audit log

A log file containing a record of system events and responses.

### availability zone

An operator-assigned, functionally independent segment of network infrastructure.

</p>
</details>

## B
<details><summary>Click to expand.</summary>
<p>

### boot node

A node that is used for running installation, configuration, node scaling, and cluster updates.

### buildpack

A collection of scripts that provide framework and runtime support for apps.

</p>
</details>

## C
<details><summary>Click to expand.</summary>
<p>

### catalog

A centralized location that can be used to browse for and install packages in a cluster.

### channel

A custom resource definition that points to repositories where Kubernetes resources are stored, such as a namespace, object store, or Helm repository. Channels use deployable resources to represent stored Kubernetes resources and Helm charts.

### cluster

A set of resources, worker nodes, networks, and storage devices that keep apps highly available and ready to deploy in containers.

### console

The graphical user interface for Red Hat Advanced Cluster Management.

### container

A system construct that allows users to simultaneously run separate logical operating system instances. Containers use layers of file systems to minimize image sizes and promote reuse. See also [image](#image), [layer](#layer), [registry](#registry).

### container image

In Docker, standalone, executable software, including code and system tools, that can be used to run an application.

### container orchestration

The process of managing the lifecycle of containers, including provisioning, deployment, and availability.

</p>
</details>

## D
<details><summary>Click to expand.</summary>
<p>

### deployable

A Kubernetes resource that contain templates that wrap other Kubernetes resources to be deployed. A deployable is also used to represent Helm charts.

### deployment

A process that retrieves the output of a build, packages the output with configuration properties, and installs the package in a pre-defined location so that it can be tested or run.

### DevOps

A software methodology that integrates application development and IT operations so that teams can deliver code faster to production and iterate continuously based on market feedback.

### Docker

An open platform that developers and system administrators can use to build, ship, and run distributed applications.
</p>
</details>

## E
<details><summary>Click to expand.</summary>
<p>

### ELK stack

The three products, Elasticsearch, Logstash, and Kibana, that comprise a stack of tools that stream, store, search, and monitor data, including logs.

### endpoint

A network destination address that is exposed by Kubernetes resources, such as services and ingresses.

### extension

A package that contains a deployment process and its required scripts and files.

</p>
</details>

## F
<details><summary>Click to expand.</summary>
<p>

### fault tolerance

The ability of a system to continue to operate effectively after the failure of a component part. See also [high availability (HA)](#high-availability-ha).

</p>
</details>

## G
<details><summary>Click to expand.</summary>
<p>

### Grafana

An open source analytics and visualization platform to monitor, search, analyze, and visualize metrics.
</p>
</details>

## H
<details><summary>Click to expand.</summary>
<p>

### HA

See [high availability (HA)](#high-availability-ha).

### Helm chart

A Helm package that contains information for installing a set of Kubernetes resources into a Kubernetes cluster.

### Helm release

An instance of a Helm chart that runs in a Kubernetes cluster.

### Helm repository

A collection of charts.

### high availability (HA)

The ability of IT services to withstand all outages and continue providing processing capability according to some predefined service level. Covered outages include both planned events, such as maintenance and backups, and unplanned events, such as software failures, hardware failures, power failures, and disasters. See also [fault tolerance](#fault-tolerance).

### hybrid cloud

A cloud computing environment that consists of multiple public and private resources.

</p>
</details>

## I
<details><summary>Click to expand.</summary>
<p>

### image

A file system and its execution parameters that are used within a container runtime to create a container. The file system consists of a series of layers, combined at runtime, that are created as the image is built by successive updates. The image does not retain state as the container executes. See also [container](#container), [layer](#layer), [registry](#registry).

### image manager

A centralized location for managing images inside a cluster.

### inception container

See [installer container](#installer-container).


### ingress

A collection of rules to allow inbound connections to the Kubernetes cluster services.

### isolation

The process of confining workload deployments to dedicated virtual and physical resources to achieve multi-tenancy support.

### isolation segment

A division that can be used to separate applications as if they were in different deployments without the need for redundant management and network complexity.

### Istio

Open technology that provides a way for developers to seamlessly connect, manage and secure networks of different microservices, regardless of platform, source, or vendor.

</p>
</details>

## K
<details><summary>Click to expand.</summary>
<p>

### Klusterlet

Red Hat Advanced Cluster Management, the agent that is responsible for a single Kubernetes cluster.

### Kubernetes

An open-source orchestration tool for containers.

</p>
</details>

## L
<details><summary>Click to expand.</summary>
<p>

### layer

A changed version of a parent image. Images consist of layers, where the changed version is layered on top of the parent image to create the new image. See also [container](#container), [image](#image).

### load balancer

Software or hardware that distributes workload across a set of servers to ensure that servers are not overloaded. The load balancer also directs users to another server if the initial server fails.

</p>
</details>

## M
<details><summary>Click to expand.</summary>
<p>

### machine type (MT)

A configuration that is used to instantiate a virtual machine.

### management logging service

An ELK stack that is used to collect and store all Docker-captured logs.

### management node

An optional node that only hosts management services such as monitoring, metering, and logging and can be used to prevent the master node from becoming overloaded.

### marketplace

A list of enabled services from which users can provision resources.

### mesh

A network topology in which devices are connected with many redundant interconnections between network nodes. Every node has a connection to every other node in the network.

### microclimate

An end-to-end, cloud-native solution for creating, building, testing, and deploying applications.

### microservice

A set of small, independent architectural components, each with a single purpose, that communicate over a common lightweight API.

### Minio

A lightweight, Amazon S3-compatible object storage server that can be used for storing unstructured data such as photos, videos, log files, backups, VMs, and container images.

### MT

See [machine type](#machine-type).

### multicloud

A cloud computing model in which an enterprise uses a combination of on-premises, private cloud, and public cloud architecture.

</p>
</details>

## N
<details><summary>Click to expand.</summary>
<p>

### namespace

A virtual cluster within a Kubernetes cluster that can be used to organize and divide resources across multiple users.

</p>
</details>

## P
<details><summary>Click to expand.</summary>
<p>

### placement policy

A policy that defines where the application components should be deployed and how many replicas there should be.

### placement rule

A rule that defines the target clusters where subscriptions are delivered.

### pod

A group of containers that are running on a Kubernetes cluster. A pod is a runnable unit of work, which can be a either a stand-alone application or a microservice.

### pod security policy

A policy that is used to set up cluster-level control over what a pod can do or what it can access.

### private cloud

A cloud computing environment in which access is limited to members of an enterprise and partner networks. See also [public cloud](#public-cloud).

### public cloud

A cloud computing environment in which access to standardized resources, such as infrastructure, multi-tenant hardware, and services, is available to subscribers on a pay-per-use basis. See also [private cloud](#private-cloud).

</p>
</details>

## R
<details><summary>Click to expand.</summary>
<p>

### RBAC

See [role-based access control](#role-based-access-control).

### registry

A public or private container image storage and distribution service. See also [container](#container), [image](#image).

### repo

See [repository (repo)](#repository-repo).

### repository (repo)

A persistent storage area for data and other application resources.

### resource

A physical or logical component that can be provisioned or reserved for an application or service instance. Examples of resources include database, accounts, and processor, memory, and storage limits.

### role-based access control (RBAC)

The process of restricting integral components of a system based on user authentication, roles, and permissions.
</p>
</details>

## S
<details><summary>Click to expand.</summary>
<p>

### service mesh

In Istio, an infrastructure layer that allows microservices to interact and communicate.

### subscription

A set of definitions that identify deployables within channels by using annotations, labels and versions. Then, the subscription places the deployables (template or referenced Helm chart) on the subscribed target clusters.

</p>
</details>

## T
<details><summary>Click to expand.</summary>
<p>

### team

An entity that groups users and resources.

</p>
</details>

## W
<details><summary>Click to expand.</summary>
<p>

### workload

A collection of virtual servers that perform a customer-defined collective purpose. A workload generally can be viewed as a multitiered application. Each workload is associated with a set of policies that define performance and energy consumption goals.
</p>
</details>

