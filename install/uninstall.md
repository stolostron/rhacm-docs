---

copyright:
  years: 2020
lastupdated: "2020-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

<<<<<<< HEAD
# Uninstalling Red Hat Advanced Cluster Management for Kubernetes

Uninstall Red Hat Advanced Cluster Management for Kubernetes by removing the CR for the product.
{:shortdesc}

1. Log in to the boot node as a user with root permissions. During installation, you specified the IP addresses for each node type.

2. Change to the `cluster` directory within your Advanced Cluster Management for Kubernetes installation directory:
    ```
    cd /<installation_directory>/cluster
    ```
    {: codeblock}

3. Uninstall Advanced Cluster Management for Kubernetes by running the `uninstall-with-openshift` command:
=======
# Uninstalling the Red Hat Advanced Cluster Management for Kubernetes offline

Uninstall Red Hat Advanced Cluster Management for Kubernetes by removing all deployed platform Helm charts.
{:shortdesc}

1. If applicable, uninstall any optional modules. 

2. Uninstall Red Hat Advanced Cluster Management for Kubernetes by running the `uninstall-with-openshift` command:
>>>>>>> doc_stage
    ```
    sudo docker run -t --net=host -e LICENSE=accept -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/mcm-inception-amd64:3.2.3-rhel-ee uninstall-with-openshift
    ```
    {: codeblock}

**Note:** If `multicluster-hub.etcd.persistence` is set to `true` in the `config.yaml` file, the persistence volume for etcd is retained after you uninstall. The `config.yaml` file is located in the `/<installation_directory>/cluster` folder. You must back up the data of the persistence volume and then delete the persistence volume manually.
