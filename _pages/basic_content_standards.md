---
permalink: /arch_content_guide
title: "Basic content standards"
---

# Basic content standards

Most of the following content is addressed in the IBM Style Manual, the Red Hat Supplemental guide, or PatternFly. Refer to manuals to stay informed about corporate standards. Additionally, many of the guidelines we adopt are industry standards for high quality writing, for proper grammar, and used to engage with technical audiences who seek for quick answers and rely on SEO.

**Note:** Much of these points result from clean-up after the release. It's important that each writer seek these standards while working on refresh items and the current release so that the team is not addressing them later. 

## Team requirements for each PR

* Request peer reviews for all new topics and other changes that result in more than a couple of lines.
* Request techincal review for any changes other than typos or broken links. (BZ or DDF are not usually opened by SMEs; seek engineer approval before making changes.)
* Check broken links as you build content. Use the link checker plug-in on each PR in preview file mode.
* Check your PR requests from team members daily. 
* Add number of peer reviews you requested or completed to your Sprint work.

## Creating a file or section

* Be sure file names increase UX and don't confuse the reader or writer. Example: `man_clu_set` changes to `manage_clusterset`. This will help the entire product team better manage links in the doc and the console.
* Know if this is one of three files: Task, reference, concept. Tasks require gerunds in the title.
* Know the technology. What is the purpose of the new function? If you don't understand it, you won't be able to advocate for the customer with the content.
* Ask where the user will interact with the feature. Day 1? During Application lifecycle?
* Seek guidance from the architect before creating a book or section so that the team can agree on the best placement for the new content.
* Don't use internal terms to define a file. Example: Wizard, Hypershift. Name the file after what the user will hear about the product.
* Validation steps need to be concrete.

## Short descriptions

* Use complete, but concise sentences with no more than 50 words at a time. 
* Avoid self-referential language: “This topic...” (Obviously the user knows they are reading this topic.)
* Don't repeat the title in the description.
* Give the user a little knowledge in just a couple sentences about what the topic is about. 
* If it is a task, make it clear that it is a procedure in the description. If it is a reference, make that clear. If it is just a concept, make it clear it is only for information.


## Key tips for quality, translatable, accessible content

* Use proper grammar and follow IBM style (Style manuals are typical in most writing professions)
* Use concise sentences. This means remove extra words. (See more examples later.)
    - First draft: `There are many ways that you can use this feature, but this is one way.` 
    - Second draft: `This is one of many procedures that you can use.`
* Write using minimalistic writing. Get to the point early.
* Avoid dangling modifiers. Be sure subject and predicate agree.
* Use Github to search for filenames if you change a filename so that you can replace them in links.
* **NOTE:** Avoid HTML, it causes translation errors and you can usually find a better solution.
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
  - First draft: If you were to save the file (not present, wordy, room for interpretations
  - Better draft: If you save the file ... (Clear, concise)
* Active voice almost always:
  - No: When the latch has been opened, the panel will slide forward.
  - Yes: When you open the latch, the panel slides forward.
  
## Adding links

From the Developing Quality Technical Information handbook (IBM Press), do not overuse embedded links:

"Embedded links are links that appear mid-sentence or mid-paragraph. Such links are disruptive because the user must decide whether to go immediately to the information..." (263)

* Careful with inline links-- do not overuse. If user needs lots of links, consider a section for references in the topic.
* Name the link so that the user sees value in the title and can better decide whether to click or come back later.
* URLs to GitHub issues are usually long and uninformative. Take the extra step to define the link with a good link title. 
* Never link to internal materials (GitHub issues, Box files, other internal-only docs like scripts. Have the developer replace a script with steps). Some initial drafts can require this removal. Ensure linked materials are from public spaces.