---

copyright:
  years: 2018, 2020
lastupdated: "2020-03-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating a storage class for the IBM PowerVC FlexVolume Driver (IBM Power only)

<!--i believe this file will be remooved--> 
If you have an {{site.data.keyword.IBM}} Power environment and want to use a FlexVolume Driver, you must configure a FlexVolume Driver storage class.

The FlexVolume Driver can be used to manage the virtual components in your environments. Complete the following steps to configure the FlexVolume Driver storage class:

1. Create a project where you are deploying your PowerVC FlexVolume Driver.

   1. Accessing the OpenShift Container Platform URL.
   2. Select **Create Project**.
   3. Enter the *Name*, *Display Name* and *Description*.
   4. Patch the project to clear the `nodeSelector` tag by entering the following command:

      ```
      oc patch namespace powervc-fvd -p '{"metadata": {"annotations": {"openshift.io/node-selector": ""}}}'
      ```
      {: codeblock}
  
2. Assign the cluster-admin role to the *powervc-fvd* project’s default service account by entering the following command:

   ```
   oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:powervc-fvd:default
   ```
   {: codeblock}
  
3. Set the `hostmount-anyuid` source code control to the user `root`, or the user ID that was used to create the *powervc-fvd* project by entering the following command:

   ```
   oc adm policy add-scc-to-user hostmount-anyuid system:serviceaccount:powervc-fvd:default
   ```
   {: codeblock}
  
4. Set the `hostmount-anyuid` source code control to the user `root` by entering the following command:

   ```
   oc adm policy add-scc-to-user hostmount-anyuid system:serviceaccount:powervc-fvd:default
   ```
   {: codeblock}

   **Tip:** You can also add the *cluster-admin* role to the user ID that was used to create the *powervc-fvd* project by entering the following command:
  
   ```
   oc adm policy add-cluster-role-to-user cluster-admin my-rhel-icp-admin -n powervc-fvd
   ```
   {: codeblock}

   Replace *my-rhel-icp-admin* with the user ID that you want to have the role.
  
5. Import the PowerVC FlexVolume Driver template into the *powervc-fvd* project by completing the following steps:
   1. In the OpenShift Container Platform UI, select **Add to Project** > **Import YAML/JSON**.

   2. Select the file that contains your product template.
   3. Select the **Save template** option.
   4. Select **Import**.
  
   After the template is imported, the PowerVC FlexVolume application appears in the Catalog list of the OpenShift Container Platform UI.
  
6. Create a secret with the PowerVC username and password.

   1. Select the IBM PowerVC FlexVolume Driver icon in the Catalog.
   2. Select **Resources** > **Secret** from the menu.
   3. Add the secret name and the keys. For the key names, use the username and password of your PowerVC instance. “OS_USERNAME” and “OS_PASSWORD”. The values are the username and password of PowerVC.

7. From the OpenShift Container Platform Catalog, deploy the PowerVC FlexVolume Driver application.
   1. Open the PowerVC FlexVolume Driver application from the Catalog.
   2. Enter the required values.

      **Tips:**
      - The *secret name* is the secret that you defined in step 8.
      - You can find the information for the PowerVC certificate in the `/etc/tls/pki/ certs/powervc.crt` file on the PowerVC server.
      - The versions of the *Provisioner* and *Drivers* must be 1.0.1.

    3. Select **Create** to create the new template.  
    4. Read and confirm the notifications that are displayed, and select **Create Anyway**.

   After the PowerVC FVD application deployment is complete, the details of the provisioner and driver pods are displayed on the project's overview page.
  
8. Verify that the storage class is available by entering the following command:

   ```
   oc get scc
   ```
   {: codeblock}
  
9. Create a persistent volume claim to determine whether the storage class is consumed.

   1. Enter the following command to create a file that specifies the settings for the persistent volume claim:

      ``` 
      cat pvc.yaml
      ```
      {: codeblock}

      The following example shows a possible persistent volume claim that you can create:

      ```
      apiVersion: "v1"
      kind: "PersistentVolumeClaim"
      metadata:
        name: "claim"
        namespace: "kube-system"
      spec:
        accessModes:
      - "ReadWriteOnce"
      resources:
      requests:
	    storage: "2Gi"
      ```
      {: codeblock}
   
    2. Run the following command to create the persistent volume claim in your environment: 
    
       ```
       kubectl create -f pvc.yaml
       ```
       {: codeblock}

    3. Run the following command to apply your settings to your persistent volume claim:
       ```
       kubectl get pvc -n kube-system
       ```
       {: codeblock}
