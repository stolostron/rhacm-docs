---
layout: page
title: Following technical writing standards
permalink: /tech_writing_standards
horizontal: false
---

"If you follow IBM Style, you already write content that large language models can use. Large language models perform best when the following general rules are applied: Write content that is grammatically correct, clear, concise, appropriate for global audiences, accessible, and easy to translate." -- [_LLM consumability_](https://www.ibm.com/docs/en/ibm-style?topic=medium-llms#adapting-content-for-large-language-model-consumption)

Please read and study this information as a technical writer on the team, or as a contributor. Writing to theses standards is required for merge.

Most of the following content is addressed in the following resources. Red Hat uses both the IBM Style Guide and has for a long time. There is a newer Red Hat supplementary guide for anything not addressed in the IBM Style manual:

* [_IBM Style Manual_](https://www.ibm.com/docs/en/ibm-style)
* [_Red Hat Supplemental_ guide](https://redhat-documentation.github.io/supplementary-style-guide/#_about_this_guide)
* [_Naming_](https://source.redhat.com/departments/marketing/brand/naming)
* [Writing and reviewing checklist](checklist.md)

The guidelines we adopt are industry standard for high quality writing, proper grammar, SEO, translation, accessibility, and readability. See more details within those standards and be familiar with them as you create new documentation.

* [General reminders](#general-reminders)
* [File names, titles, headers](#file-names-titles-headers)
* [Short descriptions](#short-descriptions)
* [Concise, clear content](#concise-clear-content)
* [Lists and tables](#lists-and-tables)
* [Adding links](#adding-links)
* [Requirements for PRs](#requirements-for-prs)

## General reminders 

* Use proper Global English. See [Global audiences](https://www.ibm.com/docs/en/ibm_style/global-audiences.html) in the _IBM Style Manual_.
* Create minimalistic content. Get to the point early and use bulleted lists and steps in place of cumbersome paragraphs. Reduce wordy sentences. Read more about [Minimalism](https://redhat-documentation.github.io/supplementary-style-guide/#minimalism) and using [clear, succinct verbs](https://www.ibm.com/docs/en/ibm-style?topic=grammar-verbs).
* Avoid dangling modifiers. Be sure subject and predicate agree. Read about [subject-verb agreement](https://www.ibm.com/docs/en/ibm-style?topic=grammar-verbs#subject-verb-agreement).
* Know something about the technology: What is the purpose of the new function? Why should a customer use it? This will help you write your _short description_.
* Use only Red Hat supported links. Do not link to open communities, for instance. You can link to Kubernetes products that are integrated with Red Hat products and tested/validated by the Dev team and QE.
* Use only approved abbreviations.
  - Check third-party official doc for abbreviations, for example AWS is used by Amazon. IBM uses few abbreviations.
  - Check manuals and the rest of the doc to see where we use abbreviations and where we don't.
  - Approved abbreviations are only used after initial full spelling and parenthesis: Custom Resource (CR)
* Ask where the user will interact with the feature: Day 1? Day 2? During the Application lifecycle? This will help with placement within the doc.
* Seek guidance from the doc architect before creating a new guide or section if you are not sure about placement.
* Reduce lengthy output examples where you can.
* Do not merge commands with output.
* Ensure YAML and other file samples are in the proper format.
* Consider using variable in versions within commands and samples so we don't get bugs or have to change them. Simply indicate that the user needs to insert the supported version. **Example:** `image: myregistry.example.com:5000/mirror/my-operator-index:v4.x,` replacing `4.x` with the current version.
 
## File names, titles, headers

* Guides with multiple files should begin with an _introductory_ file named, `folder_name/intro.adoc`, which only has conceptual information and links to the rest of the topics. Name the file `overview.adoc` if it is a larger collection that contains a few intros and guides.
* Be sure file names increase usability and don't confuse the reader or writer. Why? Proper and concise file names make our jobs easier. We can find and retrieve files easier and build URLs is easier. **Example:** `man_clu_set.adoc` changes to `manage_clusterset.adoc`, a file that is titled: _Managing ClusterSets_. This increases expectation about the contents of the file.
* Recognize the goal of the content: Task, reference, concept. (Topics will sometimes have a mix of these items.) 
  - _Tasks_ require gerunds ("ing" verbs) in the title and are procedures. (**Note:** a task is not a task if it just links to other tasks.)
  - We ask for validation steps at the end, but you may not get them in your drafts. Those steps are concrete and produce a result, or just skip adding them. **Example:** Run `oc get status` to verify pod status.
  - _Concepts_ are informative about what the product does and how. A topic about architecture is a concept. An intro file is also conceptual. 
  - _References_ are also informative. A breakdown of an API or a glossary could be defined as a reference.
  
* Avoid internal terms. Name the file and section after what the user reads about the product in announcements and in the console. For instance, name a file `console_intro.adoc` and not `ui.intro.adoc` because the product refers to the _console_. Another example is `spoke` cluster, which is an internal term for what we call and managed cluster.
* Use headers for two or more subsections. If you have more than three, create links for them at the beginning of the file for easy retrievabililty and UX.
* Use parallel language for headers. Example: Creating your cluster, Importing your cluster, Destroying your cluster.
* Separate headers with content. Headers should not be placed back-to-back with no content in between. 
* Place no code block in headers because it renders oddly. We do use conrefs and italics when needed instead of code block.
* Make headers and anchors unique, but intuitive and concise. Think about search engine optimization and usability. 

## Short descriptions

* Use complete, but concise sentences with no more than 50 words at a time.
* You also need a short introduction after each header.
* Avoid self-referential language when you can: “This topic...” (Obviously the user knows they are reading this topic.) See more about [Grammar](https://www.ibm.com/docs/en/ibm_style/global-audiences.html#grammar).
* Don't repeat the title in the description.
* Give the user a little knowledge in just a couple sentences about what the topic is about. This requires some knowledge about the function.
* If it is a task, make it clear that it is a procedure in the description. If it is a reference, be sure the user knows to refer to the topic for information. If it is just a concept, make it clear it is only for details about a component or function.

## Concise, clear content

* Analyze your sentence structure. See some examples:
* Use concise sentences. Remove extra words. 
  - First draft: `There are many ways that you can use this feature, but this is one way.` 
  - Better draft: `This is one of many procedures...`
  - Even better draft: `Complete the following procedure to...`
  - First draft: Only users belonging to the certain role can view data belonging to a certain namespace.
  - Better draft: Only users who are assigned to a certain role can view data within a namespace.
    - Belonging is confusing and can mean many things, and it is used twice.
    - A relative pronoun is better used to connect a clause or phrase to a noun or pronoun. The clause modifies, or describes, the noun.
    - The most common relative pronouns are who, whom, whose, which, and that. Sometimes when and where can be used as relative pronouns, as well.
* Mood and voice (avoid subjunctive mood, write in active voice): 
  - Wish, desire, please, recommend –- all of these are not concrete, not imperative. Avoid these.
  - Should (rarely used, but needs clarification when used)
* Tense: Always strive for present tense.  
  - First draft: If you were to save the file (not present, wordy, room for interpretation)
  - Better draft: If you save the file ... (Clear, concise)
* Voice: Use active voice almost always:
  - No: When the latch has been opened, the panel will slide forward. (It's not clear what or who takes the action, avoid passive and past participles)
  - Yes: When you open the latch, the panel slides forward.

The manuals contain many examples and tips for writing concisely.
  
## Lists and tables

Review the guidance for [lists](https://www.ibm.com/docs/en/ibm-style?topic=format-lists#definition-lists) in the IBM Style manual. See a few quick points:
* Use bullets for more than one item, but not just one item.
* Avoid nesting lists more than two levels. If you are nesting that much, consider switching to headers.
* Use parallelism.  
* Definition lists are built with the term in bold and colon. See example:
    - **Definition list:** DLs look like this.
    - Choose complete sentences, or not, but commit and make them the same throughout the list
* Use tables only when a list does not work. Tables can be hard to read, especially on a screen reader.
* Title tables with the same care that you would use to title a topic or section.
* Use left-to-right, top-to-bottom logical order.
* See more guidance for accessibility and formatting tables in the [Red Hat Supplementary manual: Tables](https://redhat-documentation.github.io/supplementary-style-guide/#accessibility-tables) and the [IBM Style Manual](https://www.ibm.com/docs/en/ibm-style?topic=format-tables). 
     
## Adding links

From the Developing Quality Technical Information handbook (IBM Press), do not overuse embedded or inline links:

"Embedded links are links that appear mid-sentence or mid-paragraph. Such links are disruptive because the user must decide whether to go immediately to the information..." (263)

* Careful with inline links. If user needs lots of links, consider a section within the topic named: _Additional resources_.
* You do not need to put a link to _Additional Resources_ in the table of contents if you don't have links to add.
* Name the link such that the user sees value in the title and can better decide whether to click or come back later. Don't name the link [here].
* URLs to Jira issues are usually long and uninformative. Take the extra step to define the link with a good link title. (This is only used in support docs or release notes.)
* Never link to internal files, other internal-only docs like scripts. Have the developer replace a script with steps. Some initial drafts can require this removal. Ensure linked materials are from public spaces.
* Do not link to blogs, temporary repositories, or anything that cannot be validated by the Support Team or QE.
* Avoid linking to upstream documentation and community policies unless necessary. Check with Lead/CS and Support for outliers.
* Because we offer features with other Kubernetes providers, we will at times link to third-party official doc, like AWS.
* When you change a file name, any links to that file also need to change or we will have broken links.

## Comments in the source

* Comments should be temporary. Comments often sit without being addressed because we are busy. They can then create more work for yourself as you eventually return to them or for others. 
* If you are commenting about changes that need to be made, please create an issue and remove the comments as soon as possible as not to clutter the source. The source is open and should be as close to the product documentation as possible to follow `dev>test>prod` principle.
* We only have permanent comments about format or issue numbers in Troubleshooting and Known issues. We do not need them in What's new or Errata.
* When commenting in the source, avoid miscommunications by being specific about the context of the comment. Provide the following information when leaving comments: `//comment | initials or account name | date`

## Requirements for PRs

* Use a few words in your commit message so that internal users understand the commit without having to search. **Note:** Since we cover many components, putting the component name in the message can increase UX. **Example:** `git commit cm -m "<ACM JIRA URL> - siteconfig template resource updated for customer bug."`
* Request peer reviews for all new topics and other changes that are more than a typo or small content correction. **Note:** Small changes for build errors can be merged without peer, but use your judgement about whether you need extra eyes or help troubleshooting.
* Request peer reviews when developers make changes with PRs; you and another writer must review a PR sent from Engineering or QE.
* Request a technical review for any changes that you make other than typos, build errors, or broken links.
* You can merge a `cherry-pick` or copy of a change from a previous branch that was peer reviewed if it is the exact same. 
* Check broken links as you build content. Use the easy _Check my links_ plug-in on each PR in preview mode. Also check the linter.
* Check your PR _requests_ from team members regularly. From the repo, click on **Pull requests** in the header and check for any reviews assigned to you.
* Keep track of peer reviews you request or complete by using the Slack user group `@pr-docs-acm-team`. **Note:** We are a small team and we get busy, so it's a good idea to follow through obtaining reviews before creating more PRs for others to review if you can.
* Consider pulling in multiple peers if there is debate or discussion, or if the content is high-impact and time allows.
* If possible, do not merge a blocked PR if you can reach the original reviewer who previously requested changes.
* If you cannot reach the original reviewer via DM or notifications because they are absent, another reviewer can vouch for those changes. **Note:** not best practice for GH hygiene, so use a comment to indicate all changes were accounted for.
* If you get a Slack approval, but the engineer has not approved in the PR, try to get them to give the official review, but you can tag the engineer in PR comments that they approved on Slack and they are too busy or absent. **Note:** This is not best practice for GH hygiene, but working across timezones (PTO and holidays), at times we need to merge if engineer is unavailable after Slack approval. 
* Ensure your peer reviews and contributions are in your goals since we spend a lot of time helping each other with PRs.
* Use the [Writing and reviewing checklist](checklist.md) to review content.


## Additional resources

* [The 7 principles of naming](https://www.namingthings.co/naming-things-principles)
* [What’s in a Name? Guidelines for Naming Files](https://techwhirl.com/whats-in-a-name-guidelines-for-naming-files/)
*  See more about [procedures](https://www.ibm.com/docs/en/ibm-style?topic=format-procedures) in the IBM style manual.
* Although are RHACM doc repo is not set up the same because we came with established content and collaborate with engineers in the same workspace, you can read more about concepts and procedures in [Red Hat: Writing modular documentation](https://redhat-documentation.github.io/modular-docs/#_creating_modules).   ` 
