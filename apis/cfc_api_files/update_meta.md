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

# Update repository metadata

Update a repository's metadata.
{:shortdesc}

Base path: `https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/repositories/<repo>`

The `<Cluster Master Host>` and `<Cluster Master API Port>` parameters are defined in [Master endpoints](../install/cluster_endpoints.md#master).

Where `repo` is the name of an image, including tags. For example, if you push the image `mycluster.icp:8500/default/tomcat` to the image registry, then `default/tomcat` is the name of the repository.

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
<dd><pre>PUT</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>


The sample curl command resembles the following code:

```
curl -X PUT -d '{"scope": "global"}' -H "Authorization: Bearer $ID_TOKEN" https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/repositories/<repo> --insecure
```
{: codeblock}

The response resembles the following code:

```
curl -X PUT -d '{"scope": "global"}' -H "Authorization:Bearer $ID_TOKEN" https://mycluster.icp:8443/image-manager/api/v1/repositories/default/cam-broker --insecure

OK
```
{: pre}

## Parameters

|Type|Name|Description|Schema|Default|Required|
|----|----|-----------|------|-------|--------|
|Body|"scope":|Update the repository image at a global or namespace level. Values: "global" or "namespace"|string||Yes|
|Body|namespace|Namespace where the repository is|string|| Yes|
|Body|repo:.*|Name of repository|string|| Yes|
{: caption="Table 1. The parameters used to update a repository" caption-side="top"}

## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|OK|No content|
{: caption="Table 2. The responses that are returned when you update a repository metadata" caption-side="top"}
