---

copyright:
  years: 2019, 2020
lastupdated: "2020-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Scanning an image registry with the Vulnerability Advisor (VA)

You can scan image registries with the VA.
{:shortdesc}

## Configuring the Vulnerability Advisor to scan an image registry

Configure the Vulnerability Advisor to add, edit, and remove an image registry to be scanned.

**Prerequisite**: Ensure the VA node can connect to the Registry you want to scan by running the following command:
    
   ```
   docker login $registry_addr -u $username -p $password
   ```
   {: codeblock}

1. Add an image registry with the following steps:

     1. Create an image pull secret that {{site.data.keyword.product}} Kubernetes can use to pull an image from the image registry:
         ```
         kubectl -n kube-system create secret docker-registry $secret_name --docker-server=$registry_addr --docker-username=$username --docker-password=$password  --docker-email=$your_mail
         ```
         {: codeblock}

     2. From the navigation menu in the VA user interface, click **Tools** > **Vulnerability Advisor** > **kube-system** > **Registries**.

     3. Click the **Add New Registry** button to open the Registry Configuration window.

     4. Enter the address of registry in _Registry_ column.

     5. Select your registry type from the _Type_ menu. Your options are `dockerhub`, `artifactory`, `icp`, `harbor`, or `openshift`.

     6. Enter the image pull secret name that you created.

     7. Define which images you want to scan by entering a scope string with regex format. Your scope string might resembele the following content:

         ```
         ".*"   means scan all images in the registry
         "^library"  means only scan images under path library/ in the registry
         "^library/va-crawler"  means only scan image `va-crawler` under path library/ in the registry
         ```
         {: codeblock}

     8. Select True or False from the _Enable_ menu to enable scanning on your image registry.

     9. Save the configuration by clicking the **Save** button.

     An image registry is added.

2. Edit your image registry with the following steps:

     1. Select an existing registry from the _Select a registry_ drop-down menu.

     2. Edit your registry by clicking the _Edit Selected Registry_ button.

     3. Click the _Save_ button after you edit your configuration.

     Your image registry is edited.

3. Remove an image registry with the following steps:

     1. Select an existing registry from the _Select a registry_ drop-down menu.

     2. Edit your registry by clicking the _Edit Selected Registry_ button.

     3. Remove your configuration by clicking the _Delete_ button.

     Your image registry is removed.

The Vulnerability Advisor is configured to scan image registries.
