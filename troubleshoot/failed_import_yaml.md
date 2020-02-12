---
copyright:
  years: 2019
lastupdated: "2019-11-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Failed to apply cluster import YAML file with error: No matches for kind Endpoint

Certain versions of the Kubernetes API server and `kubectl` cannot handle creating a Custom Resource Definition in the same YAML file as a Custom Resource of the same type.

## Symptom

When you run `kubectl apply -f cluster-import.yaml`, some resources are created, but you receive the following error:

```
error: unable to recognize "/import/cluster/import.yaml": no matches for kind "Endpoint" in version "multicloud.ibm.com/v1beta1"
```
{:codeblock}

For certain versions of the Kubernetes client and server, a Custom Resource cannot be defined in the same YAML file as the Custom Resource Definition.

## Resolve the issue

Run the `kubectl apply -f cluster-import.yaml` command again.

```
kubectl apply -f cluster-import.yaml
```
{:codeblock}
