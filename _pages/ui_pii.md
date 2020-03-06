---
permalink: /ui_pii
title: "Pii"
---

## What is PII? 

[PII](http://w3-03.ibm.com/globalization/page/4161) (Program Integrated Information) is user-visible text that is contained within a software program and is integral to the execution of that program. This applies to all software, whether it is operating system, middleware, or application software.

In this context, "contained within" means accessible only by running the software, and "integral to execution" means essential to the execution of the software. Traditionally, this has meant messages, contextual help, and extended help information. The introduction of new human-computer interaction technologies broadens this to include concepts such as intelligent agents, coaches, and wizards. The primary goal of such concepts is to guide users through complex tasks rather than to educate or inform.

## Where is PII used?

PII is used throughout our User Interface (UI) and products for embedded assistance and progressive disclosure, such as 

- Labels and alt text for UI controls
- Tooltips
- Error messages
- Inline text in UI
- Descriptive text in UI
- Chat Bots
- Command Line Interface
- Control-level assistance (tooltips)
- Hover help or pop-up help (infopops)
- Context-sensitive help
- Messages (error, information, other)
- Panel-level assistance or additional control level assistance linked from the UI
- Cross-panel-level or user task-based assistance linked from the UI
- Where the content of the task helps to drive the user through the UI
- Extended help
- Wizards
- Intelligent agents
- Mnemonics or accelerators
- Hot keys
- IPLA family of software license agreements
- Terms of Use
- Service Delivery contracts (SD)

## Reason for ID input on PII

- ID reviews all new PII, such labels, tooltips, error messages, and other UI text
- ID reviews with IBM style, IBM terminology, existing docs, and progressive disclosure in mind
- Focus on consistency across all product documentation and other IBM products including the following documentation sources:
  - UI text 
  - Knowledge Center
  - Blogs 
  - Other (presentations, readmes, release notes)
- Structure text for translation and accessibility
- Identify errors and potential issues early to avoid client issues and late UI changes
- Provide assistance to design and development with writing UI text
- Provide feedback on related user flows to improve and simplify UI and text

## Process to get PII reviewed

For general clean-up, a GitHub issue needed (if using a dev issue for PII files, add ID label `squad:doc` and your squad's assigned writer):
- Add the label `PII`
- Create your PR and assign writer as reviewer
- Additionally, you can provide the link to your properties files and request that the writer edit the file for you in his or her own branch/PR
____________________________________________________________________________________

Hill Process: (this is only for new work assigned per hill): 
- Issue (squad: design and squad: doc) 
- InVision prototype for Design/ID (Doc writer/Design focal/Design content focal) to get feedback on content. (Relies on the latest build)
- Mid-fi for feedback and initial review
- Hi-fi/Redline for final design reference for implementation
- ID initiates PR and gets all reviewers needed
- Developers handle implementation and final review
- For Hill work, Content Designer will likely have an issue opened and have Dev/ID assigned if there is a content designer

## Error Messages

IBM provides guidelines for messages within the Information Development Knowledge Center. For more information, see [Message quality and process](https://rtpdoc01.rtp.raleigh.ibm.com:9445/kc/idibm/com.ibm.utic.authoring_messages.doc/doc/messages_summary.html)

Ensure that you follow these guidelines to avoid poor error messages: 

- Poorly written and incomplete messages are costly to IBM:

- Poor messages cause customers to call IBM Support, which can cost thousands, if not tens of thousands, of dollars.
For many products, the top searches on information centers or other search engines are for messages: Customers are looking for more information to help them resolve the problem. In many cases, the message that was shown in the interface was not helpful.
Regularly review information center search statistics to determine whether users are looking for specific messages. There could be problems with those messages.

- Poor messages reflect badly on IBM products. Consumable software and hardware products require that all parts of the product, including user interface (UI) text, embedded assistance, information center and help topics, and messages are clear, accurate, complete, and helpful.


