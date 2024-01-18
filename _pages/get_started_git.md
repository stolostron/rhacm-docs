---
layout: page
title: GitHub
permalink: /get_started_git
horizontal: false
---

Our documentation source code resides in a GitHub repository. We use the Git control system (terminal) to manage and update the content. The following quick guide will help you get started with GitHub and Git, but for more information, please see the following resoruces:

- [GitHub documentation](https://docs.github.com/)
- [Git documentation](https://git-scm.com/doc)

## Prerequisites

Review the Playbook first to understand general ACM processes, which includes some GitHub and Agile practices.

## Set up GitHub

You can use your personal GitHub account if you want, but all of our team members have switched to using GitHub accounts tied to their Red Hat emails by now. When you create a new GitHub account or switch computers, you must set up a new SSH key. See [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) for more information.

## Common commands

Git refers to the Git CLI. See [Here are all the Git commands I used last week, and what they do](https://www.freecodecamp.org/news/git-cheat-sheet-and-best-practices-c6ce5321f52/) for some details on frequently used commands. We regularly use the following commands:

- `git branch`: Check which branch you are currently on.
- `git diff`: Shows you changes.
- `git pull`: Download the latest updates for the branch you are currently on.
- `git checkout`: Switch to an existing branch.
- `git checkout -b <name>`: Create and switch to a new branch.
- `git add .`: Add the changes you made in the editor to your branch. 
- `git commit -m "<description-jira#>"`: Commit your changes you made in the editor to your branch. 
- `git push --set-upstream origin <name>`: Push your new branch.
- `git push`: Push your changes upstream.
- `git status`: Tells you the branch you are on and if it is up to date.
   **Note:** You must create PRs from the GitHub website after pushing your branch.

Remember, we try to keep our process simple, streamlined, and efficient. Git has many powerful and potentially dangerous commands. Our motto is:

_We git pull, git add, git commit, and git push. We don't git crazy._

## Terms and example workflow

- **Issue:** This is a work item or a ticket (support lingo). An issue is required for all doc work or major decisions. We now use Jira issues.
  
- **Repository:** Where the source code, branches, and history live. The repository (repo) contains all the branches. You need to clone the repository.
  1. Ensure you set up your SSH first.
  2. Go to the browser and copy the code for SSH: `https://github.com/stolostron/rhacm-docs`.
  3. Go to your directory in the terminal and run `git clone https://github.com/stolostron/rhacm-docs`.
  4. Ensure the folders are cloned on your machine so that you can work.
  
- **Branch:** A copy of the doc where you apply the changes. Branches named **prod** or **stage** are set as the branches that are published at GA or for a refresh. Never work based off the production branch. We always work in staging, then copy the changes over to production when we schedule a refresh. You will create a branch off of a staged branch. You can do that in the terminal or in the browser.

- **Example of branching workflow:** If you want to work on a 2.9 update, follow this procedure:
  1. Check out `2.9_stage` by running `git checkout 2.9_stage`
  2. Run `git pull` to get the latest changes that were committed by the team. Best practice: Run this each time you start work. If you do not run `git pull` before you check out your branch, you don't have the most recent copy of the branch.
  3. Checkout your own branch by running `git checkout -b <my-branch>`, or you can use the browser. **Note:** Start the branch with a letter, not an integer. You can name the branch anything you like, but a useful template is `initials-platform-issue-version number`.
  4. Make your changes in your editor. We use VS Code and we preview our files.

You can then go through the process to commit and create a pull request, described in the following sections. (For the refresh, we create a pull request (PR) to add the new content from `2.9_stage` to `2.9_prod`.)
  
- **Pull request:** Since you opened your own branch, `<my-branch>`, against the staging branch, you must create a pull request to get your changes into the `<_stage>` branch (think of it as pulling in changes from your branch and pushing to the staged branch).
  
- **Commit:** Used as a verb, or noun. When you apply changes, you are committing to your branch. A commit is your change.

- **Example of commit and PR workflow:**
  1. Save your changes. You can run `git diff` if you want view the diff (changes).
  2. Run `git add <file>` to add the diff. You can also run `git add .` to simply add all files not yet staged for commit.
  3. Commit your changes by running `git commit -m "JIRA#--description about change", adding the Jira link, which you can copy from the browser. Only for small changes or typos do we skip that and use `git commit -m "no-issue typo fix"`.
  4. Run `git push` and you receive an output command: `git push --set-upstream origin <my-branch>`.
  5. Copy that command and run it.
  6. Go to the browser and create your PR.

You can also make changes to the repo from your branch in the browser, but that is only recommended for small changes. You can also create aliases for commands and so much more. Learn more at [Git alias](https://www.atlassian.com/git/tutorials/git-alias).

## Editing
   
For quick changes you can create branches and edit code on the GitHub website, but for most of the work we do, you are going to want to use Visual Studio Code or a similar code editor with built-in GitHub support.

## BFG Repo-Cleaner

If you commit sensitive information, let your manager know and run [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/). Remember, everything you commit is saved in the repo history.
