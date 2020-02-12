---

copyright:
  years: 2019
lastupdated: "2019-11-06"

---

# Template for troubleshooting topics
{: #title}

<!--
Include the GitHub issue number as part of the anchor for the topic within the container topic.
-->

Use the following template as a model for creating your troubleshooting topics. Review the template source for details.
<!--
Short description
Required. Write a short description that briefly describes the problem. 
 - Use more words than in the title (This is often a problem for most products troubleshooting). 
 - Your description needs to expand on the title and not simply copy or rephrase the title. 
 - Indicate whether a solution or workaround or fix (fix pack) is available. Do not announce an in-progress fix or suggest a fix can/will be provided. Only indicate whether a fix/fix pack is already available. 
 - Example (from ID KC): If the VSAM volume data set (VVDS) is out of space or destroyed, you can recover from the situation. You can recover by using DB2 commands, DB2 utilities, and access method services.
-->
{:shortdesc}

<!--
Introduction (no section heading)
Optional. Add any introductory text, longer description, or context that is needed and that does not belong within either of the following sections. 
-->

<!--
Important: Do not include more than one instance of each section heading. For example, if multiple symptoms exist, include only 1 `## Symptoms` section. Include the multiple symptoms within that section. Including multiple instances of each section heading can cause accessibility errors. 
-->

## Symptoms
<!--
Required. The problem or error that is being described in the topic.
  - Include one or more symptoms that the user is likely to observe.
  - If an error message or error code is known include the message or code. 
  - Only include 1 problem in a troubleshooting topic. Multiple symptoms for that problem can be included.
  - If a problem has multiple symptoms, include all known symptoms. Use a bulleted list if needed. 
-->

## Causes 
<!--
Optional. Describe any known causes to the problem or error. 
  - For example, if the problem is the result of a combination of settings for different storage keywords, you can state that information here.
  - If there are any steps or tools for diagnosing the cause, include or identify them here.
  - Some problems or errors can have multiple causes, such as for generic error messages so list all known causes for the error.
  - Use a bulleted list to list multiple causes. If needed, include an ID or title for each cause to match with a solution or workaround.
  - Do not include or reveal proprietary information or acknowledge that IBM made an embarrassing mistake of some sort.
-->

## Environment
<!--
Optional. Indicate any environment (Operating System (OS), Configuration, Platform) conditions for the problem to occur. 
  - For example, if the problem only occurs on OpenShift. 
  - If you indicated these conditions in the title, short description, or in any introductory text or long description, you do not need to include this section. Including the information in the title, short description or introductory text is preferred as readers can quickly determine whether the error might apply to their environment.
-->

## Diagnosing the problem	
<!--
Optional. Include this section when a user needs to complete tasks to identify the root cause before they can move on to resolving the problem. For example, if a problem has two possible solutions but only 1 can be the correct solution to implement for a user, further actions might be needed to determine which cause and solution apply. These actions can involve running a test and checking trace logs. 
  - For example, the "Diagnosing" section might have users look at a trace file for a particular field. If the field contains a zero (0), they should take the first "Resolving" action, and if the field contains anything other than a zero, they should take the second "Resolving" action. 
  - Use a numbered list when multiple actions are required. 
-->

## Resolving the problem	
<!--
Required. Include any solutions or workaround to the problem. 
  - Use a bulleted list for describing multiple solutions. 
  - If needed, use ID or titles to match to causes.
  - If different OS require different solutions, include all here or link to the topic that provides the solutions. 
  - If a solution requires a user to run a command or complete manual steps include the command or steps. 
    - If another topic includes the steps, link to that topic instead.
    - If possible, include an example of any commands that the user needs to run.
    - If there are OS specific steps or commands, include the steps or commands for each OS.
  - If help is needed, include a link to a topic how to request support. 
  - If a fixpack, patch, or other update is required, indicate the required update. 
  - Include any tests to verify the solution is applied and working.

If you need to document a workaround, specifically indicate that it is a workaround. 
  - Include a workaround when a permanent solution is not available, or the solution might not be acceptable to all users, such as if the solution can disrupt operations or can require additional resources. In general, workarounds should be avoided and only permanent solutions provided.
  - If needed, use a bulleted list for multiple workarounds. 
  - If needed, use ID or titles to match the workaround to a cause if multiple causes exist.
-->

## Related information 
<!--
Optional. If needed, include any further information or links to topics that explain ways to avoid similar issues in the future. 
  - If the problem is likely caused from the user not following directions, link to the directions and any related conceptual information. 
-->

<!--
As part of reviewing your topic, make sure that your topic answers the following questions:
  - What happened?
  - Why did it happen?
  - What do I need to do to fix it?
  - What can I do to avoid it happening again? 
-->
