---
layout: page
title: Special considerations
permalink: special_considerations
horizontal: false
---

You might encounter some rare and specific writing circumstances that require a workaround or special considerations. If you are encountering formatting or build issues, read the following topics.

## Asterisks

In AsciiDoc, `*` (asterisk symbol, Unicode `U+002A`) denotes the beginning of bold text or a bullet point. Sometimes, using a dash (-) for bulleted lists can fix formatting issues that appear in your PR.

Asterisks can cause formatting issues when used for other purposes, such as for placeholders or as part of a command or code. See the following DNS example:

Ingress for workloads within the hosted cluster, such as the following domain: `*.apps.service-consumer-domain.com`.

To avoid formatting issues, place them within the backtics `*`, just as we do for any of the code or command element. If you are creating a DNS command, it is best to format that within the same line as the text inside backtics, as seen in the previous example.

Ensure you only use a single `*` for each line, in backtics and not codeblock. If necessary, separate paragraphs with multiple single asterisks into several lines to avoid formatting or build issues.

## IP addresses

To avoid security issues, do not include public IP addresses from test clusters in the documentation. You can use private IP addresses where necessary. This is just good security practice for the tech industry in general.
