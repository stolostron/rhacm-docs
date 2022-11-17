---
layout: page
title: Installing a tiling window manager for macOS
permalink: /installing_yabai
horizontal: false
---

A tiling window manager can help you spend less time moving windows around by managing multiple windows for you. If you are coming from Linux, you might miss this option in macOS. [Amethyst](https://github.com/ianyh/Amethyst) and [yabai](https://github.com/koekeishiya/yabai) are the main options for macOS to add this feature. yabai has more features and works better with multiple monitors.

### Installing yabai

You can install yabai by completing the following steps:

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

### Installing skhd

To configure hotkeys that allow you to manipulate windows managed by yabai (as is common with tiling window managers), you need to install and set up skhd by completing the following steps:

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
    
