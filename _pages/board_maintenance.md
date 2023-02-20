---
layout: page
title: Maintaining scrum board
permalink: board_maintenance
horizontal: false
---

As the primary board focal, the lead needs to know everyone's commitment in order to speak truthfully about the team's effort, priorities, and sprint planning. Everyone helps maintain Jira issues with the following guidance:

## New issues (Jira)

  - Unassigned and untriaged issues remain in `untriaged` column until acknowledged, or if they cannot be worked due to insufficient info. Lead or doc focal will request more info in these cases.
  - Issues opened with either the `bug`, `documentation`, `acm blog` component.
  - Officially ask for more information if it is needed (use comments to track the discussion).
  - If there is not sufficient info, label `doc-awaiting-info` and keep in untriaged.
  - If it is ready with adequate info, label `doc-ack` and move to the appropriate column.
  - If it is not ready to triage, label `doc-awaiting-info` and leave.
  - Open a sub-task for QE as needed for large feature changes to tasks.
  
## Existing issues

  - Keep up with existing issues, but no issues should be 6 months old untouched, for instance. 
  - If issue is not customer reported, move towards NOT updating previous releases to make room for Sprints and Trains.
  - If an enhancement or an addition is requested internally, it may be suitable for the next release and not previous releases. 
  - If an issue has to move to the next train, make a comment for the reason it was not worked.
  
## Pipelines used for sprint planning

  - Jira tasks and bugs have different status indicators, which are used in the pipelines. (These are not flexible, so the pipelines are fixed.)
  - Issues remain in `UNTRIAGED` until the `doc-ack` label is added and `doc-awaiting-info` is removed (if it was previously added).
  - The `IN PROGRESS` column contains Bugs and Tasks that are triaged and ready to work. 
  - Labels within the `IN PROGRESS` pipeline will relate to _Sprints_ and _Trains_.
  - Issues that are ready for a PR review can move to `REVIEW` for tech review, QE review, and peer review.
  - Use meetings to plan for the sprint/train work and update the team on progress. Lead takes snapshot after planning.
  - Bring up any `unplanned` work that got in the way on progress; use the `unplanned` label.
  - The `DONE` column will contain closed items for a certain amount of time.
  - Doc issues must be placed a minimum of 2 sprints ahead of the related dev issue. For example, if the dev issue is placed in _Sprint 1_, then the doc issue is to be placed in the _Sprint 3_ realistically. (this is realistic, but trying to work in trains and sprints; let's revisit when we catch up from 2.7)

## Board review in scrums

  - Scrum lead looks at each assignees board for balance of issues.
  - Scan for old or duplicate issues.
  - Prioritize and label issues if needed.
  - Assign any unassigned issues.
  - Check for issues sitting in verification (what is needed to close them?).
  - Leads sprint planning for members.
  - Comments and snapshots incomplete or unplanned sprint work to capture trends and viloscity .

## Sprints

  - To avoid all doc work going into one release and not spread out across sprints, use sprints for release work that is related to a dev issue.
  - Use refresh release labels for valid refresh changes.
  
## Development training and internal work

  - Internal documentation, process, etc... can be discussed in an issue that will be used to make updates.
  - Lable that issue `internal-enablement` and use it for your PR into the internal docs if needed.
  - Internal docs are owned and updated by all, with most major changes being discussed in meetings or a PR.
  - Name the issue 'Development training: Your learning topics (Sprint x/x)'
  - Feel free to create an issue dedicated to learning and close when complete.
  - Use the learning issue for many purposes, including learning, development, training, experimentation, and other work that you would like to complete but feel like you don't get time to. 
