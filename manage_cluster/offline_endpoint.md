---

copyright:
  years: 2019
lastupdated: "2019-10-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Importing a managed cluster in an air gapped environment

After you install {{site.data.keyword.mcm_notm}}, you can import a managed cluster in an air-gapped environment. By default, the `multicluster-endpoint` deployment pulls all of the required images from Docker Hub. Complete the following instructions only if you are working in an air gapped environment.
{:shortdesc}

  - [Prerequisites](#prereq)
  - [Importing an {{site.data.keyword.icp_OpenShift}} in an air gapped environment](#ppa-2)

  **Note:** A hub cluster cannot manage another hub cluster.

## Prerequisites
{: #prereq}

* You must have an {{site.data.keyword.mcm_notm}} hub that is deployed and a cluster that you want to manage.

* You need to install the Kubernetes CLI, `kubectl`. To install `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

* You must install `cloudctl`. For more information, see [Installing {{site.data.keyword.cloud_pak}} CLI (cloudctl)](../../cloudctl/install_cli.md) to install the CLI.

  **Note:** Download the installation file for CLI tools from the {{site.data.keyword.gui}}.

* You must install Docker. To install Docker, see [Install Docker ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.docker.com/install/){: new_window}.

## Importing an {{site.data.keyword.icp_OpenShift}} in an air gapped environment
{: #ppa-2}

1. Log in to your cluster with the following command, where `<Cluster Master Host>` is the external hostname or IP address for your master or leading master node:

  ```
  cloudctl login -a https://<Cluster Master Host>:<Cluster Master API Port> --skip-ssl-validation
  ```
  {: codeblock}

2. Run the following command to log in to the image registry:

  ```
  docker login $(kubectl get route -n default docker-registry -o jsonpath='{.spec.host}') -u $(oc whoami) -p $(oc whoami -t)
  ```
  {: codeblock}


3. Load the PPA archive with the following command:

   ```
   cloudctl catalog load-ppa-archive -a <mcm-package-file> --registry <registry-url>/ibmcom --username <username> --password <password>
   ```
   {: codeblock}

   - File for {{site.data.keyword.linux_bit_notm}}: `mcm-endpoint-3.3.0-amd64.tgz`
   - File for {{site.data.keyword.ppc_notm}}: `mcm-endpoint-3.3.0-ppc64le.tgz` 	
   - File for {{site.data.keyword.s390_notm}}: `mcm-endpoint-3.3.0-s390x.tgz`

4. Ensure that the namespace with assigned access so that images can be pulled from this registry.

  ```
  oc policy add-role-to-group system:image-puller system:serviceaccounts:multicluster-endpoint --namespace=ibmcom
  ```
  {: codeblock}

You are ready to complete the import process either from the {{site.data.keyword.mcm_notm}} {{site.data.keyword.gui}} or from the CLI.

See [Importing a target managed cluster to the {{site.data.keyword.mcm_notm}} hub cluster](../manage_cluster/import_gui.md) for instructions.
