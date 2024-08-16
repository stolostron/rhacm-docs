---
layout: page
title: Reviewing release advisories
permalink: advisory_review
horizontal: false
---

## Background

Advisories are released for General Availability (GA) release, z-streams (x.y.z), and for all operator releases (Submariner, VolSync, Gatekeeper, and Global Hub). Announcements about the build of advisories come from the the CI/CD team. 

## Communications

Engineers create status threads for upcoming z-streams through the Slack channel, _acm-release_. The status threads are created for the following types of updates:

- Feature complete (FC): A build is ran to check for feature updates
- Release candidate (RC): A build is ran to check for bugs

View the following example of a Slack thread announcement: `MCE 2.2.12 RC1 Status Thread`

**Reminders:**

- Check Slack channel for review during RC announcements
- View advisories from Firefox if you have trouble in Chrome.
- You may see you don't have access until you run `kinit` to sign in from the terminal. This is described in the _Review process_ of this document.


## Types of advisories

- RHSA (security)
- RHBA (bug)
- RHEA (enhancement)

### RHSA (security)

* Product Security must approve before you can approve. Contact the Product Security team or ask the release manager to help connect you with them.

* Before you approve the topic, it should contain text similar to the following: “Red Hat Product Security has rated this update as having a security impact of Critical. A Common Vulnerability Scoring System (CVSS) base score, which gives a detailed severity rating, is available for each vulnerability from the CVE links in the References section.” “Critical” might be replaced with “important”, “medium”, or “low”. This should match the severity drop-down in the advisory.

* Ensure that the standard text for the product and list of _public_ Jira issues that were addressed are in the **Problem description** section.

   **Note**: Remove version numbers from the title.

* In the **Solution** section,  refer users to the product documentation.

### RHBA (bug)

* Verify that "Security" is not mentioned in the _Synopsis_. Ensure that "Bug fixes" are mentioned. You can mention others, but you cannot mention "Security." 

* Topic section should not have the security statement mentioned.
  
* Ensure that the standard text for the product and list of _public_ Jira issues that were addressed are in the **Problem description** section.
  **Note**: Remove version numbers from the title.

* No CVEs
  
* In the **Solution** section, refer users to the product documentation.

### RHEA (enhancement)

* Verify that "Security" is not mentioned in the _Synopsis_. Ensure that "Enhancements" are mentioned, and sometimes "Bug fixes".  You can mention others, but you cannot mention "Security." 

* Topic section should not have the security statement mentioned.

* Ensure that the standard text for the product and list of _public_ Jira issues that were addressed are in the **Problem description** section.
  **Note**: Remove version numbers from the title.

* No CVEs

* In the **Solution** section, refer users to the product documentation.


## CVE fixes into Submariner/Volsync/Gatekeeper/GlobalHub

There is an exception for CVEs to be listed in RHBA and RHEA. When the CVE fix becomes available in the base image, the `Freshmaker` tool runs a build for each impacted z-stream in the field to automatically update the base image for each impacted container and rebuild the image(s). Freshmaker uses the `BOTAS` tool to generate a new advisory for each impacted z-stream in the field to attach the rebuilt images. The release manager agrees to ship this advisory, unless a new z-stream is going to ship before the container grades drop. Then the team ships the new z-stream with the CVE fixes and drop the advisory created by Freshmaker/BOTAS.

Example: https://errata.devel.redhat.com/docs/show/130499

## Review process

Before you review, verify that there is a doc issue that has a link to the advisory and a release date in the title of the issue. Complete the following steps during review:

1. Monitor the `acm-release` Slack channel for announcement threads.

2. Log on to VPN and log in to the errata tool with the `kinit` command. Run the following command:
   ```
   kinit <your_usename>@IPA.REDHAT.COM
   ```

3. Open the advisory in Google chrome browser or Firefox browser.

4. View the list of issues from the _Summary_ tab. If you do not see any issues, reach out to the release manager to verify if other issues should be added.

   **Note**: We document Erratas from the Customer portal documentation for only ACM and MCE. We do not document Erratas for other operators and add-ons. If you are documenting Errata, check for a summary of the fix from the issue that is linked. For all of the issues marked with the ‘errata’ label, the release manager should ask the dev team to provide a brief (one or two sentence) summary of the issue resolution that the customer can understand. The release manager creates a doc issue for the doc team to create a docs errata for the z-stream. This issue is opened for that z-stream with the `Documentation` component and the `errata` label. This is the only doc issue that should have the `errata` label. Other issues with the label should be dev issues.

5. A developer from the Product Security team adds CVEs to the advisory or determines that there are no prod sec CVEs that apply to that release. If none, make a request to change the advisory from RHSA to RHBA or RHEA.

6. After all of that is done for the advisory, make sure that the docs tab is correct according to the list at the beginning of this document.
   **Note**: Be sure to update the reviewer section.

7. Sign off on the advisory when it is correct. 

8. Create the docs errata with the information that you just pulled up. 

- If no issues, then just add the container image statement only. 
- If there are CVEs and no issues, then use the container images and security updates statement. We don’t list CVEs in the doc errata, as they are covered in the advisory. 
- If there are issues, then list the issues and summaries. 
