---
permalink: /arch_builds
title: "Portal refreshes"
---

We refresh weekly.

After you get all the access that you need, you can refresh by following these steps:  

## Prerequisites

(Maybe prereqs/access info here)

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
   
3. Run the following command to open the crontab file, which is where you indicate which branch you will build:

   ```
   crontab -e
   ```
   The file is opened in the vi editor.
   
4. Ensure that the line that contains the release that you are building has the correct branch on it. For example, if you want to build the 2.1_prod branch for a refresh, the line should read: 
   ```
   0 0 * * 0 /root/sync/acm_sync_asciidoc.sh 2.1 2.1_prod > /root/sync/2.1_acm_cron_log
   ```
   
5. If the branch is not the one that you want to build (for example, the line is `0 0 * * 0 /root/sync/acm_sync_asciidoc.sh 2.1 2.1_stage > /root/sync/2.1_acm_cron_log`), change it to the one that you want. 
  1. Move your cursor to the beginning of `stage` in the branch name of the entry (2.1_stage). 
  2. Use the `x` key to delete the characters in `stage`.
  3. Type the `i` key to go into insert mode.
  4. Insert `prod` where you just removed `stage`.
  5. Press the `esc` key to leave insert mode. 

6. Enter `:wq` to save the `crontab file and close it.
   
7. Continue with "Run a build".

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

4. Run the following command, where `X.X doc_branch` is the version number and either `stage` for daily work, or `prod` for a live refresh or stage build. **Note:** The branch setting here must match the branch setting that is set in the `crontab` file. See the "Confirm build branch" section for information about how to verify or change this. For example, if the branch in the `crontab` file for your release is set to `2.1_prod`, then your branch in this command must be `2.1_prod`.   

   ```
   ./acm_sync_asciidoc.sh <X.X X.X_branch>
   ```
   Example:

   ```
   ./acm_sync_asciidoc.sh 2.1 2.1_stage 
   ```
   
5. When the build indicates that it is finished, there should be two sets of character strings separated by periods in the line before the line that says "DONE". These are commits that it created to do the build. Make a note of the last one that is listed (in this case, `5bfee54`). A sample of this line looks like this:
```
+ 81781d5...5bfee54 2.1_stage -> 2.1 (forced update)
```

6. Open the Pantheon UI that lists the books for the release that you are building. 

7. Confirm that the number that is listed beside the stage line for each book matches the commit number that you noted in step 5 (in this example, `5bfee54`). If it does not, then Pantheon (a different build) has not rebuilt with the new content. It should rebuild automatically by Pantheon, but sometimes it doesn't. If it doesn't, select the down arrow beside the stage version of the book select **Rebuild**. You might have to do this with several of the books. 

8. After all of the stage commits for the books are clean and match the commit from when you built, you are ready to publish if you want to refresh the live site. Continue with "Publish a GA version".

## Publish a GA version
   
1. When you have completed all of the previous steps for the `prod` branch of your release, you can publish by selecting **Publish** beside each book on the Pantheon UI. We do not publish the `*.stage` branches live. **Note:** If the publish button is grayed out, make sure that you are logged in to Pantheon. 

2. Verify that the commits on the Pantheon UI all match for stage and prod. That means that you pushed all of the latest files that resulted from your last build. 
