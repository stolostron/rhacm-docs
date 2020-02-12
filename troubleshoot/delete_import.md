---

copyright:
  years: 2019
lastupdated: "2019-05-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Delete cluster to remove an imported cluster does not work

If you are unable to remove an imported cluster, complete the following procedure.
{:shortdesc}

## Symptom

If cluster deletion is unsuccessful, you can force removal of the `multicluster-endpoint` from the managed cluster.

## Resolving the problem

1. Open your terminal and configure your `kubectl` for your managed cluster.

  See [Supported cloud providers](../manage_cluster/cloud_providers.md) to learn how to configure your `kubectl`.
  
2. Run the following `self-destruct` command to remove the multicluster-endpoint from your managed cluster:
  
  ```
  docker run -it --entrypoint=cp -v /tmp:/data ibmcom/icp-multicluster-endpoint-operator:3.2.1 /usr/local/bin/self-destruct.sh /data/self-destruct.sh; /tmp/self-destruct.sh 2>&1 | tee self-destruct.log; rm /tmp/self-destruct.sh 
  ```
  {: codeblock}
  
  The force deletion might take a few minutes.
