---

copyright:
  years: 2019 
lastupdated: "2019-12-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Pods are not deployed on managed clusters for created application resources
{: #podsunavailable_mcm1448}

When you have created resources for your applications that are to be deployed to your managed clusters, you might encounter issues where pods are not being deployed on your managed clusters for your applications.
{:shortdesc}

## Symptoms

You have created application resources, but pods are not being deployed on your managed clusters.

## Causes

This issue can be caused by multiple root causes. To determine the root cause, you need to diagnose the problem.

## Diagnosing the problem

To diagnose the problem, check the availability and status of your pods and resources. Begin by checking your pods and resources on the Hub cluster. When your checks are successful, proceed to run the checks on your managed clusters.

### Diagnose the problem on the hub cluster

Run the following commands to check the availability and status of your pods and application resources to identify the root cause for the problem:

- For checking your application and channel pods, check whether all pods are running:

  ```
  `kubectl get pods -n kube-system | grep core`
  ```
  {: codeblock}

  If a pod is not running, describe the pod to troubleshoot the cause and get the pod running.

- For checking your subscriptions, check whether the subscription resources are created:

  ```
  `kubectl get subscriptions.app.ibm.com -n <namespace>`
  ```
  {: codeblock}

  If a subscription is not created, create the subscription. For more information, see [Creating and managing subscriptions](../applications/managing_subscriptions.md).

- For checking your subscriptions, check whether the subscription resource status is propagated:

  ```
  `kubectl get subscriptions.app.ibm.com -n <namespace> <subscription_name> -o yaml`
  ```
  {: codeblock}

  If the status for a subscription is not propagated, check the log for the associated channel pod within the kube-system namespace, or restart the channel pod within the kube-system namespace.

- For checking your subscriptions when there is placement rule set for the subscription, check whether there are decisions generated within the rule status:  
  
  ```
  `kubectl get placementrule.app.ibm.com -n <namespace> <placement_rule_name> -o yaml`
  ```
  {: codeblock}

  If decisions are not generated, check the log for the application pod within the kube-system namespace, or restart the application pod within the kube-system namespace.

- For checking your subscriptions, check whether a shadow deployable is created within your project namespace:

  ```
  `kubectl get deployables.app.ibm.com -n <namespace> <subscription_name>-deployable`
  ```
  {: codeblock}

  If a shadow deployable does not exist, check the log for the application pod within the kube-system namespace, or restart the application pod within the kube-system namespace.

- Check whether corresponding deployables are created in the cluster namespaces:

  ```
  `kubectl get deployables.app.ibm.com -n <cluster_namespace>`
  ```
  {: codeblock}

  If the deployables do not exist, check the log for the application pod within the kube-system namespace, or restart the application pod within the kube-system namespace.

- Check whether status of deployables in cluster namespaces is `Deployed`:

  ```
  `kubectl get deployables.app.ibm.com -n <cluster_namespace> <deployable_name> -o yaml`
  ```
  {: codeblock}

  If the deployment failed, check the status for a reason. If the status is not set, check the log for the application pod within the kube-system namespace, or restart the application pod within the kube-system namespace.

If every check shows that the resources are created correctly and the pods are all available and running, diagnose the problem on the managed clusters where the pod was not deployed.

### Diagnose the problem on managed cluster

Run the following commands to check the availability and status of your pods and application resources to identify the root cause for the problem:

- Check whether the `appmgr` pod is running:

  ```
  `kubectl get pod -n multicluster-endpoint | grep appmgr`
  ```
  {: codeblock}

  If the pod is not running, describe the pod to troubleshoot the pod and get it running.

- Check whether the subscription is created within the correct namespace:
  
  ```
  `kubectl get subscriptions.app.ibm.com --all-namespace | grep <subscription_name>`
  ```
  {: codeblock}

  If the subscription is not created within the correct namespace, check the `appmgr` pod log to troubleshoot the cause, or restart the `appmgr` pod.

- Check the status of the subscription

  ```
  `kubectl get subscriptions.app.ibm.com -n <desired namespace> <subscription_name>`
  ```
  {: codeblock}

  If the `spec.placement.local: true` field and value exists, but the status is not `Subscribed`, check the `appmgr` pod log, or restart the `appmgr` pod.

- Check the events for the resource creation:

  ```
  `kubectl get events -n <namespace>`
  ```
  {: codeblock}

  Verify that the resources are created, updated, or deleted as expected by the subscription controller. If anything looks problematic, check the `appmgr` pod log, or restart the `appmgr` pod.

## Resolving the problem

Depending on the results of each of your checks on your Hub and managed clusters, the steps to resolve the root cause can be different. Refer to the details for each check for diagnosing the problem for tips on resolving the problem.

## Related information

For more information, see [Managing applications](../applications/overview.md).
