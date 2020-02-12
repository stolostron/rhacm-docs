---

copyright:
  years: 2016, 2019 
lastupdated: "2019-12-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# {{site.data.keyword.mcm_notm}} troubleshooting for cluster management

Learn how to isolate and resolve problems with {{site.data.keyword.mcm_notm}}.
{:shortdesc}

Verify that your issues are not related to operating system requirements, such as disk, memory, and CPU capacities. For more information, see [System requirements](../../install/requirements.md).

To get support, see [Support](support.md) in the product documentation.

- {: child} [Manually deleting a namespace fails when the cluster resources still exist](delete_provider.md)
- {: child} [Managed cluster cannot access hub cluster Kubernetes API server](mcm_kube_api.md)
- {: child} [Cluster import fails when image registry is not whitelisted](image_policy_import.md)
- {: child} [Delete cluster to remove an imported cluster does not work](delete_import.md)
- {: child} [Multicluster-endpoint fails to initialize with user-installed Tiller in the `kube-system` namespace](endpnt_tiller.md)
- {: child} [Creating an EKS cluster fails due to `AlreadyExistsException`](eks_exception_fail.md)
- {: child} [Import fails when a cluster namespace exists or apiserver has an error](import_fails_namespace.md)
- {: child} [Failed to apply cluster import YAML file with error: No matches for kind Endpoint](failed_import_yaml.md)
- {: child} [Created clusters are not automatically imported](failed_auto_import.md)
- {: child} [Import cluster resource stuck in Pending state, failure to pull Docker image](import_docker_fail.md)
- {: child} [Import cluster resource that is stuck in Terminating because of platform-api cluster finalizer](cluster_finalizer.md)
{: childlinks}
