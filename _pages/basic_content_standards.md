---
layout: page
title: Basic content standards
permalink: basic_content_standards
horizontal: false
---

Most of the following content is addressed in the IBM Style Manual, the Red Hat Supplemental guide, or PatternFly. Refer to manuals to stay informed about corporate standards. Additionally, many of the guidelines we adopt are industry standards for high quality writing, for proper grammar, and used to engage with technical audiences who seek for quick answers and rely on SEO.

**Note:** Much of these points result from clean-up after the release. It's important that each writer seek these standards while working on refresh items and the current release so that the team is not addressing them later. 

## Team requirements for each PR

* Request peer reviews for all new topics and other changes that result in more than a couple of lines.
* Request technical review for any changes other than typos or broken links. (BZ or DDF are not usually opened by SMEs; seek engineer approval before making changes.)
* Check broken links as you build content. Use the easy _Check my links_ plug-in on each PR in preview mode.
* Check your PR requests from team members. From the repo, click on **Pull requests** in the header and check for any reviews assigned to you.
* Keep track of peer reviews you request or complete by using the Slack user group `@pr-docs-acm-team`.

## Creating a file, section, or list

* Be sure file names increase UX and don't confuse the reader or writer. Example: `man_clu_set` changes to `manage_clusterset`, a file that is titled: _Managing ClusterSets_. This will help the entire product team better manage links in the doc and the console, and it increases expectation about the contents of the file.
* Recognize the goal of the content: Task, reference, concept? Tasks require gerunds in the title, for example.
* Know something about the technology. What is the purpose of the new function? If you don't understand it, you won't be able to advocate for the customer with the content.
* Ask where the user will interact with the feature. Day 1? Day 2? During the Application lifecycle?
* Seek guidance from the architect before creating a book or section so that the team can agree on the best placement for the new content.
* Don't use internal terms to define a file. Example: Wizard. Name the file after what the user will hear about the product.
* Validation steps need to be concrete.
* Headers: parallel, separate headers with content, etc... See more guidance: https://www.ibm.com/docs/en/ibm-style?topic=format-headings
    - Choose gerunds for tasks
    - No code in headers
    - Make headers and anchors unique but intuitive (think about search engine optimization)
* List: avoiding nesting more than 2, parallelism, etc... See more guidance: https://www.ibm.com/docs/en/ibm-style?topic=format-lists
    - Definition lists are built with term in bold and colon.
    - **Definition list:** DLs look like this.
    - Choose complete sentences, or not, but commit!
    
## Short descriptions

* Use complete, but concise sentences with no more than 50 words at a time. 
* Avoid self-referential language when you can: “This topic...” (Obviously the user knows they are reading this topic.)
* Don't repeat the title in the description.
* Give the user a little knowledge in just a couple sentences about what the topic is about. 
* If it is a task, make it clear that it is a procedure in the description. If it is a reference, be sure the user knows to refer to the topic for information. If it is just a concept, make it clear it is only for details about a component or function. (These can be blended, but use steps for tasks.)

## Key tips for quality, translatable, accessible content

The following tips help with translation, readability, usability, presentation, voice.

* Use proper grammar and follow IBM style. (Style manuals are typical in most writing professions.)
* Use concise sentences. This means remove extra words. (See more examples later.)
    - First draft: `There are many ways that you can use this feature, but this is one way.` 
    - Second draft: `This is one of many procedures...`
* Write using minimalistic writing. Get to the point early. Bulleted lists and steps in place of cumbersome paragraphs.
* Avoid dangling modifiers. Be sure subject and predicate agree.
* Use GitHub to search for file names if you change a file name so that you can replace URL paths.
* See instructions for link & spell checker.

## Writing concisely and clearly

* Analyze your sentence structure. Examples:
  - First draft: Only users belonging to the certain role can view data belonging to a certain namespace.
  - Better draft: Only users who are assigned to a certain role can view data within a namespace.
  - Why? Belonging is confusing and can mean many things, and it is used twice. A relative pronoun is better used to connect a clause or phrase to a noun or pronoun. The clause modifies, or describes, the noun. The most common relative pronouns are who, whom, whose, which, and that. 

* Sometimes when and where can be used as relative pronouns, as well.
* Mood and voice (avoid subjunctive mood, write in active voice): 
  - Wish, desire, please –- all of these are not concrete, not imperative
  - Should (rarely used, but needs clarification)
 * Tense: Always strive for present tense.  
  - First draft: If you were to save the file (not present, wordy, room for interpretation)
  - Better draft: If you save the file ... (Clear, concise)
* Voice: Use active voice almost always:
  - No: When the latch has been opened, the panel will slide forward.
  - Yes: When you open the latch, the panel slides forward.
  
## Adding links

From the Developing Quality Technical Information handbook (IBM Press), do not overuse embedded links:

"Embedded links are links that appear mid-sentence or mid-paragraph. Such links are disruptive because the user must decide whether to go immediately to the information..." (263)

* Careful with inline links-- do not overuse. If user needs lots of links, consider a section for references within the topic.
* Name the link so that the user sees value in the title and can better decide whether to click or come back later. Don't name the link [here].
* URLs to GitHub issues are usually long and uninformative. Take the extra step to define the link with a good link title. 
* Never link to internal materials like internal GitHub issues, files, other internal-only docs like scripts. Have the developer replace a script with steps. Some initial drafts can require this removal. Ensure linked materials are from public spaces.

## Comments

When commenting in the source, avoid miscommunications by being specific about the context of the comment. Provide the following information when leaving comments:

`//comment | initials or GitHub account name | date`

Comments should be temporary. Use the date when the comment was signed along with its purpose to determine if the comment is worth removing. If you need additional information, consider reaching out to the person who signed the comment.

## Modals

Using the following modals is acceptable:

* Can: Use to indicate ability.
* Might: Use to indicate possibility.
* Must: Use instead of "have to" or "need to" unless it is too restrictive. Example: "You don't have to" is different than "you must not".

Avoid the following modals:

* Could: Don't use in present tense. Use "can" or "might" instead.
* Should: Avoid by writing in a more direct way.
* Would: Avoid as an auxiliary verb. Only use when referring to an unfulfilled condition ("x would have resulted in y").

Use the following modals only in the manner described by the IBM style guide:

* May: Indicates permission, but it is better to use "can" or "might".

## Supplemental resources

* https://www.namingthings.co/naming-things-principles
* https://techwhirl.com/whats-in-a-name-guidelines-for-naming-files/

