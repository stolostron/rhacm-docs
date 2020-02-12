---

copyright:
  years: 2016, 2019
lastupdated: "2019-12-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Enabling the Vulnerability Advisor (VA) with {{site.data.keyword.open_s}} logging

Enable the Vulnerability Advisor (VA) on {{site.data.keyword.product}} to receive security statuses for container images.
{:shortdesc}

Vulnerability Advisor (VA) depends on Elasticsearch. After you install {{site.data.keyword.open_s}} logging, you can enable the VA with {{site.data.keyword.open_s}} logging. 

Complete the following steps to enable VA on an {{site.data.keyword.open_s}} 3.11 cluster:

1. Copy the `logging-elasticsearch` secret from the `openshift-logging` namespace into the `kube-system` namespace.

   1. Get the `logging-elasticsearch` secret from the `openshift-logging` namespace by running the following command:

      ```
      kubectl get secret logging-elasticsearch -n openshift-logging -oyaml > logging-secret.yaml
      ```
      {: codeblock}

   2. Modify the `logging-secret.yaml` file by changing the namespace to `kube-system`. Your `logging-secret.yaml` file might resemble the following YAML:

      ```
      kind: Secret
      metadata:
        creationTimestamp: 2019-09-04T05:51:46Z
        name: logging-elasticsearch
        namespace: kube-system
        resourceVersion: "28672"
        selfLink: /api/v1/namespaces/openshift-logging/secrets/logging-elasticsearch
        uid: 1462061f-ced8-11e9-8eee-0e706bf86eea
      type: Opaque
      ```
      {: pre}

   3. Apply the `logging-elasticsearch` secret to the `kube-system` namespace by running the following command:

      ```
      kubectl create -f logging-secret.yaml -n kube-system
      ```
      {: codeblock}

2. During your {{site.data.keyword.cloud_pak_mcm}} installation, add the VA parameters into your `config.yaml` file. Your `config.yaml` file might resemble the content:

   ```
   vulnerability-advisor:
     mapp_enabled: true
     es_service_name: logging-es.openshift-logging.svc.cluster.local
     es_secret:
       name: logging-elasticsearch
       ca: admin-ca
       cert: admin-cert
       key: admin-key
   ```
   {: pre}

### Enabling VA on {{site.data.keyword.open_s}} 4.2 

1. Copy the `elasticsearch` secret from the `openshift-logging` namespace into the `kube-system` namespace.

   1. Get the `elasticsearch` secret from the `openshift-logging` namespace by running the following command:

      ```
      kubectl get secret elasticsearch -n openshift-logging -oyaml > logging-secret.yaml
      ```
      {: codeblock}

   2. Modify the `logging-secret.yaml` file by changing the namespace to `kube-system`. Your `logging-secret.yaml` file might resemble the following YAML:

      ```
      kind: Secret
      metadata:
        creationTimestamp: 2019-09-04T05:51:46Z
        name: elasticsearch
        namespace: kube-system
        resourceVersion: "28672"
        selfLink: /api/v1/namespaces/openshift-logging/secrets/elasticsearch
        uid: 1462061f-ced8-11e9-8eee-0e706bf86eea
      type: Opaque
      ```
      {: pre}

   3. Apply the `elasticsearch` secret to the `kube-system` namespace by running the following command:

      ```
      kubectl create -f logging-secret.yaml -n kube-system
      ```
      {: codeblock}

2. During your {{site.data.keyword.cloud_pak_mcm}} installation, add the VA parameters into your `config.yaml` file. Your `config.yaml` file might resemble the content:

   ```
   vulnerability-advisor:
     es_service_name: elasticsearch.openshift-logging.svc.cluster.local
     es_secret:
       name: elasticsearch
       ca: admin-ca
       cert: admin-cert
       key: admin-key
   ```
   {: pre}
   
VA is enabled.
