---
permalink: /new_documentation
title: "Planning new documentation"
---

# Setting up a new book

Follow these instructions if you have to set up a new book/guide.

**Prerequisites**: You must have access to the following tools and directories:

* GitHub
* `open-cluster-management` repository
* Red Hat VPN
* Pantheon

**Important**: Do you really need a new guide? See the doucmentation architect to discuss this.

To create a new guide in the product documentation, you must create a new folder in your repository, and a new book in Pantheon. When you create a new folder, you must also create a `master.adoc` and `docinfo.xml` file for your new folder.  

## Creating a new folder 

**Create a new folder from GtHub**

1. Log in to GitHub and navigate to the `open-cluster-management/rhacm-doc` repository. 
2. Click the **Add file** button > **Create new file**. 
3. When you enter the name of the folder, select the forward slash (`/`) to continue adding a file to your folder. 
4. Add the `master.adoc` file for your folder. The contents of your file might resemble the following file:

   ```
   include::modules/common-attributes.adoc[]

   = Book/guide name

   include::intro.adoc[leveloffset=+1]
   include::guide_task1.adoc[leveloffset=+2]
   include::guide_task2.adoc[leveloffset=+2]
   ```

5. Add the `docinfo.xml` file to your new folder. Your `docinfo.xm`l file might resemble the following information:

   ```
   <productname>{product-title}</productname>
   <productnumber>{product-version}</productnumber>
   <subtitle>Manage cluster</subtitle>
   <abstract>
       <para>Manage cluster in {product-title}</para>
   </abstract>
   <authorgroup>
       <orgname>{product-title} Team</orgname>
   </authorgroup>
   <xi:include href="Common_Content/Legal_Notice.xml" xmlns:xi="http://www.w3.org/2001/XInclude" />
   ```

**Create a new folder from your text editor**

1. Verify that you are in the `rhacm-docs` repository by running the following command from your terminal:
   
   ```
   pwd
   ```
   
   Your path might resemble the following content:
   
   ```
   /Users/local-cpu-name/rhacm-docs
   ```
   
2. If you are using Visual Studio Code (VSC), select the **New Folder** icon to create a folder. 

## Set up a new book in Pantheon

You must complete the _Set up new title_ form to create a new book. Log in to Pantheon and select the **Set up a new title** button. Complete the following steps to complete the _New title_ form:
   
   1. Verify if you are setting up a new folder from an existing repository in Gitlab, by selecting one of the options that is provided. 
   2. If the repository exists in GitLab, values for the product title and version number are complete.
   3. From the _GitLab Group_ section click the drop-down button and select **Im not sure what to pick**
   4. For _GitLab Project_, select **rhacm-docs?, idk**
   5. Continue to complete the form by selecting values for the _Preview Branch_ and _Stage Branch_.
   // does the preview branch have to only match the version number? Is the Stage branch the branch from GH?
   6. Enter information for the *Content Title*, and select the _Content Type**.
   7. Ensure that the checkbox for _Content directory_ is selected, also select `AsciiDoc` as the _Content Markup_.
   8. You can add multiple new titles by selecting the **Add additional title** button. Otherwise, select **Submit** when the form is complete. 
