# GitHub pages content

Repo for the Information Development Playbook.

## Installing Jekyll

Windows: https://jekyllrb.com/docs/installation/windows/

Mac: https://jekyllrb.com/docs/installation/macos/

Once installed:
1. Open/fetch the gh-pages branch so that all files are on your local machine.
2. Go to the directory of the git content and then run the following commands: 

    1. Run: `bundle`
    2. Run: 
       * Mac: `export PAGES_REPO_NWO=IBMPrivateCloud/CP4MCM-docs`
       * Windows: `set PAGES_REPO_NWO=IBMPrivateCloud/CP4MCM-docs` 
    3. To serve content: `bundle exec jekyll serve`

Any change you make appear in the URL provided in the command. You can check your work before you do a PR. 

## Adding content

1. Add a new markdown file in the `pages` folder.
2. Update the `navigation.yml` file to add the new file, following the structure that is there. For example: 

- title: "topic name"
  url: /filename

## Troubleshooting

If you have a question about using Jekyll, start a discussion on the [Jekyll Forum](https://talk.jekyllrb.com/) or [StackOverflow](https://stackoverflow.com/questions/tagged/jekyll). Other resources:

- [Ruby 101](https://jekyllrb.com/docs/ruby-101/)
- [Setting up a Jekyll site with GitHub Pages](https://jekyllrb.com/docs/github-pages/)
- [Configuring GitHub Metadata](https://github.com/jekyll/github-metadata/blob/master/docs/configuration.md#configuration) to work properly when developing locally and avoid `No GitHub API authentication could be found. Some fields may be missing or have incorrect data.` warnings.
