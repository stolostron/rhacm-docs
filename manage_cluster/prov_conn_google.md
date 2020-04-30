# Creating a provider connection for Google Cloud Platform

You need a provider connection to use Red Hat Advanced Cluster Management for Kubernetes console to create and manage a Red Hat OpenShift Container Platform cluster on Google Cloud Platform (GCP). 

**Note:** This procedure is a prerequisite for creating a cluster with Red Hat Advanced Cluster Management for Kubernetes. 

## Prerequisites

You must have the following prerequisites before creating a provider connection:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Internet access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster so it can create the Kubernetes cluster on GCP

* GCP login credentials, which include user Google Cloud Platform Project ID and Google Cloud Platform service account JSON key. See [Creating and managing projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects).

* Account permissions that allow installing clusters on GCP 

## Creating a provider connection by using the console

To create a provider connection from the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps: 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. On the Clusters page, select the *Provider connections* tab.
  
  Existing provider connections are displayed. 
  
3. Select **Add a connection**. 
   
4. Select **Google Cloud Platform** as your provider. 

5. Add a name for your provider connection.

6. Select a namespace for your provider connection from the list. 

  **Tip:** Create a namespace specifically to host your provider connections, for both convenience and security.

7. Add your *Google Cloud Platform Project ID* for your GCP account. Log in to [GCP](https://console.cloud.google.com/apis/credentials/serviceaccountkey) to retrieve your settings.

8. Add your *Google Cloud Platform service account JSON key*.

9. Enter your *Red Hat OpenShift Pull Secret*. You can download your pull secret from [Pull secret](https://cloud.redhat.com/openshift/install/pull-secret). 

10. Add your *SSH Private Key* and *SSH Public Key* so you can access the cluster. See [Generating an SSH private key and adding it to the agent](https://docs.openshift.com/container-platform/4.3/installing/installing_gcp/installing-gcp-default.html) for more information about how to generate a key.

11. Click **Create**. When you create the provider connection, it is added to the list of provider connections.

You can use this connection when you create a cluster by completing the steps in [Creating a cluster on Google Cloud Platform](create_google.md).

## Deleting your provider connection

When you are no longer managing a cluster that is using a provider connection, delete the provider connection to protect the information in the provider connection. 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select **Provider connections**.

3. Select the options menu beside the provider connection that you want to delete.

4. Select **Delete connection**. 
