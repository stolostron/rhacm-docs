---
layout: page
title: Board maintenance
permalink: board_maintenance
horizontal: false
---

As the primary board focal, the lead needs to know everyone's commitment in order to speak truthfully about the team's effort, priorities, and sprint planning. Everyone helps maintain their issues with the following guidance:

## New issues

  - Unassigned and untriaged issues remain in `untriaged` column until acknowledged within a day or so, or if they cannot be worked due to insufficient info. Lead or doc focal will request more info in these cases.
  - Issues need to be labeled properly (dev squad label if it is release work, requires dev team validations, or is a cross squad issue).
  - Officially ask for more information if it is needed (use comments to track the discussion).
  - If there is not sufficient info, label `doc-awaiting-input` and keep in untriaged.
  - If it is ready with adequate info, label `doc-input-provided` and move to the appropriate column.
  - DDF is assigned to one person automatically, leave untriaged until acknowledged by a focal. (Would like this to change if possible--bcs)
  - When placed in `product` or `release` column, no sprint is assigned to issue. Please wait to assign the sprint when it is moved to `sprint` column, usually done by the lead in the scrum, but sometimes done by other teammates.
  
## Existing issues

  - Keep up with existing issues, but no issues should be 6 months old untouched, for instance. Removing three `stale` bots is a possible sign of inefficient template, process, not enough information, low priority, etc... Please close issues that are going nowhere after three `stale` bots, or remove our `squad doc` label. Originator can always open a new effort during the next release. (Including `blog` issues)
  - If issue is not release work or customer reported, ask if still valid based on the current doc. (Compare to latest release)
  - If an enhancement or an addition is requested internally, it may be suitable for the next release. Ask the originator and PM.
  
## Pipelines used for sprint planning

  - Future milestone can go into product column.
  - Doc issues must be placed a minimum of 2 sprints ahead of the related dev issue. For example, if the dev issue is placed in _Sprint 1_, then the doc issue is to be placed in the _Sprint 3_ realistically.
  - Use meetings to plan for the sprint and update the team on progress. Lead takes snapshot after planning.
  - Bring up any `unplanned` work that got in the way on progress, use the label.
  - Put issue in `awaiting verification` when you feel you are ready for peer/tech review.

## Board review in scrums

  - Scrum lead looks at each assignees board for balance of issues.
  - Scan for old or duplicate issues.
  - Prioritize issues if needed.
  - Assign any unassigned issues.
  - Check for issues sitting in verification (what is needed to close them?).
  - Leads sprint planning for members.
  - Comments and snapshots incomplete or unplanned sprint work to capture trends and viloscity .

## Sprints

  - To avoid all doc work going into one release and not spread out across sprints, use sprints for release work that is related to a dev issue.
  - Use refresh release labels for valid refresh changes.
  - Blogs can go into a sprint milestone. Please also label `blog`.
  - DDF items are often requests from Red Hatters for enhancements to the product. These are treated as RFEs via the Jira process. Comment and close unless doc changes are required. 
  - DDF items are also often requests for doc enhancements. Label them enhancements, not bugs. Get with developers to see what changes make sense, if any.
  - DDF items are also not opened in the proper release and sprint. Please change before you move from `untriaged`. 
  
## Development training

  - Every two sprints, feel free to create an issue dedicated to learning.
  - Name the issue 'Development training: Your learning topics (Sprint x/x)'
  - Add the `Learning/Discovery' and 'squad-doc' label.
  - Assign the next two sprints to the learning issue.
  - Use the learning issue for many purposes, including learning, development, training, experimentation, and other work that you would like to complete but feel like you don't get time to. 
  

  
