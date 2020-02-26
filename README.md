# Product documentation 

Markdown (MD) is a lightweight markup language with plain text formatting syntax. If you've created an Issue in GitHub, you've used MD. MD is flexible and easy to use for basic tasks, but it’s not the best for complicated topics. Simplify your topic hierarchy wherever possible. To learn more about MD and its syntax, see [Getting started with writing and formatting on GitHub](https://help.github.com/articles/markdown-basics/).


**IMPORTANT:** DOC SHUT DOWN three days before GA; please give us time to finalize our documentation and deliver on time.

To ensure product documentation is accessible, accurate, tested, complete, and follows coporate style manual, we need to shut down incoming work three days before GA. Please open issues early and doc test early.

## Making documentation updates

Until a link is available, please rely on the table of contents/navigation draft found in the [summary.md](https://github.com/open-cluster-management/rhacm-docs/blob/doc_stage/summary.md) file to see what is staged.

Identify documentation content updates (features, enhancements, and bug fixes) and open issues.

   - For a Dev issue where doc work is required - open up a **separate** ID issue in the open-cluster-management backlog. If you are not ready for a doc issue but you know you eventually need one, you can label `doc_needed`.
   - For Program integrated information (PII) review requests (content in the UI), such as tooltips and error messages, open a pull request and label it `squad:doc`.
   - Describe the changes that you are making or want the Doc team to make; keep it in _untriaged_ stage.
   - Add tags such as `bug` or `priority`.
   - Doc team can use the `help wanted` label if we are waiting for input late in the release. 

### Pull requests

   - Dev can use PRs for small content changes. For larger changes, devs can provide the details inside the Doc Git issue comment.
   - Doc team will write and edit the content (run Acrolinx etc.) after devs supply what is required to document the feature/fix.
   - Developers must review in a PR before closing issue.
   - Doc team peer edits large changes/new topics.
   - Doc team always uses PR to submit new changes, just as the organization requires in the playbook.

### Link issues to commits

This is important for file history and if something has to be undone. Link an issue to a commit, add a reference to the issue to the commit message and a quick note about the update. See the following syntax:

     ```
     open-cluster-management/backlog#147/#<issue_number> command updated
     ```

### Known issues or limitations

Please `squad doc` issues where we have a known issue or limitation in the product that you want us to document in the [Known issues](https://github.com/open-cluster-management/rhacm-docs/blob/doc_stage/about/known_issues.md) section. 

### Branch strategy

- We don't have a master branch because devs and doc team should target changes by opening branches from a release branch.
- Hold all changes that you can't merge on your own branch. 
- Please start your branch with a letter so your branch is not confused with a release branch:
     `josh-update` not `3.1.1-update`
- Place all changes that are relevant for the next release in the `doc_stage` (our default branch).
- "Be kind; delete your branch." Delete your branch after you have merged your changes.

## Doc schedule (draft, input from DE and archtitect) 
(Chris)
Limited release:

- 3/2: Doc repo and navigation is ready for development input
- 3/9: Development issues all created in the open_cluster repository and labeled `squad doc`
- 3/11: Dev input required for doc issues 
- 3/13: Build running markdown source with PDF output (static doc here?)
- 3/24: Doc freeze to allow time to complete required processes (See Doc team shutdown)
- 3/27: Verizon LA

GA and integration with Red Hat docs:

- 4/2: Conversion to AsciiDoc complete
- 4/4: Translation shipment 1
- 4/15: Builds running AsciiDoc
- 4/17: Doc freeze, translation shipment 2
- 4/23: GA to RH decided format

**Note** for UI guild: We have set up numerous doc links from the UI in the course of the product evolution. For LR, these docs will not be live. Brandi will follow up with how these icons/links will be updated for GA. Ping for questions.

**Note: Moving to [AsciiDoc is a text document format](http://asciidoc.org/).** (Mikela will give a quick demo at the end of the playback)

### Tips for working with the doc files (doc team only)

- If you need to make a new file, start from a copy of an existing file. You'll preserve the heading syntax.
- Remember to include necessary build tags.
- Remember to tag external links.
- If you refer to a product name, use a conref from the `conrefs.yml` file.
- If you create a new file, remember to add a link to it in its parent topic and add a reference to it either in the navigation file.

## Transforming the docs (doc team future)

Example: https://docs.openshift.com/container-platform/4.3/welcome/index.html

