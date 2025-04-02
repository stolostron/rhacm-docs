---
layout: page
title: Special tag guidance
permalink: /special_tag_guidance
horizontal: false
---

Special tags can be used to draw attention to content where necessary. Limit special tagging and make sure to use bold text for all special tags, including the colon. Red Hat calls these tags "Abominiations." We currently do not capitalize these in the RHACM docs. We agreed it was not necessary. See [All-Caps Headings: Are They Bad for Accessibility?](https://www.boia.org/blog/all-caps-headings-are-they-bad-for-accessibility) for consideration on the matter.

We stick to only a handful of [Standard notes](https://www.ibm.com/docs/en/ibm-style?topic=format-notes#standard-notes) from the manual. This is to keep one writer from overusing tags, or another from not using tags at all, or people using various tags when others are use different tags for the same reason.

## Table of special tags

| **Special tag** | **How and when to use** |
| ----------- | ----------- |
| **Note:** | Use for extra information that is helpful. |
| **Important:** | A little stronger than a note. |
| **Optional:**  | For any step not required, but user may want to take or needs to take in certain cases. |
| **Best practice:** | Use with caution. Avoid when possible by writing more descriptive text to guide the user. |
| **Technology preview:** | Place at the highest level of the doc that is tech preview, then on the title place (Technology Preview) (not bold). Include a bold special tag on the What's new entry. |

&nbsp;

## APIs

Use a plug in to change an API draft from YAML to JSON. You can use, for instance, the VS Code plugin: YAML to JSON.

From the command pallet, you can either copy the clipboard or the selected text and change YAML to JSON.

You will need to copy all the definitions manually.
