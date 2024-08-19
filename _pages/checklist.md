---
layout: page
title: Writing and reviewing checklist
permalink: /checklist
horizontal: false
---

See the following list for guidance when creating or updating content. Also use this when peer reviewing pull requests, as well. See _Technical writing standards_ for more details and access to style manuals and other information.

## Writing and reviewing checklist 

- [ ] Are file names, headers, and titles consistent with the feature and the rest of the component doc?
- [ ] For bugs, is the diff clearly addressing the customer concern or code change?
- [ ] Are file names, headers, and titles concise?
- [ ] Does the file have a meaningful short description that tells you why the user wants to use the feature?
- [ ] Are prerequisites clear?
- [ ] Are there any obvious prerequisites that can be removed, such as "You must install the RHACM" in an area where that is understood?
- [ ] Are there any red links when you preview and run Check my links?
- [ ] Are product or technology names consistent with the rest of the documentation, content references, or official guidelines?
- [ ] Are there introductions after headers and before main content?
- [ ] Do you see directional language such as "below" or "above"?
- [ ] Are variables tagged properly and consistently?
- [ ] Do you find commands that are presented together instead of as separate steps?
- [ ] If versions are listed in examples or commands, do they need to be specific or can we build like user input/variables?
- [ ] Does the PR format need to be fixed because commands or sample files are not grayed out?
- [ ] Are there many inline links and are they necessary?
- [ ] Does this require a What's new entry?
- [ ] Is this a known issue or troubleshooting entry that follows the proper format?
- [ ] Does the content present RHACM features inside the MCE doc and if so, is that intentional with tech lead visibility?
- [ ] Does the content cross features and if so, have tech leads discussed best placement for it?
- [ ] Are there any long paragraphs that should be broken up into lists or concise paragraphs?
- [ ] Do you understand what the change is about? 
- [ ] Is content grammatically correct and concise?
  - [ ] Are modals used properly?
  - [ ] Is the content in active voice and present tense?
  - [ ] Do you find wordy content that can be removed or merged?
  - Examples of wordy content:
   - "In other words...", this can be removed just write the words
   -  "...from being automatically imported", can be something like "...from automatic import"
   - Before: "Exclude a managed cluster label from being listed in the _Label_ drop-down filter. Add the label name to the `ignore_labels` list."
   - After: "Add the managed cluster label to the `ignore_labels` list to exclude it from the _Label_ drop-down filter

