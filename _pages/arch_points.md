---
layout: page
title: GitHub issue points
permalink: arch_points
horizontal: false
---

Not all issues are created equal. To help plan our anticipated workloads for each sprint and distribute issues efficiently, we assign points to GitHub issues that provide an estimate for how difficult and time-intensive each issue is. While assigning points is a subjective process, there are still some guidelines you can follow.

## General rules

- The range of points conists of integers from `1` to `10`, with `1` being "I can knock this out in 5 minutes" and `10` being "this will give me grey hairs." Do not use fractions or integers above 10.
- Estimate points when triaging issues, but feel free to change them any time during your work process, including after you have already closed the issue.

## Rubrics

Consider the following rubrics when assinging points to GitHub issues:

| **Rubric** | | **Description** |
| ----------- | | ----------- |
| Time | | How long it takes to solve an issue. |
| Difficulty | | How complex an issue is and how many additional factors you have to consider. | 
| Research | | How much new information you need to seek out and learn to understand or solve the issue. | 
| Length | | How many new files, topics or individual lines it takes to solve the issue. | 
| Review | | Who and how many people need to review your solution before merging. |

&nbsp;

**Important:** The rubrics are only guidelines. As you read the following section explaining each point selection in detail, remember that individual rubrics can vary drastically. For example, you may find some rubrics matching that of a 2 point issue while others match a 5 point issue. It's up to your subjective judgement and prior experience to select an appropriate score in such cases.

&nbsp;

## `1` point

The most basic type of issue usually consisting of fixing typos and adding or removing characters. The information provided in the issue is always sufficient to solve the issue quickly, with no additional research, communication or even review needed.

| **Rubric** | | **`1` point description** |
| ----------- | | ----------- |
| Time | | A few minutes at most. |
| Difficulty | | Copy and paste with no further considerations required. | 
| Research | | None. | 
| Length | | A single or a few characters added/changed in one file. A phrase at most. | 
| Review | | None required. |

&nbsp;

## `2` points

A simple issue that requires mostly copy and paste. These are often straightforward new known issues being requested by developers, complete with a full and mostly edited draft. At most you might need to remind yourself of a style item or rearrange some sentences, but the information is complete and ready to be implemented in your solution.

| **Rubric** | | **`2` points description** |
| ----------- | | ----------- |
| Time | | Multiple 1 point issues. |
| Difficulty | | Largely copy and paste. Might require minimal style and formatting considerations. | 
| Research | | Minimal (in the form of verification) to none. | 
| Length | | One or a few paragraphs in one file. | 
| Review | | Peer review is sufficent. |

&nbsp;

## `3` points

A relatively simple issue that requires minimal additional research and editing. May include more involved new known issues, a request for clarifying steps in the docs, or adding new information in an existing topic that requires additional considerations (placement position in the docs, verification from additional sources etc.)

| **Rubric** | | **`3` points description** |
| ----------- | | ----------- |
| Time | | Varies from hours to days. |
| Difficulty | | Some rewriting and editing is required. | 
| Research | | You might need to reach out for verification or have short discussions about the implementation. | 
| Length | | One or a few paragraphs in one or more files. | 
| Review | | Peer review and one dev review. |

&nbsp;

## `4` points

4 point issues tend to be very common and diverse, ranging from requests for new topics to restructuring of existing content. While difficult to generalize, you can expect more work/investment across all rubrics compared to 3 point issues, especially when it comes to architecture considerations, research, and communciation with SMEs. You can also expect an extended review process that requires you to adjust your pull request based on feedback.

| **Rubric** | | **`4` points description** |
| ----------- | | ----------- |
| Time | | Can be easily completed within a sprint. |
| Difficulty | | Includes drafting new content or adapting drafts that require verification, discussuion, and review from SMEs. | 
| Research | | You might need familarize yourself with the topic and learn basic new concepts.  | 
| Length | | Varies, but often requires several lines across multiple files. | 
| Review | | Peer review and one dev review. |

