# IBM Red Hat Guide to Install Red Hat Software for IBM Cloud Pak for Multicloud Management 1.2

<b>Product Release</b>: 1.2.0

<b>Publication date</b>: December 13 2019

<b>Last modified date</b>: December 6, 2019

This guide provides a quick and easy way to install Red Hat software.

The IBM Cloud Pak for Multicloud Management includes entitlement to use Red Hat OpenShift Container Platform, Red Hat Enterprise Linux CoreOS (RHCOS), and Red Hat Enterprise Linux (RHEL). RHCOS is the only supported operating system for OpenShift Container Platform master node hosts. RHCOS and RHEL are both supported operating systems for OpenShift Container Platform worker node hosts, though RHCOS is the default.

## Installing Red Hat OpenShift Container Platform

OpenShift Container Platform 4.x can be downloaded and installed by accessing Red Hat OpenShift Cluster Manager at https://cloud.redhat.com/openshift/install by using your Red Hat account, which can be created freely, without a paid Red Hat subscription entitlement to any IBM offering.

If you do not yet have a Red Hat account, create one for free at https://www.redhat.com/wapps/ugc/register.html before you follow the remaining instructions.

If you have a Red Hat account, navigate to https://cloud.redhat.com/openshift/install and log in with your account credentials.

The cluster manager displays several tiles that represent various cloud providers and infrastructure types. Click the tile for the type of infrastructure where you would like to install the OpenShift Container Platform. Some cloud providers support Installer-Provisioned Infrastructure, which installs OpenShift Container Platform on cloud infrastructure that is automatically provisioned by the Cluster Manager. For other cloud providers and infrastructure types, a cluster can be installed on User-Provisioned Infrastructure.

Select your preferred infrastructure type and choose either `Installer-Provisioned Infrastructure` or `User-Provisioned Infrastructure`, and then follow the instructions that are displayed.

For any of the User-Provisioned Infrastructure types, including the “Bare Metal” tile, you are presented with a short series of steps to follow. For detailed installation instructions, you can click the “Get Started” link to open the official installation documentation. For the “Bare Metal” infrastructure type, see the documentation: https://docs.openshift.com/container-platform/4.2/installing/installing_bare_metal/installing-bare-metal.html.

1. Download the OpenShift installer by using the link provided by the Cluster Manager website. These files are accessible directly over the internet, and do not require a Red Hat ID to download.
2. Download or copy your OpenShift pull secret. This step requires you to be logged in with a Red Hat ID but does not require a paid subscription.
3. Download Red Hat Enterprise Linux CoreOS (RHCOS) by using the link provided by the Cluster Manager website. These files are accessible directly over the internet, and do not require a Red Hat ID to download.
4. Download the OpenShift Command Line Tools (openshift-install) by using the link that is provided by the Cluster Manager website and add them to your PATH. These files are accessible directly over the internet, and do not require a Red Hat ID to download.
5. Follow the official documentation for your infrastructure type to complete the installation by using the openshift-install command. When the installer is complete, you see the console URL and credentials for accessing your new cluster. A kubeconfig file is also be generated for you to use with the oc CLI tools you downloaded.

<img src="red-hat-install.png" alt="Describes accessing binaries for manual installation from IBM Passport Advantage">

## Optional: accessing Red Hat Enterprise Linux installation binaries

RHCOS is the only supported operating system for OpenShift Container Platform master node hosts. RHCOS and RHEL are both supported operating systems for OpenShift Container Platform worker node hosts, though RHCOS is the default. If you prefer to use Red Hat Enterprise Linux (RHEL) as the operating system for the worker node hosts, you need to download the RHEL installation binary files separately, as they are not available to download without paid entitlement.

The preferred method of accessing and installing RHEL is to follow the standard installation documentation from Red Hat and register your systems by using your Red Hat Network subscription. Installation binary files, documentation, and entitlement information can all be accessed from the Red Hat Customer Portal at https://access.redhat.com. If you are new to the Red Hat Customer Portal, click *Getting Started* after you log in (or use this link: https://access.redhat.com/start/) to take a guided tour and learn how to get the most out of your Red Hat subscription.

## Preferred method for accessing RHEL: By using the Red Hat Customer Portal

### Accessing installation binary files through the Red Hat Customer Portal

After your Cloud Pak order has been processed, you will receive an email from Red Hat at the address that is associated with your order. This email lists the entitlement quantities for your Red Hat OpenShift Container Platform and subscription has been updated.

### Installing Red Hat Enterprise Linux

OpenShift Container Platform 4.2 is supported on Red Hat Enterprise Linux 7.6 or later. If you do not already have Red Hat Enterprise Linux installed, use the following documentation to complete the installation of Red Hat Enterprise Linux.

Red Hat Enterprise Linux 7.7 installation media can be accessed through the Red Hat Customer portal at https://access.redhat.com/downloads/content/69/ver=/rhel---7/7.7/x86_64/product-software

