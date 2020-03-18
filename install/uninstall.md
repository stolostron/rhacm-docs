---

copyright:
  years: 2019
lastupdated: "2019-12-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Uninstalling the Red Hat Advanced Cluster Management for Kubernetes offline

Uninstall Red Hat Advanced Cluster Management for Kubernetes by removing all deployed platform Helm charts.
{:shortdesc}

1. If applicable, uninstall any optional modules. 

2. Uninstall Red Hat Advanced Cluster Management for Kubernetes by running the `uninstall-with-openshift` command:
    ```
    sudo docker run -t --net=host -e LICENSE=accept -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/mcm-inception-amd64:3.2.3-rhel-ee uninstall-with-openshift
    ```
    {: codeblock}

**Note:** If `multicluster-hub.etcd.persistence` is set to `true` in the `config.yaml` file, the persistence volume for etcd is retained after you uninstall. The `config.yaml` file is located in the `/<installation_directory>/cluster` folder. You must back up the data of the persistence volume and then delete the persistence volume manually.