&nbsp;

## `5` points

A somewhat difficult issue that requires you to research topics, reach out to SMEs, and go through an extended review process. Can include anything from documenting new features to overhauling existing sections of documentation. Information provided usually needs to be expanded, verified, and rewritten, all while considering the doc architecture, style, formatting, and user needs.

| **Rubric** | | **`5` points description** |
| ----------- | | ----------- |
| Time | | Can be completed in one sprint but can require more time. |
| Difficulty | | You need to author new topics and content based on multiple sources. Includes research and communication with multiple SMEs. Consider style, formatting, user needs, and, to some extent, the architecture of the doc. | 
| Research | | Reaching out to SMEs, learning new technical and product concepts as well as becoming familiar with the architecture of the doc section affected. | 
| Length | | Varies, but often requires several topics across multiple files. | 
| Review | | Peer review and one or two dev reviews. |

&nbsp;

## `6` points

A difficult issue similar to 5 point issues, but with even more investment required across all rubrics.

| **Rubric** | | **`6` points description** |
| ----------- | | ----------- |
| Time | | Can be completed in one sprint but sometimes requires more time. |
| Difficulty | | You need to author new topics and content based on multiple sources. Includes research, communication with multiple SMEs, and, sometimes, meetings for discussion. You need to consider the doc architecture, style, formatting, and user needs. | 
| Research | | Reaching out to SMEs, learning new technical and product concepts as well as becoming familiar with the architecture of the doc section affected. Meetings might be helpful. | 
| Length | | Varies, but often requires several topics across multiple files. | 
| Review | | Peer review and two dev reviews. |

&nbsp;

## `7` points

The first level of issue difficulty that requires strong awareness of doc architecture and planning. The issue may provide a general request with some details or limited drafts, but doesn't provide clear directions about how to accomplish the goal. It is up to you to research, plan, and write a solution to solve the issue, all while considering architecture, the nature of the goal, style, and formatting. You need to meet or consult with multiple SMEs and, potentially, team leaders.

| **Rubric** | | **`7` points description** |
| ----------- | | ----------- |
| Time | | Requires multiple sprints. |
| Difficulty | | Complex authoring of new content based on limited available information. You need to have strong awareness of the doc architecture to make the right decisions. | 
| Research | | Intensive research required to understand the issue and topic. You also need to gather complex information thriough various means and verify it. | 
| Length | | Varies, but can require some input in a dozen or more files. | 
| Review | | Peer review and multiple devs or team leaders. |

&nbsp;

## `8` points

A complex issue similar to 7 point issues, but with even more investment required across all rubrics.

| **Rubric** | | **`8` points description** |
| ----------- | | ----------- |
| Time | | Requires multiple sprints. |
| Difficulty | | Complex authoring of new content based on limited available information. You need to have strong awareness of the doc architecture to make the right decisions. | 
| Research | | Intensive research required to understand the issue and topic. You also need to gather complex information through various means and verify it. | 
| Length | | Varies, but can require input in dozens of files. | 
| Review | | Peer review and multiple devs or team leaders. |

&nbsp;

## `9` points

Draft

| **Rubric** | | **`9` points description** |
| ----------- | | ----------- |
| Time | | Requires multiple sprints. |
| Difficulty | | Draft | 
| Research | | Draft | 
| Length | | Varies, but can require major input in dozens of files. | 
| Review | | Draft |

&nbsp;

## `10` points

An extremely complex issue that requires massive work on all fronts and input from multiple parties. Can require an epic and might consist of multiple issues. Several meetings and extensive review are required.

| **Rubric** | | **`10` points description** |
| ----------- | | ----------- |
| Time | | Requires multiple sprints or even releases. |
| Difficulty | | Draft | 
| Research | | Draft | 
| Length | | Up to a whole book in size (massive input in hundreds of files). | 
| Review | | Multiple peer, developer, team leader, and proudct manager reviews through meetings and via GitHub. |

