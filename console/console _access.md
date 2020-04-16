---

copyright:
  years: 2020
lastupdated: "2020-04-16"

---

# Accessing your console

From the Red Hat OpenShift web console, you can access the Red Hat Advanced Cluster Management for Kubernetes console. You can also access the console from your terminal after installation. See all the options for accessing your console.

## From theUsing your cluster console OpenShift web console

  - You can click the **Application launcher** in the header and choose the _Red Hat Advanced Cluster Management for Kubernetes_ option.

  - You can also access the console from he left-hand navigatio.
  
    - Click **Networking** > **Routes**
    - From the _Project_ menu, select the namespace where Red Hat Advanced Cluster Management for Kubernetes is installed.
    - Find `multicloud-console` and click the URL from the `Location` column.

## From the Red Hat OpenShift CLI:

  1. While logged in to Red Hat OpenShift and after you install Red Hat Advanced Cluster Management for Kubernetes, run the following command to find the route. Here, `<namespace-from-install>` is the namespace where you installed the product:

  ```
  oc get routes -n <namespace-from-install>
  ```
  
  2. Find the `multicloud-console` name and the `Host/Port` columns to get your URL.

  Learn more about the Red Hat Advanced Cluster Management for Kubernetes console at [Using your cluster console](console_intro.md).