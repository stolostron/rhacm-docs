---
permalink: /publish_builds
title: "Build and publish"
---


# Build and publish

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
  

## Confirm build branch

You want to make sure you are building the branch that you need.

1. Open your terminal and run the following command to sign in:

   ```
   ssh root@oseccs.bne.redhat.com
   ```

2. Enter the following password: 

   ```
   see team for pw!
   ```
   
3. Run the following command to open the `crontab` file to verify the branch you want to build:

   ```
   crontab -e
   ```
   
   The file is opened in the vi editor. Your `crontab` might resemble the following content:
   
   ```
   20 */4 * * * /root/sync/sync.sh 4.3 > /root/sync/4.3_cron_log
   10 */3 * * * /root/sync/sync.sh 4.4 > /root/sync/4.4_cron_log
   0 * * * * /root/sync/sync.sh 4.5 > /root/sync/4.5_cron_log
   0 0 * * 0 /root/sync/acm_sync.sh 1.0 doc_prod> /root/sync/1.0_acm_cron_log
   0 0 * * 0 /root/sync/acm_sync_asciidoc.sh 2.0 2.0_stage > /root/sync/2.0_acm_cron_log
   0 0 * * 0 /root/sync/acm_sync_asciidoc.sh 2.1 2.1_stage > /root/sync/2.1_acm_cron_log
   0 */12 * * * /root/sync/sync_moa.sh 4.3 > /root/sync/moa_4_cron_log
   0 0 * * 0 /root/sync/sync_aro.sh 4.3 > /root/sync/aro_4_cron_log
   ```
   
4. If the selected branch is not the one that you want to build (for example, the line is `0 0 * * 0 /root/sync/acm_sync_asciidoc.sh 2.1 2.1_stage > /root/sync/2.1_acm_cron_log`), change it to the one that you want. 

For example, use the following process to choose `2.1_prod`: 

  1. Move your cursor to the beginning of `stage` in the branch name of the entry (2.1_stage). 
  2. Use the `x` key to delete the characters in `stage`.
  3. Type the `i` key to go into insert mode.
  4. Insert `prod` where you just removed `stage`.
  5. Press the `esc` key to leave insert mode. 

5. Enter `:wq` to save the `crontab` file and close it. 
   
6. Continue with _Run a build_.

## Run a build

Use this process to refresh a public version or build internally.

1. Run the following command to sign in, if you are not already connected from the previous procedure:

   ```
   ssh root@oseccs.bne.redhat.com
   ```

2. Enter the following password, if you are not already connected from the previous procedure: 

   ```
   see team for pw!
   ```

3. Run the following to change your directory: 

   ```
   cd /root/sync/
   ```

4. Run the following command, where `X.X doc_branch` is the version number and either `stage` for daily work, or `prod` for a live refresh. 

   **Note:** Be sure to verify your branch in the `crontab` file matches the branch you are building. See the _Confirm build branch_ section to complete this task if you have not already.

   ```
   ./acm_sync_asciidoc.sh <X.X X.X_branch>
   ```
   Example:

   ```
   ./acm_sync_asciidoc.sh 2.1 2.1_stage 
   ```
   
5. When the build output says `"DONE"`, the commit number and branch are displayed. Take note of the last commit number that is listed (in this case, `5bfee54`). See the following example:

   ```
   + 81781d5...5bfee54 2.1_stage -> 2.1 (forced update)
   ```

6. Open the Pantheon UI that lists the books for the release that you are building. 

7. Confirm that the commit number that you noted in step 5 is listed for each book (in this example, `5bfee54`). If you see a different commit #, Pantheon might not have the latest build. Select the drop-down arrow, then select **Rebuild** for each book that needs the updated commit. You can also do this from _Bulk actions_. 

   You can now check for failures and review logs, if needed.

8. **Important** Only if you are publishing live. After all of the builds for the books are clean and the commits match your build, you are ready to publish. See the following steps to _Publish a GA version_.

## Publish a GA version
   
1. When you have completed all of the previous steps for the `prod` branch of your release, you can publish by selecting **Publish** for each book on Pantheon.

**Note:** If the publish button is grayed out, make sure that you are logged in to Pantheon. 

2. Verify that the commits on the Pantheon UI all match for stage and prod. That means that you pushed all of the latest files that resulted from your last build. 
