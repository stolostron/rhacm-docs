---

copyright:
  years: 2019,2020
lastupdated: "2020-03-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# MustGather to collect logs and obtain support

You can use this guide to gather information that is needed and relevant to the problem before you open a case with {{site.data.keyword.IBM}} Support. 
{:shortdesc}

**Note**: A `healthcheck` tool collects the data that is required to open the support case on the {{site.data.keyword.IBM_notm}} support portal.

## Self-diagnose

Before you contact {{site.data.keyword.IBM_notm}} Support, see [Stack overflow ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://stackoverflow.com/questions/tagged/ibm-cloud-private){: new_window} or [{{site.data.keyword.product_tm}} troubleshooting and support](mcm_troubleshoot.md) to check whether your problem is already reported.

To view examples and specific tutorials, see the following links: 

* Explore other topics in the [troubleshooting section](mcm_troubleshoot.md).
* Explore the [{{site.data.keyword.product}} Developer Community ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://stackoverflow.com/search?q=ibm-cloud-private){: new_window}.

## General troubleshooting information

When you open a ticket for support, follow the directions from the [{{site.data.keyword.IBM_notm}} Support ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/mysupport/s/topic/0TO500000001o0fGAA/ibm-cloud-private?language=en_US&productId=01t50000004X1PWAA0){: new_window}. As you gather information to open a ticket for support, include the following required information: 

* Title
* Product version
* Platform ({{site.data.keyword.ppc}}, {{site.data.keyword.linux}}, or {{site.data.keyword.s390}})
* Operating system _OS_ ({{site.data.keyword.rhel_short}}, Ubuntu, {{site.data.keyword.sles}})
* Virtualization platform (VMWARE, Azure, AWS, {{site.data.keyword.cloud_notm}})
* High Availability _HA_  
* Problem area
* Severity
* Detailed error description
* `hosts` file
* `config.yaml` file
* [Healthcheck results](#run_log)

  **Note**: The `hosts` and `config.yaml` file is located in the `/<installation-directory>/cluster` directory. The `hosts` file provides server topology details to {{site.data.keyword.IBM_notm}}. The `config.yaml` file provides customization details, which also include load balancer details.

## Types of issues

  * [Installation](#install_support)
  * [Upgrade](#upgrade_support)
  * [Uninstall](#uninstall_support)
  * [Reinstallation](#reinstall_support)
  * [{{site.data.keyword.gui_caps_only}}](#console_support)
  * [Security (LDAP, High Availability (HA), Access URL)](#security_support)
  * [Command line interface (CLI) usage (Helm, Kubernetes, {{site.data.keyword.product}}, Docker)](#cli_support)
  * [Deploying pods](#deploy_support)
  * [Crashing pods](#crash_support)
  * [Hanging server](#hang_server_support)
  * [Server not starting](#server_support)
  * [Memory issue](#memory_support)
  * [Performance](#performance_support)

### Installation
{: #install_support}

As you install {{site.data.keyword.product}}, ensure that you meet all of the system requirements and complete all prerequisites. For more information, see [System requirements](../../install/requirements.md).

**Note**: Verify whether Docker is installed with the {{site.data.keyword.IBM_notm}} binary files or directly from Docker.

If you have installation issues, view your cluster installation logs to view the summary. Run the following command from the `/<installation-directory>/cluster/` folder to generate installation logs:

  ```
  docker run --net=host -t -e LICENSE=accept -v "$(pwd)":/installer/cluster ibmcom/cpmcm-inception-<architecture>:<version> install -vvv
  ```
  {: codeblock}

The time-stamped logs are located in the `/<installation-directory>/cluster/logs/` folder.

### Upgrade
{: #upgrade_support}

If you have upgrade issues, complete the following steps: 

1. As you upgrade your cluster, view the version that you are upgrading to. This information is in the name of the `*.tar.gz` file in the `/<installation-directory>/cluster/images/` directory.

2. If your upgrade fails, note and copy the exact command that failed. Use that information to open a case with {{site.data.keyword.IBM}} Support.

### Uninstall
{: #uninstall_support}

If you have issues with uninstalling {{site.data.keyword.product}}, complete the following steps: 

1. Rerun the following uninstall command:

    ```
    sudo docker run -e LICENSE=accept --net=host \
    -t -v "$(pwd)":/installer/cluster ibmcom/cpmcm-inception-$(uname -m | sed 's/x86_64/amd64/g'):3.2.1-ee uninstall -vvv
    ```
    {: codeblock}
    
2. Create a file listing of the directory to where {{site.data.keyword.product}} is installed, run the following command:

    ```
    ls -ltR > filelist.txt
    ```
    {: codeblock}

### Reinstallation
{: #reinstall_support}

If you have issues reinstalling your {{site.data.keyword.product}} cluster, complete the following steps to reinstall your cluster:

1. Uninstall your cluster by running the following command: 

    ```
    sudo docker run -e LICENSE=accept --net=host \
    -t -v "$(pwd)":/installer/cluster ibmcom/cpmcm-inception-$(uname -m | sed 's/x86_64/amd64/g'):3.2.1-ee uninstall -vvv
    ```
    {: codeblock}
    
2. Create a file listing of the directory to where {{site.data.keyword.product}} is installed, run the following command:

    ```
    ls -ltR > filelist.txt
    ```
    {: codeblock}
    
3. Remove the Docker data from your directory by running the following command:

    ```
    rm -rf /var/lib/docker
    ```
    {: codeblock}

4. Reinstall your cluster by running the following command:
    
    ```
    docker run --net=host -t -e LICENSE=accept -v "$(pwd)":/cluster/logs ibmcom/cpmcm-inception-<architecture>:<version> install -vvv
    ```
    {: codeblock}

### {{site.data.keyword.gui_caps_only}}
{: #console_support}

Gather the following information before you open a case with {{site.data.keyword.IBM}} Support:

- Gather a clear problem description
- Provide the console page with the issue
- Check the network tab in the browser to see if any errors are being returned for the respective data
- Check the console tab for client-side errors and add them to the issue
- Gather information about the environment
- Gather any logs that are available
- Check your access credentials

#### You can no longer view contents of your secret

You can no longer view the contents of your secret on the _Secret details_ page. To increase PCI compliance for 3.1.1 and later releases, you cannot view decrypted secret values. You can update secret values from the command line according to your role-based access.

#### Page links are missing

In 3.1.1 and later, page links were moved to consolidate the navigation menu. User security and anything related was moved to the _Identity and Access_ page, which has an internal navigation menu with the missing items.

#### The _Welcome_ page is missing some links for certain users

The _Welcome_ page was modified to display only links that users can access. A User might not see links
on the _Welcome_ page that were previously available because they are hidden for that particular user based on role access.

#### Not all namespaces display in the dropdown menu

The namespace dropdown menu is scrollable. **Note:** Scrollable display might not work the same in all browsers.

#### Default namespace is no longer the default when you configure client

Starting in 3.1.1, new namespaces were added. More namespaces are returned in alphabetical order, so the `default` namespace might not be the first namespace available when you configure the client.

To resolve this issue, go to the _Workloads_ page and select the namespace that you want, then click the **Configure client** button. The selected namespace is in the `kubectl` configuration commands.

#### You cannot create any new deployments

Starting with 3.1.1, new security features were added. By default `image-security-enforcement` is enabled to restrict images from specific registries from being deployed as part of a workload, but only if the registry is not part of the image policy.

Be sure to add a policy to allow images that are not part of the default image policy list to be white-listed. This might affect charts and workloads during installation when the image is not part of the internal registry.

#### The Container images page does not load, cannot find an image, having a sorting problem

If there are an increased number of images that are loaded in the internal registry, you might experience errors when you load the Container images in the [{{site.data.keyword.gui}}].

For instance, loading 250 images might require an increased amount of time and cause timeouts in the [{{site.data.keyword.gui}}], despite performance and feature enhancements. There is a limit on the number of images that the image manager returns. If you can `get` an image from a CLI tool, but not from the {{site.data.keyword.gui}}, it might be caused by the image manager limitations.

#### Team Resources page search for nested resources

The search for nested resources does not work on the _Team resources_ page.

#### Upgrading to version 3.2.0 or later, the CSS styling in the header is off

If you have a highly available (HA) environment, be sure to clean up all your nodes before you upgrade.

#### The hamburger menu navigation is not updated with the service that is installed in version 3.2.0 or later

Be sure that your service is installed completely and that Helm charts are uploaded properly. Wait for a few minutes for the service to display in the navigation menu. Refresh the page, or log out and log in. For the account administrator role, the service that is installed must have the appropriate annotations assigned for the user to view in the navigation menu.

### Security (LDAP, HA, Access URL)
{: #security_support}

**Important**: Verify your role access. For more information, see [Role-based access control](../../iam/3.4.0/assign_role.md).

View the following questions to help you gather the following information:

* What is the role of the user who is logged in?
* What LDAP directory are you using?
* Did you configure LDAP over SSL?
* What is your LDAP URL?
* Is the LDAPSearch installed? 
   
If you have security issues, complete the following steps: 

1. Verify whether LDAP search is installed by running the following command:

    ```
    ldapsearch -x -H "<LDAP_URL>" -b "<LDAP_BASEDN>" -D "<LDAP_BINDDN>" -w "<LDAP_BINDPASSWORD>" -s sub
    ```
    {: codeblock}
    
    If the LDAP search is not installed, run the following command to install the LDAP search:
    
    * For Ubuntu:
      ```
      apt install ldap-utils
      ```
      {: codeblock}
      
    * For {{site.data.keyword.rhel}} ({{site.data.keyword.rhel_short}}):
      ```
      yum install openldap-clients
      ```
      {: codeblock}

2. View the status of the `auth` pod by running the following command:

    ```
    kubectl -n kube-system get pods | grep auth-idp
    ```
    {: codeblock}

3. To view the logs from your `auth` pod, run the following command:

    ```
    kubectl -n kube-system logs auth-yours
    ```
    {: codeblock}

4. View the details about the LDAP search by running the following command:

    ```
    ldapsearch -x -H "<LDAP_URL>" -b "<LDAP_BASEDN>" -D "<LDAP_BINDDN>" -w "<LDAP_BINDPASSWORD>" -s sub
    ```
    {: codeblock}

### Command line (CLI) usage (Helm, Kubernetes, {{site.data.keyword.product}}, Docker)
{: #cli_support}

View the following questions to help you gather information for any CLI issues:

* What command line are you using?
* What is the role of the user who is running the command?
* Did the problem occur as an LDAP authenticated user or cluster administrator? If it is an LDAP authenticated user, is it an administrator in the namespace?
* Which account had the issue with CLI usage?
* What is the output of the command?
* Was this command working and stopped, or is this the first time that you are trying to run it?

Complete the following steps to collect the logs for Helm, Kubernetes, the product, and Docker CLI issues: 

  * For Helm: 

    * Verify the Helm CLI version by running the following command:
        ```
        helm version --tls
        ```
        {: codeblock}
    
    * Debug `helm` by running the following command:
        ```
        helm <command> --tls --debug
        ```
        {: codeblock}

  * For Kubernetes:
  
    * Verify the Kubernetes CLI version by running the following command:
        ```
        kubectl version
        ```
        {: codeblock}
    
    * Debug `kubectl` by running the following command:
        ```
        kubectl version --v=<version_number>
        ```
        {: codeblock}

  * For `cloudctl`: 
    
    * Verify the CLI by running the following command:
        ```
        cloudctl version
        ```
        {: codeblock}

  * For the Docker CLI:
    
    * Verify the version number for Docker by running the following command:
        ```
        docker info
        ```
        {: codeblock}

### Deploying pods
{: #deploy_support}

Complete the following steps to gather logs for pod deployment issues:

1. To get a list of your pods run the following command: 

    ```
    kubectl get pods --all-namespaces -o wide
    ```
    {: codeblock}

2. Get a description of your pods by running the following command:
  
    ```
    kubectl describe pods --all-namespaces
    ```
    {: codeblock}

### Crashing pods
{: #crash_support}

If your pods are crashing, identify the pod by running the following command:
  
  ```
  kubectl get pods --all-namespaces
  ```
  {: codeblock}

### Hanging server
{: #hang_server_support}

If you are experiencing server hang, collect the logs to describe the problem and location of the hung server. Be sure to include which steps you followed and the frequency of the error.

For example, your log might have the following information:

* One or more error messages
* System crash memory dump
* Screen capture of the output from the `top` command (if possible)

### Server not starting
{: #server_support}

If your environment does not start, complete the following steps to collect the logs:

1. Identify which server is not starting (master, proxy, management, worker).
2. Check the status of your `kubelet` server by running the following command: 

    ```
    systemctl status kubelet
    ```
    {: codeblock}

3. To verify the status of your `docker` server, run the following command:

    ```
    systemctl status docker
    ```
    {: codeblock}
    
4. To get the `kubelet` logs, run the following command:

    ```
    journalctl -u kubelet
    ```
    {: codeblock}

5. To get the `docker` logs, run the following command:

    ```
    journalctl -u docker
    ```
    {: codeblock}

6. Check the Kubernetes services from the master node by running the following command:

    ```
    docker ps -a | grep hyper
    ```
    {: codeblock}

7. Check the running containers in Docker by running the following command:

    ```
    docker ps | grep ibmcom | grep k8s
    ```
    {: codeblock}

### Memory issue
{: #memory_support}

If you run out of memory, use the `healthcheck` tool. Run the following command:

  ```
  sudo docker run --net=host -t -e LICENSE=accept -v "$(pwd)":/installer/cluster ibmcom/cpmcm-inception-<architecture>:<version> healthcheck -v
  ```
  {: codeblock}

### Performance
{: #performance_support}

If your environment is slow, gather the following information for each node to open a service request to [{{site.data.keyword.IBM_notm}} Support ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/mysupport/s/topic/0TO500000001o0fGAA/ibm-cloud-private?language=en_US&productId=01t50000004X1PWAA0):

* Memory usage
* Available memory
* CPU usage
* `top` output 
* Synthetic Aperture Radar (SAR) (if available)
* nmon (if available) (monitor that gets the resource user from the server)

## Collecting logs
{: #run_log}

From the `/<installation-directory>/cluster/` folder, use the `healthcheck` tool to collect logs. When you use the `healthcheck` tool, a file is created to collect the required information to open a case with {{site.data.keyword.IBM}} Support.

Create a `healthcheck` folder for your logs, run the following command:

  ```
  sudo docker run --net=host -t -e LICENSE=accept -v "$(pwd)":/installer/cluster ibmcom/cpmcm-inception-<architecture>:<version> healthcheck -v
  ```
  {: codeblock}

   You can verify the name of the image by running the following command: 
    
   ```
   docker images | grep inception
   ```
   {: codeblock}

   **Note**: You must archive the entire health check folder. Before you archive the folder, verify that the pods and system folders, and that each folder is populated with log files in the `healthcheck` folder.
