---
permalink: /create_builds
title: "Create a build for a new version"
---

# Create a build for a new version

Learn more about creating a build for a new version in Pantheon.

## Prerequisites

You must have the following 

* Minimum KCS1 access to the Customer Portal and Pantheon
* Connection to the VPN
* Logged in to the Customer Portal
* Logged in to the Pantheon UI

## Creating a build

Complete the following steps:

1. Create a new branch in the [rhacm-docs repository](https://github.com/open-cluster-management/rhacm-docs) for the new version. For example, 2.3_stage.

2. Navigate to the [`modules/common-attributes.adoc`](https://github.com/open-cluster-management/rhacm-docs/blob/2.3_stage/modules/common-attributes.adoc) to change the version for the `:product-version:` field.

3. Create a new branch for the new version in [GitLab](https://gitlab.cee.redhat.com/red-hat-enterprise-openshift-documentation/advanced-cluster-management/-/tree/2.3), if it is not already there. Ex. `2.3`. You can create it from the branch from the previous version. 

   1. Open the branch for the previous version.
   2. Select **+** > **New branch**. 
   3. Name it the new version number. For example, name the branch _2.3_. 
   
   **Alternatively**: You can run the build script with the new version number to create a branch in GitLab. For more information about running the build, see [Build and publish](https://github.com/open-cluster-management/rhacm-docs/blob/gh-pages/_pages/arch_builds.md).

4. Log in to Pantheon.

5. Select all of the books. Select **Bulk actions** > **Clone**. The configuration of the build is also cloned.

   * You can create a new title manaually. Complete the following steps to create a new title in Pantheon: 

     1. Select **Set up new title**. 
     2. Select to set one up from an existing repository.
     3. Fill in the following fields to configure the new title:
        - Version: `<NewVersion>`
        - GitLab Group: `Documentation: Red Hat OpenShift Enterprise`
        - GitLab Project: `Red Hat Advanced Cluster Management for Kubernetes`

6. Click the drop-down arrow in the _Stage_ row of a specific book.

7. Click **Edit configuration** for each book in Pantheon to reference the new version.

8. Disable the preview feature by clicking the drop-down arrow in the _Preview_ row. Select **Disable Job**.  

9. Add the directory path to the `crontab` file for the new version.
 
   1. Move your cursor to where you need to add the directory path.
   2. Type the `i` key to go into insert mode.
   3. Add the directory path. Your path might resemble the following: `0 0 * * 0 /root/sync/acm_sync_asciidoc.sh 2.3 2.3_stage > /root/sync/2.1_acm_cron_log`
   4. Press the `esc` key to leave insert mode.
   5. Enter `:wq` to close the `crontab` file
