---
layout: page
title: ASCII Doc template ACM
permalink: /ascii_acm_template
horizontal: false
---
See the following code block that contains a template for a typical procedure document at ACM. Always refer to the standards in the internal doc and manuals for writing content: 

```
[#unique-concise-id]
= Upgrading a cluster (gerund for tasks, concepts can be without gerund, please make the ID concise)

Short and informative description (50 words or so) with no prereqs here except in special cases. Why does the user want to do this? What is it?

Important info or notes may be listed here concisely (no large paragraphs)

*Required access:* Get this from developer or QE the role based access required

Your header 2 ID and titles go here if there are more than two:

* <<your-id-prereq,Prerequisites>> always plural
* <<your-id-prepare, Preparing for upgrade>> 
* <<your-id-deploy, Deploying your operator>>
* <<your-id-resources>>Additional resources>>

[#id-prereq]
== Prerequisites

You must have the following prerequisites: (or a line similar between the list and header)
Only use bullets if you have more than one prereq to list.

* A deployed hub cluster that is running on a supported {ocp-short} version with...
* An {ocp-short} cluster that is managed by the hub cluster
* Access credentials to a local repository

You can choose either incomplete sentences that come from the previous line with no punctuation or you can close the introductory sentence and use full sentences, sticking to what ever format you choose for the entire list. The list should be parallel.

[#your-id-prepare]
== Preparing for upgrade

You must mirror.... (Accessibility requires an intro between header and steps)

. Create a file...

. Run the following command:

[#your-id-deploy]
== Deploying the operator

To deploy the operator for...

. On the hub cluster, access the {ocp-short} operator hub. 
. Deploy the operator by selecting `{update-service} Operator`.
. Verify the status with the following command:

And so on...

[#your-id-resources]
== Additional resources

See the following additional....

- See the ____ documentation for 
- See ____ for information about
- Don't just link because the user needs to know why we are giving them extra links
```


