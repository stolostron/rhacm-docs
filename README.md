# Building with Jekyll

It is helpful learn how to build  a website for GitHub pages using Jekyll from scratch. This ensures that your system is set up correctly. If you only want to maintain this website, you can skip to [Maintaining](/README.md#Maintaining).

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

1. Choose a theme for your website. [Cayman](https://github.com/pages-themes/cayman) is the default option but there are many themes available on GitHub. This website uses [al-folio](https://github.com/pages-themes/cayman).

2. 

# Maintaining

You can add new topics, tabs and cards to the website using Markdown files. GitHub pages will automatically update the site when changes are detected.

## Add new topic

1. Create new Markdown file in the __pages_ folder.

**Note:** Observe the naming conventions.

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
2. Name the file `tab#.md`.

**Note:** Replace `#` with an integer.

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
5. Add the link to the Markdown file (topic) you want your tab to link to after `permalink:`.

**Note:** See [Add new topic](/README.md#Add-new-topic) for more details on how to add topics.

6. Add an integer after `nav_order:` to choose where the tab appears on the website.

## Add new dropdown tab

1. Create a new Markdown file on the __pages_ folder.
2. Name the file `dropdown#.md`.

**Note:** Replace `#` with an integer.

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
6. Add the link to the Markdown file (topic) you want your tab to link to after `permalink:` below `children:`

**Note:** See [Add new topic](/README.md#Add-new-topic) for more details on how to add topics.

## Add new link card

1. Create a new Markdown file in the __projects_ folder.

**Note:** Observe the naming conventions.

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
3. Add a title for your card after `title:`.

**Note:** It must fit on a single line and must not exceed three words in length.

4. Add a description for your card. It appears under the title and must fill three lines once published.
5. Create a screenshot for the website you are linking the card to.

**Note:** See [Screenshot requirements](/README.md#Screenshot-requirements) for more details.

6. Add the link to the website you want to link to after `redirect:`
7. Add an integer after `importance:` to set where the card appears in the list.

## Screenshot requirements

- Screenshot size must be 700x575 pixels.
- Save screenshot as a `.png` file.
- Only screenshot website content. No user interface that must be visible that is not part of the HTML code of the website.
- Remove sensitive information from the screenshot by painting over it. Do not use blur.
- The naming convention of the file must follow `##-name`.

# Deployment

Deploying your website to [GitHub Pages](https://pages.github.com/) is the most popular option.
Starting version [v0.3.5](https://github.com/alshedivat/al-folio/releases/tag/v0.3.5), **al-folio** will automatically re-deploy your webpage each time you push new changes to your repository.

**Web pages**
1. Rename your repository to `<your-github-username>.github.io` or `<your-github-orgname>.github.io`.
2. In `_config.yml`, set `url` to `https://<your-github-username>.github.io` and leave `baseurl` empty.
3. Set up automatic deployment of your webpage (see instructions below).
4. Make changes, commit, and push!
5. After deployment, the webpage will become available at `<your-github-username>.github.io`.

**Project pages:**
1. In `_config.yml`, set `url` to `https://<your-github-username>.github.io` and `baseurl` to `/<your-repository-name>/`.
2. Set up automatic deployment of your webpage (see instructions below).
3. Make changes, commit, and push!
4. After deployment, the webpage will become available at `<your-github-username>.github.io/<your-repository-name>/`.

**Enable automatic deployment:**
1. Click on **Actions** tab and **Enable GitHub Actions**; do not worry about creating any workflows as everything has already been set for you.
2. Make any other changes to your webpage, commit, and push. This will automatically trigger the **Deploy** action.
3. Wait for a few minutes and let the action complete. You can see the progress in the **Actions** tab. If completed successfully, in addition to the `master` branch, your repository should now have a newly built `gh-pages` branch.
4. Finally, in the **Settings** of your repository, in the Pages section, set the branch to `gh-pages` (**NOT** to `master`). For more details, see [Configuring a publishing source for your GitHub Pages site](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#choosing-a-publishing-source).


<details><summary>(click to expand) <strong>Manual deployment to GitHub Pages:</strong></summary>

If you need to manually re-deploy your website to GitHub pages, run the deploy script from the root directory of your repository:
```bash
$ ./bin/deploy
```
uses the `master` branch for the source code and deploys the webpage to `gh-pages`.

</details>

<details><summary>(click to expand) <strong>Deployment to another hosting server (non GitHub Pages):</strong></summary>

If you decide to not use GitHub Pages and host your page elsewhere, simply run:
```bash
$ bundle exec jekyll build
```
which will (re-)generate the static webpage in the `_site/` folder.
Then simply copy the contents of the `_site/` foder to your hosting server.

**Note:** Make sure to correctly set the `url` and `baseurl` fields in `_config.yml` before building the webpage. If you are deploying your webpage to `your-domain.com/your-project/`, you must set `url: your-domain.com` and `baseurl: /your-project/`. If you are deploing directly to `your-domain.com`, leave `baseurl` blank.

</details>

<details><summary>(click to expand) <strong>Deployment to a separate repository (advanced users only):</strong></summary>

**Note:** Do not try using this method unless you know what you are doing (make sure you are familiar with [publishing sources](https://help.github.com/en/github/working-with-github-pages/about-github-pages#publishing-sources-for-github-pages-sites)). This approach allows to have the website's source code in one repository and the deployment version in a different repository.

Let's assume that your website's publishing source is a `publishing-source` sub-directory of a git-versioned repository cloned under `$HOME/repo/`.
For a user site this could well be something like `$HOME/<user>.github.io`.

Firstly, from the deployment repo dir, checkout the git branch hosting your publishing source.

Then from the website sources dir (commonly your al-folio fork's clone):
```bash
$ bundle exec jekyll build --destination $HOME/repo/publishing-source
```

This will instruct jekyll to deploy the website under `$HOME/repo/publishing-source`.

**Note:** Jekyll will clean `$HOME/repo/publishing-source` before building!

The quote below is taken directly from the [jekyll configuration docs](https://jekyllrb.com/docs/configuration/options/):

> Destination folders are cleaned on site builds
>
> The contents of `<destination>` are automatically cleaned, by default, when the site is built. Files or folders that are not created by your site will be removed. Some files could be retained by specifying them within the `<keep_files>` configuration directive.
>
> Do not use an important location for `<destination>`; instead, use it as a staging area and copy files from there to your web server.

If `$HOME/repo/publishing-source` contains files that you want jekyll to leave untouched, specify them under `keep_files` in `_config.yml`.
In its default configuration, al-folio will copy the top-level `README.md` to the publishing source. If you want to change this behaviour, add `README.md` under `exclude` in `_config.yml`.

**Note:** Do _not_ run `jekyll clean` on your publishing source repo as this will result in the entire directory getting deleted, irrespective of the content of `keep_files` in `_config.yml`.

</details>

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

