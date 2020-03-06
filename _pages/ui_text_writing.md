---
permalink: /ui_text_writing
title: "Writing about user interfaces"
---

## Prerequisites

Always start with the IBM Style Guide. You can see from the navigation that the style guide covers not only product documentation, but a variety of other topics.

Keep an eye on [What's new](https://apps.na.collabserv.com/wikis/home?lang=en-us#!/wiki/W580a84a67242_4da6_81cf_69e3db4bdbfa/page/What's%20new), as it is regularly updated. 

To build content that references the UI, follow [GUI elements](https://apps.na.collabserv.com/wikis/home?lang=en-us#!/wiki/W580a84a67242_4da6_81cf_69e3db4bdbfa/page/GUI%20elements).

For example, you will see the following guidance for clickable items and icon images:

_For graphical items such as push [clickable] buttons or icons, if users would benefit from seeing the graphic, include it after the label or tooltip name._

_If the graphical item does not have a label or name, provide a generic description._

**Example:** On the toolbar, click the **Permanent Pen** icon [image-here].

Please always start with the IBM Style Manual since it helps all teams at IBM have one voice. See the following section to see how the product is standardized on top of the IBM standards:

## Guidance for console content

- The user interface is named the **console**. (Lowercase unless for some strange reason you start your sentence with console.)
There is a conref for this element. If changed, open a git issue for stakeholders (ID team) and agree on the name, then change the conref.

- While you do not have to document the console, the doc will have console tasks, so it is important for the team to agree on elements outside of the GUI style guide.

- If you have an extensive console, you may want to create and maintain a _Console guide_ in the documentation. This section is a place where you can explain very active pages, such as the _Getting started_ page. Additionally, you may have to document short tasks that only belong to the console, like _Configuring a logo_.

- For windows, modals, pages, etc..., italicize the element. Example: Find your cluster in the _Cluster details_ page. Reserve bold for clickable items.

- Be sure to use _Search_ and _Find_ properly. Many times you are telling the user to find something in a list, but you are telling them to search for something in the _Search box_ or _Search bar_. Be clear when using these two terms.
(This was an issue raised by a Design VP because the two words confused the user.)

- Though the first page the user sees has "welcome" in the URL, it is called the _Getting started_ page. Be sure to stay on top of changes on this page. Also be sure to have the ID team stay on top of links on this page. For instance, the console may have a link to the documentation, but the writer may have removed that file. This has in the past caused broken links on the _Getting started_ page.

- The GUI element **(...)** is currently named _Options_, though the hover help reads: "Click for more options." 

When you decide what to name an element (if it is not named in the IBM Style Manual), you should use the hover-help as a guide. It is important that the ID team name the element the same. 

**Note:** If the UI developers do not have hover-help for a GUI element, always check with them and maybe encourage them to name their element in hover help.

## But I wrote using DITA!

Yes, DITA is widely known here at IBM. It is easier to write accessible doc with tags like `ui control` and `varname`. With Markdown, it is important to write as if the tags cannot "speak" for you with a screen reader.


Consider a small list of differences and similarities if you are coming from DITA to Markdown:


|Element|Similarities|Differences|
--------|------------|-------------|
|Bold|Use for UI, clickable components|Use .md bold tag where you would have used `ui-control`. Do not use bold for emphasis, see Style Guide
|Variable|Still build as italicized just like DITA|Use .md italics tag. No `varname` tag, so use <these> to identify a variable
|Menu cascade|Bold, same as DITA|No `menu cascade` tag, build as **Multi-cluster** > **Pods**|
|A window or UI page|Usually italicized|No `wintitle` tag, simply _use this_ for those types of indicators.
|Quotation marks|Death to " " not in codeblocks, see IBM Style guide for when to use (citations only and rarely in doc)|no diff--they are not good for accessibility

