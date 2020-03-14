---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# List specified repository

Get details on a specific repository.
{:shortdesc}

Base path: `https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/repositories/<repo>`

Where `repo` is the name of an image, including tags. For example, if you push the image `mycluster.icp:8500/default/tomcat` to the image registry, then `default/tomcat` is the name of the repository. The `<Cluster Master Host>` and `<Cluster Master API Port>` parameters are defined in [Master endpoints](../install/cluster_endpoints.md#master).


<dl>
<dt><b>API version</b></dt>
<dd>4.4.0</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host name</b></dt>
<dd><pre>Cluster Master Host</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>Cluster Master API Port</pre></dd>
<dt><b>Base path</b></dt>
<dd><pre>/image-manager/api/v1/repositories/{namespace}/{repo}</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>GET</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>


The sample curl command resembles the following code:

```
curl -k -H GET --header "Authorization: Bearer $ID_TOKEN" https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/repositories/<repo> --insecure
```
{: codeblock}

The response resembles the following code:

```
root@master:~# curl -k -H GET --header "Authorization: Bearer $ID_TOKEN" https://mycluster.icp:8443/image-manager/api/v1/repositories/default/alpine --insecure

{"name":"default/alpine","owner":"default","scope":"global","tags":\
[{"name":"3.6","manifest":{"schemaVersion":2,"mediaType":"application/\
vnd.docker.distribution.manifest.v2+json","config":{"mediaType":"application/\
vnd.docker.container.image.v1+json","size":1512,"digest":\
"sha256:053cde6e8953ebd834df8f6382e68be83adb39bfc063e40b0fc61b4b333938f1"},"layers":[{"mediaType":"application/vnd.docker.image.rootfs.diff.tar.gzip","size":1991435,\
"digest":"sha256:b56ae66c29370df48e7377c8f9baa744a3958058a766793f821dadcb144a4647"}]}}]}root@master:~#
```
{: pre}

## Parameters

|Type|Name|Description|Schema|Default|Required|
|----|----|-----------|------|-------|--------|
|Path|namespace|Namespace where the repository is|string| |Yes|
|Body|repo:.*|Name of repository|string| |Yes|
{: caption="Table 1. The parameters that you use to list specific repositories" caption-side="top"}

## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|Create success|No content|
{: caption="Table 2. The responses that are returned when you list specific repositories" caption-side="top"}
