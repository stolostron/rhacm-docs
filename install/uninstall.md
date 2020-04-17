# Uninstalling Red Hat Advanced Cluster Management for Kubernetes

When you uninstall Red Hat Advanced Cluster Management for Kubernetes, you must delete both the MultiClusterHub Instance and the multiclusterhub-operator.

There is a script that is provided in the [`open-cluster-management/deploy` GitHub repository](https://github.com/open-cluster-management/deploy) that simplifies the procedures. You can also uninstall them manually by using the `oc` commands.

## Deleting both components by using the uninstall script file

When you run the `uninstall.sh` script file that is in the root directory of the [`open-cluster-management/deploy` GitHub repository](https://github.com/open-cluster-management/deploy), it deletes both the MultiClusterHub and the multiclusterhub-operator. To run this script file, run the following command in the root directory of the cloned repository:

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

**Tip:** You can redeploy the `multiclusterhub` instance by running the following command:

```
kubectl apply -k multiclusterhub/
```

## Deleting the multiclusterhub-operator by using commands

1. Delete the `yaml` definitions that are contained in the `multiclusterhub` directory by entering the following command:

```
kubectl delete -k multiclusterhub-operator/
```

This removes the MultiClusterHub instance. 

2. Run the `unistall.sh` script in the `multiclusterhub` directory to ensure that all of the objects are removed:

```
./multiclusterhub-operator/uninstall.sh
```

**Tip:** You can redeploy the `multiclusterhub-operator` by running the following command:

```
kubectl apply -k multiclusterhub-operator/
```
