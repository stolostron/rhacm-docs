# Creating a provider connection for Microsoft Azure

You need a provider connection to use Red Hat Advanced Cluster Management for Kubernetes console to create and manage a Red Hat OpenShift Container Platform cluster on Microsoft Azure.

**Note:** This procedure is a prerequisite for creating a cluster with Red Hat Advanced Cluster Management for Kubernetes.

## Prerequisites {#azure_prov_conn_prerequisites}

You must have the following prerequisites before creating a provider connection:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Internet access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster so that it can create the Kubernetes cluster on Azure

* Account permissions that allow installing on Azure. See [How to configure a cloud service](https://docs.microsoft.com/en-us/azure/cloud-services/cloud-services-how-to-configure-portal) for more information.

* Azure login credentials, which include your Base Domain Resource Group and Azure Service Principal JSON. See [azure.microsoft.com](https://azure.microsoft.com/en-ca/features/azure-portal).

## Creating a provider connection by using the console {#azure_provider_conn}

To create a provider connection from the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps:

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. On the _Clusters_ page, select the *Provider connections* tab.

  Existing provider connections are displayed.

3. Select **Add a connection**.

4. Select **Microsoft Azure** as your provider.

5. Add a name for your provider connection.

6. Select a namespace for your provider connection from the list.

  **Tip:** You can create a namespace specifically to host your provider connections, both for convenience and added security.

7. Add your *Base Domain Resource Group Name* for your Azure account. This entry is the resource name that you created with your Azure account. You can find your Base Domain Resource Group Name by selecting **Home** > **DNS Zones** in the Azure interface. Your Base Domain Resource Group name is in the *Resource Group* column of the entry that contains the Base DNS domain that applies to your account.

8. Add your *Azure Service Principal JSON* file name. You can determine this name by entering the following command: 

```
cat ~/.azure/osServicePrincipal.json
```

  **Tip:** If you need to generate an `osServicePrincipal.json` file, you can create it when you create the service principle by entering a command similar to the following example:
  
  ```
  az ad sp create-for-rbac --role Owner --name <service_principal> \
   | jq --arg sub_id "$(az account show | jq -r '.id')" \
     '{subscriptionId:$sub_id,clientId:.appId, clientSecret:.password,tenantId:.tenant}' \
     > ~/.azure/osServicePrincipal.json
  ```
  
  Replace <service_principal> with the name of your new file.
  
  **Note:** You must have the `jq` package installed to run the command.
  
  For more information about creating a service principal, see [Creating a service principal for your Microsoft Azure account](https://docs.openshift.com/container-platform/4.3/installing/installing_azure/installing-azure-account.html#installation-azure-service-principal_installing-azure-account) in the Red Hat OpenShift Container Platform documentation.

9. Enter your *Red Hat OpenShift Pull Secret*. You can download your pull secret from [Pull secret](https://cloud.redhat.com/openshift/install/pull-secret).

10. Add your *SSH Private Key* and *SSH Public Key* to use to connect to the cluster. You can use an existing key pair, or create a new pair using a key generation program. See [Generating an SSH private key and adding it to the agent](https://docs.openshift.com/container-platform/4.3/installing/installing_azure/installing-azure-default.html) for more information about how to generate a key.

11. Click **Create**. When you create the provider connection, it is added to the list of provider connections.

You can create a cluster that uses this provider connection by completing the steps in [Creating a cluster on Microsoft Azure](create_azure.md).

## Deleting your provider connection {#azure_delete_provider_conn}

When you are no longer managing a cluster that is using a provider connection, delete the provider connection to protect the information in the provider connection.

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select **Provider connections**.

3. Select the options menu for the provider connection that you want to delete.

4. Select **Delete connection**.
