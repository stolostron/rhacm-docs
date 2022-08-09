# Building with Jekyll

It is helpful learn how to build  a website for GitHub Pages using Jekyll from scratch. This ensures that your system is set up correctly. If you only want to maintain this website, you can skip to [Maintaining](/README.md#Maintaining).

## Prerequisites

### MacOS

Install the following software packages:

- [Homebrew](https://brew.sh/)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Ruby](https://formulae.brew.sh/formula/ruby)
- [RubyGems](https://formulae.brew.sh/formula/brew-gem)
- [GCC](https://formulae.brew.sh/formula/gcc)
- [Make](https://formulae.brew.sh/formula/make#default)
- [Jekyll](https://jekyllrb.com/docs/installation/macos/)

## Installation

1. Choose a theme for your website. [Cayman](https://github.com/pages-themes/cayman) is the default option but there are many themes available on GitHub. This website uses [al-folio](https://github.com/alshedivat/al-folio).

2. 

# Maintaining

You can add new topics, tabs and cards to the website using Markdown files. GitHub Pages will automatically update the site when changes are detected in the repository.

## Add new topic

1. Create new Markdown file in the __pages_ folder.
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

1. Create a new Markdown file on the __pages_ folder.
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

1. Create a new Markdown file on the __pages_ folder.
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

- Screenshot size must be 700x575 pixels.
- Save screenshot as a `.png` file in /assets/img/
- Only screenshot website content. No user interface that must be visible that is not part of the HTML code of the website.
- Remove sensitive information from the screenshot by painting over it. Do not use blur.
- The naming convention of the file must follow `##-name`.

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
The previous command will create or updeate static HTML files for other hosting platforms in the __site/_ folder.

**Note:** Correctly set the `url` and `baseurl` fields in `_config.yml` before building the website. If you are deploying your website to `your-domain.com/your-project/`, you must set `url: your-domain.com` and `baseurl: /your-project/`. If you are deploing directly to `your-domain.com`, leave `baseurl` blank.

# Upgrading from a previous version

You can upgrade to the latest al-folio version by completing the following steps:

```bash
# Assuming the current directory is <your-repo-name>
$ git remote add upstream https://github.com/alshedivat/al-folio.git
$ git fetch upstream
$ git rebase v0.3.5
```

If you have extensively customized a previous version, it might be trickier to upgrade. You can still follow the steps above, but `git rebase` may result in merge conflicts that must be resolved. See [git rebase manual](https://help.github.com/en/github/using-git/about-git-rebase) and how to [resolve conflicts](https://help.github.com/en/github/using-git/resolving-merge-conflicts-after-a-git-rebase) for more information.

If rebasing is too complicated, re-install the new version of the theme from scratch and port over your content and changes from the previous version manually.

# License

The theme is available as open source under the terms of the [MIT License](https://github.com/alshedivat/al-folio/blob/master/LICENSE). Originally, **al-folio** was based on the [\*folio theme](https://github.com/bogoli/-folio) (published by [Lia Bogoev](https://liabogoev.com) and under the MIT license).

