---
permalink: /getting_started_github
title: "Learn GitHub: Tips and resources"
---

# Learn GitHub: Tips and resources

Learn more about GitHub lingo and how we use it on the IBM Cloud Pak for Multicloud Management team. This is not designed to teach you GitHub. Learning GitHub and Git comes with time, practice, and curiosity, just like learning any other tool. 

If you are coming from CMVC or RTC, some of the terms may be unfamiliar, so we listed a few. Learn more from [Git docs](https://git-scm.com/).

ID teams and Dev teams alike have increased efficiency and collaboration with GitHub/Git and Markdown. Early ICP ID team members learned Git via CLI, as the instructions display, but there is also a desktop client with sufficient documentation for others who do not use the CLI.

**Prerequisite: All onboarding members should review the DE's Playbook, which is required also for developers. Here you will find many resources and guidelines already published about learning GitHub, Agile practices, Slack, and more. Much of these processes, like linking issues to PRs, apply to the ID team, as well.

[IBM Cloud Private onboarding playbook](https://pages.github.ibm.com/IBMPrivateCloud/github/00-getting-started/).

Video recording of ICP ID Git presentation: https://ibm.webex.com/ibm/lsr.php?RCID=3fca183c36a54dd9bc6706a9216ccf4a
Password: Ec45pxp6

 - [Things to remember](#remember)
 - [Terms](#terms)
 - [Set up an editor](#editor)
 - [Set up GitHub](#git)
 - [Common commands](#commands)

## Things to remember
{: remember}

1. **Developer issues that need doc changes require a new doc issue.**

  Doc issues are required because dev issues often close before doc issues are resolved, dev issues do not always have what ID needs, and the doc issue is tracked on our board--we can iterate across backlogs as needed. (All of the ID team benefits from this simple process and this is why we have an easy template for developers to use.)

2. **Issues are used to track decisions,** such as removing a popular conref, changing a name, etc... See an example of how issues are used to track decisions. Examples:

   - Decision/inquiries to leads from DE to change version name: 
  [#18371](https://github.ibm.com/IBMPrivateCloud/roadmap/issues/18371)
  
   - Decision to format ID's branching strategy:
  [#18474](https://github.ibm.com/IBMPrivateCloud/roadmap/issues/18474)

## Terms
{: terms}

A few terms are listed here, but you can learn more from the GitHub documentation and since it is widely used, you can easily search online for anything unfamiliar.

**Issue:** This is a work item (RTC-lingo), or a ticket (support lingo). An issue is required for doc work or major decisions.

**Branch:** Basically a copy of the doc where you apply the changes. Branches named **master** or **branch_prod** are set as the branches that are published at GA or for a refresh. (See the properties files to understand how branches are published. To understand the build, see the [internal documentation](https://rtpdoc01.rtp.raleigh.ibm.com:9445/kc/docs_kc_20/kccloud/gitsource.html).
  
These are the final copies, and your branch off of those branches is your workspace. You never update the main production branches without a pull request. 

For example, if I want to work on 1.2, I need to check out `1.2_prod`, run `git pull` to get the latest changes that were committed by the team, then checkout my own branch from prod. If you do not run `git pull` before you check out your branch, you don't have the most recent copy of the branch.
  
**Pull request:** Since you opened your own branch, `<my-branch>`, against the production branch, you must create a pull request to get your changes into the main branch `<_stage>`. (Really, think of it as a PUSH request.)
  
**Commit:** Used as a verb, or noun. When you check in your changes, you are "committing" to your branch. A "commit" is your change. Think: Checking in code.
  
**Repository:** Everything--the code, the branches, the history...all takes place in the repo. The repo is not the branch, but the repo contains all the branches.

**Clone:** When you are ready to start, you first have to clone the repo. You should only do this once at the beginning, then you always have the repo, you just check out the branches you need. Cloning pulls the copy of the staging branch to your machine.

## Set up an editor
{: editor}
   
You want to use these editors to easily set up plug-ins, preview to catch mistakes, set up local build, and build tables/lists/code items properly. (Recommend VS Code over Atom, many developers also use VS Code.)

1. [Download VSCode](https://code.visualstudio.com/)

2. [Download Atom](https://atom.io/) 

These are widely used tools. As with Git and other open tools, you can search online if you have problems, questions, or want to learn more.

## Set up GitHub
{: git}

1. Go to the Mac@IBM store to get Git and other "Whitewater" tools. 

  If IBM stores do not have what you need: https://git-scm.com/download/mac, https://gitforwindows.org/
  
  Command Line Interface (CLI): For Mac users simply can use the terminal, Windows users use GitBash.

2. [Set up SSH keys](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)
 
3. Clone the docs repo. (Be sure you are added as a collaborator with write access. ID team members should be admins for our repo.) Click **Clone or download** on the right-hand side. Pay attention to the branch you are on, you want to clone what we use to stage for production:

  Clone with SSH key. Check your `pwd` (print working directory) so that you are placing your cloned doc files where you want them--you will access these files regularly. Change the directory if needed.
  
  See the example command to clone:
 
  ```
  git@github.ibm.com:IBMPrivateCloud/CP4MCM-docs.git
  ```
  {: codeblock}
     
## Common commands
{: commands}

Git is actually the term related to the Git CLI. See [Here are all the Git commands I used last week, and what they do](https://www.freecodecamp.org/news/git-cheat-sheet-and-best-practices-c6ce5321f52/) for a few regular commands you will use. There are many, many other articles online for reference. You can also use Git documentation. Also, becoming familiar with Linux commands will help.

(If you want to shorten commands with _aliases_, you can do that, too.)

1. Be sure you are on an updated staging branch. Insert the command `git branch` or `git status` to check on which branch you are working on. 

2. Run the following to be sure you have the lastest changes from the team after you check out the main branch:

 ```
 git pull
 ```
 {: codeblock}
  
3. To create a branch, run the following:

  ```
  git checkout -b <named-branch>
  ```
  {: codeblock}
  
  **Note:** Start the branch with a letter, not a number. Example: `install-defect`. (This is to not confuse our personal branches with the GA, refresh, or NLV branches.
  
  You need to push your branch (you can do this later when you push changes):
  
  ```
  git push --set-upstream origin test-swope
  ```
  {: codeblock}
  
4. Make changes, then check them. To check changes, run the following:

  ```
  git diff
  ```
  {: codeblock}
  
5. To add your changes, run the following command (`.` = all files, but you can add only certain files by naming them accordingly):

  ```
  git add .
  ```
  {: codeblock}
      
6. Commit your changes. Use this syntax to record the commits and link the PR to the Issue you are working. Example of command used to add this document to the playbook: `IBMPrivateCloud/CP4MCM#1338 write process playbook`. This helps track history and your own effort within an issue:

  ```
  git commit -m <"#IBMPrivateCloud/roadmap#xxxx - description of change">
  ```
  {: codeblock}
    
7. Push content upstream (to the repo); basically "check in" your changes to your branch:

 ```
 git push
 ```
 {: codeblock}
 
8. Next, you need to [Create a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) to get your changes into the final staging branch. 

From your branch, you want to "PR" into the staging branch that you branched from. Creating the PR is fairly intuitive. Additionally, this is where you ask for peer reviewers and developer reviewers to approve your content before you merge.

## Other resources

We gathered some resources, but this is not a complete list of all that can help you learn new tools and processes:
 
 - [Merge and Build](https://github.ibm.com/IBMPrivateCloud/docs#transform-the-docs)

 - If you want to learn about cherry picking, (not used much on our team, but you may benefit or want to explore), see [What does cherry-picking a commit with Git mean?](https://stackoverflow.com/questions/9339429/what-does-cherry-picking-a-commit-with-git-mean).

   Example command:

   ```
   git cherry-pick [commit_ID]
   ```
   {: codeblock}

 - You can [change the base branch in your PR](https://help.github.com/en/articles/changing-the-base-branch-of-a-pull-request).


