---
permalink: /globalization_translation
title: "Translation"
---

## Best practices for packaging files for translation

It is highly recommended that the same individual on the ID team packages and sends all translation shipments for a release. If you plan to rotate translation assignments, transfer responsibilities between releases.

For example, for a release (_Release1Q*_) that includes two translation shipments (_Shipment 1_, _Shipment 2_), the same Information Developer should send both shipments.

The reason for this process is because the TPT tool records the previous versions of shipped packages that are within your local machine directory whenever you send a shipment. These previous versions are referenced when you send subsequent shipments.

For example, for _Release1Q_, if _Information Developer A_ sent _Shipment 1_ and now _Information Developer B_ sends _ShipmentB_, an issue occurs. When _Information Developer 2_ is using the TPT tool to select and send _Shipment 2_, the tool cannot detect _Shipment 1_ as it does not exist on the local machine for _Information Developer B_. The TPT tool then shows an error to indicate that the shipment is being sent out of sequence. This issue results in _Information Developer B_ being unable to send the shipment as _Shipment 2_. However, if _Information Developer A_ sent _ShipmentA_ and now sends _ShipmentB_, no issues occur as the connection to the _ShipmentA_ exists. By having the same Information Developer send both packages, the issue is avoided.

The following instructions do provide a workaround if you do encounter an out of sequence error when different Information Developers are sending shipments.

## Before you begin

- Determine the directory location on your local machine where the files that you want to package are stored.
  - This directory should be nested no deeper than two levels from the drive letter.

    For example, `C:\Translation\31\<files to be sent and their corresponding folders are here>`

