# Building RHACM docs process with Jekyll

It is helpful learn how to build  a website for GitHub pages using Jekyll from scratch . This ensures that your system is set up correctly. If you ojnly want to maintaint this website, you can skip to [RHACM docs process](/README.md#Maintaining).

# Build from scratch

## Prerequisites

### MacOS

1. Install the following software packages:

- [Homebrew](https://brew.sh/)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Ruby](https://formulae.brew.sh/formula/ruby)
- [RubyGems](https://formulae.brew.sh/formula/brew-gem)
- [GCC](https://formulae.brew.sh/formula/gcc)
- [Make](https://formulae.brew.sh/formula/make#default)
- [Jekyll](https://jekyllrb.com/docs/installation/macos/)

2. Choose a theme for your website. [Cayman](https://github.com/pages-themes/cayman) is the default option but there are many themes available on GitHub. This website uses [al-folio](https://github.com/pages-themes/cayman).

3. 

# Maintaining

# Deployment

Deploying your website to [GitHub Pages](https://pages.github.com/) is the most popular option.
Starting version [v0.3.5](https://github.com/alshedivat/al-folio/releases/tag/v0.3.5), **al-folio** will automatically re-deploy your webpage each time you push new changes to your repository! :sparkles:

**For personal and organization webpages:**
1. Rename your repository to `<your-github-username>.github.io` or `<your-github-orgname>.github.io`.
2. In `_config.yml`, set `url` to `https://<your-github-username>.github.io` and leave `baseurl` empty.
3. Set up automatic deployment of your webpage (see instructions below).
4. Make changes, commit, and push!
5. After deployment, the webpage will become available at `<your-github-username>.github.io`.

**For project pages:**
1. In `_config.yml`, set `url` to `https://<your-github-username>.github.io` and `baseurl` to `/<your-repository-name>/`.
2. Set up automatic deployment of your webpage (see instructions below).
3. Make changes, commit, and push!
4. After deployment, the webpage will become available at `<your-github-username>.github.io/<your-repository-name>/`.

**To enable automatic deployment:**
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

---

# Upgrading from a previous version

If you installed **al-folio** as described above, you can upgrade to the latest version as follows:

```bash
# Assuming the current directory is <your-repo-name>
$ git remote add upstream https://github.com/alshedivat/al-folio.git
$ git fetch upstream
$ git rebase v0.3.5
```

If you have extensively customized a previous version, it might be trickier to upgrade.
You can still follow the steps above, but `git rebase` may result in merge conflicts that must be resolved.
See [git rebase manual](https://help.github.com/en/github/using-git/about-git-rebase) and how to [resolve conflicts](https://help.github.com/en/github/using-git/resolving-merge-conflicts-after-a-git-rebase) for more information.
If rebasing is too complicated, we recommend to re-install the new version of the theme from scratch and port over your content and changes from the previous version manually.

---

# FAQ

Here are some frequently asked questions.
If you have a different question, please ask using [Discussions](https://github.com/alshedivat/al-folio/discussions/categories/q-a).

1. **Q:** After I fork and setup the repo, I get a deployment error.
   Isn't the website supposed to correctly deploy automatically? <br>
   **A:** Yes, if you are using release `v0.3.5` or later, the website will automatically and correctly re-deploy right after your first commit.
   Please make some changes (e.g., change your website info in `_config.yml`), commit, and push.
   Make sure to follow [deployment instructions](https://github.com/alshedivat/al-folio#deployment) in the previous section.
   (Relevant issue: [209](https://github.com/alshedivat/al-folio/issues/209#issuecomment-798849211).)

2. **Q:** I am using a custom domain (e.g., `foo.com`).
   My custom domain becomes blank in the repository settings after each deployment.
   How do I fix that? <br>
   **A:** You need to add `CNAME` file to the `master` or `source` branch of your repository.
   The file should contain your custom domain name.
   (Relevant issue: [130](https://github.com/alshedivat/al-folio/issues/130).)

3. **Q:** My webpage works locally.
    But after deploying, it is not displayed correctly (CSS and JS is not loaded properly).
    How do I fix that? <br>
   **A:** Make sure to correctly specify the `url` and `baseurl` paths in `_config.yml`.
   Set `url` to `https://<your-github-username>.github.io` or to `https://<your.custom.domain>` if you are using a custom domain.
   If you are deploying a personal or organization website, leave `baseurl` blank.
   If you are deploying a project page, set `baseurl: /<your-project-name>/`.

4. **Q:** Atom feed doesn't work. Why?
   <br>
   **A:** Make sure to correctly specify the `url` and `baseurl` paths in `_config.yml`.
  RSS Feed plugin works with these correctly set up fields: `title`, `url`, `description` and `author`.
  Make sure to fill them in an appropriate way and try again.

## Photos

Photo formatting is made simple using [Bootstrap's grid system](https://getbootstrap.com/docs/4.4/layout/grid/).
Easily create beautiful grids within your blog posts and project pages:

<p align="center">
  <a href="https://alshedivat.github.io/al-folio/projects/1_project/">
    <img src="https://raw.githubusercontent.com/alshedivat/al-folio/master/assets/img/photos-screenshot.png" width="75%">
  </a>
</p>

---

## GitHub repositories and user stats
**al-folio** uses [github-readme-stats](https://github.com/anuraghazra/github-readme-stats) to display GitHub repositories and user stats on the the `/repositories/` page.

Edit the `_data/repositories.yml` and change the `github_users` and `github_repos` lists to include your own GitHub profile and repositories to the the `/repositories/` page.

You may also use the following codes for displaying this in any other pages.
```
<!-- code for GitHub users -->
{% if site.data.repositories.github_users %}
<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% for user in site.data.repositories.github_users %}
    {% include repository/repo_user.html username=user %}
  {% endfor %}
</div>
{% endif %}

<!-- code for GitHub repositories -->
{% if site.data.repositories.github_repos %}
<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% for repo in site.data.repositories.github_repos %}
    {% include repository/repo.html repository=repo %}
  {% endfor %}
</div>
{% endif %}
```

## Theming
Six beautiful theme colors have been selected to choose from.
The default is purple, but you can quickly change it by editing `$theme-color` variable in the `_sass/_themes.scss` file.
Other color variables are listed there as well.

## License

The theme is available as open source under the terms of the [MIT License](https://github.com/alshedivat/al-folio/blob/master/LICENSE).

Originally, **al-folio** was based on the [\*folio theme](https://github.com/bogoli/-folio) (published by [Lia Bogoev](https://liabogoev.com) and under the MIT license).
Since then, it got a full re-write of the styles and many additional cool features.

