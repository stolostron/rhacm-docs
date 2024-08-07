---
layout: page
title: Maintaining scrum board
permalink: board_maintenance
horizontal: false
---

As the primary board focal, the lead needs to know everyone's component responsibilities in order to speak truthfully about the team's effort, priorities, and sprint planning. The team is responsible for updating status and discussion in the JIRA comments. This helps with history and tracking. 

The team also may be assigned items that are not triaged, but can take the follow up action to get the template filled out and triage when it is complete.

Everyone helps maintain Jira issues with the following guidance:

## New issues (Jira)

  - Untriaged issues remain in `untriaged` column until acknowledged with `doc-ack`, which means **the template is filled out**, and a writer has enough information to start work.
  - Label `doc-awaiting-info` and leave in `untriage` if info is insufficient. Lead or doc focal will request more info in the comments, or assign the writer to track down that info.
  - Issues from support are often not doc issues and need development input or draft before they are accepted. Use comments and Slack to collaborate.
  - Issues are opened with either the `bug`, `documentation`, `acm blog` component.
  - Bugs are usually from support, at times from QE, and can only exist on a published version.
  - Bugs represent inaccurate content that is breaking a customer. Use tasks for other issues.
  
## Existing issues

  - Only update previous releases for customer reported issues from support or high impact topics. The `Linked cases` tab should contain the customer case. If from PM, TAM, or Engineering, only update if they can show where it will break the customer.
  - If an enhancement or an addition is requested internally, but did not make the last release GA, see if that work can be added to the active and next release.
  - Do not switch `Train-XX` labels on doc issues because we need to track velocity and reasons for not completing `Train-XX` work for future improvements.
  - It's OK to complete work from a previous `Train-XX`, though the goal is to merge your doc along with `Train-XX` development issues.
  - Change the train label only if the engineers have discussed in the release plan to move a feature to a different train. Track those changes in a comment.
  - Trains are numbered continuously in JIRA, so you may start the release in `Train-05`, though it is the first train for that new release.
  - Keep up with existing issues, but no issues should be 6 months old untouched, for instance. 
  
## Pipelines/Columns used for sprint planning

  - Jira tasks and bugs have different status indicators, which are used in the pipelines. (These are not flexible, so the pipelines are fixed.)
  - Issues remain in `UNTRIAGED` until the `doc-ack` label is added and `doc-awaiting-info` is removed, if it was added.
  - The `IN PROGRESS` column contains Bugs and Tasks that are triaged and ready to work. 
  - Labels within the `IN PROGRESS` pipeline will relate to trains if they are part of a feature, example: `Train-XX`.
  - Issues that are ready for a PR review can move to `REVIEW` for tech review, QE review, and peer review.
  - Blogs are `IN PROGRESS` when the editor (us) is reviewing the blog. Move to `Review` when the editor has completed their part. Close when the Google form has been submitted. Track these stages in issue comments.
  - For `ContentX_CY24`, label issues also `high-impact` for doc all customers need (install, support matrix, upgrade), `pm-ask` and `tam-ask` if the request comes from PMs or TAMs, even on Slack, and `doc-customer` if linked to a customer case. Broken links, Typos, most internal issues, are not ContentX.
  - Use meetings to plan work for the train and update the team on progress. Also redistribute work as needed on the board.
  - Bring up any `unplanned` work that got in the way on progress; use the `unplanned` label.
  - Label any JIRA issues that close without work as `not-started`.
  - The `DONE` column will contain closed items for a certain amount of time.

## Board review in scrums

  - Scrum lead looks at each assignees board for balance of issues.
  - Scans for old, duplicate, `not-started` issues.
  - Prioritize and label issues as needed.
  - Assign any unassigned issues that are `doc-ack`.
  - Check for issues sitting in `Review` (what is needed to close them?).
  - Comments and snapshots incomplete or unplanned sprint work to capture trends and viloscity.
  - Scans PRs for developer iniated work and older PRs. 

  
## Training and discovery

  - Change to internal documentation, processes (Playbook, blogs, templates, etc...) can be discussed in an issue that will be used to make updates.
  - Label that issue `Enhancement` and use it for your PR into the internal docs if needed.
  - Internal docs are owned and updated by all, with most major changes being discussed in meetings or a PR.
  - Feel free to create an issue dedicated to learning and close when complete.
  - Use the learning issue for many purposes, including learning, development, training, experimentation, and other work that you would like to complete but feel like you don't get time to. 
  - If you want to track training time, open an issue and label it `Discovery`.
  
