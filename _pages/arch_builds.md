---
permalink: /publish_builds
title: "Build and publish"
---


# Build, publish, set up local build

We refresh weekly. These directions walk you through a refresh, as well as an internal build to check drafts and error logs in between publish dates.

## Prerequisites

You must have the following prerequisites to publish live:

- Minimum KCS1 access to the Customer Portal and Pantheon
- Connection to the VPN
- Logged in to the Customer Portal
- Logged in to the Pantheon UI 

## PR for live refresh

**Note:** Do not create a PR to the `prod` branch if you are only building `stage` for internal purposes. Move on to the later sections in this case.

You have to get a copy of `stage` to `prod` to refresh live docs. To create the pull request (PR) to refresh live, complete the following steps:

1. Create a PR from `stage` to `prod`. 

2. Get it approved, then merge. If the PR has conflicts, you and the team will have to work through those.

   **Note:** If you are publishing a previously staged version for GA, you will need to create the `prod` branch first. You will only have stage because you have not yet published the version.
  
## Run a build

Use this process to refresh a public version or build internally.

1. Run the following command, where `X.X doc_branch` is the version number and either `stage` for daily work, or `prod` for a live refresh. 

   ```
   ./acm_sync_asciidoc.sh <X.X X.X_branch>
   ```
   Example:

   ```
   ./acm_sync_asciidoc.sh 2.4 2.4_stage 
   ```
   
2. When the build output says `"DONE"`, the commit number and branch are displayed. Take note of the last commit number that is listed (in this case, `5bfee54`). See the following example:

   ```
   + 81781d5...5bfee54 2.4_stage -> 2.4 (forced update)
   ```

3. Open the Pantheon UI that lists the books for the release that you are building. 

4. Confirm that the commit number that you noted in step 5 is listed for each book (in this example, `5bfee54`). If you see a different commit #, Pantheon might not have the latest build. Select the drop-down arrow, then select **Rebuild** for each book that needs the updated commit. You can also do this from _Bulk actions_. 

   You can now check for failures and review logs, if needed.

5. **Important** Only if you are publishing live. After all of the builds for the books are clean and the commits match your build, you are ready to publish. See the following steps to _Publish a GA version_.

## Publish a GA version
   
1. When you have completed all of the previous steps for the `prod` branch of your release, you can publish by selecting **Publish** for each book on Pantheon.

**Note:** If the publish button is grayed out, make sure that you are logged in to Pantheon. 

2. Verify that the commits on the Pantheon UI all match for stage and prod. That means that you pushed all of the latest files that resulted from your last build.

## Set up local build

To build locally:

1. Log on to the VPN.
2. Install homebrew, if you don't already have it installed.
3. Find and download the build script is located in the master branch at: https://gitlab.cee.redhat.com/red-hat-enterprise-openshift-documentation/advanced-cluster-management: acm_sync_asciidoc.sh. We are assuming it went to the `Downloads` folder.
5. Change to the folder you chose, in this case, the `Downloads` folder: `cd ~/Downloads`
6. Make the script executable by entering: `chmod +x acm_sync_asciidoc.sh`
7. Check for `gsed` install, or install if needed.
8. Edit the script in an editor to change the 3 instances of `sed` to `gsed`. (They are on lines 67, 70, and 73. This is required for running it on a Mac.) 
9. Save the changes to the file.
10. Run the file with the following command: `./acm_sync_asciidoc.sh 2.3 2.3_stage`. **Note:** The first number is the GitLab branch number (which corresponds to our release number). The second number is our github branch. Both prod and stage go to the same Gitlab branch.
11. Enter your github password when prompted.
12. Enter your gitlab password, if you have one. Since we use SAML, we probably don't. In that case, enter your SSH keys into GitLab. Find your SSH, for example:
    `vi /Users/cdawson/.ssh/id_rsa.pub`:
    
     - Copy the key.
     - Open GitLab.
     - Open your profile.
     - Select SSH keys in the left nav.
     - Paste the key and select Add key. 
     - Try running the file again.
  
When the file runs successfully, it should look similar to what you saw on the server, with the commits. Pantheon should update automatically, and match the commit number here, as it does when you use the server. This may take a few minutes, so keep your commit number.
