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

# Setting up an instance

Instances in the KMS allow for access controls to be assigned for a group of keys. An instance can be used for any logical grouping of keys, such as, by application or by team.

## Provisioning an instance
{: #prov_kmsinst}

To provision an instance, add the annotation, `ibm.com/kms.instanceID` to the metadata of a secret. You might give the instance identifier a convenient name for reference when you access the data from the secret later.

For example, to provision an instance with the data stored in the reference `kms-instance`, a secret with:

```
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: example-app-secret
  namespace: default
  annotations:
    ibm.com/kms.instanceID: "kms-instance"
```

The `data` section is updated, and a provisioned instance ID is added to the secret with your selected reference name. The instance ID is in UUID format (for example, `ee8bf75d-aa46-4329-af41-9a2404d2b0eb`). It is included in all API requests to the KMS.

### Default instance

A default instance is provisioned upon initial deployment of the key management service HSM chart. The instance ID in located in the `key-management-secret` with the label, "kms-instance".

## Setting up Service IDs
{: #service-id}

At a minimum, you must configure two service IDs. One service ID is assigned an administrative role for an instance of the KMS. The other ID is assigned a viewer role to be used by the application or service.

For more information, see [Create a service ID](../../iam/3.4.0/apis/service_id_mgmt.md#create1).

For each service ID, a service policy must be added by the cluster administrator. Include the provisioned instance ID in the policy. For the viewer service ID to be used by the service, you must add the root key to the instance. For more information, see [Adding Root Keys to the Instance](kms_guide_add_keys.md).

The policy body resembles the following code. For the instance administrator, do not provide `resource` or `resourcetype` parameters.

```
{
     "resources": [
       {
           "namespaceId": "kube-system",
           "serviceName": "kms",
           "serviceInstance": "<INSTANCE_ID>,
           "resource": "<KEY_ID>",
           "resourceType": "key"
       }
   ],
   "roles": [
       {
           "id": "crn:v1:icp:private:iam::::role:<ROLE>"
       }
   ]
}
```
{: codeblock}
