# Uninstalling

When you uninstall Red Hat Advanced Cluster Management for Kubernetes, you must delete both the MultiClusterHub Instance and the `multiclusterhub-operator`. You can do that by using scripts, or by using commands. 

There are scripts that are provided in the [`open-cluster-management/deploy` GitHub repository](https://github.com/open-cluster-management/deploy) that simplify the procedures.

## Deleting both components by using script files

1. Run the `uninstall.sh` script file that is in the root directory of the [`open-cluster-management/deploy` GitHub repository](https://github.com/open-cluster-management/deploy) to remove the MultiClusterHub instance. To run this script file, run the following command in the root directory of the cloned repository:

```
./uninstall.sh
```

2. To remove the `multiclusterhub-operator`, any Hive deployments, and detach all imported clusters, run the `clean-clusters.sh` script file by entering the following command: 

```
./clean-clusters.sh
```

3. Enter `DESTROY` to delete any Hive deployments and detach all imported clusters.

4. Run the `unistall.sh` script again by entering the following command:

```
./uninstall.sh
```

## Deleting a MultiClusterHub Instance by using commands  

1. Delete the `yaml` definitions that are contained in the `multiclusterhub` directory by entering the following command:

```
kubectl delete -k multiclusterhub/
```

  This removes the MultiClusterHub instance. 
 
2. Run the `unistall.sh` script in the `multiclusterhub` directory to ensure that all of the objects are removed:

```
./multiclusterhub/uninstall.sh
```

## Deleting the multiclusterhub-operator by using commands

1. Delete the `yaml` definitions that are contained in the `multiclusterhub` directory by entering the following command:

```
kubectl delete -k acm-operator/
```

This removes the `acm-operator`. 

2. Run the `uninstall.sh` script in the `multiclusterhub` directory to ensure that all of the objects are removed:

```
./acm-operator/uninstall.sh
```
