---
layout: page
title: Cheat sheets
permalink: /extras_cheat_sheets
horizontal: false
---

## Resolving a GitHub doc issue using VS Code

Only use this after a team member has guided you through the process. Use the following steps as a reference until you have learned the steps by heart.  Replace code examples where necessary.

1. Change the issue pipeline to `In Progress` and make sure it has the correct sprint and labels attached to it.

2. Check that you are on the correct base branch in Visual Studio Code:
  
  ```
  git branch
  ```
  **Note:** Run the following command if you are on the wrong base branch and need to switch to the branch you want to create a PR for first:
  ```
  git checkout 2.8_stage
  ```

3. Create and switch to a new branch:
  
  ```
  git checkout -b of-ji-31458-28
  ```
  **Note:** of = initials | ji = platform of bug report | 31458 = issue number | 28 = version number

4. Make your changes in VS Code and save them for each file with ⌘ + s (MacOS) or Ctrl + s (other systems).

5. Add the changes to your branch:
  
  ```
  git add .
  ```

6. Commit your changes:
  
  ```
  git commit -m "Fix issue in 2.8"
  ```

7. Push your changes:
  
  ```
  git push
  ```
  **Note:** Save time by only using the previous command, which automatically generates the following full command:
  ```
  git push --set-upstream origin of-ji-31458-28
  ```

8. Go to [rhacm-docs](https://github.com/stolostron/rhacm-docs) to find your new PR.

9. Double check that you are on correct base branch and are merging into the correct target branch.

10. Add a link to the issue in the commit title.
  **Optional:** Add additional info into the comment.

11. Add reviewers (should include issue owner and/or appropriate devs) and create the PR.
  **Note:** Once you have dev approval or are close it, use the `@pr-docs-acm-team` tag to request a peer review in our channel.

12. If you are close to dev and peer approval, change the issue pipeline to `Awaiting Verification`.

13. Merge your PR after receiving approval (see [GitHub issue points](arch_points.md) for detailed approval requirements) and delete the branch in the PR.

14. Switch back to the base branch:
  
  ```
  git checkout 2.8_stage
  ```

15. Pull the newest base branch version and check that your merged changes download and show up:
  
  ```
  git pull
  ```

16. Delete your local branch in VS Code:
  
  ```
  git branch -d of-ji-31458-28
  ```

17. Verify that the changes you made show up in the Pantheon stage environment after building (see [Refreshing builds](arch_builds.md) for more information).

18. Comment a link to the updated source file(s) and the Pantheon previews in the original issue (if you completed step 18, also comment that you verified the changes).

19. Check if the changes you made are also needed in other branches (ask in the original issue if it's unclear).

20. Leave the pipeline on `Awaiting Verification` until the issue opener closes the issue, otherwise close it if there is no response after a few days.
