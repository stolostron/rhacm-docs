---
layout: page
title: Writing and reviewing checklist
permalink: /checklist
horizontal: false
---

See the following list for guidance when creating or updating content. Use this as a guide while writing and when peer reviewing pull requests. See _Technical writing standards_ for more details and access to style manuals and other information.

## Writing and reviewing checklist 

On any PRs for new or changed content, paragraphs, procedures, files, etc..., please indicate in the PR that you considered the checklist while writing. This is not neceessary for typos, broken links, or small changes that do not impact the content much.

Before you submit for peer review, go through at least one tech review. You can still be in review status with the tech leads when you submit, but it doesn't make sense to peer review content when the engineer might request a lot of changes. If the content changes after peer review, seek an official peer review again.

- [ ] Are file names, headers, anchors, and titles consistent with the feature and the rest of the component doc?
   - You can intuitively find the file named in the repo based on the title of the file.
   - For example, the file is named `upgrade_cluster_disconnected` and the title of the file is `Upgrading your cluster in a disconnected environment`.
   - Headers are parallel with each other and named to fit the content.
- [ ] Are file names, headers, anchors, and titles concise, and unique for easier URL building? (You can eliminate article like "the" from the file name, for example)
- [ ] For bugs, Errata release notes, etc... is the diff clearly addressing the customer concern, bug fix, or code change?
- [ ] Does the file have a meaningful short description that tells you why the user wants to use the feature and what the feature is about?
- [ ] Are prerequisites separate, clear, and imperative?
- [ ] Are there any obvious prerequisites that can be removed, such as "You must install the RHACM" in an area where that is already understood because the user is working with an MCH resource that you get during install?
- [ ] Are there any red links when you preview and run _Check my links_ or any errors from the linter.
- [ ] Are product or technology names correct?
   - Consistent with the rest of the documentation
   - Correct from content references
   - In line with third-party official doc, such as Amazon product doc
   - Consistent with the General Use column of the _Official Product and Solution List_ from the [Red Hat official brand and naming](https://source.redhat.com/departments/marketing/brand/naming)?
- [ ] Are there introductions after headers before lists or tables?
- [ ] Are tables titled?
- [ ] Do you see directional language such as "below" or "above", which violates accessibility?
- [ ] Are variables and code instances tagged properly and consistently according the the manual?
- [ ] Do you find commands that are presented together instead of as separate steps? (one step that runs multiple commands for many actions, for example)
- [ ] Are comments in the YAML samples that should be either steps or callouts?
- [ ] Is the YAML missing field values or proper formatting?
- [ ] If versions are listed in examples or commands, do they need to be specific or can we build with user input/variables? (For example, in a sample, consider `<4.x>` coded as a variable instead of the current version to lower maintance requirements.)
- [ ] Does the PR format need to be fixed because commands or sample files are not grayed out? (This is tyically fixed by using an approve quotation mark, other teamates can help with an example if needed.)
- [ ] Are there many inline links and are they necessary? Per the manual and for better UX, use them sparingly.
- [ ] Does this require a _What's new_ entry because it is a feature?
- [ ] Is this a _known issue_ or _troubleshooting_ entry that follows the proper format?
- [ ] Does the content present RHACM features inside the MCE doc? If yes, it may be missplaced. We have to carefully indicate that you must have ACM in those cases. There are examples in the doc, but a teammate can also help with this.
- [ ] Does the content cross features and if so, have tech leads discussed best placement for it in the issue so the decision making is recorded?
- [ ] Are there any long paragraphs that should be broken up into lists or more concise paragraphs?
- [ ] Is content grammatically correct and concise? See some examples to think about, though this is not all inclusive:
     - Are modals used properly and according to the manual?
     - Is the content in active voice and present tense? (In most cases, we can meet this standard, a peer reviewer can help with rewriting where a second opinion is needed.)
     - Do you find wordy content that can be removed or merged together?
     - Are restrictive clauses used where necessary? (that are, which are) This is important for translation.
     - Are commas and parenthesis used appropriately.
     - Examples of wordy content:
      - "In other words...", this can be removed, just write the words
      -  "...from being automatically imported", can be something like "...from automatic import"
      - Before: "Exclude a managed cluster label from being listed in the _Label_ drop-down filter. Add the label name to the `ignore_labels` list."
      - After: "Add the managed cluster label to the `ignore_labels` list to exclude it from the _Label_ drop-down filter.
       
## Common resources

These are a few common resources to view while you are writing, but this is not all inclusive. Please be familiar with the industry standards in the *IBM Style Manual*, *Red Hat Supplementary Manual*, and *PatternFly Manual* (for the UI).

- [Word usage IBM](https://www.ibm.com/docs/en/ibm-style?topic=word-usage) and [RedHat](https://redhat-documentation.github.io/supplementary-style-guide/#glossary-terms-conventions)
- [Accessibility](https://redhat-documentation.github.io/supplementary-style-guide/#accessibility) and [IBM Accessibility](https://www.ibm.com/docs/en/ibm-style?topic=medium-accessibility)
- [Language and grammar](https://www.ibm.com/docs/en/ibm-style?topic=language-grammar)
- [Highlighting](https://www.ibm.com/docs/en/ibm-style?topic=format-highlighting)
- [Prerequisite info](https://www.ibm.com/docs/en/ibm-style?topic=format-procedures#prerequisite-information) and [More](https://redhat-documentation.github.io/supplementary-style-guide/#prerequisites)
- [Short descriptions](https://redhat-documentation.github.io/supplementary-style-guide/#shortdesc)

