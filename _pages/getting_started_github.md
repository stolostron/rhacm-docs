---
layout: page
title: GitHub
permalink: /getting_started_github
horizontal: false
---

Our documentation source code resides in a GitHub repository. We use the Git control system to manage that repository. The following quick guide will help you get started with GitHub and Git, but for more information, please see the following resoruces:

- [GitHub documentation](https://docs.github.com/)
- [Git documentation](https://git-scm.com/doc)

## Prerequisites

Review the Playbook first to understand general ACM processes, which includes some GitHub and agile practices.

## Set up GitHub

You can use your personal GitHub account if you want, but all of our team members have switched to using GitHub accounts tied to their Red Hat emails by now. When you create a new GitHub account or switch computers, you must set up a new SSH key. See [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) for more information.

## Common GitHub terms

- **Issue:** This is a work item (RTC-lingo), or a ticket (support lingo). An issue is required for doc work or major decisions.

- **Branch:** Basically a copy of the doc where you apply the changes. Branches named **prod** or **stage** are set as the branches that are published at GA or for a refresh. Never work based off the production branch. We always work in staging, then copy the changes over to production when we schedule a refresh.

For example, if you want to work on 2.9, you need to check out `2.9_stage` by running `git checkout`, run `git pull` to get the latest changes that were committed by the team, then checkout your own branch by running `git checkout -b`. If you do not run `git pull` before you check out your branch, you don't have the most recent copy of the branch. Then, for the refresh, we create a pull request (PR) to add the new content from `2.9_stage` to `2.9_prod`.
  
- **Pull request:** Since you opened your own branch, `<my-branch>`, against the staging branch, you must create a pull request to get your changes into the `<_stage>` branch (think of it as pulling in changes on staging from your branch).
  
- **Commit:** Used as a verb, or noun. When you apply changes, you are committing to your branch. A commit is your change.
  
- **Repository:** Where the source code, branches, and history live. The repository (repo) contains all the branches.

## Editing
   
For quick changes you can create branches and edit code on the GitHub website, but for most of the work we do, you are going to want to use Visual Studio Code or a similar code editor with built-in GitHub support.

## Common commands

Git refers to the Git CLI. See [Here are all the Git commands I used last week, and what they do](https://www.freecodecamp.org/news/git-cheat-sheet-and-best-practices-c6ce5321f52/) for some details on frequently used commands. We regularly use the following commands:

- `git branch`: Check which branch you are currently on. 
- `git pull`: Download the latest updates for the branch you are currently on.
- `git checkout`: Switch to an existing branch.
- `git checkout -b <name>`: Create and switch to a new branch.
   **Note:** Start the branch with a letter, not an integer. You can name the branch anything you like, but a useful template is `initials-platform-issue-version number`.
- `git add .`: Add the changes you made in the editor to your branch. 
- `git commit -m "<description-jira#>"`: Commit your changes you made in the editor to your branch. 
- `git push --set-upstream origin <name>`: Push your new branch.
- `git push`: Push your changes upstream.
   **Note:** You must create PRs from the GitHub website after pushing your branch.

Remember, we try to keep our process simple, streamlined, and efficient. Git has many powerful and potentially dangerous commands. Our motto is:

_We git pull, git add, git commit, and git push. We don't git crazy._

## BFG Repo-Cleaner

If you commit sensitive information, let your manager know and run [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/). Remember, everything you commit is saved in the repo history.
