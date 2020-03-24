---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-24"

---

# Multicluster config.yaml file settings

The `config.yaml` file contains all the configuration settings that are needed to deploy your cluster.

From the `config.yaml` file, you can customize your installation by using various parameters.

**Note:** Before you update any section of the `config.yaml` file, review the inline comments in that section.

You can set or update the following parameters by modifying the `config.yaml` file.

1. Open the `/<installation_directory>/cluster/config.yaml` file.
2. Add or modify the parameters and values. The format for defining a parameter and values is `<parameter_name>:<value>`.

  * Table 1. [Multicluster-hub settings](#mcm-hub)

## Multicluster-hub settings
{: #mcm-hub}

|Parameter|Description|Default value|
|---------|-----------|-------------|
|`multicluster-hub:`|Configure multicluster hub parameters. | |
|`etcd:`|Configure etcd parameters for multicluster hub. ||
|`persistence:`|Enable or disable the persistence volume for etcd. |false |
|`localPath:`|The local directory for persistence volume in all management nodes for etcd. |/var/lib/etcd-mcm |
{: caption="Table 1. Multicluster-hub settings for the IBM Cloud Pak for Multicloud Management" caption-side="top"}

