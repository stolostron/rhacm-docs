# Link to the website

[<img src="https://cdn-icons-png.flaticon.com/512/1864/1864534.png">](https://stolostron.github.io/rhacm-docs)

# Building with Jekyll

If you only want to maintain this website, you can skip to [Maintaining](/README.md#Maintaining). If you want to create a new project similar to this website, you need Jekyll and Ruby. See the following topics for a complete guide on installing Jekyll and Ruby on MacOS.

## Prerequisites

- [GitHub account](https://github.com/)
- [Retrieve your Git keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)

## Installation

1. Install [Hombrew](https://brew.sh) by running the following command:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
**Note:** This might take several minutes.

2. To install Ruby, run the following commands:
```
brew install chruby ruby-install xz
```
```
ruby-install ruby
```
**Important:** You must use the previous commands to install Ruby, even if your system already comes with Ruby pre-installed. The pre-installed version does not function correctly. This step might take several minutes.

3. Install RubyGems by running the following command:
```
brew install brew-gem
```

4. Configure Ruby by running the following commands:
```
echo "source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh" >> ~/.zshrc
echo "source $(brew --prefix)/opt/chruby/share/chruby/auto.sh" >> ~/.zshrc
echo "chruby ruby-3.1.2" >> ~/.zshrc
```

5. Quit the terminal and restart it. Run the following command to verify that Ruby is installed and functioning correctly:
```
ruby -v
```

4. Install GCC by using the following command:
```
brew install gcc
```

5. Install Make by using the following command:
```
brew install make
```

6. Install Git by using the following command:
```
brew install git
```

7. Install Jekyll and Bundler by running the following command:
```
gem install jekyll bundler
```
**Note:** This step might take several minutes. If you receive an `ERROR: Could not find a valid gem 'jekyll' (>=0)` error message, run the following commands before repeating step 7:
```
gem sources --remove https://rubygems.org/
```
```
gem sources -a http://rubygems.org/
```

8. Quit the terminal and restart. Verify that Jekyll installed correctly by using the following command:
```
jekyll -v
```

9. Install bundle by running the following command:
```
bundle install
```

10. Choose a theme for your website. [Cayman](https://github.com/pages-themes/cayman) is the default option but there are many themes available on GitHub. This website uses [al-folio](https://github.com/alshedivat/al-folio).

11. To verify that Jekyll works, navigate to the main folder of your theme and run the following command:
```
bundle exec jekyll serve
```

Copy and paste the server address into your browser and hit enter. If your website appears, you have installed Jekyll and Ruby successfully. Use the previous command to preview your website as you work in your repository. Changes you make in the repository are automatically pushed to the preview. Refresh the page in your browser to update the live view after changing and saving files in your repository.

To publish your new website, see [Deployment](/README.md#Deployment) for more details.

# Maintaining

You can make changes to the content on the website by editing the Markdown files in __pages_. You can also add new topics, tabs, and cards to the website using Markdown files. GitHub Pages will automatically update the site when changes are detected in the repository.

## Add new topic

1. Create a new Markdown file in the __pages_ folder.
2. Add the following template:
```
---
layout: page
title:
permalink: /
horizontal: false
---
```
3. Add a title for your topic after `title:`.
4. Add the link to the file you just created after `permalink:`.

## Add new tab

1. Create a new Markdown file in the __pages_ folder.
2. Name the file `tab#.md`. Replace `#` with an integer.
3. Add the following template:
```
---
layout: page
title: 
permalink: /
nav: true
nav_order:
dropdown: false
---
```
4. Add a title for your tab  after `title:`.
5. Add the link to the Markdown file (topic) you want your tab to link to after `permalink:`. See [Add new topic](/README.md#Add-new-topic) for more details on how to add topics.
6. Add an integer after `nav_order:` to choose where the tab appears on the website.

## Add new dropdown tab

1. Create a new Markdown file in the __pages_ folder.
2. Name the file `dropdown#.md`. Replace `#` with an integer.
3. Add the following template:
```
---
layout: page
title: 
permalink: /
nav: true
nav_order:
dropdown: true
children: 
    - title: 
      permalink: /
    - title: divider
---
```
4. Add a title for your tab  after `title:`.
5. Add an integer after `nav_order:` to choose where the tab appears on the website.
6. Add the link to the Markdown file (topic) you want your tab to link to after `permalink:` below `children:` See [Add new topic](/README.md#Add-new-topic) for more details on how to add topics.

## Add new link card

1. Create a new Markdown file in the __projects_ folder.
2. Add the following template:
```
---
layout: page
title: 
description: 
img: assets/img/##-source.png
redirect: 
importance: 
category: work
---
```
3. Add a title for your card after `title:`. It must fit on a single line and must not exceed three words in length.
4. Add a description for your card. It appears under the title and must fill three lines once published.
5. Create a screenshot for the website you are linking the card to. See [Screenshot requirements](/README.md#Screenshot-requirements) for more details.
6. Add the link to the website you want to link to after `redirect:`
7. Add an integer after `importance:` to set where the card appears in the list.

## Screenshot requirements

- Screenshot size must be 400x300 pixels.
- Save screenshot as a `.png` file in /assets/img/
- Only screenshot website content. No user interface elements must be visible that are not part of the HTML code of the website.
- Remove sensitive information from the screenshot by painting over it. Do not use blur.
- The naming convention of the file must follow `##-name`.

## Easter eggs

Easter eggs must be squirrel-themed.

# Deployment

This website is already deployed using [GitHub Pages](https://pages.github.com/). Some themes don't automatically update when changes are made to the repository but [al-folio](https://github.com/alshedivat/al-folio) supports this feature. No further deployment is needed. If you do need to deploy the website again, see the following instructions:

## Website
1. Rename your repository to `<your-github-username>.github.io` or `<your-github-orgname>.github.io`.
2. In `_config.yml`, set `url` to `https://<your-github-username>.github.io` and leave `baseurl` empty.
3. Set up [automatic deployment of your webpage](/README.md#Enable-automatic-deployment).
4. Make changes, commit, and push.
5. After deployment, the website becomes available at `<your-github-username>.github.io`.

## Projects
1. In `_config.yml`, set `url` to `https://<your-github-username>.github.io` and `baseurl` to `/<your-repository-name>/`.
2. Set up [automatic deployment of your webpage](/README.md#Enable-automatic-deployment).
3. Make changes, commit, and push.
4. After deployment, the webpage becomes available at `<your-github-username>.github.io/<your-repository-name>/`.

## Enable automatic deployment
1. Click on **Actions** tab and **Enable GitHub Actions**.
2. Make changes to your websit, commit, and push. This automatically triggers the **Deploy** action.
3. Wait a few minutes and let the action complete. You can see the progress in the **Actions** tab. If completed successfully, in addition to the `master` branch, your repository should now have a newly built `gh-pages` branch.
4. In the **Settings** of your repository, set the branch to `gh-pages`. For more details, see [Configuring a publishing source for your GitHub Pages site](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#choosing-a-publishing-source).

### Manual deployment to GitHub Pages

Run the following script from the root directory of your repository:
```bash
$ ./bin/deploy
```
The previous command uses the `master` branch for the source code and deploys the webpage to `gh-pages`.

### Deployment to a different hosting server

Run the following command to build your website for other hosting options besides GitHub Pages:
```bash
$ bundle exec jekyll build
```
The previous command will create or update static HTML files for other hosting platforms in the __site_ folder.

**Note:** Correctly set the `url` and `baseurl` fields in `_config.yml` before building the website. If you are deploying your website to `your-domain.com/your-project/`, you must set `url: your-domain.com` and `baseurl: /your-project/`. If you are deploing directly to `your-domain.com`, leave `baseurl` blank.

# Upgrading theme version

Assuming the current directory is `your-repo-name`, you can upgrade to the latest al-folio version by running the following commands:

```bash
$ git remote add upstream https://github.com/alshedivat/al-folio.git
$ git fetch upstream
$ git rebase vx.x.x
```
**Note:** Replace all instances of `x` to match the current version of [al-folio](https://github.com/alshedivat/al-folio).

Upgrading a customized version of al-folio can cause issues during the upgrade. You can still follow the previous steps, but `git rebase` may result in merge conflicts that you must resolve. See [Git rebase manual](https://help.github.com/en/github/using-git/about-git-rebase) and how to [resolve conflicts](https://help.github.com/en/github/using-git/resolving-merge-conflicts-after-a-git-rebase) for more information.

If rebasing causes too many issues or fails, reinstall the new version of the theme from scratch and port over your content and changes from the previous version manually.

# License

[Al-folio](https://github.com/alshedivat/al-folio) is available as open source under the terms of the [MIT License](https://github.com/alshedivat/al-folio/blob/master/LICENSE). Originally, it was based on the [\*folio theme](https://github.com/bogoli/-folio) (published by [Lia Bogoev](https://liabogoev.com) and under the MIT license).

