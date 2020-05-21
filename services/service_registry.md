# Configuring Red Hat Advanced Cluster Management for Kubernetes service discovery and registry

You can configure the Red Hat Advanced Cluster Management for Kubernetes service registry to discover Kubernetes, ingress, and Istio services that are in different Red Hat Advanced Cluster Management for Kubernetes managed clusters.

When you have multiple instances of a Kubernetes, ingress, or Istio service that are managed by Red Hat Advanced Cluster Management for Kubernetes, it is challenging to maintain them. The Red Hat Advanced Cluster Management for Kubernetes service discovery and registry function discovers Kubernetes, ingress, and Istio services that are configured to be discovered.

**Required user type or access level:** Cluster administrator.

After the Red Hat Advanced Cluster Management for Kubernetes hub cluster and managed cluster are configured, you need complete the following steps to configure your service registry component:

## Configure DNS

Configure the DNS for each managed cluster by completing these steps for each managed cluster:

1. Find the `mcm-svc-registry-dns` service cluster IP by entering the following command, where _rcm-klusterlet-namespace_ is the namespace that contains your Klusterlet:

   ```
   kubectl get -n <rcm-klusterlet-namespace> service mcm-svc-registry-dns -o jsonpath='{.spec.clusterIP}'
   ```

2. Configure your cluster DNS configuration by entering the following command:

   ```
   kubectl edit -n kube-system configmap kube-dns
   ```

3. Enable the forwarding plugin in the `kube-dns` configuration, similar to the following example, where <mcm-svc-registry-dns-service-cluster-ip> is the IP address that you identified in step 1:

   ```
   Corefile: |
     .:53 {

         ...

         forward mcm.svc. <mcm-svc-registry-dns-service-cluster-ip>
     }
   ```

   The value `mcm.svc` is the default DNS domain suffix for the service registry. If you want to set it to another value, complete the following steps:

      1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

	  2. Navigate to **Workloads** > **Helm Releases**.

	  3. Select your `rcm-klusterlet` release.

	  4. Expand **All parameters**.

	  5. In the *Multicloud Manager service registry configuration* section, set the DNS suffix in the *DNS Suffix* field.

## (Optional) Enable the kube-ingress and Istio discovery plugin

The `kube-service` plugin is enabled by default in the service registry component. You can discover Kubernetes services in the managed clusters that are using the `kube-service` plugin. The plugins for the ingress and Istio discovery must be enabled if you want to discover a Kubernetes ingress or Istio service in your managed clusters. Complete the following steps to enable ingress and Istio plugins:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

2. Navigate to **Workloads** > **Helm Releases**.

3. Select your `rcm-klusterlet` release.

4. Expand **All parameters**.

