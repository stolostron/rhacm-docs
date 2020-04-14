---

copyright:
  years: 2020
lastupdated: "2020-04-07"

---

# Creating a provider connection for Amazon Web Services

You need a provider connection to use Red Hat Advanced Cluster Management for Kubernetes console to deploy and manage an OpenShift cluster on Amazon Web Services (AWS). 

**Note:** This procedure must be done before you can create a cluster with Red Hat Advanced Cluster Manager for Kubernetes. 

## Prerequisites

You must have the following prerequisites before creating a provider connection:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Internet access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster so it can create the Kubernetes cluster on Amazon Web Services

* Amazon Web Services (AWS) login credentials, which include access key ID and secret access key. See [Understanding and Getting Your Security Credentials](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html).

* Account permissions that allow installing clusters on AWS. See [Configuring an AWS account](https://docs.openshift.com/container-platform/4.3/installing/installing_aws/installing-aws-account.html#installation-aws-permissions_installing-aws-account) for instructions on how to configure. 

## Creating a provider connection by using the console

To create a provider connection from the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps: 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. On the _Clusters_ page, select the *Provider connections* tab.
  
  Existing provider connections are displayed. 
  
3. Select **Add a connection**. 
   
4. Select **Amazon Web Services** as your provider. 

5. Add a name for your provider connection.

6. Select a namespace for your provider connection from the list. 

  **Tip:** Create a namespace specifically to host your provider connections, both for convenience and added security.

7. Add your *AWS Access Key ID* for your Amazon Web Services account. Log in to [AWS](https://console.aws.amazon.com/iam/home#/security_credentials) to find the ID.

8. Add your *AWS Secret Access Key ID*.

9. Enter your *Red Hat OpenShift Pull Secret*. You can download your pull secret from [Pull secret](https://cloud.redhat.com/openshift/install/pull-secret).

10. Add your *SSH Private Key* and *SSH Public Key*, which allows you to connect to the cluster. See [Generating an SSH private key and adding it to the agent](https://docs.openshift.com/container-platform/4.3/installing/installing_aws/installing-aws-default.html#ssh-agent-using_installing-aws-default) for more information about how to generate a key.

11. Click **Create**. When you create the provider connection, it is added to the list of provider connections.

You can create a cluster that uses this provider connection by completing the steps in [Creating an OpenShift cluster on Amazon Web Services] (create_ocp_aws.md).

## Deleting your provider connection

When you are no longer managing a cluster that is using a provider connection, delete the provider connection to protect the information in the provider connection. 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select **Provider connections**.

3. Select the options menu beside the provider connection that you want to delete.

4. Select **Delete connection**. 
