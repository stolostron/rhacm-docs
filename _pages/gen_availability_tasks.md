---
layout: page
title: General availability tasks
permalink: gen_availability_tasks
horizontal: false
---

These directions walk you through preparing for the release and tasks for GA day. Ideally this is done by a strategist/architect or a lead with a big-picture view of the doc, but as long as a teammate has rights, they can go through these procedures.

## Prerequisites

You must have the following prerequisites to publish live:

- Minimum KCS1 access to the Customer Portal and Pantheon
- Connection to the VPN
- Logged in to the Pantheon UI 
- Feature doc and release work is completed for GA

## Preparing for _Pencils Down_

At some point the team agrees to a _Pencils Down_ date, which may move depending on the product release. Close to that date, start preparing.

1. Ensure the build is regularly green. Ask writers fix any errors for their books a few days before GA and work to keep the build green closer to the agreed upon _Pencils Down_ day.
2. Ask the team to work on reconciling the changes and merging active PRs to the stage branch. Since this depends on reviews and such, the PR list may not be clear in time, but no PRs for stage is the goal for _Pencils Down_.
3. Declare _Pencils Down_ on the date/time so that the team pauses any pushing to stage.
4. Build stage. Check for green. Fix any errors. 

## Creating the `production` from `stage` 

Now that stage is finalized and green, you can create the production branch from the stage branch. See [Branch Strategy](branch_strategy.md) for important information about how and why we use these branches.

1. Create the new <release_number>_prod branch from the <release_number>_stage branch.
2. Protect the branch to keep anyone from bypassing rules in the production branch. Two users are needed to push stage into to prod: The creator and the reviewer. Go to **Settings** > **Branches**. (Because GitHub changes the UI at times, if this is not the workflow, you can simply Google something like "how to protect my branch in GitHub" for the process.)
3. Select **Add rule** in the _Branch protection_ rules section. 
4. Add the branch name to the **Branch name pattern**. Example: `2x_prod`. 
5. Select **Require a pull request before merging**. 
6. Ensure that **Require approvals** is selected. 
7. Select **Include administrators** to prevent admins from bypassing this rule. Admins can bypass in `stage` IF needed, but not `prod`.
8. Select **Create** to apply the rule. 
9. Run a build wit the prod branch in the command: `./acm_sync_asciidoc.sh 2.x 2.x_prod`
10. Ensure the build is clean.
11. Stop any builds until GA day and after because `prod` and `stage` are in the same directory. You can return to building stage after you publish.

## Publishing the doc and the splash page

Ideally the architect or strategist is doing this but can be done by the lead, with overall big-picture in mind. See support from the DE/PM about arranging this when needed.

1. Log in to Pantheon.
2. See the _Publish a GA version_ section of [Refreshing builds](refresh_builds.md) and complete the procedure. <!-- we probably need to rename this simply to "Publishing" because it is for GA and refresh.-->
2. Click **Splash Pages** in the navigation to view the splash pages. If you are not logged in to Pantheon, you will not see this item in the navigation.
3. Find the entry for **Red Hat Advanced Cluster Management for Kubernetes**. The entry should show the version of the product that you are pushing, with an `unpublished` label.
4. Click the name of the product to open the splash page. 
5. Add the categories for the documentation and drag the books into the correct categories, if necessary. 
6. When you are ready to publish it, expand **Update/view product status**.
7. Change the _Product status_ from **Unpublished** to **Published**.
8. Click **Save** to save the changes.

## Additional tasks

1. Publish the draft(s) for the Support Matrix. There should be an issue for the release that tracked this work. See the strategist or lead. Currently there is a matrix for ACM and MCE. 
2. Edit [Comet](https://comet.engineering.redhat.com/containers/products/5ec54aa3535cb70ab8c02996). (?) <!--check into this; I have not had to do this in a while. Ask Chris about this.-->
3. Add the _Support matrix_ to the _Lifecycle_ page.
4. Double check that links to the Support matrix work after you publish.
