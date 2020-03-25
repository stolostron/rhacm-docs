---

copyright:
  years: 2016, 2020 
lastupdated: "2020-03-24"

---

# Red Hat Advanced Cluster Management for Kubernetes troubleshooting for cluster management

Learn how to isolate and resolve problems with Red Hat Advanced Cluster Management for Kubernetes.

Verify that your issues are not related to operating system requirements, such as disk, memory, and CPU capacities. For more information, see [System requirements](../install/requirements.md).

To get support, see [Support](support.md) in the product documentation.

- [Manually deleting a namespace fails when the cluster resources still exist](delete_provider.md)
- [Managed cluster cannot access hub cluster Kubernetes API server](mcm_kube_api.md)
- [Cluster import fails when image registry is not whitelisted](image_policy_import.md)
- [Delete cluster to remove an imported cluster does not work](delete_import.md)
- [Multicluster-endpoint fails to initialize with user-installed Tiller in the `kube-system` namespace](endpnt_tiller.md)
- [Creating an EKS cluster fails due to `AlreadyExistsException`](eks_exception_fail.md)
- [Import fails when a cluster namespace exists or apiserver has an error](import_fails_namespace.md)
- [Failed to apply cluster import YAML file with error: No matches for kind Endpoint](failed_import_yaml.md)
- [Created clusters are not automatically imported](failed_auto_import.md)
- [Import cluster resource stuck in Pending state, failure to pull Docker image](import_docker_fail.md)
- [Import cluster resource that is stuck in Terminating because of platform-api cluster finalizer](cluster_finalizer.md)
