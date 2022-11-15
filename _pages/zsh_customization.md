---
layout: page
title: Zsh customization
permalink: /zsh_customization
horizontal: false
render_with_liquid: false
---

Zsh is the default Terminal.app shell. You can customize it to optimize your Git and general CLI workflow.

## Show current branch

You can save yourself one step by no longer needing to type `git branch` or `git status` if you add a branch indicator to Zsh. It can also help you avoid accidentally checking out the wrong branch. To add the indicator, add the lines from the following link to your `.zshrc` file (located in your home directory):

```
https://github.com/oafischer/dotfiles/blob/main/zsh/zshrc
```

You can customize the colors using ANSI color codes and replace the command indicator with a unicode character of your choice, or use the traditional `$`.