---
layout: page
title: System customization
permalink: /cheat_custom
horizontal: false
render_with_liquid: false
---

You can customize your system to better suit the workflow and processes we use.

## `zsh` show current branch

To add an indicator in your terminal prompt showing you which git branch you are currently on, add the following lines to your `.zshrc` file (located in your home directory):

```
Due to GitHub liquid syntax limitations, you must copy the lines from https://github.com/oafischer/dotfiles/blob/main/zsh/zshrc
```

You can customize the colors using ANSI color codes and replace the command indicator with a unicode character of your choice, or use the traditional `$`. Using the indicator can help you avoid accidentally creating a new branch from the wrong base branch.

**Tip:** To show the `.zshrc` file in Finder, press the Command, Shift, and period (.) keys at the same time. The hidden files appear as translucent in the folder. Alterantively, you can edit the file with a terminal editor such as visudo.
