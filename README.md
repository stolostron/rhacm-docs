# Product documentation for the IBM Cloud Pak for Multicloud Management

## Using Markdown

Markdown (MD) is a lightweight markup language with plain text formatting syntax. If you've created an Issue in GitHub, you've used MD. MD is flexible and easy to use for basic tasks, but it’s not the best for complicated topics. Simplify your topic hierarchy wherever possible. To learn more about MD and its syntax, see [Getting started with writing and formatting on GitHub](https://help.github.com/articles/markdown-basics/).

KC uses the IBM Cloud (formerly Bluemix) MD parser to normalize files, and most of the IBM Cloud customizations apply to MD in KC. For information about IBM Cloud markdown, see [Markdown tips](https://console.stage1.bluemix.net/docs/developing/markdown/tips.html#markdown-tips) and the [IBM-Bluemix/docs readme file](https://github.com/IBM-Bluemix/docs/blob/master/README.md).

## ID schedule

See [ID schedule](https://ibm.ent.box.com/notes/473352121449) for details.

**IMPORTANT:** ID SHUT DOWN three days before GA. 

To ensure product documentation is accessible, accurate, tested, complete, and follows IBM style manual, we need to shut down incoming work three days before GA. This is also why we need issues opened and planned early in the release. 

## Making documentation updates

### Submitting doc deliverables for each sprint

Note: ID updates the current version and the two previous versions (n-2). For earlier versions, we address only P1 Doc APARS for releases in support.

1. Identify documentation content updates (features, enhancements, and bug fixes).
     - For a Dev issue where ID work is required - open up a separate ID issue.
     - For Program integrated information (PII) review requests, such as tooltips and error messages, open a pull request and label it `squad:doc` and `pll` for review. (Give ID at least 24 hours to review your request.)
     - New documentation requests for each sprint are due by the end of the sprint.
2. Create an issue in the [IBMPrivateCloud/roadmap](https://github.ibm.com/ibmprivatecloud/roadmap/) repo by using the [Documentation issue template](https://github.ibm.com/IBMPrivateCloud/roadmap/issues/new?template=documentation-report.md) to describe the changes that you are making or want the ID team to make to the docs and have it in the untriaged stage.
     
3. ID insert tags, such as `bug` and `task` or `story` when we triage issues and assign to the appropriate backlog. A ID member is assigned to the task at this stage. If ID requires Dev information, the label `doc:waiting on content` is added and the appropriate dev squad label is added.

### Pull requests

- Dev can only use PRs for small content changes. Instead of using PRs, Dev can provide the details inside the ID Git issue. ID will write and edit the content (run Acrolinx etc.) and Dev will supply any content that is required to document the feature/fix the bug. Dev will also review the content before the issue is closed.
- For ID: If you make a change to the docs, use a PR) to submit your changes. It's best to make changes on a new branch and create your PR from that branch.

### Link issues to commits
To link an issue to a commit, add a reference to the issue to the commit message. Use this syntax:
```
IBMPrivateCloud/CP4MCM/#<issue_number>
```

### Known issues or limitations
Please add the `release_note` label to issues where we have a known issue or limitation in the product that you want us to document in the [Known issues](https://www-03preprod.ibm.com/support/knowledgecenter/SSFC4F_1.1.0/cp/getting_started/known_issues.html) section.

### Branch strategy
- We don't have a master branch because you should target your changes to an active or planned doc release.
- Hold all changes that you can't merge on your own branch.
- Place all changes that are relevant for the 1.2 release in the `1.2_stage` branch.
- Delete your branch after you have merged your changes. ID will delete unnecessary branches after each release.

### Tips for working with the doc files
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

1. Open the Jenkings job.
  - For 1.1.0 updates, open the [normalize_github_project](http://kcpbnrm1.ahe.pok.ibm.com:8080/view/All/job/normalize_github_product/build) Jenkins job. Log in using your GSA user name and password.
  - For 1.2.0 updates, open the [normalize_github_project](http://kcpbnrm1.ahe.pok.ibm.com:8080/view/All/job/normalize_cloudpak_product/build?delay=0sec) Jenkins job. Log in using your GSA user name and password. 

2. In the **PRODUCT_CONFIG**, enter the location of the test properties file. The location for the test properties file is `/gsa/pokgsa/projects/a/ahe01_kc/projects/wwwtest/content/knwctr/mainframe/_content_config/platform/cloud_pak_mcm/<properties_file_name>`. Obtain the properties file name from the following table:

Table 1: IBM Cloud Pak for Multicloud Management properties files

|Build file|Source|Preprod collection link|Live collection link|
|----------|------|--------|-------|
|SSFC4F.properties|Welcome file in GSA|[SSFC4F collection](https://www-03preprod.ibm.com/support/knowledgecenter/SSFC4F/product_welcome_cloud_pak.html)|[Live SSFC4F collection](https://www.ibm.com/support/knowledgecenter/SSFC4F/product_welcome_cloud_pak.html)|
|SSFC4F_1.2.0_stage.properties|Stage branch |[Staging (draft) collection](https://www-03preprod.ibm.com/support/knowledgecenter/SSFC4F_1.2.0_stage/kc_welcome_cloud_pak.html)|No live docs|
|SSFC4F_1.1.0.properties|1.1.0|[1.1.0 collection](https://www-03preprod.ibm.com/support/knowledgecenter/SSFC4F_1.1.0/kc_welcome_cloud_pak.html)|[Live 1.1 collection](https://www.ibm.com/support/knowledgecenter/SSFC4F/kc_welcome_cloud_pak.html)|
|SSFC4F_1.1.0_stage.properties|Stage branch|[Staging (draft) collection](https://www-03preprod.ibm.com/support/knowledgecenter/SSFC4F_1.1.0_stage/kc_welcome_cloud_pak.html)|No live docs|

3. Click **Build**.

The collection is normalized and a `normalize_preprod_product` job is started. When the second Jenkins job is finished, the appropriate collection updates. The changes are visible about 20 minutes after the job completes. You might need to clear your cache in order to see the changes.

If you are pushing to production: From the Preview tab, locate [promote to preview](http://kcpbnrm1.ahe.pok.ibm.com:8080/view/Preview/). Click the icon to build with parameters. Do the same for production.

Note: To promote preprod to preview, then preview to production, enter _only_ the product key. Example: SSBS6K_1.2.0

You can learn more about the KC process for using Git and Markdown [here](http://rtpdoc01.rtp.raleigh.ibm.com:9082/kc/docs_kc_20/kccloud/gitsource.html).
