---
permalink: /arch_branching
title: "Branching guidelines"
---

## Creating a branch

When you are creating a branch, **start your personal branch with a letter**, such as your initials, so your branch is never confused with a release or staging branch.

For example, a staging branch might be named, `3.2.1_stage`. If you name your own branch for completing install related changes, `3.2.1_changes`, that confuses any developer doing a review in our docs or other writers looking for the `3.2.1` branch.

Instead, consider naming your branch, `install-changes-3.2.1-johnsmith` or `js-3.2.1-install-changes`.

See the following content to learn about how the overall branching strategy works for release and stage branches:

## Why a branch strategy?

- Helps to prevent content from being pushed to the public KC prematurely

- Paves the way for rare, but required, time-sensitive updates without interrupting drafts that sit in stage

- Provides a consistent branch for development PRs (when necessary)

- Overcome the limitation of KC to provide separate servers with the same key

- Follows dev/test/prod principles used in IT

See the GitHub issue: https://github.ibm.com/IBMPrivateCloud/roadmap/issues/18474 for more information.

## Branching: stage, prod, and NLV 

There can be multiple main branches for some releases: 

  * A **staging** branch where daily drafting and updates are completed: Example: 3.2.0-stage
  * A **production** branch, which always contains the live content: Example: 3.2.0-prod
  * An NLV branch is _for the translation focal only_... no one else should ever push to this branch
  
The build focals will refresh content, to avoid confusion. Refreshes require a pull request and approval. In very rare cases, a fix will need to go into both branches if a refresh is required outside of the weekly refreshes. 

Some offerings might not include these branches. Instead only a **master** branch might be used to include the latest approved content: Example: Common services.

### Stage branch

  * Complete all work in this branch. 
  * A snapshot of this branch is taken on Fridays and published on the corresponding branch with our regular Friday refreshes
  * This branch cannot be directly pushed to production
  * Not all releases include a staging branch. For instance ICP 3.2.1, CP4MCM 1.2 use this branch. Older ICP 3.1.x, 3.2.0 releases do not.
  * A snapshot of this branch is taken on Fridays and published on the 3.2.0 branch with our regular Friday refreshes
  * This branch will not be pushed to production
  * Development would submit PRs to this branch if you are working reviews with them
  * This is the branch to use for peer reviews

### Prod branch

  * This is the production branch, so no one works directly in this branch, if a stage branch is used, 
  * Only the build or refresh focals push to this branch for refreshes 
  * The stage branch should always have everything that is in this branch
  * This branch will be overwritten on Fridays with the contents of the stage branch
  * In rare cases, minor critical changes can be made to both this branch and the stage branch (both required if a random refresh is needed), and this can be pushed to production between releases. This is only for quick, high-visibility emergency changes.  
  * Set the highest branch rules here so that draft content is not accidentally published and so that refreshes take place with team discussion. See the following rule examples (found in GitHub branch settings):
    - Require pull request reviews before merging 
    - Enforce all configured restrictions for administrators (this prevents the ability to bypass a merge without one other approval, but this option is not enforced on stage because writers continuously submit to stage and use PRs on new topics or when working in other's component area).
  
Examples: a sev1 security issue, or something that blocks the customer from using the product, opened by support team. See organization's P1 label requirements for more information.

