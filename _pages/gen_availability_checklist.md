---
layout: page
title: General availability checklist
permalink: gen_availability_checklist
horizontal: false
---

These directions walk you through preparing for the release and getting ready to publish.

## Prerequisites

You must have the following prerequisites to publish live:

- Minimum KCS1 access to the Customer Portal and Pantheon
- Connection to the VPN
- Logged in to the Pantheon UI 

## Preparing for _Pencils Down_

At some point the team agrees to a _Pencils Down_ date, which may move depending on the product release. Close to that date, start preparing.

1. Ensure the build is regularly green. Ask writers fix any errors for their books a few days before GA and work to keep the build green closer to the agreed upon _Pencils Down_ day.
2. Ask the team to work on reconciling changes and merging active PRs to the stage branch. Since this depends on reviews and such, the PR list may not be clear in time, but no PRs for stage is the goal for _Pencils Down_.
3. Declare _Pencils Down_ on the date/time so that the team pauses any pushing to stage.
4. Build stage. Check for green. Fix any errors. 

## Creating the `production` from `stage` 

Now that stage is finalized and green, you can create the production branch from the stage branch. See [Branch Strategy](branch_strategy.md) for imporation information about how and why we use these branchs.

1. Create the new <release_number>_prod branch from the <release_number>_stage branch.
2. Protect the branch to keep anyone from bypassing rules in the production branch. Two users are needed to push stage into to prod: The creator and the reviewer. Go to **Settings** > **Branches**. (Because GitHub changes the UI at times, if this is not the workflow, you can simply Google something like "how to protect my branch in GitHub" for the process.)
3. Select **Add rule** in the _Branch protection_ rules section. 
4. Add the branch name to the **Branch name pattern**. Example: `2x_prod`. 
5. Select **Require a pull request before merging**. 
6. Ensure that **Require approvals** is selected. 
7. Select *Include administrators*. 
Select *Create* to apply the rule. 
Run a build using the new prod branch to verify that it is working ok: ./acm_sync_asciidoc.sh <release_number> _prod
Ensure the build is clean. 
Make sure nobody builds anymore until after GA.


1. Create a PR from `stage` to `prod`. 

2. Get it approved, then merge. If the PR has conflicts, you and the team will have to work through those.

   **Note:** If you are publishing a previously staged version for GA, you will need to create the `prod` branch first. You will only have stage because you have not yet published the version.
  
## Run a build

Use this process to refresh a public version or build internally.

1. Run the following command, where `X.X doc_branch` is the version number and either `stage` for daily work, or `prod` for a live refresh. 

   ```
   ./acm_sync_asciidoc.sh <X.X> <X.X_branch>
   ```
   Example:

   ```
   ./acm_sync_asciidoc.sh 2.9 2.9_stage 
   ```
   
2. When the build output says `"DONE"`, the commit number and branch are displayed. Take note of the last commit number that is listed (in this case, `9ce7819`). See the following example:

   ```
   + e7cd514...9ce7819 2.9_stage -> 2.9 (forced update)
   ```

3. Open the Pantheon UI that lists the books for the release that you are building. 

4. Confirm that the commit number that you noted in step 5 is listed for each book (in this example, `9ce7819`). If you see a different commit #, Pantheon might not have the latest build. Select the drop-down arrow, then select **Rebuild** for each book that needs the updated commit. You can also do this from _Bulk actions_. 

   You can now check for failures and review logs, if needed.

5. **Important** Only if you are publishing live. After all of the builds for the books are clean and the commits match your build, you are ready to publish. See the following steps to _Publish a GA version_.

## Publish a GA version
   
1. When you have completed all of the previous steps for the `prod` branch of your release, you can publish by selecting **Publish** for each book on Pantheon.

**Note:** If the publish button is grayed out, make sure that you are logged in to Pantheon. 

2. Verify that the commits on the Pantheon UI all match for stage and prod. That means that you pushed all of the latest files that resulted from your last build.

## Set up local build

Make sure you are connected to the VPN and have [Homebrew](https://brew.sh/) installed before completing the following steps to build locally:

1. Download the build script to a folder of your choice from the master branch at: 

   ```
   https://gitlab.cee.redhat.com/red-hat-enterprise-openshift-documentation/advanced-cluster-management/-/blob/master/acm_sync_asciidoc.sh
   ```

2. Change to your chosen directory. For example, the following command switches to the _Documents_ folder:

   ```
   cd Documents
   ```

3. Make the script executable by running the following command:

   ```
   chmod +x acm_sync_asciidoc.sh
   ```

4. Install gsed by running the following command:

   ```
   brew install gnu-sed
   ```

5. Add your SSH key to your GitLab account. You can find the link to GitLab on Rover Apps. If you have already set up your GitHub account, you have a SSH key. To find it, see [Checking for existing SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys). If you need to create a new key, see [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

   Then, complete the following steps to use your SSH key for your GitLab account:
   - Copy the key.
   - Open GitLab.
   - Open your profile.
   - Select **SSH Keys** in the left nav.
   - Paste the key and select **Add key**.   
      
6. Run the file with the following command to build 2.9:

   ```
   ./acm_sync_asciidoc.sh 2.9 2.9_stage
   ```

   **Note:** The first number is the GitLab branch number (corresponds to our release number). The second number is our GitHub branch. Both prod and stage go to the same GitLab branch.

7. When running the script for the first time after adding your SSH key to GitLab, you might receive an error resembling the following message:

   ```
   The authenticity of host can't be established.
   Are you sure you want to continue connecting (yes/no/[fingerprint])?
   ```

   - Enter `yes` and continue.
   - You might receive an access rights error message. Ignore the message and run the script again. If you have the correct access rights, the script runs successfully. If not, contact your manager to gain access rights.
  
Pantheon updates automatically and matches the commit number. If Pantheon does not update automatically, you can manually refresh individual books.

## Resolve error `zsh: permission denied`

Running step 7 from the [Set up local build](#set-up-local-build) topic results in the error `zsh: permission denied` if the correct permissions are not set up. To solve the issue, complete the following steps:

1. Give the terminal full write access to the disk.
2. Run the following command after filling in your username and the correct path to the acm_sync_asciidoc.sh file:
   
   ```
   sudo chown -R username/path-to-file
   ```
   
3. Run the following command:

   ```
   chmod +x acm_sync_asciidoc.sh
   ```