- Install the latest version of the Translation Packaging Tool (TPT).
  - Windows
    - Download the latest version of the TPT release from [TPT releases](http://w3-03.ibm.com/globalization/page/2306)
    - Use the install instructions for the release to install the tool.
  - Mac
    - Download and install the tool from the Mac@IBM Store.

  If needed, apply any hotfixes that are available. The hotfixes are available from the [TPT releases](http://w3-03.ibm.com/globalization/page/2306). Use the install instructions for the fix to apply the fix.

- Ensure that you are using the current version of the CHKPII tool. TPT will not open without the current CHKPII version. Instead, TPT will provide a message that states that your CHKPII is back level.

  To download and install the current CHKPII tool, see [CHKPII](http://w3-03.ibm.com/globalization/page/2011)

**Notes:**
- You cannot use TPT Light with Cloud Pak or Common Services files. There are too many files for that tool to work.
- For a list of all available translation tools, see [Translation tools](http://w3-03.ibm.com/globalization/page/1996).

## Packaging files

1. Go to the Git repository where your project source files are stored and download a Zip file clone of the branch that includes the files to send to translation.

2. Extract the downloaded Zip package files to the directory on your local machine where you want to store your translation packages. This directory should be nested no deeper than two levels from the drive letter. The following steps assume that this directory is `C:\translation.`

3. Prepare your files by removing files that do not need to be included in the package that is sent to translation. For instance, remove the following items from the directory structure:

   - `images` directory
   - `readmes` directory
   - `.vscode` directory
   - `README.md` in the docs directory
   - `issue_template.md` from the docs directory
   - `.spelling` from the docs directory
   - `.gitignore` from the docs directory
   - Any `nls` directory

4. **Final release shipment only:** Create a branch from your working GitHub repository directory that will be used for the translations and the DVT.
   - Name the branch `*release*-nlv`
   - No one should push to this branch except you and the Globalization Project Manager. This branch is your consistent copy of the documentation files that are used to run DVT. By separating this branch, you allow the rest of the ID team to keep pushing updates for the current release.

5. Launch the TPT tool.

**If you are not packaging the first shipment for a release, skip to step 7.**

6. If you are packaging the first shipment for a release or you did not ship the previous shipments for a release, create a project profile within the TPT tool for the release:

   1. Select **File** > **New** > **Project Profile**.
   2. Click **Update** beside the _MTP Charge To ID_ field to make sure that you have the latest ID values pulled that are available in MTP.
   3. Use type-ahead to find your assigned _Charge to ID_ (C2ID) for the shipment.  The translation planner (Globalization Project Manager) provides this ID. An example is ICP31ABD001. Note: ID typically has 2 of these IDs.  Both should indicate non-PII. One is for the Quick-start guide (designated as "readme files"), and one is for the IBM Knowledge Center shipments. Be sure that you are using the correct one. If you click on one to select it, its name is displayed.
   4. Enter the following information into the *Notes* field:

      - `Notes title`
      - `Keywords`
      - `Readmes`

      For example

      ```
      # Translation notes for IBM Cloud Pak for Multicloud Management non-PII

      Return to GSA.

      ## Keywords

      Attached is the `conrefs_cp.yml` file, which should be translated, as necessary. These are mostly product names and terms. See the following list and also the non-translatable `.yml` file for more examples:

      gui:
      console

      product:
      IBM Cloud Pak for Multicloud Management

      icpcf-ops:
      IBM&reg; Cloud Private Cloud Foundry ops console

      ## Readmes

      **There is a separate shipment for the readmes**
      ```

   5. Select **File** > **Save** to save your project profile.

7. Create a new source package by selecting **File** > **New** > **Source package**.

8. Select the project profile that you want to pair with this source package and click **Open**. Most likely, it will be your C2ID. Again, make sure that you select the correct one.

9. Select the correct shipment in the _MTP Shipment Name_ field.

   - CD_Doc_Ship: For sending common documentation shipments
   - DVT_Doc_Ship: For shipments to address translated document test issues

   This field is very important. If you select the wrong shipment, all types of fire and fury will fall upon you. Not really, but your life will become more difficult than it needs to be.

   Readme files generally are sent in shipment 1 only. Most releases will often have a shipment 1 and a shipment 2. Make sure that you select the correct shipment. If the plan information does not match the correct information, update your _MTP Charge To ID_ value.

10. Enter the following information in the Package Notes field.

    ```
    # Translation notes for IBM Cloud Pak for Multicloud Management non-PII

    Return to GSA.

    ## Keywords

    Attached is the `conrefs_cp.yml` file, which should be translated, as necessary. These are mostly product names and terms. See the following list and also the non-translatable `.yml` file for more examples:

    gui:
    console

    product:
    IBM Cloud Pak for Multicloud Management

    icpcf-ops:
    IBM&reg; Cloud Private Cloud Foundry ops console

    ## Readmes

    **There is a separate shipment for the readmes**
    ```

11. Click **Next** to move to the next step.

    There should be buttons at the bottom of the window. If you don't see the buttons, adjust your window size. They can be hidden with certain settings.

12. Browse to the folder where you extracted the clone of the branch that you created.

    In this example, it is `C:\translation\docs`

13. Select the _Include subfolders_ checkbox.

14. Select **Add All>>** to add all of the files to the package.

    **Reminder:** Ensure that you removed any unnecessary files and folders from these folders before you add the files.

    This step will take a while. Watch the status under the _Selected Files_ pane - it will show the files as they are being added.

15. Review the list of _Selected Files_ within the tool. Make sure that you DO NOT have any files listed within a subfolder that is not part of the topic directory structure. For example, `getting_started\whats_new.md` is OK, `Translation\31_files\getting_started\whats_new.md` is not OK.

    If a subfolder other than the actual subfolders for a file, such as `getting_started` is listed, the package is rejected.

    Two folder levels, such as `C:Translation\folder\files` works OK with the tool. The tool does not insert an additional folder into the filepath on the files tab when the files are packaged.

    If you see something like `31_files\getting_started\whats_new.md` on the _File Details_ tab, then the package will be rejected since `31_files` isn't part of the directory structure for the content. The path should include only the folders that are part of the directory structure for the content, so, `getting_started\whats_new.md` is what you want to see.

16. Click the **File Details** tab. Then, click **Perform CHKPII**.

17. Document any deviations that are identified from the CHKPII check. Files that includes a red-colored cell for the _CHKPII Errors_ column include one or more errors.

    - For files that include two CHKPII errors, the errors are likely caused by two examples that list acceptable characters.

      1. For each file that includes one or more errors, select the row for the file.
      2. Right-click the red cell for the selected row and select **View CHKPII Errors**
      3. Depending on the error, fix the issue or enter a deviation.
         Enter a deviation only after you checked to make sure your file contents are correct, but still causing CHKPII error. Deviations should be a rare occurrence.
      4. To enter a deviation, right-click the red cell for the selected row and select **Edit CHKPII Deviation**. Enter an explanation, such as _"This is an example that cannot be updated. Please disregard the CHKPII error."_
      5. Repeat for all files that include errors.

18. When the CHKPII run is completed and you have fixed any issues or entered deviations, click **Validate Files**.

19. Click the **Contacts** tab to view the contact names.
    1. Click **Add** and enter your contact information to create an entry for yourself as the _Lab File Handler_.
    2. Add another team member as a _Lab File Handler_ to serve as a backup.

20. Click **Create** to create the shipment package.

## Send the translation shipment package

1. Select **Source Package** > **Send to CFM/MTP**.

   **Note:** Remember the fire and fury mentioned earlier? Here is where you might see an error that you are shipping out of order, or that the previous version wasn't shipped to CFM. If you see this message, continue with the next step:

   1. Use your browser to link to this directory: https://rtpgsa.ibm.com/projects/c/cfm/final/
   2. Open the directory with the same name as your C2ID.
   3. Select the *0/* directory to find the file for the first shipment. Later shipments are in the later directories, such as *1/*, and so on.
   4. Download the translation package. The file name will likely be something like: *C2ID_Release*_DOC_Ship1.tpkg.
   5. Move the file to a directory on your drive.
   6. In the error window, select the option that the previous version has been sent to CFM.
   7. Navigate to the package that you downloaded it, and use that as the target package file.
   8. Select **Ship to CFM**.

2. Enter your name and email address.
3. Enter your GSA ID and password.
4. Click **Send**.

## Respond to translation questions

During the translation cycle, the translation service centers (TSCs) open Translation Communication Tool (TCT) articles when there is a question about the content that they are translating. You should receive notifications of these in your email. The reasons that a TCT is opened can include:

- Typos
- Unclear language
- Missing words
- Inconsistent use of terminology
- Any other issue that makes it difficult for them to translate the content

TCTs are normally blocking accurate translation of the content. For that reason, they should be responded to (at a minimum) within 24 hours. Ideally, they are resolved within 24 hours.

When you receive a TCT article in your inbox, it has a status of “open.”  Use the following guidance to change the status on the issue:

- TSC pending: We believe we completed the work to resolve the TCT on our end. We have provided the required explanations or updates in the source that are required to close the issue. This status is an indicator to the TSC that their action is now required. Include a note telling the TSCs what you did to resolve the issue.
- Working: We have looked at the issue, and we are investigating how we can resolve it on our end. Include a note that you are looking into the issue. It helps our team to know that someone is already working this one, too.
- Lab pending: The TSCs change to this status when they need assistance from our team. Maybe they don't quite understand our explanation, or they don't see all of the updates. They will add a note to let us know what they still need. This is our indicator that action is required from us. Again, this should be responded to within 24 hours.
- Closed: This one means the TSC is satisfied with the resolution that we have provided, and they are no longer blocked by the issue.

Resolving a TCT article

A TCT article is sometimes resolved by just explaining our meaning. While this might be the right approach, keep in mind that the way it is written might be confusing to users. If the translators found it confusing, others might. Rewrite it, if it is unclear.
If you have to make some changes to the source to resolve the TCT, you must make the change in at least three places, if applicable:

1. The English source of the working branch of the Git repo: This is from where your latest content is built, and your everyday working branch. This change must be made here to make sure that it is fixed for future versions of the documentation. Sometimes, this will already be fixed in the main branch, as your NLV branch might be older.
2. The English NLV branch: This is the branch that matches the content that you pulled for the translation drop, so it most closely matches the NLV content. If you have to resend the content to be translated, you should send the NLV content to make sure that it is the same as the translated content (not your everyday working branch).
3. The branches of the maintained older English versions: These are the same file in previous versions that have the same issue. It is best to at least get it fixed in the English only refresh, if it helps.

## Processing the returned translations

**Method 1: Automatic process**

You will begin to see notifications that the translations have been returned. Use the notifications as an FYI. Our translation coordinator (Geoffrey) creates a PR for each language into the designated nlv branch of our docs repo. Note: He might wait until he has a few returned to create them.

1. Check the PRs in the morning to see if they are there.
2. Ensure that the files are going into the correct nlv branch.
3. Merge the PR. You can check to make sure that it is there, and in the right place by using the browser version of Git to view the structure.
4. Run the build for the nlv content to build the content with the new language.
5. Verify that the new language information is available on preprod by using the language selector.

**Method 2: Manual process**

1. In the branch that you created with your last translation shipment that you will use for DVT, create a directory at the top level (the level that contains your `summary.md` file or `toc.xml` file) called *nl*. **Tip:** You can also copy this branch on your drive, and use it as a staging area.
2. Create a directory in the `nl` directory for each language. Use the following names: `de`, `es`, `fr`, `ja`, `ko`, `pt/BR`, and `zh/CN`. **Note:** `pt/BR` and `zh/CN` are both two levels of folders.
3. You will receive a notification in your email from the apcfm ID for each language as it is finished. Select the link in the note to follow it to the package that contains the returned files.
4. When asked for an ID and password, use your GSA ID and password (not your Intranet ID and password).
5. Select to open the file with the default tool. This should default to opening it with TPT.
6. From the main menu, select **NLV Package** > **Extract files**.
7. In the **Target Directory** field, select the folder that you created that will contain the files for that language. Remember to select the lowest level of the folder structure that you can for the language (for example, es, BR, CN).
8. Extract the files into that folder.

## DVT

### Preparation

1. A few days before DVT starts, reach out to the translation coordinator to make sure that we are on track to have DVT.
2. Make sure that the release_nlv branch contains the required languages, and are displaying them correctly. Currently, the languages are: French, Spanish, Korean, Japanese, Brazilian Portuguese, and Simplified Chinese. Note: If you do not have all of the languages, you might have to make additional changes to the content, or overwrite some changes in the future.
3. Set up a KC sandbox build that will build the DVT content:

   1. Using Filezilla, find the corresponding "_stage" properties file in the correct folder (/gsa/pokgsa/projects/a/ahe01_kc/projects/wwwtest/content/knwctr/mainframe/_content_config/platform/cloud_pak_mcm):

      1. Open Filezilla.
      2. Go to File -> Site Manager
      3. Select **New Site**.
      4. In Protocol, select **SFTP**
      5. In the Host, add the following: `pokgsa.ibm.com`
      6. Add your GSA username and pw.
      7. Select **OK** to save it for reuse later.
      8. Select **Connect** to connect to the GSA servers.
      9. Paste `/gsa/pokgsa/projects/a/ahe01_kc/projects/wwwtest/content/knwctr/mainframe/_content_config/platform/cloud_pak_mcm` in the **Remote site:** field.

   2. Copy the corresponding "<release>_stage.properties" file for your release onto your hard drive.
   3. Rename the downloaded file to "<release>_nlv.properties".
   4. Edit the file to run the sandbox DVT environment:

      1. Update the product name to be, "<taxonomy>_<release>_nlv
      2. Update your path to include the path to the GSA folder that you will set up to parse the content. This path should be relative to the location of the properties file, when you copy it back to GSA. Example: ../../../platform/cloud_pak_mcm/SSFC4F_1.2.0_nlv
      3. Update the git branch in the properties file to pull from your "release_nlv" branch, rather than from your "release" branch. **Important:** Make sure that this branch contains the English source that you shipped to the translation centers, not the current branch. The comparisons for DVT are made from the files that they received and translated, and the files in your main branch likely contain updates that are not in the translated files. Hopefully you created this branch when you shipped your files, but you can always recreate it using the package that you sent.
      4. Update other repos that are listed in the properties file, as necessary to pull in the other files that are required.
      5. Upload the properties file to where your other properties files are located in GSA. This is often the directory where you downloaded the original properties file from.

   5. Run the build using the properties file that you created.
   6. Your nlv instance will be in the location on the preproduction KC that you specified in your properties file. For example: https://www-03preprod.ibm.com/support/knowledgecenter/SSFC4F_1.2.0_nlv/kc_welcome_containers.html.

### DVT in action

DVT problems are identified using the Translation Communication Tool (TCT). If you have the correct access to the project, you will receive notifications from TCT in your email about identified issues.

1. Use the links provided in the email notification to view and respond to a TCT issue.

   Responses to DVT changes can depend on the type of issue:

    - Translated content

      1. Anything that requires a translation change must have the change made in the EN master file.
      2. Attach the updated master file, and send to the translation center.
      3. The TSC will translate the file and send it back, which the translation coordinator will make a new PR for.  You might receive new files from all of the languages for this, if it applies.

    - Broken links

      1. Broken links should be fixed in the EN master. This file can be attached and sent to the TSCs.
      2. Because the link values are not translated you could save some time by making the change in all of the languages in the NLV branch. They can verify quickly and don't have to package a new file. **Attention:** Use this with caution. Sometimes these updates are overwritten if they return the file for another reason.

   Remember: With DVT comments, they don't want you to just add a correction in the issue the way you can during translation. They want you to attach the entire file or send an updated package. If you have to send an updated package, you don't have to repackage all of the files.  You can include only the updated files that address the TCT issues.  Use TPT to create ththis package the same way you would a full package, and send them using the `dvt_doc_shipment` shipment title.

   Try to respond to DVT issues within 24 hrs, even if you just have to say that we are looking into it. These are sometimes holding them up, and we don't want to delay sign-off, if we can help it.

2. All DVT issues must be closed or deferred before a language will sign off on DVT.
3. Reach out to the translation coordinator to see whether the languages are signed off.
4. When you have sign-off from all of the languages, you can push to production.

## Pushing translations to production

1. Create a PR to add all of the languages into the `docs/nl` folder of the main branch, according to language.
2. Merge the PR.
3. Run a build of the content. Note: This build will take longer, as it is building all of the other languages.
4. Verify on preprod that the languages built correctly.
5. Push with the next refresh.
