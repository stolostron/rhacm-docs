---
layout: page
title: Create builds for a new version
permalink: /create_builds
horizontal: false
---

Learn more about creating a build for a new version in Pantheon.

## Prerequisites

You must have the following:

* Minimum KCS1 access to the Customer Portal and Pantheon
* Connection to the VPN
* Logged in to the Customer Portal
* Logged in to the Pantheon UI

## Creating a build

Complete the following steps:

1. Create a new branch in the [rhacm-docs GitHub repository](https://github.com/open-cluster-management/rhacm-docs) for the new version. For example, 2.8_stage. For more information, see [Creating a branch](https://github.com/open-cluster-management/rhacm-docs/blob/gh-pages/_pages/arch_branching.md).

2. Navigate to the [`modules/common-attributes.adoc`](https://github.com/open-cluster-management/rhacm-docs/blob/2.3_stage/modules/common-attributes.adoc) that is in your new branch to change the version for the `:product-version:` field. This value is used during the build process, and must be updated to your new version for the build to work. 

3. Create a new branch for the new version in [GitLab](https://gitlab.cee.redhat.com/red-hat-enterprise-openshift-documentation/advanced-cluster-management/-/tree/2.7), if it is not already there. Ex. `2.7`. You can create it from the branch from the previous version. 

   1. Open the branch for the previous version.
   2. Select **+** > **New branch**. 
   3. Name it the new version number. For example, name the branch _2.7_. **Note**: Do not include the `_stage` in this branch name, as you did with the GitHub branch.  
   
   **Alternatively**: You can run the build script with the new version number to create a branch in GitLab. For more information about running the build, see [Build and publish](https://github.com/open-cluster-management/rhacm-docs/blob/gh-pages/_pages/arch_builds.md).

4. Log in to Pantheon.

5. Select all of the books. Select **Bulk actions** > **Clone**, then enter the new version. The configuration of the build is also cloned.

   * Alternatively, you can create a new title manually. Complete the following steps to create a new title in Pantheon: 

     1. Select **Set up new title**. 
     2. Select to set one up from an existing repository.
     3. Fill in the following fields to configure the new title:
        - Version: `<NewVersion>`
        - GitLab Group: `Documentation: Red Hat OpenShift Enterprise`
        - GitLab Project: `Red Hat Advanced Cluster Management for Kubernetes`
        - Select your new version branch from the drop-down menu for the stage version. 
        - Select any other version branch from the drop-down menu for the preview version. We do not use this version, and an error occurs if you select the same version for both fields. 

6. After the books are cloned, update the version in each book:
    
    1. Click the drop-down arrow in the _Stage_ row of a specific book.
    2. Click **Edit configuration**.
    3. Set the version of the configuration to your new version.
    4. Change the default setting for each book from **Use default content directory** to the actual name of your folder in _Content Directory_.
    5. Repeat these steps for each book in your Pantheon title to reference the new version and correct directory.

7. Disable the preview feature by clicking the drop-down arrow in the _Preview_ row. Select **Disable Job**. We don't use this build.

8. Run the build as you normally would with the new version specified in the command.
