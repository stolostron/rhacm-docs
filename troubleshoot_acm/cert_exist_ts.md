---

copyright:
  years: 2020
lastupdated: "2020-03-23"

---

# Certificate manager must not exist during an installation

Certificate manager must not exist on a cluster when you install Red Hat Advanced Cluster Management for Kubernetes.

## Symptom

Red Hat Advanced Cluster Management for Kubernetes installation fails. 

## Causes

Certificate manager already exists on the cluster.

## Solution

Verify if the certificate manager is present in your cluster by running the following command: 

   ```
   kubectl get crd | grep certificates.certmanager
   ```

