---

copyright:
  years: 2016, 2018
lastupdated: "2018-01-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating services

To allow access to your deployment from outside of your network, expose your deployment as a service.
{:shortdesc}

Two formats are available for you to create a service from the {{site.data.keyword.gui}}.

You can create services either by entering the parameter values in the Create Service window or by pasting a YAML file into the "Create resource" window.

**Required user type or access level**: Cluster administrator or team administrator

## Creating a service by using the Create Service window

1. From the navigation menu, click **Network Access** > **Services**.
2. Click **Create Service**.
3. Provide the service details. Provide individual values in the Create Service window.

    You must provide values for several parameters:

    * On the General tab, provide these values:
        * **Name** - A name for your service
        * **Expose method** - Select the method for exposing the deployment.
            * **ClusterIP**
            * **NodePort**
            <!--* **Ingress**- For more information about Ingress resources, see [http://kubernetes.io/docs/user-guide/ingress/](http://kubernetes.io/docs/user-guide/ingress/).-->
        * **Cluster IP** - If you do not specify the cluster IP address, one is automatically generated.
        * **Session affinity**
    * On the Ports tab, provide these values:    
       Define the connection details.
        * From the **protocol** list, select the connection for the protocol.
        * Enter the connection's name.
        * In the **port** field, specify the service access point, such as 80.
        * In the **targetPort** field, specify the port number that the service that is running inside the container uses, such as 8080.
        * If you use the NodePort method, in the **NodePort** field, specify the node port, such as `31888`. The default node port range is 31000 - 32000.
        <!--* If you use the Ingress connection method, in the **hostName** field, specify the host name, such as foo.bar.com.-->
    * On the Selectors tab, provide these values:
       As key-value pairs, specify the deployment that you want to create a service for.
        * selector - app
        * value - provide the name of the deployment
4. Click **Create**.
<!--5. If you exposed your application by using Ingress, you can create secrets for the resource. For example, you might create `tls.crt` and `tls.key` resources. Create the secrets by using the kubectl command from the CLI. You can then use these secret objects to create HTTP-enabled Ingress resources.-->

## Creating a service by using the "Create resource" window

1. From the dashboard, click **Create resource**.
2. Copy and paste a YAML or JSON file into the "Create resource" dialog box. For more information about creating a Kubernetes service by using a YAML file, see [https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service){: new_window}.
3. Click **Create**.
