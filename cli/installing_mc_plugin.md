---
copyright:
  years: 2019
lastupdated: 2019-12-11
---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Installing the multicluster plug-in (mc)

The `mc` plug-in is required after CLI installation. Complete the following procedure to download and install the plug-in to work with multiple clusters.

## Prerequisites

* You must install the OpenShift CLI tool. (need the prereq here)

## Installing the plug-in (change this for oc/acm instructions)

1. Download the multicluster, or `mc` plug-in for the applicable operating system. See the list of the `mc` plug-in commands for the different operating systems:

  For macOS, run the following command: 
  
  ```
  curl -kLo cloudctl-mc-plugin https://<Cluster Master Host>:<Cluster Master API Port>/rcm/plugins/mc-darwin-amd64
  ```
  {: codeblock}

  For {{site.data.keyword.ppc_notm}}, run the following command:
  
  ```
  curl -kLo cloudctl-mc-plugin https://<Cluster Master Host>:<Cluster Master API Port>/rcm/plugins/mc-linux-ppc64le
  ```
  {: codeblock}

  For {{site.data.keyword.linux_notm}}, run the following command:
  
  ```
  curl -kLo cloudctl-mc-plugin https://<Cluster Master Host>:<Cluster Master API Port>/rcm/plugins/mc-linux-amd64
  ```
  {: codeblock}

  For {{site.data.keyword.s390_notm}}, run the following command:
  
  ```
  curl -kLo cloudctl-mc-plugin https://<Cluster Master Host>:<Cluster Master API Port>/rcm/plugins/mc-linux-s390x
  ```
  {: codeblock}
    
2. Install the `mc` plugin for `cloudctl`. Run the following command to install the plug-in:

  ```
  cloudctl plugin install -f cloudctl-mc-plugin
  ```
  {: codeblock}

3. Verify that the `mc` plugin for `cloudctl` was successfully installed. Run the following command:

  ```
  cloudctl mc -help
  ```
  {: codeblock}

  See the following output:

  ```
  NAME:
     cloudctl mc

  USAGE:
     cloudctl mc command [arguments...] [command options]

  COMMANDS:
     apply                Apply a configuration to a resource by `filename` or `stdin`.
     cluster create       Create a cluster resource for import
     cluster delete       Delete a cluster. This will remove the cluster from management and delete management components from the cluster if connected.
     cluster import       Output the YAML content to be applied to the cluster to import it.
     cluster template     Output a template config.yaml file used for cluster import
     cluster update       Update a cluster resource for import
     create               Create a resource from a file or from stdin
     create helmrepo      Create a Helm repository
     delete               Delete resources by file names, stdin, resources and names, or by resources and label selector
     deploy application   Deploy an application
     describe             Show details of a specific resource or group of resources
     edit                 Edit a resource from the default editor
     get                  Display one or many resources
     label                Update the labels on a resource
     logs, log            Print the logs for a container in a pod
     help
  ```
  {: pre}

  Enter `cloudctl mc help [command]` for more information about a command. (This changes)
  
 
