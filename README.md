# GitHub pages content

You need to familiarize yourself with Jekyll, Ruby, gem files, static sites, etc...

## Installing Jekyll and using for the first time

Windows: https://jekyllrb.com/docs/installation/windows/

Mac: https://jekyllrb.com/docs/installation/macos/

1. Check install of all things by running -v behind it. Example: `ruby -v` `jekyll -v`
2. Create and `cd` into your directory where you want the files: `cd documents`.
3. Run `jekyll new <how-to-docs>`, where `how-to-docs` is what you want to name your project.
4. Go into the project folder that you created: `cd how-to-docs`
5. Open with your editor. Do a search to find the command for your editor and configure. I have configured VS Code with `code` to simple open on command.
6. Initialize git: `git init`.
7. Check in the files you need from install and commit with a message. Pause here. You now want to preview what you have thus far in a local host.
8. Preview by running the command: `bundle exec jekyll serve` and going to the local host in the browser: Example using the server address that I was given: http://localhost:4000/about/.
9. Change theme, contact info, etc... in the config YAML file. 
10. Go to the directory of the git content and then run the following commands: 

    1. Run: `bundle`
    2. Run: 
       * Mac: `export PAGES_REPO_NWO=open-cluster-management/rhacm-docs`
       * Windows: `set PAGES_REPO_NWO=cluster-management/rhacm-docs` 
    3. To serve content: `bundle exec jekyll serve`

## Adding content

1. Add a new markdown file in the `_pages` folder.
2. Update the `navigation.yml` file to add the new file, following the structure that is there. For example: 

- title: "topic name"
  url: /filename

## Troubleshooting

If you have a question about using Jekyll, start a discussion on the [Jekyll Forum](https://talk.jekyllrb.com/) or [StackOverflow](https://stackoverflow.com/questions/tagged/jekyll). Other resources:

- [Ruby 101](https://jekyllrb.com/docs/ruby-101/)
- [Setting up a Jekyll site with GitHub Pages](https://jekyllrb.com/docs/github-pages/)
- [Configuring GitHub Metadata](https://github.com/jekyll/github-metadata/blob/master/docs/configuration.md#configuration) to work properly when developing locally and avoid `No GitHub API authentication could be found. Some fields may be missing or have incorrect data.` warnings.
