---
layout: page
title: Reviewing release advisories
permalink: advisory_review
horizontal: false
---

## Background

Advisories are released for General Availability (GA) release, z-streams (x.y.z), and for all operator releases (Submariner, VolSync, Gatekeeper, and Global Hub). Announcements about the build of advisories are announced by the CI/CD team. 

## Communications

Feature complete (FC): A build is ran to check for feature updates
Release Candidate (RC): A build is ran to check for bugs


Example of Slack thread announcement: `MCE 2.2.12 RC1 Status Thread`

**Reminders:**

- Check Slack channel for review during RC announcements
- View advisories from Firefox


## Types of advisories

- RHSA (security)
- RHBA (bug)
- RHEA (enhancement)

### RHSA (security)

Requirements:
Product Security has to approve before you can approve. Patrick Hickey normally gets the security information ready before Owen Watkins and you sign off on it.


Topic should contain text similar to the following: “Red Hat Product Security has rated this update as having a security impact of Critical. A Common Vulnerability Scoring System (CVSS) base score, which gives a detailed severity rating, is available for each vulnerability from the CVE links in the References section.” “Critical” might be replaced with “important”, “medium”, or “low”. This should match the severity drop-down in the advisory.


Problem description updates:
Should contain the standard text for the product 
A list of public Jira issues that were addressed (be sure to remove version numbers out)


In the Solution section be sure to refer users to the product documentation

### RHBA (bug)

Requirements:
Security is not mentioned in the Synopsis. “Bug fixes” is mentioned. There can be others, but not security. 
The problem description should contain the standard text for the product and a list of public Jira issues that were addressed.


Topic section should not have the security statement mentioned.
Problem description updates:
Should contain the standard text for the product 
A list of public Jira issues that were addressed (be sure to remove version numbers out)
No CVEs


In the Solution section be sure to refer users to the product documentation

### RHEA (enhancement)

Requirements:
Security is not mentioned in the Synopsis. “enhancements” is mentioned. There can be others, but not security.
The problem description should contain the standard text for the product and a list of public Jira issues that were addressed. 


Topic section should not have the security statement mentioned.


Problem description updates:
Should contain the standard text for the product 
A list of public Jira issues that were addressed (be sure to remove version numbers out)


No CVEs


In the Solution section be sure to refer users to the product documentation

## Advisory logic

RHBA & RHEA
Topic section should not have the security statement mentioned.
No CVEs
RHBA & RHEA & RHSA
They are all advisories 
The problem description should contain the standard text for the product and a list of public Jira issues that were addressed.
In the Solution section be sure to refer users to the product documentation

## Review process

1. Brian creates the advisory as an RHSA when he sets up the project build.

2. When we are close to GA, the release manager adds the resolved Jira issues to the advisory.

3. That might also be a good time for the release manager to tag the Jira issues with the `errata` label for the ones that should be included in the docs errata. These are most often the customer issues. Only the issues with the ‘errata’ label will be included in the docs errata. For all of the issues marked with the ‘errata’ label, the release manager should ask the dev team to provide a brief (one or two sentence) summary of the issue resolution that the customer will understand.

4. Patrick either adds prod sec CVEs to the advisory or determines that there are no prod sec CVEs that apply to that release. If none, Owen or Borja have to change the advisory from RHSA to RHBA or RHEA.

5. After all of that is done for the advisory, make sure that the docs tab is correct according to the list at the beginning of this document.

6. The release manager creates a doc issue for the doc team to create a docs errata for the z-stream. This issue is opened for that z-stream with the ‘Documentation’ component and the ‘errata’ label. This is the only doc issue that should have the ‘errata’ label. Other issues with the label should be dev issues.

7. When it’s time to do the docs errata, the doc team runs a query for issues with both of the following specifications: 

- z-stream release that matches: example ‘ACM 2.9.1’ and ‘MCE 2.4.1’ 
- The ‘errata’ label. **Note:** Remember not to filter on the ‘Documentation’ component at this point because the other issues should be dev issues and have their components listed. 

8. The results of that query should be what you will include in the docs errata. The summary should be provided in the issue. If not, you can add a comment for the creator to request a summary. 

9. Sign off on the advisory when it is correct. 

10. Create the docs errata with the information that you just pulled up. 

- If no issues, then just add the container image statement only. 
- If there are CVEs and no issues, then use the container images and security updates statement. We don’t list CVEs in the doc errata, as they are covered in the advisory. 
- If there are issues, then list the issues and summaries. 
