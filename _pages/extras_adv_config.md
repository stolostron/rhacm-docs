---
layout: page
title: Advanced configuration
permalink: /adv_config
horizontal: false
render_with_liquid: false
---

You can customize your system with additional configurations to better suit the workflow and processes we use. While some of these advanced configurations are personal preferences, they might still be helpful if you are new to some of the tools we use, or simply want to optimize your workflow.

## `zsh` show current branch

By default, there is no indicator in the terminal prompt showing you which Git branch you are currently on. Using an indicator can help you avoid accidentally creating a new branch from the wrong base branch. It also saves you time by removing the need to frequently check your branch with the `git branch` command. To add the indicator, add the lines from the following link to your `.zshrc` file (located in your home directory):

```
https://github.com/oafischer/dotfiles/blob/main/zsh/zshrc
```

You can customize the colors using ANSI color codes and replace the command indicator with a unicode character of your choice, or use the traditional `$`.

## Tiling window manager for macOS

### yabai

If you are used to a tiling window manager or want to spend less time managing multiple windows yourself, you can install [yabai](https://github.com/koekeishiya/yabai) by completing the following steps:

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
    
7. Configure the scripting addition by creating a new `yaba` file in _sudoers.d_:

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
    
## Useful macOS tools

If you are using a MacBook, you might find the following tools useful:

### Scroll reverser

Set a separate scroll direction for the touchpad and external mouse.

[Download](https://github.com/pilotmoon/Scroll-Reverser)

## Color themes

If you have a coding background, you might already be familiar with color themes. If not, the following resources provide some background information by using the [Dracula theme](https://ui.draculatheme.com/) as an example:
    
- [Origin story and context](https://www.protocol.com/workplace/dracula-color-scheme)
- [Benefits and reasons](https://ui.draculatheme.com/principles)
    
[This website](https://stolostron.github.io/rhacm-docs/) uses the [Catppuccin](https://github.com/catppuccin) pastel theme. You can personalize your machine with the same theme by visiting the [Catppuccin repository](https://github.com/catppuccin/catppuccin) and following the provided steps for the software, tools, or websites you want to customize. You can find additional styles in our [dotfiles/css](https://github.com/oafischer/dotfiles/blob/main/css/) repo.
