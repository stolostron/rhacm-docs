---
permalink: /wr_validationtools
title: "Validating documentation"
---

# Validating documentation locally

Producing documentation requires patience and diligence because the work can become tedious. Writers often make small mistakes such as mispelling a word or filename. When you mispell a filename, the link is considered broken. Review the following sections to learn how to validate documentation:

- [Markdown tools](#md)
- [Acrolinx](#acro)
- [Accessibility testing](#accessible)
- [Technical reviews](#review)

## Markdown tools
{: #md}

Markdown has a few tools to help you validate that you are producing error-free files, such as the [Link checking tool](#link),[Spellcheck tool](#spell), and [Local build tool](#local).

**Prerequisite:** Before you begin, you must download [NPM](https://nodejs.org/en/download/current/) for your operating system.

* If you are a MacOS user, complete the following steps to install NPM:
    
  1. Install Xcode from the Apple Store.
  2. Install Homebrew from your Terminal by running the following command:
     
     ```
     ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
     ```
     {: codeblock}
  3. Install NPM from your Terminal by running the following command:
  
     ```
     brew install node
     ```
     {: codeblock}
     
     
* If you are a Windows user, complete the following steps to install NPM:

  1. After you download the install, double-click the installer and complete the instructions that are provided. 
  
    **Note**: You can use the default settings. If you encounter problems, you can use the package installer and follow the instructions on the [NodeJS site](nodejs.org).
    
  2. Verify that NodeJS and NPM are installed by running the following commands:
  
     ```
     node -v
     
     npm -v
     ```
     {: codeblock}
     
You are now ready to validate your documentation. 

### Broken link tool 

Install the Markdown broken link tool to extract links from markdown files.

#### MacOS 

Install and run the broken link tool from your terminal by completing the following steps:

1. Install the link check tool from the command-line interface (CLI) by running the following command:

   ```
   npm install -g markdown-link-check
   ```
   {: codeblock}
   
2. On your local drive, navigate to the directory where the `docs` repository is cloned. Run the following command:

   ```
   cd ~/Documents/docs
   ```
   {: codeblock}
   
3. Run the link check tool on the `docs` repository. To create a text file of your results from the tool, run the following command:

   ```
   find . -name "*.md" -exec markdown-link-check -q {} \; > ../filename.txt
   ```
   {: codeblock}
   
 4. Open the text file that has the broken link results by navigating to the file with the Finder application. 
   
   
**Tips**: You may encounter the following results in your text file:

   ```
   FILE: ./manage_cluster/create_storage_class.md
   [✖] ../manage_cluster/create_vfd_vol.md
   
   FILE: ./manage_cluster/ma_adv.md
   [✖] ../../images/icons/launch-glyph.svg
   
   FILE: ./supported_system_config/hardware_reqs.md
   [✖] ../../supported_environments/edge/install_edge.md#prereq_hard
   
   FILE: ./apis/mcm/mt_mcm_apis.md
   [✖] ../../../manage_cluster/cluster_endpoints.md#master
   [✖] ../../..//apis/cfc_api_files/directory_mgmt.md#list
   ```
   {: codeblock}
   
   * Remember, icons are considered to be internal links. Be sure to use the _Preview_ feature view in Visiual Studio Code (or another text editor), or select the _Preview changes_ tab in GitHub from the browser. 
   * When you reference a section on the same page or a different one, ensure that the anchor name matches the spelling of the anchor in the section.
   * When you reference an internal file, you might have to add `../` to indicate that the file is in a different folder. Preview your changes as described previously and test the links to your file. Choose to open the link in a new tab. 

**IMPORTANT**: Instructions for Windows is currently unavailable. 

#### Running the broken link tool on multiple repositories

Recently, there was a shift in documentation where we needed to manage two different repositories for one Knowledge Center. As a result of this seperation, there were a ton of broken links and difficulties verifying the functionality of links. No need to worry, you are able to run the broken link tool on both repositories. 

**Prerequisite**: You must clone the `CP4MCM-docs` and `common-services` repository.

Complete the following steps to run the broken link tool:

1. Select your text editor application and open your folders. For example, open the `CP4MCM-docs` folder in Visual Studio Code (VSC). 

2. After you open the application, open the `common-services` folder in a seperate VSC window. Select **File** > **New Window**. 

3. Open the terminal for both VSC windows that you have opened. From the CLI, get the updated version of the repositories. Be sure to verify your current branch. Run the following commands:

   ```
   git branch 
   
   git pull
   ```
   
4. Copy both folders and rename them. From the Finder application, double-click the folder name and select rename. For example, rename your `CP4MCM-docs` folder to `CP4MCM-docs-copy`.

5. Copy all of the files that are in your copied folder for `common-services` and move it into your copied folder for `CP4MCM-docs`. The copied folders are now combined.

6. Now, open another VSC window of the combined folder and run the broken link tool by running the following command:

   ```
   find . -name "*.md" -exec markdown-link-check -q {} \; > ../combine.txt
   ```
   {: codeblock}
   
7. Open the `combine.txt` file to view the results.

**CLI task**

Complete the following steps to run the broken link tool on more than one repository:

1. Copy the `.md` files of each repository and add them into a new folder. Run the following commands:
   
   ```
   cp -rf common-services-docs/ combined
   cp -rf CP4MCM-docs/ combined/
   ```
 
2. Change your directory path and run the broken link tool by running the following commands:

   ```
   cd combined
   find . -name \*.md -exec markdown-link-check -q {} \; > broken_links.txt
   ```
   {: codeblock}

### Spellcheck tool
{: #spell}

Install the Markdown spellcheck tool to extract misspelled words from markdown files.

#### MacOS 

Install and run the spellcheck tool from your terminal by completing the following steps:

1. Install the spellcheck tool from the CLI by running the following command:

   ```
   npm i markdown-spellcheck -g
   ```
   {: codeblock}
   
2. On your local drive, naviagte to the directory where the `docs` repository is cloned by running the following command:

   ```
   cd ~/Documents/docs
   ```
   {: codeblock}
   
3. Run the spellcheck tool and create a text file with the results by running the following command:

   ```
   mdspell -r -n -a --en-us *.md **/*.md **/**/*.md **/**/**/*.md > ../yourfilename.txt
   ```
   {: codeblock}
   
4. Open the text file that has the results of the misspelled words by navigating to the file from the Finder application. 


#### Windows

Create shortcuts on your local drive to run the spellcheck tool. Complete the following steps: 

1. Right-click on your desktop. Select **New** > **Shortcut**.
2. Enter a value for the location of your tool. Your value might resemble the following path:

   ```
   C:\Windows\System32\cmd.exe /k mdspell -r -n -a --en-us *.md **/*.md **/**/*.md **/**/**/*.md > ../yourfilename.txt
   ```
   {: codeblock}

3. Click **Next**. 

4. Enter a name for your command, then click **Finish**. 

5. Right-click your new desktop shortcut and click **Properties**.

6. Replace any default path with the path to where the command needs to run in the **Start in** field. In this case, run the shortcut in the folder where you installed your `docs` repository and NPM. 

7. Run the command by double-clicking the shortcut. A command-line window opens and when the process is complete, it shows the path to the specified _Start in_ location.

8. Check your specified destination for the resulting files (either your root Docs folder or your output folder).

### Local build tool
{: #local}

Install and run the [Markdown marked-it tool](https://github.com/IBM/marked-it-cli/blob/master/README.md) to access a HTML preview of your .md files. Produce a local build by completing the following steps: 

1. Install marked-it-cli from the CLI by running the following command:

   ```
   npm install -g marked-it-cli
   ```
   {: codeblock}
   
   **Note**: If your installation is unsuccessful, run the following command: `sudo npm install -g marked-it-cli`.
   
2. Run the marked-it tool to create a local. Your command might resemble the following path:

   ```
   marked-it-cli /Users/mikeladockery@ibm.com/docs-icp/ --output=/Users/mikeladockery@ibm.com/Documents/output --conref-file=/Users/mikeladockery@ibm.com/Documents/docs-icp/conrefs.yml --toc-xml --overwrite --verbose
   ```
   {: codeblock} 
   
   **Important**: According to the path that is previously provided, the results of the local build are located in my `Documents/output` folder. You can rename your output folder. 
   

#### Running the local build tool on multiple repositories

Complete the following steps to run the marked-it tool on multiple repositories from the CLI:

1. Copy the `.md` files of each repository and add them into a new folder. Run the following commands:
   
   ```
   cp -rf common-services-docs/ combined
   cp -rf CP4MCM-docs/ combined/
   ```
 
2. Change your directory path and run the marked-it tool to produce a local build for both repositories. You must use the same output folder. Run the following commands:

   ```
   cd combined
   
   marked-it-cli /Users/mikeladockery@ibm.com/CP4MCM-docs/ --output=/Users/mikeladockery@ibm.com/Documents/output-combo --conref-file=/Users/mikeladockery@ibm.com/Documents/docs-icp/conrefs.yml --toc-xml --overwrite --verbose
   
   marked-it-cli /Users/mikeladockery@ibm.com/common-services-docs/ --output=/Users/mikeladockery@ibm.com/Documents/output-combo --conref-file=/Users/mikeladockery@ibm.com/Documents/docs-icp/conrefs.yml --toc-xml --overwrite --verbose
   ```
   {: codeblock}

## Acrolinx
{: #acro}

Add Content 

## Accessibility testing
{: #accessible}

Add Content 

## Technical reviews
{: #review}

Add Content 
