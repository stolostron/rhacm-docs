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

# Key Management Service APIs

Use these APIs to manage keys for Key Management Service (KMS).
{:shortdesc}

Access to the API endpoints is governed by the access level of the service ID that makes the call.

To use these APIs, you must have a service ID, and you must add an authorization header to your request. You need an OIDC access token to add to the authorization header. To obtain the access token, see [Generate an OpenID Connect (OIDC) token](../iam/3.4.0/apis/api_keys.md#get3).

`<Cluster Master Host>:<Cluster Master API Port>` are used to access the APIs. The parameters are defined in [Master endpoints](../installer/3.2.2/cluster_endpoints.md#master).


## Generate a key
{: #gen_key}

**Required user type or access level**: Cluster administrator, Administrator, or Editor

<dl>
<dt><b>API version</b></dt>
<dd>2.0.0</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host IP</b></dt>
<dd><pre>Cluster Master Host</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>Cluster Master API Port</pre></dd>
<dt><b>Path</b></dt>
<dd><pre>/kms/api/v2/keys</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>POST</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>

The sample curl command resembles the following code:  
```
curl -X POST \
   https://<Cluster Master Host>:<Cluster Master API Port>/kms/api/v2/keys \
   -H 'authorization: Bearer $ACCESS_TOKEN' \
   -H 'icp-instance: <instance_ID>' \
   -H 'content-type: application/vnd.ibm.kms.key+json' \
   -H 'correlation-id: <correlation_ID>' \
   -d '{
  "metadata": {
    "collectionType": "application/vnd.ibm.kms.key+json",
    "collectionTotal": 1
  },
  "resources": [
    {
    "type": "application/vnd.ibm.kms.key+json",
    "name": "<key_alias>",
    "description": "<key_description>",
    "expirationDate": "<YYYY-MM-DDTHH:MM:SS.SSZ>",
    "extractable": <key_type>
    }
  ]
 }'
```
{: codeblock}

| Variable | Description |
| --- | --- |
| ACCESS_TOKEN | Your {{site.data.keyword.product_tm}} access token. Include the full contents of the access token, including the Bearer value, in the curl request. |
| instance_ID | The unique identifier that is assigned to your KMS instance.|
| correlation_ID | The unique identifier that is used to track and correlate transactions. |
| key_alias | A unique, human-readable name for easy identification of your key. <p>**Important:** To protect your privacy, do not store your personal data as metadata for your key.</p> |
| key_description | **Optional:** An extended description of your key. <p> **Important:** To protect your privacy, do not store your personal data as metadata for your key. </p> |
| YYYY-MM-DD HH:MM:SS.SS | **Optional:** The date and time that the key expires in the system, in RFC 3339 format. If you do not specify the `expirationDate` attribute, the key does not expire. |
| key_type | A boolean value that determines whether the key material can leave the service. When you set the `extractable` attribute to `false`, the service creates a root key that you can use for `wrap` or `unwrap` operations. Set the `extractable` attribute to `true` to generate a standard key.|

A successful response returns the ID value for your key, along with other metadata. The ID is a unique identifier that is assigned to your key and is used for subsequent calls to the Key Protect API.

## Import a key
{: #import_key}

**Required user type or access level**: Cluster administrator, Administrator, or Editor

<dl>
<dt><b>API version</b></dt>
<dd>2.0.0</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host IP</b></dt>
<dd><pre>Cluster Master Host</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>Cluster Master API Port</pre></dd>
<dt><b>Path</b></dt>
<dd><pre>/kms/api/v2/keys</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>POST</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>

The sample curl command resembles the following code:  

```
 curl -X POST \
   https://<Cluster Master Host>:<Cluster Master API Port>/kms/api/v2/keys \
   -H 'authorization: Bearer $ACCESS_TOKEN' \
   -H 'icp-instance: <instance_ID>' \
   -H 'content-type: application/vnd.ibm.kms.key+json' \
   -H 'correlation-id: <correlation_ID>' \
   -d '{
  "metadata": {
    "collectionType": "application/vnd.ibm.kms.key+json",
    "collectionTotal": 1
  },
  "resources": [
    {
    "type": "application/vnd.ibm.kms.key+json",
    "name": "<key_alias>",
    "description": "<key_description>",
    "expirationDate": "<YYYY-MM-DDTHH:MM:SS.SSZ>",
    "payload": "<key_material>",
    "extractable": <key_type>
    }
  ]
 }'
```

| Variable | Description |
| --- | --- |
| IAM_token | Your {{site.data.keyword.product}} access token. Include the full contents of the access token, including the Bearer value, in the curl request. |
| instance_ID | The unique identifier that is assigned to your KMS instance.|
| correlation_ID | The unique identifier that is used to track and correlate transactions. |
| key_alias | A unique, human-readable name for easy identification of your key. <p> **Important:** To protect your privacy, do not store your personal data as metadata for your key. </p> |
| key_description | **Optional:** An extended description of your key. <p> **Important:** To protect your privacy, do not store your personal data as metadata for your key. </p>  |
| YYYY-MM-DD HH:MM:SS.SS | **Optional:** The date and time that the key expires in the system, in RFC 3339 format. If you do not specify the `expirationDate` attribute, the key does not expire. |
| key_material | <p>The base64 encoded key material, such as an existing key-wrapping key, that you want to store and manage in the service.</p><p>Ensure that the key material meets the following requirements:</p><ol><li> The key must be 256, 384, or 512 bits.</li><li>The bytes of data, for example 32 bytes for 256 bits, must be encoded by using base64 encoding.</li></ol> |
| key_type | A boolean value that determines whether the key material can leave the service. When you set the `extractable` attribute to `false`, the service imports a root key that you can use for `wrap` or `unwrap` operations. Set the `extractable` attribute to `true` to import a standard key.|

A successful response returns the ID value for your key, along with other metadata. The ID is a unique identifier that is assigned to your key and is used for subsequent calls to the Key Protect API.


## Retrieve list of keys
{: #get_key}

**Required user type or access level**: Cluster administrator, Administrator, or Editor

<dl>
<dt><b>API version</b></dt>
<dd>2.0.0</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host IP</b></dt>
<dd><pre>Cluster Master Host</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>Cluster Master API Port</pre></dd>
<dt><b>Path</b></dt>
<dd><pre>/kms/api/v2/keys</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>GET</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>

The sample curl command resembles the following code:  
```
curl -X GET \
   https://<Cluster Master Host>:<Cluster Master API Port>/kms/api/v2/keys \
   -H 'authorization: Bearer $ACCESS_TOKEN' \
   -H 'icp-instance: <instance_ID>' \
   -H 'accept: application/vnd.ibm.collection+json' \   
```
{: codeblock}

| Variable | Description |
| --- | --- |
| ACCESS_TOKEN |  Your {{site.data.keyword.product}} access token. Include the full contents of the access token, including the Bearer value, in the curl request. |
| instance_ID | The unique identifier that is assigned to your KMS instance.|

A successful response returns the number of keys and the key names. It does not return the key material.

## Retrieve number of keys
{: #get_num}

**Required user type or access level**: Cluster administrator, Administrator, or Editor

<dl>
<dt><b>API version</b></dt>
<dd>2.0.0</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host IP</b></dt>
<dd><pre>Cluster Master Host</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>Cluster Master API Port</pre></dd>
<dt><b>Path</b></dt>
<dd><pre>/kms/api/v2/keys</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>HEAD</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>

The sample curl command resembles the following code:  
```
curl -X HEAD \
   https://<Cluster Master Host>:<Cluster Master API Port>/kms/api/v2/keys \
   -H 'authorization: Bearer $ACCESS_TOKEN' \
   -H 'icp-instance: <instance_ID>' \
   -H 'accept: application/vnd.ibm.collection+json' \   
```
{: codeblock}

| Variable | Description |
| --- | --- |
| ACCESS_TOKEN | Your {{site.data.keyword.product}} access token. Include the full contents of the access token, including the Bearer value, in the curl request. |
| instance_ID | The unique identifier that is assigned to your KMS instance.|

A successful response returns the number of keys.

## Retrieve a key by ID
{: #key_ID}

**Required user type or access level**: Cluster administrator, Administrator, or Editor

<dl>
<dt><b>API version</b></dt>
<dd>2.0.0</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host IP</b></dt>
<dd><pre>Cluster Master Host</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>Cluster Master API Port</pre></dd>
<dt><b>Path</b></dt>
<dd><pre>/kms/api/v2/keys/{ID}</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>GET</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>

The sample curl command resembles the following code:  
```
curl -X GET \
   https://<Cluster Master Host>:<Cluster Master API Port>/kms/api/v2/keys/{ID} \
   -H 'authorization: Bearer $ACCESS_TOKEN' \
   -H 'icp-instance: <instance_ID>' \
   -H 'accept: application/vnd.ibm.collection+json' \   
```
{: codeblock}

| Variable | Description |
| --- | --- |
|ID|The v4 UUID of the key.|
| ACCESS_TOKEN | Your {{site.data.keyword.product}} access token. Include the full contents of the access token, including the Bearer value, in the curl request. |
| instance_ID | The unique identifier that is assigned to your KMS instance.|

A successful response returns the details of the requested key.

## Wrap a key
{: #wrap_key}

**Required user type or access level**: Cluster administrator, Administrator, Editor, or Viewer

<dl>
<dt><b>API version</b></dt>
<dd>2.0.0</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host IP</b></dt>
<dd><pre>Cluster Master Host</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>Cluster Master API Port</pre></dd>
<dt><b>Path</b></dt>
<dd><pre>/kms/api/v2/keys/{ID}</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>POST</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>

The sample curl command resembles the following code:  
```
curl -X POST \
   https://<Cluster Master Host>:<Cluster Master API Port>/kms/api/v2/keys/{ID}?action=wrap \
   -H 'authorization: Bearer $ACCESS_TOKEN' \
   -H 'icp-instance: <instance_ID>' \
   -H 'accept: application/vnd.ibm.kms.key_action+json' \
   -H 'content-type: application/vnd.ibm.kms.key+json' \   
   -d '{
     'plaintext': '<data_key>',
     'aad': ['<additional_data>', '<additional_data>']
   }'  
```
{: codeblock}

| Variable | Description |
| --- | --- |
|ID| The root key that is used as the wrapping key. It must be a v4 UUID for an active key.|
| ACCESS_TOKEN |  Your {{site.data.keyword.product}} access token. Include the full contents of the access token, including the Bearer value, in the curl request. |
| instance_ID | The unique identifier that is assigned to your KMS instance.|
| correlation_ID | The unique identifier that is used to track and correlate transactions. |
| data_key | The data encryption key (DEK). Provide a base64 encoded plaintext during a wrap action. To generate a new DEK, omit the plaintext property. KMS generates a random plaintext of 32 bytes that is rooted in an HSM device and then wraps that value. The key length must be less than or equal to 4096 bytes. |
| additional_data | The additional authentication data (AAD) that is used to secure the key. If you use AAD when you make a wrap call, you must use the same AAD during an unwrap call. You can specify up to 126 AADs. The length of the AAD must be in the range 0-255.|

## Unwrap a key
{: #unwrap_key}

**Required user type or access level**: Cluster administrator, Administrator, Editor, or Viewer

<dl>
<dt><b>API version</b></dt>
<dd>2.0.0</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host IP</b></dt>
<dd><pre>Cluster Master Host</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>Cluster Master API Port</pre></dd>
<dt><b>Path</b></dt>
<dd><pre>/kms/api/v2/keys/{ID}</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>POST</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>

The sample curl command resembles the following code:  
```
curl -X POST \
   https://<Cluster Master Host>:<Cluster Master API Port>/kms/api/v2/keys/{ID}?action=unwrap \
   -H 'authorization: Bearer $ACCESS_TOKEN' \
   -H 'icp-instance: <instance_ID>' \
   -H 'accept: application/vnd.ibm.kms.key_action+json' \
   -H 'content-type: application/vnd.ibm.kms.key+json' \   
   -d '{
     'ciphertext': '<data_key>',
     'aad': ['<additional_data>', '<additional_data>']
   }'  
```
{: codeblock}

| Variable | Description |
| --- | --- |
|ID| The root key that is used as the wrapping key. It must be a v4 UUID for an active key.|
| ACCESS_TOKEN | Your {{site.data.keyword.product}} access token. Include the full contents of the access token, including the Bearer value, in the curl request. |
| instance_ID | The unique identifier that is assigned to your KMS instance.|
| correlation_ID | The unique identifier that is used to track and correlate transactions. |
| data_key | The wrapped DEK (WDEK) that is used in `unwrap` actions. Provide a base64 encoded ciphertext during an unwrap action. The response is a base64 encoded plaintext in the response body. |
| additional_data | The AAD that is used to secure the key. If you used AADs when you made a wrap call, you must use the same AADs during the unwrap call.|

## Rotate a key
{: #rotate_key}

**Required user type or access level**: Cluster administrator or Administrator

<dl>
<dt><b>API version</b></dt>
<dd>2.0.0</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host IP</b></dt>
<dd><pre>Cluster Master Host</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>Cluster Master API Port</pre></dd>
<dt><b>Path</b></dt>
<dd><pre>/kms/api/v2/keys/{ID}</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>POST</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>

The sample curl command resembles the following code:  
```
curl -X POST \
   https://<Cluster Master Host>:<Cluster Master API Port>/kms/api/v2/keys/{ID}?action=rotate \
   -H 'authorization: Bearer $ACCESS_TOKEN' \
   -H 'icp-instance: <instance_ID>' \
   -H 'accept: application/vnd.ibm.kms.key_action+json' \
   -H 'content-type: application/vnd.ibm.kms.key+json' \   
   -d '{
     'payload': '<data_key>'
   }'  
```
{: codeblock}

| Variable | Description |
| --- | --- |
|ID| The root key that is used as the wrapping key. It must be a v4 UUID for an active key.|
| ACCESS_TOKEN | Your {{site.data.keyword.product}} access token. Include the full contents of the access token, including the Bearer value, in the curl request. |
| instance_ID | The unique identifier that is assigned to your KMS instance.|
| correlation_ID | The unique identifier that is used to track and correlate transactions. |
| data_key | <p>The base64 encoded key material, such as an existing key-wrapping key, that you want to store and manage in the service.</p><p>To rotate a key that was initially generated by KMS, omit the payload attribute and pass an empty request entity body. To rotate an imported key, provide a key material that meets the following requirements:</p><ol><li>The key must be 256, 384, or 512 bits.</li><li>The bytes of data, for example 32 bytes for 256 bits, must be encoded by using base64 encoding.</li></ol> |

## Delete a key by ID
{: #key_del}

**Required user type or access level**: Cluster administrator or Administrator

<dl>
<dt><b>API version</b></dt>
<dd>2.0.0</dd>
<dt><b>API URI components</b></dt>
<dd>
<dl>
<dt><b>Scheme</b></dt>
<dd><pre>HTTPS</pre></dd>
<dt><b>Host IP</b></dt>
<dd><pre>Cluster Master Host</pre></dd>
<dt><b>Port number</b></dt>
<dd><pre>Cluster Master API Port</pre></dd>
<dt><b>Path</b></dt>
<dd><pre>/kms/api/v2/keys/{ID}</pre></dd>
<dt><b>Command</b></dt>
<dd><pre>DELETE</pre></dd>
</dl>
</dd>
<dt><b>Command output format</b></dt>
<dd><pre>application/json</pre></dd>
</dl>

The sample curl command resembles the following code:  
```
curl -X DELETE \
   https://<Cluster Master Host>:<Cluster Master API Port>/kms/api/v2/keys/{ID} \
   -H 'authorization: Bearer $ACCESS_TOKEN' \
   -H 'icp-instance: <instance_ID>' \
   -H 'accept: application/vnd.ibm.collection+json' \   
```
{: codeblock}

| Variable | Description |
| --- | --- |
|ID|The v4 UUID of the key.|
| ACCESS_TOKEN |  Your {{site.data.keyword.product}} access token. Include the full contents of the access token, including the Bearer value, in the curl request. |
| instance_ID | The unique identifier that is assigned to your KMS instance.|

When you delete a key, the key content and associated data is permanently removed. You cannot reverse the action.
