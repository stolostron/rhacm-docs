---
permalink: /arch_content_guide
title: "Content guide and standards"
---

Most of the following content is addressed in the IBM Style Manual, so refer to that manual to stay informed about corporate standards.

## Key tips for quality, translatable, accessible content

* Use concise sentences, minimalistic writing, careful writing
* Check broken links as you build content for preprod
* Use Github to search for filenames if you change a filename
* Run the link checker on your files 
* Request peer reviews for all new topics (for ICP ID members) 
* Run local builds and check spelling before you do a PR
* Use proper grammar and follow IBM style (Style manuals are typical in most writing professions)
* Avoid product names in PII
* Run Acrolinx (Update on Acrolinx status at IBM--moved to individual teams instead of marketing)
* **NOTE:** Avoid HTML in .md: causes translation errors and you can usually find a .md solution -Let's clean up our KC
* All this helps translation, readability, usability, presentation, voiceInstructionsfor link & spell checker  and running local build

## Writing concisely and clearly

* Analyze your sentence structure.

Examples:
  - First draft: Only users belonging to the certain role can view data belonging to a certain namespace.
  - Better draft: Only users who are assigned to a certain role can view data within a namespace.

Why? Belonging is confusing and can mean many things, and it is used twice. A relative pronoun is better used to connect a clause or phrase to a noun or pronoun. The clause modifies, or describes, the noun. The most common relative pronouns are who, whom, whose, which, and that. 

* Sometimes when and where can be used as relative pronouns, as well.
* Mood and voice (avoid subjunctive mood, write in active voice): 
  - Wish, desire, please –- all of these are not concrete, not imperative
  - Should (rarely used, but needs clarification—make it must!)
 * Tense: Always strive for present tense.  
  - If you were to save the file (not present, wordy, room for interpretations
  - If you save the file ... (Clear, concise)
  * Active vs passive voice
  - No: When you open the latch, the panel will slide forward.
  - Yes: When you open the latch, the panel slides forward.
  
## Links

From the Developing Quality Technical Information handbook (IBM Press), do not overuse embedded links:

"Embedded links are links that appear mid-sentence or mid-paragraph. Such links are disruptive because the user must decide whether to go immediately to the information..." (263)

* Careful with inline links-- do not overuse. If user needs lots of links, consider a section for references in the topic.
* Name the link so that the user sees value in the title and can better decide whether to click or come back later.
* URLs to GitHub issues are usually long and uninformative. Take the extra step to define the link with a good link title. 
* Never link to internal materials (GitHub issues, Box files, other internal-only docs). Some initial drafts can require this removal. Ensure linked materials are from public spaces.

## Short descriptions

* Use complete, but concise sentences. 
* Avoid self-referential language: “This topic...” (Although this is present in much of KC)
* Don't repeat the title
* Give the user a little knowledge in just a couple sentences about what the topic is about

## Other topics

See the guide for [Writing about user interfaces](ui_text_writing.md).

As the style guide recommends, quotation marks are only for citations, which are rarely used in tech doc. Only use them if they are part of the command so not to confuse anyone not able to read the text without a screen reader.
