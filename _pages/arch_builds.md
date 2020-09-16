---
permalink: /arch_builds
title: "Portal refreshes"
---

We refresh weekly.

After you get all the access that you need, you can refresh by following these steps:  

## Prerequisites

You must have the following prerequisites to publish live:
- at minimum KCS1 access to the Customer Portal and Pantheon
- Connection to the VPN
- Logged in to the customer portal
- Logged in to the Pantheon UI

To create the pull request (PR), complete the following steps:

1. If you are refreshing the current published version, create a PR from `stage` to `prod`. Get it approved and merged.

2. If you are pusbishing a staged version for GA, you will need to create the `prod` branch right before you publish.

3. Do not push any PR to `prod` if you are only building `stage`.

## Confirm build branch

1. Run the following command to sign in:

   ```
   ssh root@oseccs.bne.redhat.com
   ```

2. Enter the following password: 

   ```
   redhat1!
   ```
   
3. Run the following command to open the crontab file to verify the branch you want to build:

   ```
   crontab -e
   ```
   
   The file is opened in the vi editor. Your crontab might resemble the following content:
   
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
   
   Close the file when you locate the branch.
   
4. If the branch is not the one that you want to build (for example, the line is `0 0 * * 0 /root/sync/acm_sync_asciidoc.sh 2.1 2.1_stage > /root/sync/2.1_acm_cron_log`), change it to the one that you want. 
  1. Move your cursor to the beginning of `stage` in the branch name of the entry (2.1_stage). 
  2. Use the `x` key to delete the characters in `stage`.
  3. Type the `i` key to go into insert mode.
  4. Insert `prod` where you just removed `stage`.
  5. Press the `esc` key to leave insert mode. 

5. Enter `:wq` to save the `crontab` file and close it.
   
6. Continue with "Run a build".

## Run a build

1. Run the following command to sign in, if you are not already connected from the previous procedure:

   ```
   ssh root@oseccs.bne.redhat.com
   ```

2. Enter the following password, if you are not already connected from the previous procedure: 

   ```
   redhat1!
   ```

3. Run the following to change your directory: 

   ```
   cd /root/sync/
   ```

4. Run the following command, where `X.X doc_branch` is the version number and either `stage` for daily work, or `prod` for a live refresh. 

   **Note:** Be sure to verify your branch in the `crontab` file matches the branch you are building. See the "Confirm build branch" section for information about how to view that file. 

   ```
   ./acm_sync_asciidoc.sh <X.X X.X_branch>
   ```
   Example:

   ```
   ./acm_sync_asciidoc.sh 2.1 2.1_stage 
   ```
   
5. When the build output says `"DONE"` the commit number and branch are displayed. Make a note of the last one that is listed (in this case, `5bfee54`). See the following example:
   ```
   + 81781d5...5bfee54 2.1_stage -> 2.1 (forced update)
   ```

6. Open the Pantheon UI that lists the books for the release that you are building. 

7. Confirm that the commit number that you noted in step 5 is listed beside the stage line for each book (in this example, `5bfee54`). If it does not, select the down arrow beside the stage version of the book select **Rebuild** for each book that requires it. 

   You can review build logs to check for failures.

8. **Important** Only if you are publishing live. After all of the builds for the books are clean and the commits match your build, you are ready to publish. See the following steps to _Publish a GA version_.

## Publish a GA version
   
1. When you have completed all of the previous steps for the `prod` branch of your release, you can publish by selecting **Publish** beside each book on the Pantheon UI. We do not publish the `*.stage` branches live. **Note:** If the publish button is grayed out, make sure that you are logged in to Pantheon. 

2. Verify that the commits on the Pantheon UI all match for stage and prod. That means that you pushed all of the latest files that resulted from your last build. 
