---
layout: page
title: Writing and reviewing checklist
permalink: /checklist
horizontal: false
---

See the following list for guidance when creating or updating content. Use this when peer reviewing pull requests, as well. See _Technical writing standards_ for more details and access to style manuals and other information.

## Writing and reviewing checklist 

- [ ] Are file names, headers, anchors, and titles consistent with the feature and the rest of the component doc?
   - You can intuitively find the file named in the repo based on the title of the file.
   - Headers are parallel with each other and named to fit the content.
- [ ] Are file names, headers, anchors, and titles shortened, concise, and unique for easier URL building? 
- [ ] For bugs and Errata release notes, is the diff clearly addressing the customer concern, bug fix, or code change, and is it signed off by QE/Dev?
- [ ] Does the file have a meaningful short description that tells you why the user wants to use the feature and what the feature is about?
- [ ] Are prerequisites separate, clear, and imperative?
- [ ] Are there any obvious prerequisites that can be removed, such as "You must install the RHACM" in an area where that is already understood?
- [ ] Are there any red links when you preview and run _Check my links_ or any errors from the linter.
- [ ] Are product or technology names correct?
   - Consistent with the rest of the documentation
   - Correct from content references
   - In line with third-party official doc
   - Consistent with the General Use column of the _Official Product and Solution List_ from the [Red Hat official brand and naming](https://source.redhat.com/departments/marketing/brand/naming)?
- [ ] Are there introductions after headers?
- [ ] Do you see directional language such as "below" or "above", which violates accessibility?
- [ ] Are variables and code instances tagged properly and consistently according the the manual?
- [ ] Do you find commands that are presented together instead of as separate steps? (one step that runs multiple commands for many actions, for example)
- [ ] Are comments in the YAML samples that should be either steps or callouts?
- [ ] If versions are listed in examples or commands, do they need to be specific or can we build with user input/variables?
- [ ] Does the PR format need to be fixed because commands or sample files are not grayed out?
- [ ] Are there many inline links and are they necessary?
- [ ] Does this require a _What's new_ entry because it is a feature?
- [ ] Is this a _known issue_ or _troubleshooting_ entry that follows the proper format?
- [ ] Does the content present RHACM features inside the MCE doc? If yes, it may be missplaced. (This is changing slightly as we open up MCE to contain ACM again.)
- [ ] Does the content cross features and if so, have tech leads discussed best placement for it?
- [ ] Are there any long paragraphs that should be broken up into lists or concise paragraphs?
- [ ] Do you understand what the change is about from the introduction?
- [ ] Is content grammatically correct and concise? See some examples to think about:
  - Are modals used properly?
  - Is the content in active voice and present tense?
  - Do you find wordy content that can be removed or merged together?
  - Are restrictive clauses used where necessary? (that are, which are)
  - Examples of wordy content:
   - "In other words...", this can be removed, just write the words
   -  "...from being automatically imported", can be something like "...from automatic import"
   - Before: "Exclude a managed cluster label from being listed in the _Label_ drop-down filter. Add the label name to the `ignore_labels` list."
   - After: "Add the managed cluster label to the `ignore_labels` list to exclude it from the _Label_ drop-down filter

## Common resources

These are a few common resources to view while you are writing, but this is not all inclusive. Please be familiar with the industry standards in the *IBM Style Manual*, *Red Hat Supplementary Manual*, and *PatternFly Manual* (for the UI).

- [Word usage IBM](https://www.ibm.com/docs/en/ibm-style?topic=word-usage) and [RedHat](https://redhat-documentation.github.io/supplementary-style-guide/#glossary-terms-conventions)
- [Accessibility](https://redhat-documentation.github.io/supplementary-style-guide/#accessibility) and [IBM Accessibility](https://www.ibm.com/docs/en/ibm-style?topic=medium-accessibility)
- [Language and grammar](https://www.ibm.com/docs/en/ibm-style?topic=language-grammar)
- [Highlighting](https://www.ibm.com/docs/en/ibm-style?topic=format-highlighting)
- [Prerequisite info](https://www.ibm.com/docs/en/ibm-style?topic=format-procedures#prerequisite-information) and [More](https://redhat-documentation.github.io/supplementary-style-guide/#prerequisites)
- [Short descriptions](https://redhat-documentation.github.io/supplementary-style-guide/#shortdesc)

