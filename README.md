# Product documentation 

Markdown (MD) is a lightweight markup language with plain text formatting syntax. If you've created an Issue in GitHub, you've used MD. MD is flexible and easy to use for basic tasks, but it’s not the best for complicated topics. Simplify your topic hierarchy wherever possible. To learn more about MD and its syntax, see [Getting started with writing and formatting on GitHub](https://help.github.com/articles/markdown-basics/).

**Note: Moving to [AsciiDoc is a text document format](http://asciidoc.org/).**


## ID schedule

Limited release:
GA and integration with Red Hat docs:

**IMPORTANT:** ID SHUT DOWN three days before GA; please give us time to finalize our documentation.  

To ensure product documentation is accessible, accurate, tested, complete, and follows coporate style manual, we need to shut down incoming work three days before GA. Please open issues early and doc test early.

## Making documentation updates

Until a link is available, please rely on the table of contents/navigation draft found in the summary.md file to see what is staged.

1. Identify documentation content updates (features, enhancements, and bug fixes).
     - For a Dev issue where ID work is required - open up a **separate** ID issue in the open-cluster-management backlog. If you are not ready for a doc issue but you know you eventually need one, label `doc_needed`.
     - For Program integrated information (PII) review requests (content in the UI), such as tooltips and error messages, open a pull request and label it `squad:doc`.
     - Describe the changes that you are making or want the ID team to make to the docs and keep it in _untriaged_ stage.
     - Add tags such as `bug` or `priority`.
     - ID team can use the `help wanted` label if we are waiting for input late in the release. 

### Pull requests

- Dev can use PRs for small content changes. For larger changes, devs can provide the details inside the ID Git issue comment.
- ID will write and edit the content (run Acrolinx etc.) after devs upply any what is required to document the feature/fix.
- Developers must review in a PR before closing issue.
- ID team peer edits large changes/new topics.
- ID team always uses PR to submit new changes, just as the organization requires in the playbook.

### Link issues to commits

This is important for file history and if something has to be undone. Link an issue to a commit, add a reference to the issue to the commit message. Use this syntax:

```
IBMPrivateCloud/CP4MCM/#<issue_number> command was wrong
```

### Known issues or limitations

Please add the `release_note` label to issues where we have a known issue or limitation in the product that you want us to document in the [Known issues](https://www-03preprod.ibm.com/support/knowledgecenter/SSFC4F_1.1.0/cp/getting_started/known_issues.html) section.

### Branch strategy
- We don't have a master branch because devs and doc team should target your changes to an active or planned doc release.
- Hold all changes that you can't merge on your own branch."open-cluster-management/backlog#96 continue to set up repo/nav"
- Place all changes that are relevant for the 1.2 release in the `1.2_stage` branch.
- Delete your branch after you have merged your changes. ID will delete unnecessary branches after each release.

### Tips for working with the doc files (ID team only)
- If you need to make a new file, start from a copy of an existing file. You'll preserve the heading syntax.
- Remember to include a `{:shortdesc}` tag after the short description.
- Remember to tag external links. They resemble the following code:

  ```
  [Docker installation ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.docker.com/engine/installation/){: new_window}
  ```
- If you refer to a product name, use a conref. The conrefs take the form `{{site.data.keyword.KEYWORD}}`, where *KEYWORD* is the keyword that is listed in the `conrefs.yml` file.
- If you create a new file, remember to add a link to it in its parent topic and add a reference to it either in the `mcm_toc.xml` file for an MCM topic or the `master_map.ditamap` file for a new cloud pak topic, or both. Use existing files as reference.
- **Important:** You cannot use conrefs in the mcm_toc.xml file.  This file is not run through the build in the same way that the other files are. It is assumed by the build that it has already been through the process to resolve the conrefs.  Spell out the conrefs in this file only. Conrefs in the files that are referred to by this file are resolved as expected.  

## Transforming the docs (ID team only)

