---
layout: page
title: Tools used to improve documentation quality
permalink: /wr_tools
horizontal: false
---

Quality of the Red Hat Advanced Cluster Management for Kubernetes (RHACM) documentation is vital for customer success. Some items of quality that we verify are functionality of links and spelling. Maintain the quality of the RHACM docs by using the following tools:

## Check my links tool

Download the Google Chrome web extension [Check My Links](https://chrome.google.com/webstore/detail/check-my-links/ojkcdipcgfaekbeaelaapakgnjflfglf) or Firefox add-on [Broken Link Checker (Firefox)](https://add0n.com/broken-link-checker.html).

## client9/misspell tool

Complete the following steps to run the spellcheck tool:

1. Install the [`client9/misspell`](https://github.com/client9/misspell) locally by running the following command:
   ```
   curl -L -o ./install-misspell.sh https://git.io/misspell
   sh ./install-misspell.sh
   ```
2. Run the following command in the folder where the `misspell` tool is installed:
   ```
   misspell -w -locale US rhacm-docs 2.8_stage
   ```
   
   **Note**: The results are populated in your terminal automatically.

3. Create a new branch before committing the changes.
4. Create a pull request and verify the updates.  
