# Information from and for the doc team

Please take a minute or two to read!

**IMPORTANT:** DOC SHUT DOWN three days before GA; please give us time to finalize our documentation and deliver on time.

To ensure product documentation is accessible, accurate, tested, complete, and follows corporate style manual, we need to shut down incoming work three days before GA. Please open issues early and doc test early.

## Contributing to the repository

**Please open an issue, not a PR** so that we can make updates as we transition into ASCII doc.

To see the content, (until a link is available), please rely on the table of contents/navigation draft found in the [summary.md](https://github.com/open-cluster-management/rhacm-docs/blob/doc_stage/summary.md) file.

**RHACM developers:** Please open an issue as normal with the file/content that needs to be added. Label your issue `squad doc` and give a detailed description of your change. The clearer you are in the description, the quicker we can make the updates. 

## Issue and Pull request process

Identify documentation content updates (features, enhancements, and bug fixes) and open issues.

   - For a Dev issue where doc work is required - open up a **separate** ID issue in the open-cluster-management backlog. If you are not ready for a doc issue but you know you eventually need one, you can label `doc_needed`.
   - Describe the changes that you are making or want the Doc team to make; keep it in _untriaged_ stage.
   - Add tags such as `bug` or `priority`.
   - Doc team can use the `help wanted` label if we are waiting for input late in the release.
   
**Link issues to commits** This is important for file history and if something has to be undone. Link an issue to a commit, add a reference to the issue to the commit message and a quick note about the update. See the following syntax:

     ```
     open-cluster-management/backlog#147/#<issue_number> command updated
     ```     
### Pull requests

   - Dev can use PRs for small content changes. For larger changes, devs can provide the details inside the GitHub issue comment.
   - Doc team will write and edit the content after devs supply what is required to document the feature/fix.
   _ Reviews on new topics, reorgs, or large changes require: Peer review, dev review, support review.
   - Doc team always uses PR to submit new changes, just as the organization requires in the playbook.
   
### UI content or PII

It is very important to get the doc team to help with UI content. 

 - For Program integrated information (PII) review requests (content in the UI), such as tooltips and error messages, label the design or UI dev issue `squad:doc` and use that issue to get the content reviewed.
 - The doc team can also branch from the developer's property files and create a PR with recommended changes or the developers can do the same.
 
### Known issues or limitations

Please `squad doc` issues where we have a known issue or limitation in the product that you want us to document in the [Known issues](https://github.com/open-cluster-management/rhacm-docs/blob/doc_stage/about/known_issues.md) section.

## Branch strategy

- Work in the _stage_ branch. The _production_ branch will be updated regulary by the doc team.
- We don't have a master branch because devs and doc team should target changes by opening branches from a release branch.
- Hold all changes that you cannot merge on your own branch.
- Please start your branch with a letter so your branch is not confused with a release branch:
    good: `josh-update` creates craziness: `3.1.1-update`
- Place all changes that are relevant for the next release in the `doc_stage` (our default branch).
- "Be kind; delete your branch." Delete your branch after you have merged your changes.

## Doc schedule (draft, input from DE and architect) 
Limited release:

- 3/2: Doc repo and navigation is ready for development input
- 3/9: Development issues all created in the open_cluster repository and labeled `squad doc`
- 3/11: Dev input required for doc issues
- 3/24: Doc freeze to allow time to complete required processes (See Doc team shutdown)
- 3/27: Verizon LA

GA and integration with Red Hat docs:

- 4/2: Conversion to AsciiDoc complete
- 4/15: Builds running AsciiDoc
- 4/17: Doc freeze
- 4/23: GA to RH decided format

**Note for UI guild:** We have set up numerous doc links from the UI in the course of the product evolution. For LR, these docs will not be live. Brandi will follow up with how these icons/links will be updated for GA. Ping for questions.

**Note: Moving to [AsciiDoc is a text document format](http://asciidoc.org/).** 

## Doc writer internal processes (doc team only unless you are just curious)

### Writer assignments

Chris: Lead, Cluster Lifecycle and all squads within, Foundation, Install (please add what is missing)
Brandi: Architect for doc, UI Guild writer, Cluster application and all squads within, (please add what is missing)
Mikela: Support doc focal, GRC and all squads withing, (please add what is missing)

### Using the board

Use the following milestones to triage issues:

 - Product: Next release/future issues
 - Release: GA after any limited or beta issues
 - Sprint: Immediate release issues
 - In progress: What we have started these issues
 - Awaiting Verification: In peer/dev/support review issues

### Working with the doc files 

- Keep directories as short as possible.
   Example: `manage_apps/subscriptions.md` is easy for linking, readability, usability, etc...
   Without some regulation, things can get out of control with extra folders (we have all seen this): `managing/manage_all_the_things/manage_this_specific_thing/subscriptions.md`.
- File names, let's not get craxy here, too. Keep product abbreviations out of file names; we jus thave to keep changing them. And keep them as short and as intuitive as possible.  
- If you create a new file, remember to add a link to it in its parent/container topic and add a reference to it in the navigation file.
- Remember to include necessary build tags (not needed until the transition)
- If you refer to a product name, use a conref from the `conrefs.yml` file. (not needed until the transition-hard code instead)

### Transforming the docs (doc team future)

Example: https://docs.openshift.com/container-platform/4.3/welcome/index.html
