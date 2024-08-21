# RHACM internal doc process

- [Internal Documentation](https://stolostron.github.io/rhacm-docs)

# Building with Jekyll

If you only want to maintain this website, you can skip to [Maintaining and updating](/README.md#Maintaining-and-updating). If you want to create a new project similar to this website, you need Jekyll and Ruby. See the following topics for a complete guide on installing Jekyll and Ruby on MacOS.

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

6. Install GCC by using the following command:
   ```
   brew install gcc
   ```

7. Install Make by using the following command:
   ```
   brew install make
   ```

8. Install Git by using the following command:
   ```
   brew install git
   ```

9. Install Jekyll and Bundler by running the following command:
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

10. Quit the terminal and restart. Verify that Jekyll installed correctly by using the following command:
   ```
   jekyll -v
   ```

11. Install bundle by running the following command:
   ```
   bundle install
   ```

12. Choose a theme for your website. [Cayman](https://github.com/pages-themes/cayman) is the default option but there are many themes available on GitHub. This website uses [al-folio](https://github.com/alshedivat/al-folio).

13. To verify that Jekyll works, navigate to the main folder of your theme and run the following command:
   ```
   bundle exec jekyll serve
   ```

Copy and paste the server address into your browser and hit enter. If your website appears, you have installed Jekyll and Ruby successfully. Use the previous command to preview your website as you work in your repository. Changes you make in the repository are automatically pushed to the preview. Refresh the page in your browser to update the live view after changing and saving files in your repository.

To publish the website, see [Deploying](/README.md#Deploying) for more details.

# Maintaining and updating

You can make changes to the content on the website by editing the Markdown files in `__pages_`. You can also add new topics, tabs, and cards to the website by using Markdown files. GitHub Pages will automatically update the site when changes are detected in the repository.

## Adding a new topic

1. Create a new Markdown file in the `__pages_` folder.
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

## Adding a new tab

1. Create a new Markdown file in the `__pages_` folder.
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
5. Add the link to the Markdown file (topic) you want your tab to link to after `permalink:`. See [Adding a new topic](/README.md#Adding-a-new-topic) for more details on how to add topics.
6. Add an integer after `nav_order:` to choose where the tab appears on the website.

## Adding a new dropdown tab

1. Create a new Markdown file in the `__pages_` folder.
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
6. Add the link to the Markdown file (topic) you want your tab to link to after `permalink:` below `children:` See [Adding a new topic](/README.md#Adding-a-new-topic) for more details on how to add topics.

## Adding a new `Quick links` card

1. Create a new Markdown file in the `__projects_` folder.
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

## Image and screenshot requirements

Use images and screenshots sparingly and adhere to the following rules when using them:

- For quick link cards:
  - Screenshot size must be 400x300 pixels.
  - The naming convention for the file must follow `##-name`.
- Save screenshots as a `.png` file in `/assets/img/`.
- Only screenshot website content. No user interface elements must be visible.
- Remove sensitive information from the screenshot by painting over it. Do not use blur.

## Easter eggs

Easter eggs must be squirrel-themed.

# Deploying

This website is already deployed with [GitHub Pages](https://pages.github.com/). Some themes don't automatically update when changes are made to the repository but [`al-folio`](https://github.com/alshedivat/al-folio) supports this feature. No further deployment is needed. If you do need to deploy the website again, see the following instructions:

## Website

1. Rename your repository to `<your-github-username>.github.io` or `<your-github-orgname>.github.io`.
2. In `_config.yml`, set `url` to `https://<your-github-username>.github.io` and leave `baseurl` empty.
3. Set up [automatic deployment of your webpage](/README.md#Enabling-automatic-deployment).
4. Make your changes, commit, and push.
5. After deployment, the website becomes available at `<your-github-username>.github.io`.

## Enabling automatic deployment

1. Click on **Actions** tab and **Enable GitHub Actions**.
2. Make changes to your websit, commit, and push. This automatically triggers the **Deploy** action.
3. Wait a few minutes and let the action complete. You can see the progress in the **Actions** tab. If completed successfully, in addition to the `master` branch, your repository should now have a newly built `gh-pages` branch.
4. In the **Settings** of your repository, set the branch to `gh-pages`. For more details, see [Configuring a publishing source for your GitHub Pages site](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#choosing-a-publishing-source).

### Deploying manually to GitHub Pages

Run the following script from the root directory of your repository:
```bash
./bin/deploy
```
The previous command uses the `master` branch for the source code and deploys the webpage to `gh-pages`.

### Deploying to a different hosting server

Run the following command to build your website for other hosting options besides GitHub Pages:
```bash
bundle exec jekyll build
```
The previous command will create or update static HTML files for other hosting platforms in the `__site_` folder.

**Note:** Correctly set the `url` and `baseurl` fields in `_config.yml` before building the website. If you are deploying your website to `your-domain.com/your-project/`, you must set `url: your-domain.com` and `baseurl: /your-project/`. If you are deploing directly to `your-domain.com`, leave `baseurl` blank.

# License

[Al-folio](https://github.com/alshedivat/al-folio) is available as open source under the terms of the MIT License. It is based on the [\*folio theme](https://github.com/bogoli/-folio) published by [Lia Bogoev](https://liabogoev.com) under the MIT license.