5. In the *Multicloud Manager service registry configuration* section, you can enable the plugin that you want to use by entering it in the **Enabled Plugins** field. Your entry should be comma-separated, like the following example:

   ```
   kube-service,kube-ingress,istio
   ```

   **Note:** If you enable the Istio plugin, you need to install the [istio-coredns-plugin](https://github.com/istio-ecosystem/istio-coredns-plugin) onto your Istio system and make sure your Istio system has an external load balancer.

## Discover the Kubernetes service

To discover a Kubernetes service on your managed clusters, complete the following steps:

1. Annotate the service to enable the service discovery.

   You must enable the service in the managed cluster to be discovered by adding the following annotation to the `config.yaml` file for the service that you want to discover:

   ```
   mcm.rcm.com/service-discovery
   ```

   The following example shows the format for the `dbservice`:

   ```
   apiVersion: v1
   kind: Service
   metadata:
     annotations:
       mcm.rcm.com/service-discovery: "{}"
     name: dbservice
     namespace: database
   spec:
     type: LoadBalancer
     ports:
     - name: http
       nodePort: 8080
       port: 8000
       protocol: TCP
     selector:
       app: dbservice
   ```

   **Note:** The Kubernetes service that you want to discover must be either a `LoadBalancer` or `NodePort` type.

2. If the service that you added the discovery annotation for has other applications that depend on it, add the service to the application's entry as a deployable dependency.

   The following example shows how to add this dependency:

   ```
   apiVersion: apps.mcm.com/v1alpha1
   kind: Deployable
   metadata:
     name: name1
     namespace: workspace
   spec:
     template:
       apiVersion: extensions/v1beta1
       kind: Deployment
       metadata:
         name: ibm-websphere
         labels:
           app: ibm-websphere
       spec:
         replicas: 1
         selector:
           matchLabels:
             app: ibm-websphere
         template:
           metadata:
             labels:
               app: ibm-websphere
           spec:
             containers:
             - name: ibm-websphere
               image: "registry.ng.bluemix.net/seed/ibm-websphere-sample"
               imagePullPolicy: Always
     dependencies:
     - name: dbservice
       namespace: database
       kind: Service
       apiGroup: v1
    placement:
       clusterNames:
       - managed cluster1
   ```

   The deployable dependent service is automatically discovered in the cluster (`managed cluster1`) in which the application is deployed.

3. Access the discovered service by using the following format:

   ```
   <service-name>.<service-namespace>.<service-registry-dns-suffix>
   ```


   An example of the format is: `dbservice.database.mcm.svc`.

## Discover the Kubernetes ingress

To discover a Kubernetes ingress within your managed clusters, complete the following steps:

1. Annotate an ingress with service discovery annotation.

   You must enable the ingress in the managed cluster to be discovered by adding the following annotation to the `config.yaml` file for the ingress that you want to discover:

   ```
   mcm.rcm.com/service-discovery
   ```

   The following example shows how to add this to the ingress:

   ```
   apiVersion: extensions/v1beta1
   kind: Ingress
   metadata:
     name: dbing
     namespace: database
     annotations:
       mcm.ibm.com/service-discovery: "{}"
   spec:
     rules:
     - host: mydb.database.mcm.svc
       http:
         paths:
         - path: /db
           backend:
            serviceName: dbservice
            servicePort: 8000
   ```

   **Tip:** You can append the service registry DNS suffix (mcm.svc) to your ingress host name, thus you can access the ingress host directly using the host name.

2. If the ingress that you added the discovery annotation to has other applications that depend on it, add the ingress to the application's entry as a deployable dependency.

   The following example shows how to add this dependency:

   ```
   apiVersion: apps.rcm.com/v1alpha1
   kind: Deployable
   metadata:
     name: name1
     namespace: workspace
   spec:
     template:
       apiVersion: extensions/v1beta1
       kind: Deployment
       metadata:
         name: rcm-websphere
         labels:
           app: rcm-websphere
       spec:
         replicas: 1
         selector:
           matchLabels:
             app: rcm-websphere
         template:
           metadata:
             labels:
               app: rcm-websphere
           spec:
             containers:
             - name: rcm-websphere
               image: "registry.ng.bluemix.net/seed/ibm-websphere-sample"
               imagePullPolicy: Always
     dependencies:
     - name: dbing
       namespace: database
       kind: Ingress
       apiGroup: extensions/v1beta1
     placement:
       clusterNames:
       - managed cluster1
   ```

   After applying this deployable, its dependent ingress is automatically discovered in the cluster (`managed cluster1`) in which the application is deployed.

3. Access the discovered ingress by using the ingress host name. In this example, the host name is `mydb.database.mcm.svc`.

## Discover the Istio service

To discover an Istio service within the managed clusters, complete the following steps:

1. Expose an Istio service outside of the service mesh by using an Istio gateway.

   See [Control Ingress Traffic](https://istio.io/docs/tasks/traffic-management/ingress/) for information about how to use the Istio Gateway to expose your Istio Service.

2. The Istio gateway that you added should look similar to the following example:

   ```
   apiVersion: networking.istio.io/v1alpha3
   kind: Gateway
   metadata:
     name: dbgateway
     namespace: database
   spec:
     selector:
       istio: ingressgateway
     servers:
     - port:
         number: 80
         name: http
         protocol: HTTP
       hosts:
       - "mydb.database.global"
  ```

   **Note:** The host name must end with the *.global* suffix. This is required by the `istio-coredns-plugin`.

3. Annotate the Istio gateway with the service discovery annotation

   You must enable the Istio gateway in the managed cluster to be discovered by adding the following annotation to the `config.yaml` file for the gateway that you want to discover:

   ```
   mcm.rcm.com/service-discovery
   ```

   The following example shows how to add this to the ingress:

   ```
   apiVersion: networking.istio.io/v1alpha3
   kind: Gateway
   metadata:
     name: dbgateway
     namespace:
     annotations:
       mcm.rcm.com/service-discovery: "{}"
   spec:
     selector:
       istio: ingressgateway
     servers:
     - port:
         number: 80
         name: http
         protocol: HTTP
       hosts:
        - "mydb.database.global"
   ```

4. If the Istio application that you added the discovery annotation for has other applications that depend on it, add the annotated gateway to the application's entry as a deployable dependency.

   The following example shows how to add this dependency:

   ```
   apiVersion: apps.rcm.com/v1alpha1
   kind: Deployable
   metadata:
     name: name1
     namespace: workspace
   spec:
     template:
       apiVersion: extensions/v1beta1
       kind: Deployment
       metadata:
         name: rcm-websphere
         labels:
           app: rcm-websphere
       spec:
         replicas: 1
         selector:
           matchLabels:
             app: rcm-websphere
         template:
           metadata:
             labels:
               app: rcm-websphere
           spec:
             containers:
             - name: rcm-websphere
               image: "registry.ng.bluemix.net/seed/rcm-websphere-sample"
               imagePullPolicy: Always
     dependencies:
     - name: dbgateway
       namespace: database
       kind: Gateway
       apiGroup: networking.istio.io/v1alpha3
    placement:
       clusterNames:
       - managed cluster1
   ```

   After applying this deployable to an Istio system, its dependent gateway is automatically discovered in the cluster (`managed cluster1`) in which the application is deployed.

5. Access the discovered ingress by using the gateway host name. In this example, the host name is `mydb.database.global`.
