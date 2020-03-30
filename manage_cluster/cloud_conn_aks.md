---

copyright:
  years: 2020
lastupdated: "2020-03-26"

---


# Creating a cloud connection for Microsoft Azure

You need a cloud connection to use Red Hat Advanced Cluster Management for Kubernetes console to create and manage a Red Hat OpenShift Container Platform cluster on Microsoft Azure. 
{:shortdesc}

**Note:** This procedure is a prerequisite for creating a cluster with Red Hat Advanced Cluster Manager for Kubernetes. 

## Prerequisites
{: #prereq}

You must have the following prerequisites before creating a cloud connection:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Internet access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster so that it can create the Kubernetes cluster on Azure

* Account permissions that allow installing on Azure. See [How to configure a cloud service](https://docs.microsoft.com/en-us/azure/cloud-services/cloud-services-how-to-configure-portal) for more information. 

* Azure login credentials, which include your Base Domain Resource Group and Azure Service Principal JSON. See [azure.microsoft.com](https://azure.microsoft.com/en-ca/features/azure-portal).

## Creating a cloud connection by using the console
{: #create_gui}

To create a cloud connection from the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps: 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. On the _Clusters_ page, select the *Cloud connections* tab.
  
  Existing cloud connections are displayed. 
  
3. Select **Add a connection**. 
   
4. Select **OCP on Azure** as your cloud provider. 

5. Add a name for your cloud connection.

6. Select a namespace for your cloud connection from the list. 

  **Tip:** You can create a namespace specifically to host your cloud connections, both for convenience and added security.

7. Add your *Base Domain Resource Group Name* for your Azure account. This is the resource name that you created with your Azure account. You can determine this by entering: `cat ~/.azure/osServicePrincipal.json`. 

8. Add your *Azure Service Principal JSON*.

9. Enter your *Red Hat OpenShift Pull Secret*. 

10. Add your *SSH Private Key* and *SSH Public Key*. See [Generating an SSH private key and adding it to the agent](https://docs.openshift.com/container-platform/4.3/installing/installing_azure/installing-azure-default.html) for more information about how to generate a key.

11. Click **Create**. When you create the cloud connection, it is added to the list of cloud connections.

You can create a cluster that uses this cloud connection by completing the steps in [Creating an OpenShift cluster on Microsoft Azure] (create_aks.md).

## Deleting your cloud connection
{: #delete}

When you are no longer managing a cluster that is using a cloud connection, delete the cloud connection to protect the information in the cloud connection. 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select **Cloud connections**.

3. Select the options menu for the cloud connection that you want to delete.

4. Select **Delete connection**. 
