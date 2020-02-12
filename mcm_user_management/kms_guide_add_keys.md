---

copyright:
  years: 2019
lastupdated: "2019-06-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Adding root keys to instances

Root keys are stored and managed in the KMS. The keys use envelope encryption to protect data encryption keys that are used by your applications.

## Generating root keys

The KMS uses the following API call to generate a root key:

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

For more information, see [Generate a key](../../apis/kms_apis.md#gen_key).

## Importing root keys (Bring Your Own Key)

You might already have a key, or prefer to generate the key yourself. You can use the following API call to import your key material into the KMS:

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
{: codeblock}

For more information, see [Import a key](../../apis/kms_apis.md#import_key).

## Incorporating root keys into your applications

With your instance provisioned and your root key added, you are ready to take advantage of the KMS in your application.

### Wrapping Data Encryption Keys (DEK)

Rather than storing the data encryption key used in your application within the application itself, you must encrypt the DEK with your root key. The wrapped DEK must be stored in your application. For example:

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

For more information, see [Wrap a key](../../apis/kms_apis.md#wrap_key).

### Unwrapping Data Encryption Keys (DEK)

Your application uses the following API to unwrap (decrypt) the wrapped data encryption key when it is needed.

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

For more information, see [Unwrap a key](../../apis/kms_apis.md#unwrap_key).

### Generating Data Encryption Keys (DEK)

If you prefer to have the KMS generate your DEK, follow the instructions for wrapping a key. Omit the payload.

## Managing the lifecycle of your keys

The KMS can be used to manage the lifecycle of your root keys.

### Expiration

You might have included an expiration date when the root key is added to the KMS. That key is unusable for encryption when the expiration date arrives. You must add a new key for your application to have continued use of KMS. You must also update the application configuration to use the new key ID. The expired key can still be used to decrypt existing data.

### Rotation

Key rotation allows the root key material to be replaced, while you maintain the same key ID. This solution is perfect if you believe that your key might be compromised. It is also a good practice to periodically swap key materials.

A generated root key must be rotated with a freshly generated root key. Similarly, a provided root key must be provided to rotate a key that was previously imported. You are still able to use the old key material to decrypt existing data. Use the following API call to rotate a key:

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

For more information, see [Rotate a key](../../apis/kms_apis.md#rotate_key).
