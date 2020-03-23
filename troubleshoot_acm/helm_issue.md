---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-17"

---

# Cannot create a Helm release on a managed cluster

You are unable to deploy Helm charts that contain images on a managed cluster.

## Causes

Not sure; will ask Chris if he remembers why

## Solution

To fix this error, you must configure `ClusterImagePolicy`. Run the following command to configure `ClusterImagePolicy`:

   ```yaml
   apiVersion: securityenforcement.admission.cloud.mcm.com/v1beta1
   kind: ClusterImagePolicy
   metadata:
     annotations:
       helm.sh/hook: post-install
       helm.sh/hook-weight: "1"
     name: mcm-default-cluster-image-policy
   spec:
     repositories:
     - name: <repo_name>
   ```