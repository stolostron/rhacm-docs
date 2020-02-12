---

copyright:
  years: 2016, 2019
lastupdated: "2019-12-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Delete repositories

Remove specific repositories from the private image registry.
{:shortdesc}

Base path: `https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/repositories/<repo>`

- The `<Cluster Master Host>` and `<Cluster Master API Port>` parameters are defined in [Master endpoints](../../installer/3.2.2/cluster_endpoints.md#master).

- `repo` is the full name of the repository image, including the namespace. For example, `default/alpine`. The private image registry creates individual repositories for images that are assigned the same name. When you remove an image repository, you remove all the images in that repository. You cannot remove a specific image within the repository.

  For example, `mycluster.icp:8500/default/nginx:1.9.1` is an image in the `mycluster.icp:8500/default/nginx` repository.


<dl>
<dt><b>API version</b></dt>
<dd>{{site.data.keyword.version}}</dd>
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
<dd><pre>DELETE</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>


The sample curl command resembles the following code:

```
curl -X DELETE -H "Authorization:Bearer $ID_TOKEN" https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/repositories/<repo> --insecure
```
{: codeblock}


The command does not return any messages.

```
root@master:~# curl -X DELETE -H "Authorization: Bearer $ID_TOKEN" https://mycluster.icp:8443/image-manager/api/v1/repositories/default/alpine --insecure

```
{: pre}

## Parameters

|Type|Name|Description|Schema|Default|Required|
|----|----|-----------|------|-------|--------|
|Path|namespace|Namespace where the repository is|string| |Yes|
|Path|repo:.*|Name of repository|string| |Yes|
{: caption="Table 1. The parameters that you use to delete repositories" caption-side="top"}

## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|OK|No content|
{: caption="Table 2. The responses that are returned when you delete repositories" caption-side="top"}
