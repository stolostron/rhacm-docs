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

## Tiling window manager for macOS

### yabai

You can use a tiling window manager solution similar to i3 or dwm, but for macOS, by installing [yabai](https://github.com/koekeishiya/yabai). We often work with multiple windows for editing code, running terminal commands, and navigating GitHub and Zenhub. Using a tiling window manager can help you manage windows more efficiently so that you can focus on your work. To install yabai, complete the following steps:

1. When starting your Mac, press and hold the power button until `Loading startup options` appears.

2. Follow the instructions to enter recovery mode. Once the menu bar becomes available, select *Utilities* in the menu bar and open a terminal window.

3. Run the following command to disable SIP:

    ```
    csrutil enable --without debug --without fs
    ```

4. Reboot. You can verify that SIP is disabled by running the following command:

    ```
    csrutil status
    ```
    
5. Install Xcode CLI tools by downloading it from the app store. You need an Apple ID for this.

6. Run the following commands to install yabai:

    ```
    brew install koekeishiya/formulae/yabai
    sudo yabai --install-sa
    killall Dock
    ```
    
7. Configure the scripting addition by creating a new file in _sudoers_:

    ```
    sudo visudo -f /private/etc/sudoers.d/yabai
    ```

8. Insert the following line into the new file, replacing elements where required:

    ```
    <user> ALL = (root) NOPASSWD: sha256:<hash> <yabai> --load-sa
    ```

    - Replace <yabai> with the path to the yabai binary (echo `which yabai`).
    - Replace <user> with your username (echo `whoami`). 
    - Replace <hash> with the sha256 hash of the yabai binary (echo `shasum -a 256 $(which yabai)`). You must update this hash manually again after running `brew upgrade`.

9. Add the following loading script to the top of your `.yabairc` file (located in your home directory), if you are setting up your own configuration:

    ```
    yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
sudo yabai --load-sa
    ```
    Alternatively, you can use the official example at the following link:
    ```
    https://github.com/koekeishiya/yabai/blob/master/examples/yabairc
    ```
    Or you can use one of our configurations at the following link:
    ```
    https://github.com/oafischer/dotfiles/blob/main/yabai/yabairc
    ```

10. Make your `yabairc` file executable by running the following command:

    ```
    chmod +x ~/.yabairc
    ```

11. Start yabai and add it to your login items by running the following command:

    ```
    brew services start yabai
    ```
    **Note:** When prompted, grant yabai access to Accessbility.
    If you need to make changes to the configuration, you can run the following command after saving your changes to restart yabai:

    ```
    brew services restart yabai
    ```

### skhd

To configure hotkeys that allow you to manipulate windows managed by yabai in a similar fashion to i3 or dwm, you need to install and set up skhd by completing the following steps:

1. Run the following command to install skhd:

    ```
    brew install koekeishiya/formulae/skhd
    ```

2. Configure your `.skhdrc` file (located in your home directory) by using the official example:

    ```
    https://github.com/koekeishiya/yabai/blob/master/examples/skhdrc
    ```
    Alternatively, you can use one of our configurations at the following link:
    ```
    https://github.com/oafischer/dotfiles/blob/main/skhd/skhdrc
    ```

3. Start skhd and add it to your login items by running the following command:

    ```
    brew services start skhd
    ```
    **Note:** When prompted, grant skhd access to Accessbility.
    If you need to make changes to the configuration, you can run the following command after saving your changes to restart yabai:

    ```
    brew services restart skhd
    ```


## Color themes

This website uses the [Catppuccin](https://github.com/catppuccin) pastel theme. You can personalize your machine with the same theme by visiting the [Catppuccin repository](https://github.com/catppuccin/catppuccin) and following the provided steps for the software, tools, or websites you want to customize. You can also use the [style guide](https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md) to create themes for additional platforms that are not listed. Using a pastel theme can help with eye strain and create a more enjoyable working experience when staring at code all day.

### Zenhub

There is no official Catppuccin theme for Zenhub. You can use one of our custom themes based on Catppuccin Macchiato at the following link:

    ```
    https://github.com/oafischer/dotfiles/blob/main/yabai/yabairc
    ```
