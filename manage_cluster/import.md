# Importing a target managed cluster to the hub cluster

You can import clusters from different Kubernetes cloud providers. After you import, the targeted cluster becomes a managed cluster for the Red Hat Advanced Cluster Management for Kubernetes hub cluster. Unless otherwise specified, complete the import tasks anywhere where you can access the hub cluster and the targeted managed cluster.

 **Note:** A hub cluster cannot manage _any_ other hub cluster; you must import an existing cluster.

Choose from the following instructions to set up your managed cluster, either from the console or from the CLI:

**Required user type or access level**: Cluster administrator

- [Importing a cluster with the console](import_gui.md)
- [Importing a cluster with the CLI](import_cli.md)
- [Modifying multicluster endpoint](modify_endpoint.md)

