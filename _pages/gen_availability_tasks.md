---
layout: page
title: General availability tasks
permalink: gen_availability_tasks
horizontal: false
---

These directions walk you through preparing for the release and tasks for GA day. Ideally this is done by a strategist/architect or a lead with a big-picture view of the doc, but as long as a teammate has rights, they can go through these procedures.

- [Prerequisites](#prerequisites)
- [Tasks to complete early staging](#tasks-to-complete-early-staging)
- [Preparing for _Pencils Down_](#preparing-for-pencils-down)
- [Creating `production` branch from `stage`](#creating-production-branch-from-stage)
- [Publishing doc and splash page](#publishing-doc-and-splash-page)
- [Publishing support matrices](#publishing-support-matrices)
- [Request support matrix link update on product page](#request-support-matrix-link-update-on-product-page)
- [Additional required tasks](#additional-required-tasks)

## Prerequisites

You must have the following prerequisites to publish live:

- Minimum KCS1 access to the Customer Portal and Pantheon
- Connection to the VPN
- Logged in to the Pantheon UI 
- Feature doc and release work is completed for GA

## Tasks to complete early staging

In addition to the release work, the lead or the strategist must follow up on general tasks each release before GA. **Best practice:** Open a story on the Documentation component to track along side the dev stories. Add your story as "Related to" the Release Manager's Release Epic. Attach issues to your story that can be shared if needed for the following tasks (you can combine similar tasks in one issue):

1. Remove old _What's new_ entries so that the team can start over for the new release.
2. Remove deprecation and removal items that are older than staged-N minus two (the squads help with this via the cross-squad issue).
3. Clean the Errata release notes to only have the intro (both MCE and ACM).
4. Update link versions for OCP. (Currently we use the earliest of N-2, unless the feature is built on a later OCP. See PM for guidance. If this changes, we need to change the note we added about this.)
5. Update any other versions, such as channel, RHEL, etc.... Get guidance from a tech lead on this.
6. Change support matrix links in the doc and on the Splash Page.
7. If something went EOL, ensure the latest doc reflects those changes. See _Deprecating and removing_ for that guidance.
8. Work with console focal and engineers to ensure links in the console have not changed. You will need to know the deadline for code changes from the UI team.

## Preparing for _Pencils Down_

At some point the team agrees to a _Pencils Down_ date, which may move depending on the product release. Close to that date, start preparing.

1. Ensure the build is regularly green. Ask writers fix any errors for their books a few days before GA and work to keep the build green closer to the agreed upon _Pencils Down_ day.
2. Ask the team to work on reconciling the changes and merging active PRs to the stage branch. Since this depends on reviews and such, the PR list may not be clear in time, but no PRs for stage is the goal for _Pencils Down_.
3. Declare _Pencils Down_ on the date/time so that the team pauses any pushing to stage.
4. Build stage. Check for green. Fix any errors.

## Creating `production` branch from `stage` 

Now that stage branch is finalized and green, you can create the production branch from the stage branch. See [Branch Strategy](branch_strategy.md) for important information about how and why we use these branches.

1. Create the new <release_number>_prod branch from the <release_number>_stage branch.
2. Protect the branch to keep anyone from bypassing rules in the production branch. Two users are needed to push stage into to prod: The creator and the reviewer. Go to **Settings** > **Branches**. (Because GitHub changes the UI at times, if this is not the workflow, you can simply Google something like "how to protect my branch in GitHub" for the process.)
3. Select **Add rule** in the _Branch protection_ rules section. 
4. Add the branch name to the **Branch name pattern**. Example: `2x_prod`. 
5. Select **Require a pull request before merging**. 
6. Ensure that **Require approvals** is selected. 
7. Select **Do not allow bypassing the above settings** to prevent admins from bypassing this rule. Admins can bypass in `stage` IF needed, but not `prod`.
8. Select **Create** to apply the rule. 
9. Run a build wit the prod branch in the command: `./acm_sync_asciidoc.sh 2.x 2.x_prod`
10. Ensure the build is clean.
11. Stop any builds until GA day and after because `prod` and `stage` are in the same directory. You can return to building stage after you publish.

## Publishing doc and splash page

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

## Publishing support matrices

1. Publish MCE matrix at MCE GA, then update the previous matrix references with the newest version.
2. Publish ACM matrix at ACM GA, then update the previous matrix references with the newest version.
3. Double check that all links work in the documentation.
4. 
## Request support matrix link update on product page

This was something that we had to update but is now handled through an issue with more process attached. 

1. Clone [CPPX-948](https://issues.redhat.com/browse/CPPX-948) and update the version numbers. This example was used for version 2.12. 
2. Request an update to the Support Matrix link on the product page to the new support matrix.
3. Submit the issue. It is usually a very fast turnaround. 

## Additional required tasks

1. Publish the draft(s) for the Support Matrix. There should be an issue for the release that tracked this work. See the strategist or lead. Currently there is a matrix for ACM and MCE. 
2. Edit [Comet](https://comet.engineering.redhat.com/containers/products/5ec54aa3535cb70ab8c02996). (?) <!--check into this; I have not had to do this in a while. Ask Chris about this.-->
3. Add the _Support matrix_ to the [_Lifecycle_ page](https://access.redhat.com/support/policy/updates/advanced-cluster-management).
4. Double check that links to the Support matrix work after you publish.
5. Reach out at the earliest convenience to get the Jira template changed with the following note (or something similar) to **rh-issues@redhat.com:**
   
```
When you create the Jira for the ACM Doc team, you choose the **Documentation** component to see the **Doc template** for requested Customer Portal changes. All issue types would display this template because it is controlled by the component, `Documentation`. Please update the current link with the latest published doc that just went live: `<insert link to landing page for most recent doc>`
```
