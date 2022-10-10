---
layout: page
title: Linking
permalink: /wr_linking
horizontal: false
---

Links in the documentation are important to the reader. Broken links create an inconvenient experience, and interrupts the review during documentation tests. As you create customer-facing documentation, it is important to consider the placement and accuracy of links. 

When writers advise readers to select a link, it can be disruptive and divert the reader away from the task. To keep the customer in mind, consider providing a link at the end of your page to direct the user to the topic they previously read. This is beneficial in case the user wants to return and view more topics.

**Important**: Link only to related topics, and avoid using more than 10 links in your topic. See your corporate manual for more information.

## Types of link referencing

There are several ways reference links in the ASCII source file (`.adoc`). View a list of examples for link referencing:

* Document/section header, otherwise known as anchors. Use these anchors for longer topics or topics with lots of headers (three or more). Add them after the short description:

  ```
  [#your-anchor-for-the-doc]
  = Your anchor for the doc

  [#section-header-example]
  == Section header
  ```

  **Note:** It is not required for the anchor to match the entire name of the document or title. Ensure that the link reference includes the correct anchor for a specific document. Avoid using spaces and special characters in the brackets

* External links and cross-book references :

  ```
  //External link
  link:https://your-url-here.com[Your URL]
  
  OR 
  
  //cross-book reference
  link:../console/web_console.adoc#random-web-console[Web console link example]
  ```

* Internal cross reference links:

  ```
  // Inline cross reference
  <<<section-anchor,section-title>>>

  //same book cross reference
  xref:../console/web_console.adoc#random-web-console[Web console link example]
  ```

* Image links

  ```
  image::Image-example.jpg[My image]
  ```

You must verify that the links are functioning as expected. If there are broken links in your source file, you might receive the following errors:

* 404 Error
* Direct the user to the wrong page or section 
* Error in the Pantheon log

## Tips

1. Install and use the link check extension for Google Chrome [Check My Links](https://chrome.google.com/webstore/detail/check-my-links/ojkcdipcgfaekbeaelaapakgnjflfglf?hl=en) or Firefox add-on [Broken Link Checker Firefox](https://add0n.com/broken-link-checker.html).

2. If you discover that there is a broken link from the Pantheon log, use Visual Studio Code for efficiency, to find out which file the broken link resides. Select the **Search** icon in Visual Studio Code, to search for the anchor that is in the Pantheon log. All instances are returned.

3. Verify that there are no extra spaces in your anchor.

4. Verify that the links work correctly by using the _Preview_ tab in GitHub when you edit a file.

   1. Open the options list for the links before you click the link
   2. Select the **Open in a new tab** option.  



