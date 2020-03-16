---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Red Hat Advanced Cluster Management for Kubernetes services overview

An Red Hat Advanced Cluster Management for Kubernetes service can be one of the following types: Kubernetes service, Kubernetes ingress, or Istio Gateway. An Red Hat Advanced Cluster Management for Kubernetes service runs on a single managed cluster or on multiple managed clusters. They support Kubernetes services, Kubernetes ingress services, and Istio Gateway services.

The following sections provide a summary of the types of services that are available for Red Hat Advanced Cluster Management for Kubernetes.

## Kubernetes service

A _service_ resource is a Kubernetes service resource. Edit the `spec` section of your service definition `yaml` file to define your service with labels. The following example shows a Kubernetes service resource:

<!-- CD: Where will you find the YAML for the service? -->

  ```
  apiVersion: v1
  kind: Service
  metadata:
    annotations:
      mcm.ibm.com/service-discovery: "{}"
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
  {: pre}

## Ingress service

An _Ingress_ service is a Kubernetes ingress that defines the criteria where the services on the managed cluster can communicate with other managed clusters. Edit the `spec` section of your ingress service definition `yaml` file to define your Ingress rules. See the following sample of an Ingress service definition: 

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
  {: pre}

## Gateway service

A _gateway_ service is used to define an Istio gateway. An Istio gateway is used to expose an Istio service outside of the Istio service mesh. You must enable an Istio gateway to expose an Istio service. Edit the `spec` section of your Istio gateway definition `yaml` file to define your gateway. 

See the following sample gateway service:

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
  {: pre}



See [Working with Red Hat Advanced Cluster Management for Kubernetes service discovery](working_serv_intro.md) for more information about the services. 