Instructions for downloading and installing Red Hat Enterprise Linux 7, including registering your installation by using Subscription Manager, can be found in the Red Hat Customer Portal at: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/chap-getting-started

### Installing Red Hat OpenShift Container Platform

Once you have successfully provisioned hosts or virtual machines with Red Hat Enterprise Linux installed and registered, proceed to install OpenShift Container Platform 4.2 by following the documentation provided in the Red Hat Customer Portal: https://access.redhat.com/documentation/en-us/openshift_container_platform/4.2/html-single/installing/index

## Alternate Method for accessing RHEL: By using IBM Passport Advantage

### Accessing binary flies for manual installation from IBM Passport Advantage

If you require the ability to install the Cloud Pak before your entitlements have been updated in the Red Hat Customer Portal, all of the binary files necessary to install Red Hat OpenShift Container Platform and Red Hat Enterprise Linux CoreOS are available for download by using a freely available Red Hat ID as described earlier. These binary files are not available for download from IBM Passport Advantage.

If you choose to install Red Hat Enterprise Linux as the host operating system on your worker nodes before and do not yet have an active Red Hat subscription, Red Hat Enterprise Linux 7.7 is accessible through IBM Passport Advantage. Installation images and RPMs for Red Hat Enterprise Linux 7.7 can be downloaded from IBM Passport Advantage (Part number CC4KJEN), which is part of your Cloud Pak eAssembly.) This file has the description “IBM Red Hat Enterprise Linux English only eImage” in IBM Passport Advantage. This installation is required to be registered and associated with your Red Hat Network ID later.

The download is approximately 50 GB, and extra storage is required when you extract the files.

This manual installation process requires the creation of a local HTTP server to host the RPM files that are provided in the mentioned download package. These steps are not required when you use the preferred installation method, since that scenario enables access to the necessary files through Red Hat Network.

To perform a manual installation, follow this procedure:

1. Download the Red Hat Enterprise Linux installation files from Passport Advantage (if you don’t already have Red Hat Enterprise Linux installed)
2. Provision a web server to host a Yum repository
3. Copy the downloaded files to the web server
4. Install Red Hat Enterprise Linux on the worker nodes
5. Install OpenShift Container Platform by using the official documentation

### Download the Red Hat Enterprise Linux installation files from Passport Advantage

Log in to IBM Passport Advantage and download “IBM Red Hat Enterprise Linux English only eImage” (part number CC4KJEN), which is associated with the Cloud Pak eAssembly. The file name to download is `IBM_RED_HAT_ENTERPRISE_LINUX_ENGLISH.tgz`.

### Provision a web server to host a Yum repository

Provision a physical host or virtual machine with an HTTP server to support the local installation. You can use the web server of your choice as the repository.

If you do not have a web server available, you can install and configure the Apache web server on a Red Hat Enterprise Linux system by using the documentation that is provided by Red Hat under the heading “Prepare and populate the repository server”: https://docs.openshift.com/container-platform/3.11/install/disconnected_install.html#disconnected-repo-server

### Copy the downloaded files to the web server

Copy `IBM_RED_HAT_ENTERPRISE_LINUX_ENGLISH.tgz` to the web server and extract it into a subdirectory named “repos” under your web server’s document root (/var/www/html/repos if you have created a web server by using the documentation).

Ensure that the repository files can be read by any user (chmod -R +r /var/www/html/repos).

## Install Red Hat Enterprise Linux on the worker nodes

If you don’t already have Red Hat Enterprise Linux installed, provision the hosts or VMs that are used for the master and worker nodes for the OpenShift Container Platform cluster where you install the Cloud Pak, and install Red Hat Enterprise Linux by using the ISO downloaded from IBM Passport Advantage.

Complete instructions for downloading and installing Red Hat Enterprise Linux, including prerequisites and host preparation, can be found in the Red Hat Customer Portal at: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/chap-getting-started

* An ISO image of the installation media (rhel-server-7.7-x86_64-dvd.iso) can be found in the directory where you extracted the file that is downloaded from IBM Passport Advantage. Use these files in place of steps in Chapter 2 of the Red Hat Enterprise Linux installation guide that describe downloading Red Hat Enterprise Linux from the Red Hat Customer Portal. If you are creating virtual machines to provision your nodes, this image can be used directly.
* If you are installing Red Hat Enterprise Linux on a physical host, refer to Chapter 3 of the Red Hat Enterprise Linux installation guide for information on creating physical installation media or accessing installation media over a network: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/chap-making-media

### Install Red Hat OpenShift Container Platform by using the official documentation

Follow the documentation provided by Red Hat to install OpenShift Container Platform 4.2: https://access.redhat.com/documentation/en-us/openshift_container_platform/4.2/html-single/installing/index
