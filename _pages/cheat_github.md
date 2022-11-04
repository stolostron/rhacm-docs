---
layout: page
title: GitHub Visual Studio Code cheat sheet
permalink: /cheat_github
horizontal: false
---

Use the following steps as a reference after a team member has walked you throough the process. Replace code examples where necessary.

1. Change the issue pipeline to _In Progress_ and make sure it has the correct sprint and labels attached to it.

2. Check that you are on the correct base branch:
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

4. Make your changes in Visual Studio Code.

5. Save your changes with ⌘ + s (MacOS) or Ctrl + s (other systems).

6. Add the changes to your branch:
```
git add .
```

7. Commit your changes:
```
git commit -m "Fix issue in 2.8"
```

8. Push your changes:
```
git push
```
**Note:** Save time by only using the previous command, which automatically generates the following full command:
```
git push --set-upstream origin of-ji-31458-28
```

9. Go to [RHACM docs](https://github.com/stolostron/rhacm-docs) to find your new PR.

10. Double check that you are on correct base branch and are merging into the correct target branch.

11. Add a link to the issue in the comments.

12. Add reviewers as needed and create the PR.
**Note:** Once you have dev approval, you can use the `@pr-docs-acm-team` tag to request a peer review.

13. Change the issue pipeline to _Awaiting Verification_.

14. Merge your pull request after receiving approval (see [GitHub issue points](arch_points.md) for detailed approval requirements).

15. Delete your branch from step 3 on GitHub.

16. Double check which branch you are on in Visual Studio Code:
```
git branch
```

17. Switch back to the base branch:
```
git checkout 2.8_stage
```

18. Download the newest base branch version:
```
git pull
```

19. Check that your changes download in Visual Studio Code after completing step 18.

20. Delete your local branch in Visual Studio Code:
```
git branch -d of-ji-31458-28
```

21. Verify that the changes you made show up in the Pantheon stage environment after building (see [Refreshing builds](arch_builds.md) for more information).

22. Comment a link to the updated source file(s) and the Pantheon previews in the original issue report (if you completed step 21, also comment that you verified the changes).

23. Check if the changes you made are also needed in other branches (ask in the original issue if it's unclear).

24. Leave the pipeline on _Awaiting Verification_ if not closing the issue yourself, otherwise close the issue.





