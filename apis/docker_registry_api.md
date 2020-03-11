---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Docker Registry V2 API

You can run Docker API commands. Red Hat Advanced Cluster Management for Kubernetes version 4.4.0 uses a Docker distribution that implements the Docker Registry V2 API spec to manage the storage of Docker images.
{:shortdesc}

Both cluster administrator and administrator can access the Docker Registry API. However, administrators can access only resources that belong to their namespace. Cluster administrators can access all resources in the cluster.

For details about the Docker Registry V2 API, refer to the official documentation:

* [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api){: new_window}
* [Docker Registry v2 authentication via central service](https://github.com/docker/distribution/blob/master/docs/spec/auth/token.md){: new_window}

## Running Docker API commands

When you run a Docker API command, you must obtain an authentication certificate from a cluster node and specify the authentication token.

You must copy the `/etc/docker/certs.d/<Cluster Master Host>:8500/ca.crt` file, the authentication certificate, from a cluster node to the node that runs the API commands.

`<Cluster Master Host>:<Cluster Master API Port>` are used to access the APIs. The parameters are defined in [Master endpoints](../install/cluster_endpoints.md#master).

You can store the authentication token in the `ID_TOKEN` variable by running the following commands:

```
export CMD=`curl --cacert /<certificate_path>/ca.crt -s -u admin:admin "https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/auth/token?service=token-service&scope=registry:catalog:*"`

```
{: codeblock}

```
export ID_TOKEN=$(echo $CMD | python -c 'import sys,json; print json.load(sys.stdin)["token"]')
```
{: codeblock}

```
echo $ID_TOKEN

```
{: codeblock}

Then you can use the authentication token in your REST commands. For example, to get a list of images from Docker Registry, run the following command:

```
curl --cacert /<certificate_path>/ca.crt -s -H "Authorization: Bearer $ID_TOKEN" "https://<Cluster Master Host>:8500/v2/_catalog"
```
{: codeblock}

In this command, `$ID_TOKEN` is the variable that stores the authentication cookie for your cluster.

The output resembles the following code:

```
{"repositories":[]}

```
{: pre}
