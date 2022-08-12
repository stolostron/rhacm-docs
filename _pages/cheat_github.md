---
layout: page
title: GitHub Visual Studio Code cheat sheet
permalink: /cheat_github
horizontal: false
---

Use these steps as a reference after a team member walks through the process with you. Replace code examples where necessary.

1. Change pipeline for issue to _In Progress_

2. Check branch
```
$ git branch
```

3. Switch to new branch
```
$ git checkout -b of-bz-22189-25
```
**Note:** of = initials | bz = platform of bug report | 22189 = issue number | 25 = version number

4. Make your changes in Visual Studio

5. Save your changes with ⌘ + s (MacOS) or Ctrl + s (other systems)

6. Add changes to your branch
```
$ git add .
```

7. Commit changes
```
$ git commit -m "Fix issue in 2.5"
```

8. Push changes
```
$ git push
```
**Note:** Save time by only using the previous command, which automatically generates the following full command.
```
$ git push --set-upstream origin of-bz-22189-25
```

9. Go to [RHACM docs](https://github.com/stolostron/rhacm-docs) to find your new PR

10. Double check that you are on correct base branch

11. Add link to the issue in the comments

12. Add reviewers as needed and create the PR

13. Change pipeline to _Awaiting Verification_

14. Merge pull request after approval from reviewers

15. Delete your branch from step 3 on GitHub

16. Double check which branch you are on in Visual Studio Code
```
$ git branch
```

17. Switch back to base branch
```
$ git checkout 2.5_stage
```

18. Download newest base branch version
```
$ git pull
```

19. Check that your changes download in Visual Studio Code after step 18

20. Delete your local branch after in Visual Studio Code
```
$ git branch -d of-bz-22189-25
```

21. Comment link to updated source file and to preview in the original issue report

22. Comment that you verified the change in stage environment after building

23. Check if same change is needed in newer stage (if it makes sense to do so)

24. Leave pipeline on _Awaiting Verification_ if not closing issue yourself, otherwise close issue





