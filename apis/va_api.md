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

# Vulnerability Advisor API

The Vulnerability Advisor API commands can be used to manage security reports.
{:shortdesc}

Both Cluster administrator and Administrator can access all Vulnerability Advisor APIs for all resources.

You can also access the swagger API docs for the Vulnerability Advisor components from your {{site.data.keyword.product}} {{site.data.keyword.gui}} `https://<Cluster Master Host>:<Cluster Master API Port>/va/ui/api-docs/index.html`. The `<Cluster Master Host>` and `<Cluster Master API Port>` parameters are defined in [Master endpoints](../installer/3.2.2/cluster_endpoints.md#master).

To access these APIs from the command line, you must add an authorization header to your request. See [Preparing to run component or management API commands](../iam/3.4.0/apis/access_api.md).

For example,

```

curl -k -s -XGET -H  "Authorization: Bearer $ID_TOKEN" https://<Cluster Master Host>:<Cluster Master API Port>/va/api

```
{: codeblock}

The `$ID_TOKEN` parameter is the variable that stores the identity token for your cluster, and `<Cluster Master Host>` and `<Cluster Master API Port>` are defined in [Master endpoints](../installer/3.2.2/cluster_endpoints.md#master).


## Vulnerability Advisor API data

<dl>
<dt><b>API version</b></dt>
<dd>{{site.data.keyword.version}}</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host name</b></dt>
<dd><pre>&lt;Cluster Master Host&gt;</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>&lt;Cluster Master API Port&gt;</pre></dd>
<dt><b>Base path</b></dt>
<dd><pre>/va/api/v1</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>


## Get namespaces
The sample curl command resembles the following command:

```
curl -k -s -XGET -H "Authorization: Bearer $ID_TOKEN" 'https://<Cluster Master Host>:<Cluster Master API Port>/va/api/get-namespaces?access_group=kube-system&max=3' | jq .
```
{: codeblock}

The response resembles the following command:

```
{
  "result": [
    {
      "namespace": "kube-system/va-annotator-74c4c9bb96-8pbg9/va-annotator/e84dbbbca7af7c6ca3555620ca4ffc80d23c668221321098968cc759741ebaea",
      "source_type": "container",
      "timestamp": "2018-04-27T10:59:59+0000"
    },
    {
      "namespace": "kube-system/filebeat-ds-amd64-9s4zv/POD/6bcc7bb988f449586eaa5c45289e1f1f67af2b2ad68f4c2bc60e1944aca93e47",
      "source_type": "container",
      "timestamp": "2018-04-27T06:53:09+0000"
   }
}
```
{: pre}

## Get a snapshot of the timestamps

The sample curl command resembles the following command:

```
curl -k -s -XGET -H "Authorization: Bearer $ID_TOKEN" 'https://<Cluster Master Host>:<Cluster Master API Port>/va/api/get-snapshot-timestamps?access_group=kube-system&namespace=kube-system/elasticsearch-client-6c9fc8b5b6-dvztg/POD/d228119a35ab6ff158b3903cf24b3c014ad3809748485b1c6008d00baf1d6487' | jq ..
```
{: codeblock}

The response resembles the following content:

```
{
  "result": [
    "2018-04-27T06:52:23+0000",
    "2018-04-26T06:52:32+0000",
    "2018-04-25T06:54:12+0000",
    "2018-04-24T06:53:22+0000",
  ],
  "request_id": "66c4e381-0cc9-4f63-8ca5-aac81400ac8d"
}
```
{: pre}

## Get report

The sample curl command resembles the following command:

```
curl -k -s -XGET -H "Authorization: Bearer $ID_TOKEN" 'https://<Cluster Master Host>:<Cluster Master API Port>/va/api/get-report?access_group=kube-system&namespace=kube-system/elasticsearch-client-6c9fc8b5b6-dvztg/POD/d228119a35ab6ff158b3903cf24b3c014ad3809748485b1c6008d00baf1d6487&timestamp=2018-04-10T06%3A53%3A27%2B0000&report_type=compliance' | jq .
```
{: codeblock}

The response resembles the following code:

```
{
  "result": {
    "compliance": {
      "statusCode": 200,
      "body": {
        "total": 27,
        "compliant": 23,
        "non_compliant": 4,
        "custom": 0,
        "crawled_time": "2018-04-10T06:53:27+0000",
        "details": [
          {
            "compliance_id": "Linux.1-1-a",
            "compliant": "false",
            "compliance_check_time": "2018-04-10T06:53:30.639238Z",
            "reason": "File /etc/passwd not found",
            "description": "Each UID must be used only once.",
            "rule_type": "default"
          },
          {
          .............
```
{: pre}

## Get verdict

The sample curl command resembles the following code:

```
curl -k -s -XGET -H "Authorization: Bearer $ID_TOKEN" 'https://<Cluster Master Host>:<Cluster Master API Port>/va/api/get-verdict?access_group=kube-system&namespace=kube-system%2Fk8s-proxy-10.91.0.130%2Fproxy%2Fa7a93bba0f57de8055b3b5c880c340501a5d2158fa36326fbc76392e243b55f4&policy_name=package_vulnerability_found&source_type=container' | jq .
```
{: codeblock}

The response resembles the following code:

```
{
  "result":
  {
    "status": "violation",
    "detail":
    {
      .....
    }
  },
  "request_id": "30252cbf-5519-4bd3-837e-d0549795eef3"
}
```
{: pre}

## Get features

The sample curl command resembles the following code:

```
curl -k -s -XGET -H "Authorization: Bearer $ID_TOKEN" 'https://<Cluster Master Host>:<Cluster Master API Port>/va/api/get-features?access_group=kube-system&namespace=kube-system%2Fk8s-proxy-10.91.0.130%2Fproxy%2Fa7a93bba0f57de8055b3b5c880c340501a5d2158fa36326fbc76392e243b55f4&source_type=container&timestamp=2018-11-11T03%3A56%3A26%2B0000&data_type=config' | jq .
```
{: codeblock}

The response resembles the following code:

```
{
    "result":
    {
        "total": 9,
        "count": 9,
        "crawled_time": "2018-11-11T03:56:26+0000",
        "values": [
        {
            "key": "/etc/hostname",
            "value":
            {
                "name": "hostname",
                "content": "ra3icp2\n",
                "path": "/etc/hostname"
            }
        },
        ....
        }]
    },
    "request_id": "889032f0-65aa-462f-b174-2d82f7a6bbf9"
}
```
{: pre}
