---

copyright:
  years: 2016, 2019
lastupdated: "2019-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# List repositories

List all repositories in the private image registry.
{:shortdesc}

The private image registry creates individual repositories for images that are assigned the same name.

Base path: `https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/repositories`

The `<Cluster Master Host>` and `<Cluster Master API Port>` parameters are defined in [Master endpoints](../../installer/3.2.2/cluster_endpoints.md#master).

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
<dd><pre>/image-manager/api/v1/repositories</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>GET</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>


The sample curl command resembles the following code:

```
curl -k -H GET --header "Authorization: Bearer $ID_TOKEN" https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/repositories --insecure
```
{: codeblock}

The sample response resembles the following code:

```
root@master:~# curl -k -H GET --header "Authorization: Bearer $ID_TOKEN" https://mycluster.icp:8443/image-manager/api/v1/repositories
{"repositories":[{"name":"default/alpine","owner":"default","scope":"global","tags":\
[{"name":"3.6","manifest":{"schemaVersion":2,"mediaType":"application/
vnd.docker.distribution.manifest.v2+json",\
"config":{"mediaType":"application/vnd.docker.container.image.v1\
+json","size":1512,"digest":\
"sha256:053cde6e8953ebd834df8f6382e68be83adb39bfc063e40b0fc61b4b333938f1"},"layers":[{"mediaType":"application/\
vnd.docker.image.rootfs.diff.tar.gzip","size":1991435,"digest":\
"sha256:b56ae66c29370df48e7377c8f9baa744a3958058a766793f821dadcb144a4647"}]}}]},{"name":"default/alpine-ppc64le","owner":"default","scope":"namespace","tags":[{"name":"3.6","manifest":\
{"schemaVersion":2,"mediaType":"application/vnd.docker.distribution.manifest.v2+json",\
"config":{"mediaType":"application/vnd.docker.container.image.v1
+json","size":1760,"digest":\
"sha256:daa414b19dcffa0ba7b80abb50a6b31156f1efd7bb1b8cdaeeb848da367afa38"},"layers":[{"mediaType":"application/\
vnd.docker.image.rootfs.diff.tar.gzip","size":2008578,\
"digest":"sha256:1e52418956f7d2a8ea35e8e6e3318fd08e005b27457d77868c225e7433bbfa02"},{"mediaType":"application/\
vnd.docker.image.rootfs.diff.tar.gzip","size":176,\
"digest":"sha256:acf472f4e5bb7956ac20bb343b304e1d3de1f79160c0d158cccbe25980022d50"}]}}]},{"name":"default/alpine-s390x","owner":"default","scope":"namespace","tags":[{"name":"3.6","manifest":{"schemaVersion":2,"mediaType":"application/vnd.docker.distribution.manifest.v2+json","config":{"mediaType":\
"application/vnd.docker.container.image.v1
+json","size":1758,"digest":\
"sha256:f7d8089567d12668e7f0d27e18b87abb38013f1b221b37ff7158fce2cbc3d792"},"layers":[{"mediaType":"application/\
vnd.docker.image.rootfs.diff.tar.gzip","size":2109387,\
"digest":"sha256:22a16c518b849c1025d3475ee9310b25eaf5ec70f10d657ac7a322323f14873a"},{"mediaType":"application/vnd.docker.image.rootfs.diff.tar.gzip","size":176,\
"digest":"sha256:0e5978b6b34b3e943e0fd25dfb50991c0bad82a986cfdaa91c4de756431ba679"}]}}]}]}root@master:~#
```
{: pre}


## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|OK|No content|
{: caption="Table 1. The responses that are returned when you list all repositories" caption-side="top"}
