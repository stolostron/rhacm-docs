---
layout: page
title: Writing and reviewing checklist
permalink: /checklist
horizontal: false
---

See the following list for guidance when creating or updating content. Use this when peer reviewing pull requests, as well. See _Technical writing standards_ for more details and access to style manuals and other information.

## Writing and reviewing checklist 

- [ ] Are file names, headers, and titles consistent with the feature and the rest of the component doc? Meaning you can intuitively find the file named in the repo based on the title of the file.
- [ ] Are file names, headers, and titles concise for easier URL building?
- [ ] For bugs, is the diff clearly addressing the customer concern or code change, and is it signed of by QE/Dev?
- [ ] Does the file have a meaningful short description that tells you why the user wants to use the feature and what the feature is about?
- [ ] Are prerequisites separate, clear, and imperative?
- [ ] Are there any obvious prerequisites that can be removed, such as "You must install the RHACM" in an area where that is understood?
- [ ] Are there any red links when you preview and run _Check my links_?
- [ ] Are product or technology names consistent with the rest of the documentation, content references, third-party official doc, or Red Hat official naming guidelines?
- [ ] Are there introductions after headers and before main content for accessibility?
- [ ] Do you see directional language such as "below" or "above", which violates accessibility?
- [ ] Are variables tagged properly and consistently according the the manual?
- [ ] Do you find commands that are presented together instead of as separate steps?
- [ ] Are comments in the YAML samples that should be either steps or callouts?
- [ ] If versions are listed in examples or commands, do they need to be specific or can we build with user input/variables?
- [ ] Does the PR format need to be fixed because commands or sample files are not grayed out?
- [ ] Are there many inline links and are they necessary?
- [ ] Does this require a _What's new_ entry because it is a feature?
- [ ] Is this a _known issue_ or _troubleshooting_ entry that follows the proper format?
- [ ] Does the content present RHACM features inside the MCE doc? If yes, it may be missplaced.
- [ ] Does the content cross features and if so, have tech leads discussed best placement for it?
- [ ] Are there any long paragraphs that should be broken up into lists or concise paragraphs?
- [ ] Do you understand what the change is about? 
- [ ] Is content grammatically correct and concise?
  - [ ] Are modals used properly?
  - [ ] Is the content in active voice and present tense?
  - [ ] Do you find wordy content that can be removed or merged together?
  - Examples of wordy content:
   - "In other words...", this can be removed just write the words
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

