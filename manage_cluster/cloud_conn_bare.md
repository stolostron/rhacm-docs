---

copyright:
  years: 2020
lastupdated: "2020-04-01"

---

# Creating a cloud connection for a bare metal environment

You need a cloud connection to use Red Hat Advanced Cluster Management for Kubernetes console to deploy and manage a Red Hat OpenShift Container Platform cluster in a bare metal environment.

**Note:** This procedure must be done before you can create a cluster with Red Hat Advanced Cluster Manager for Kubernetes. 

## Prerequisites

You need the following prerequisites before creating a cloud connection:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Internet access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster so it can create the Kubernetes cluster on your bare metal server

* Your bare metal server login credentials, which include the libvirt URI, SSH Private Key, and a list of SSH known hosts; see [Generating an SSH private key and adding it to the agent](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.3/html/installing_on_bare_metal/installing-on-bare-metal#ssh-agent-using_installing-bare-metal)

* Account permissions that allow installing clusters on the bare metal infrastructure

## Creating a cloud connection by using the console

To create a cloud connection from the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps: 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. On the _Clusters_ page, select the *Cloud connections* tab.
  
  Existing cloud connections are displayed. 
  
3. Select **Add connection**. 
   
4. Select **Bare metal** as your Cloud provider. 

5. Add a name for your cloud connection.

6. Select a namespace for your cloud connection from the list. 

  **Tip:** Create a namespace specifically to host your cloud connections, both for convenience and added security.

7. Add your *libvirt URI*. See [Connection URIs](https://libvirt.org/uri.html) for more information.

8. Enter your *Red Hat OpenShift Pull Secret*. You can download your pull secret from [Pull secret](https://cloud.redhat.com/openshift/install/pull-secret). 

9. Add your *SSH Private Key* so you can access the cluster. See [Generating an SSH private key and adding it to the agent](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.3/html/installing_on_bare_metal/installing-on-bare-metal#ssh-agent-using_installing-bare-metal) for more information about how to generate a key.

10. Add a list of your SSH known hosts.

11. Click **Create**. When you create the cloud connection, it is added to the list of cloud connections.

You can create a cluster that uses this cloud connection by completing the steps in [Creating an OpenShift cluster on bare metal](create_bare.md).

## Deleting your cloud connection

When you are no longer managing a cluster that is using a cloud connection, delete the cloud connection to protect the information in the cloud connection. 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select **Cloud connections**.

3. Select the options menu beside the cloud connection that you want to delete.

4. Select **Delete connection**. 