&nbsp;

## Case studies

### Adding technology preview (`1` point)

**Issue title:**
Cluster scaling is technology preview #25677

**Link:**
[25677](https://github.com/stolostron/backlog/issues/25677)

This is an open and shut case of a SME pointing out that "technology preview" was accidentally removed and needs to be added back to a topic. The solution was to add back the missing "technology preview" to the title of the topic.

More `1` point examples:

- [25092](https://github.com/stolostron/backlog/issues/25092)

### Adding simple new known issue (`2` points)

**Issue title:**
Add new installation known issue for blue button #25641 

**Link:**
[25641](https://github.com/stolostron/backlog/issues/25641)

A simple and short new known issue where a strong draft and even screenshot for verification was provided. The solution only required minor style and formatting edits to the provided draft. The screenshot provided verifiaction the UI steps, which any technical writer could also verify on the console themselves as well.

More `2` point examples:

- [11423](https://github.com/stolostron/backlog/issues/11423)

### Documenting horizontal scaling of ocp clusters (`3` points)

**Issue title:**
Add details for horizontal scaling of an ocp cluster that's deployed using CIM (Central Infra Management) #24059

**Link:**
[24059](https://github.com/stolostron/backlog/issues/24059)

The original request was to add steps explaining how to add more nodes to an existing ocp cluster. Some information was missing, such as details in the provided steps and a suggested location for the new steps. After a quick discussion in the issue and some additional review in the associated PR, the solution was to add a short new topic in one of the suggested locations that made the most sense from an architecture perspective and using the provided information, which was supplemented by an additional developer.

More `3` point examples:

- [25389](https://github.com/stolostron/backlog/issues/25389)

### Adding technology preview (`4` points)

**Issue title:**
Add details for horizontal scaling of an ocp cluster that's deployed using CIM (Central Infra Management) #24059

**Link:**
[24059](https://github.com/stolostron/backlog/issues/24059)

The report asks to adjust the documentation because cluster proxy add-on moved. The solution required some awareness of the doc architecture and careful review to make sure content was moved properly from and to the correct locations. Drafts were provided but, as always, needed to be review and edited for formatting and style.

More `4` point examples:

- [18252](https://github.com/stolostron/backlog/issues/18252)

### Draft (`5` points)

**Issue title:**
Draft

**Link:**
[Draft](https://github.com/stolostron/backlog/issues/Draft)

Draft

More `5` point examples:

- [Draft](https://github.com/stolostron/backlog/issues/Draft) 

### Draft (`6` points)

**Issue title:**
Draft

**Link:**
[Draft](https://github.com/stolostron/backlog/issues/Draft)

Draft

More `6` point examples:

- [Draft](https://github.com/stolostron/backlog/issues/Draft) 

### Draft (`7` points)

**Issue title:**
Draft

**Link:**
[Draft](https://github.com/stolostron/backlog/issues/Draft)

Draft

More `7` point examples:

- [Draft](https://github.com/stolostron/backlog/issues/Draft) 

### Draft (`8` points)

**Issue title:**
Draft

**Link:**
[Draft](https://github.com/stolostron/backlog/issues/Draft)

Draft

More `8` point examples:

- [Draft](https://github.com/stolostron/backlog/issues/Draft) 

### Draft (`9` points)

**Issue title:**
Draft

**Link:**
[Draft](https://github.com/stolostron/backlog/issues/Draft)

Draft

More `9` point examples:

- [Draft](https://github.com/stolostron/backlog/issues/Draft) 


### Draft (`10` points)

**Issue title:**
Draft

**Link:**
[Draft](https://github.com/stolostron/backlog/issues/Draft)

Draft

More `10` point examples:

- [Draft](https://github.com/stolostron/backlog/issues/Draft) 

