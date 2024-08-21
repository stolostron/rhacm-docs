---
layout: page
title: Writing for UI
permalink: /ui_writing
horizontal: false
---

## Prerequisites

Always start with the [IBM Style Guide](https://source.redhat.com/groups/public/ccs/ccs_folder/ibm_style_guide/ibm_stylepdf). From the navigation, notice that the style guide covers not only product documentation, but a variety of other topics.

Keep an eye on the _What's new_ section in the guide, as it is regularly updated. 

To build content that references the UI, follow the guidance in the GUI elements topic.

For example, you will see the following guidance for clickable items and icon images:

_For graphical items such as push [clickable] buttons or icons, if users would benefit from seeing the graphic, include it after the label or tooltip name._

_If the graphical item does not have a label or name, provide a generic description._

**Example:** On the toolbar, click the **Permanent Pen** icon [image-here].

Always start with the IBM Style Manual since it helps all teams have one voice. See the following section to see how the product is standardized on top of the IBM standards:

## Guidance for console content

- The user interface is named the **console** (lowercase unless for some strange reason you start your sentence with console).

- While you do not have to document the console, the doc will have console tasks, so it is important for the team to agree on elements outside of the GUI style guide.

- If you have an extensive console, you may want to create and maintain a _Console guide_ in the documentation. This section is a place where you can explain very active pages, such as the _Getting started_ page. Additionally, you may have to document short tasks that only belong to the console, like _Configuring a logo_.

- For windows, modals, pages, etc..., italicize the element. Example: Find your cluster in the _Cluster details_ page. Reserve bold for clickable items.

- Be sure to use _Search_ and _Find_ properly. Many times you are telling the user to find something in a list, but you are telling them to search for something in the _Search box_ or _Search bar_. Be clear when using these two terms.
(This was an issue raised by a Design VP because the two words confused the user.)

- Though the first page the user sees has "welcome" in the URL, it is called the _Getting started_ page. Be sure to stay on top of changes on this page. Also be sure to have the ID team stay on top of links on this page. For instance, the console may have a link to the documentation, but the writer may have removed that file. This has in the past caused broken links on the _Getting started_ page.

- The GUI element **(...)** is currently named _Options_, though the hover help reads: "Click for more options." 

When you decide what to name an element (if it is not named in the IBM Style Manual), you should use the hover-help as a guide. It is important that the ID team name the element the same. 

**Note:** If the UI developers do not have hover-help for a GUI element, always check with them and maybe encourage them to name their element in hover help.

## Selected guidance

|Element|Reason|Guidance|
--------|------------|-------------|
|Bold|Use for UI, clickable components|Use bold for UI buttons and clickable elements. Do not use bold for emphasis, see Style Guide.
|Variable inside of a command or script sample|Identify as a variable.|Use angle brackets (<>) to identify a variable. Surround the variable with the angle brackets (<>) to identify it within the existing monospace style. Ex: `oc get <namespace>`. 
|Variable ouside of a command or script sample (in normal text).|Identify as a variable.|Use monospace style to identify a variable. Surround the variable with backticks to add the monospace style to identify it as a variable. Ex: Replace `namespace` with the name of your project namespace. 
|Menu cascade|Identify it as successive selections in a menu|Use bold for the selections, and separate them by the character >. The > should not be bold. For example: *Multi-cluster* > *Pods*|
|A window or UI page|Identifies a title|Use italic for this content. Example: In the _windowname_ window, select *Save*.
|Quotation marks|Not really used much in docs outside of within codeblocks (citations only and rarely in doc)|Try to avoid

## UI content

User-facing content is user-visible text that is contained within a software program and is integral to the execution of that program. This applies to all software, whether it is operating system, middleware, or application software.

In this context, "contained within" means accessible only by running the software, and "integral to execution" means essential to the execution of the software. Traditionally, this has meant messages, contextual help, and extended help information. The introduction of new human-computer interaction technologies broadens this to include concepts such as intelligent agents, coaches, and wizards. The primary goal of such concepts is to guide users through complex tasks rather than to educate or inform.

## Where to find UI content

Used throughout our User Interface (UI) and products for embedded assistance and progressive disclosure, such as 

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

## Reasons for doc input on UI content

- Doc reviews all new UI content, such labels, tooltips, error messages, and other UI text (writers please make sure this is consistent across pillars)
- Doc reviews with IBM/Pattern Fly/RH style, terminology, existing docs, and progressive disclosure in mind
- Focus on consistency across all product documentation and other products including the following documentation sources:
  - UI text 
  - Portal
  - Blogs 
  - Other (presentations, readmes, release notes)
- Structure text for translation and accessibility
- Identify errors and potential issues early to avoid client issues and late UI changes
- Provide assistance to design and development with writing UI text
- Provide feedback on related user flows to improve and simplify UI and text

## Process to get user-facing content reviewed

For general clean-up, a GitHub issue is needed for the doc team.

- Dev can create your PR and assign writer as reviewer, confident writer can also make a change to dev source if devs agree
- Additionally, you can provide the link to your properties files and request that the writer edit the file for you in his or her own branch/PR

## UI error messages

Ensure that you follow these guidelines to avoid poor error messages: 

- Poorly written and incomplete messages are costly:

- Poor messages cause customers to call Support, which can cost thousands, if not tens of thousands, of dollars.
For many products, the top searches on information centers or other search engines are for messages: Customers are looking for more information to help them resolve the problem. In many cases, the message that was shown in the interface was not helpful.
Regularly review information center search statistics to determine whether users are looking for specific messages. There could be problems with those messages.

- Poor messages reflect badly on products. Consumable software and hardware products require that all parts of the product, including user interface (UI) text, embedded assistance, information center and help topics, and messages are clear, accurate, complete, and helpful.