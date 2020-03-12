---	

copyright:	
  years: 2016, 2020	
lastupdated: "2020-03-12"	

---	

{:new_window: target="_blank"}	
{:shortdesc: .shortdesc}	
{:screen: .screen}	
{:codeblock: .codeblock}	
{:pre: .pre}	
{:child: .link .ulchildlink}	
{:childlinks: .ullinks}	

# Image management API	

The image management API commands list, update, and delete images in the image registry.	
{:shortdesc}	

Both Cluster administrator and Administrator can access all image management APIs commands for all resources.	

To use these APIs, you must add an authorization header to your request. See [Preparing to run component or management API commands](../iam/3.4.0/apis/access_api.md).	<!--need to verify link-->

For example,	

```	
curl --cacert /<certificate_path>/ca.crt -s -H "Authorization: Bearer $ID_TOKEN" https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1	
```	
{: codeblock}

In this command:	
* `<certificate_path>` is `<installation_directory>/cluster/cfc-certs/router/icp-router.crt` on your boot node	

* `$ID_TOKEN` is the variable that stores the identity token for your cluster	

* `<Cluster Master Host>` and `<Cluster Master API Port>` are defined in [Master endpoints](../install/cluster_endpoints.md#master)	
If you have not set a CA domain, you can continue the request with an insecure connection.	

For example,	
```	
curl -k -H "Authorization: Bearer $ID_TOKEN" https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1	
```	

## Image management API data	
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
<dd><pre>/image-manager/api/v1</pre></dd>	
</dl>	
</dd>	
<dt><b>Command output format</b></dt>	
<dd><pre>application/json</pre></dd>	
</dl>	

- {: child} [Delete repositories](../apis/cfc_api_files/delete_repo.md) <br />  	
- {: child} [Get JWT tokens](../apis/cfc_api_files/get_tokens.md) <br />  	
- {: child} [List endpoints](../apis/cfc_api_files/list_endpoints.md) <br />  	
- {: child} [List repositories](../apis/cfc_api_files/list_repo.md) <br />  	
- {: child} [List specified repository](../apis/cfc_api_files/list_spec_repo.md) <br />  	
- {: child} [Update repository metadata](../apis/cfc_api_files/update_meta.md) <br />  	
{: childlinks}