---
layout: page
title: Learning Markdown
permalink: /getting_started_markdown
horizontal: false
---

So you gotta start writing in Markdown? If you love DITA, this might be a hard transition. When you get going, you will probably grow to enjoy Markdown. And who does not enjoy having a new skill?

1. Start here with a [basic tutorial](https://www.markdowntutorial.com/). (Should this trusty tutorial go down, search for another one online--but it has been available for a few years now.)
   
2. Save this and use it often--you will reach a point when you don't need it: [Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

## Tips
   
- Header organization has to be consecutive (H1 > H2 > H3), if you accidentally go from H1 # to H3 #, your code will be off.
- If content, like a list, should be indented and be a subset of the preceding content, include the subset content on a new line and indent it by two spaces or one tab. 
- Use `git pull` often to minimize conflicts when you merge and to ensure that you have the latest content that someone else merged. 
- Use the Visual Studio Code preview to see your output...also use the browser preview as a guide...not always 100% accurate, but usually a good way to see your errors.
- After you prompt the user to run a command, be sure to start the codeblock in the following new line; press the spacebar three times to help with the alignment of the codeblock.
- Use anchors for long topics. Since we are getting away from rigid concepts, task, and references, you can have different kinds of content all in one topic. Sometimes the topics get long. Anchors are built much like links. See the beginning of [getting_started_github.md](getting_started_github.md) and notice how the anchors are referenced in the headers.
- Use the back tick character for surrounding coding text. You can't use an apostrophe ('). Use three in a row to begin a codeblock and end it with another three:

   Example: `this is code` and this is `filename` 

   This is a code block:

   ```
   codeblock
   ```

## Tables

Find a table generator that is easy to use to create a Markdown table. Markdown tables are very easy, but have some limitations. For instance, you cannot easily create a list within a cell. You can always search for solutions that may better fit your needs, like using HTML within the cell, but try not to use HTML elsewhere because it can cause build/translation errors. 

(And it is best to use one markup language for simplicity.)


To convert a table to a `.md` table, consider a [Table generator](https://www.tablesgenerator.com/markdown_tables). To convert HTML to Markdown in this specific tool, see the following procedure:


1. Copy and save your output (not the code) as an `.csv` file. Use Numbers or Excel for this step.
2. Go to [the site](www.tablesgenerator.com) and click Import the CSV file.
3. From the Results, click Copy to clipboard.
4. Copy the table and add it to your source to render a `.md` table.

**Notes:**

- These instructions may change; please update as things change on the table generator site.
- Be careful not to lose your title/description. If you find it not generating in the _GitHub preview_, you may need a space between the title and the first row.

## Limitations to Markdown

- As previously mentioned, to add a list to a table cell, create your `.md` table, then use HTML within a cell to create your list. This should be the only time you need to use HTML within a `.md` file.

- Version control can be an issue since you do not have `.ditavals`. The simpler you keep the versioning, then better.

- You need to know the IBM Style Guide and stay on top of changes. Standardization is not as easy as it is in DITA. For instance, IBM DITA writers know exactly when to use `ui-control` (click **something** is bold), and when to use `wintitle` (window or _page_ is italicized). 

This is because the DITA tag alone takes care of the text meaning for us. Work as a team to follow the style guide and use bold, italics, lists, etc... according to the IBM Style Guide and the context of the document. 

