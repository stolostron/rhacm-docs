---
layout: page
title: Branching strategy
permalink: /arch_branching
horizontal: false
---

An intro paragraph needs to be added here.

## Creating a release `prod` and `stage` branch

When you are ready to start working the new release, use the most recent snapshot of the most recent release to create `XX_stage`. You then need to protect the branch. You want to **require pull requests to merge** so that users outside of the doc team cannot merge changes directly into the release branch. 

When you are ready to create a build, you can create the `XX_prod` from the most recent version of your staged branch. Create the production branch, then add the same protection with an additional protection that **prevents administrator override.** The extra protection prevents one team member from refreshing the documentation without agreement from at least on other team member.

## Creating a branch to work

When you are creating a branch for your work, from the `default` branch,  **start your personal branch with a letter**, such as your initials, so your branch is never confused with a release or staging branch.

For example, a staging branch might be named, `2.8_stage`. If you name your _own_ branch for completing install related changes, `2.8_changes`, that confuses any developer doing a review in our docs, and other writers looking for the `2.8` branch.

Instead, consider naming your branch, `install-bug-3` or `jean-install-bug`. (Using a name makes it easy to see when you have to clean up your own branches.)

See the following content to learn about how the overall branching strategy works for release and stage branches:

## Why a branch strategy?

- Helps to prevent content from being pushed to the public prematurely

- Paves the way for rare, but required, time-sensitive updates without interrupting drafts in `stage`

- Provides a consistent branch for development PRs (when necessary)

- Follows dev/test/prod principles used in DevOps


## Branching: stage and prod

There can be multiple main branches for some releases: 

  * A **staging** branch where daily drafting and updates are completed. The format is <major_release_number>\_stage. Example: 2.8_stage
  * A **production** branch, which always contains the live content. The format is <major_release_number>\_prod.: Example: 2.8_prod

### Stage branch

  * Complete all work in this branch. If you create a branch to prepare a PR, create your branch from this one  
  * A snapshot of this branch is taken on Thursdays (mostly) and published on the corresponding branch with our regular refreshes
  * This branch cannot and will not be directly pushed to production
  * Development would submit PRs to this branch for small updates or during PR reviews
  * This is also the branch to use for peer reviews (new topics, significant changes)

### Prod branch

  * This is the production branch, so no one works directly in this branch
  * The `stage` branch should always have everything that is in this branch
  * This branch will be overwritten on Thursdays with the contents of the `stage` branch
  * In extremely rare cases, minor critical changes can be made to both this branch and the `stage` branch (both required if a random refresh is needed), and this can be pushed to production between releases; only for quick, high-visibility emergency changes
  * Set the highest branch rules here so that draft content is not accidentally published, and so that refreshes take place with team discussion. See the following rule examples (found in GitHub branch settings):
    - Require pull request reviews before merging 
    - Enforce all configured restrictions for administrators (this prevents the ability to bypass a merge without one other approval, but this option is not enforced on stage because writers continuously submit to stage, and use PRs on new topics or when working in other's component area)
  * A release that is not yet live will not have a `prod` branch
  
Examples (rare): a sev1 security issue, or something that blocks the customer from using the product, opened by support team. 

