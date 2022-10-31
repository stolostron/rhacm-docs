---
layout: page
title: System customization
permalink: /cheat_custom
horizontal: false
---

You can customize your system to better suit the workflow and processes we use.

## `zsh` show current branch

To add an indicator in your terminal prompt showing you which git branch you are currently on, add the following lines to your `.zshrc` file (located in your home directory):

```
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

setopt PROMPT_SUBST
export PROMPT='%{%F{243}%}%n %{%F{197}%}%~ %{%F{39}%}$(parse_git_branch) %{%F{normal}%}$%{%f%} '
```

You can customize the colors using ANSI color codes. Using the indicator can help you avoid accidentally creating a new branch from the wrong base branch.

*Tip:* If your `.zshrc` file is hidden, press the Command, Shift, and period (.*) keys at the same time. The hidden files appear as translucent in the folder.
