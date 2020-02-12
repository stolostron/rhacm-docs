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

# Get JWT tokens

Get the JWT token that is to be used with the Docker client.
{:shortdesc}

Base path: `https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/auth/token`

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
<dd><pre>/image-manager/api/v1/auth/token</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>GET</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>


The sample curl command resembles the following code:


```
curl -k -H GET --header "Authorization: Bearer $ID_TOKEN" https://<Cluster Master Host>:<Cluster Master API Port>/image-manager/api/v1/auth/token
```
{: codeblock}

The response resembles the following code:

```
root@master:~# curl -k -H GET --header "Authorization: Bearer $ID_TOKEN" https://mycluster.icp:8443/image-manager/api/v1/auth/token
{"expires_in":1800,"issued_at":"2017-11-30T05:24:21Z","token":\
"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjZMUDY6SFFJUjozVkg0OlZIUUk6TTRNMjpMSEFWOldGS0M6Mk9aQTpSTjRMOlQ3UUs6RzVLUTpKNkg1In0.eyJpc3MiOiJyZWdpc3RyeS10b2tlbi1pc3N1ZXIiLCJzdWIiOiIiLCJhdWQiOiIiLCJleHAiOjE1MTIwMjEyNjEsIm5iZiI6MTUxMjAxOTQ2MSwiaWF0IjoxNTEyMDE5NDYxLCJqdGkiOiJsYzVkRzVPVTI0anhjemVLIiwiYWNjZXNzIjpudWxsfQ.F2D6VjwhQRlRvU-da2zHDzDbck8avh1lxc8B4hAVrIhEY8orcqwYhocjxnFk3kXdNm3yihMwi17lYySEnet3_p7jWOJ0XGTF6_m7DeUsNd-YqtGGv7FTycTG_10Xnm7zuknBhpsbMx_Eq4gKRBM1ndwdkhhOLG135r97BbTcT_GlHcnmyKfFLXfmhVgiAhBeTn1_phmSO-Olys0bhbKl2M_jIiCGLwleKQpa3dFsJ3JsYGSQcB7dEVZuSAmzc3OmlYXmvl8oCnjyM-RIkQk8-uGkI_7cjhXOY8rORGMgp0r6f8LXky5K_XH1mIG7BARKr1E-9SKyyIGwRWMUIs3fwA"}
```
{: pre}

## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|OK|No content|
{: caption="Table 1. The responses that are returned when you get JWT tokens" caption-side="top"}
