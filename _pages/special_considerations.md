---
layout: page
title: Special considerations
permalink:special_considerations
horizontal: false
---

You might enciunter some rare and specific writing cirumstances that require a workaround or special considerations. If you are encountering formatting or build issues, read the following topics.

## Asterisks

In AsciiDoc, `*` (asterisk symbol, Unicode `U+002A`) denotes the beginning of bold text or a bullet point. This can cause formatting issues when `*` is used for other purposes, such as for placeholders or as part of a code or command.

To avoid formatting issues, do not use a single `*` if possible. You can often ask developers to provide alternatives if a codeblock or similar has stray asterisks.

If you must use `*`, make sure to only use a single `*` per line. If necessary, separate paragraphs with multiple single asterisks into several lines to avoid formatting or build issues.

Additionally to only appearing once per line, a single  `*` should also be enclosed in backticks, not in a codeblock.

## IP addresses

To avoid security issues, do not include public IP addresses from test clusters in the documentation. You can use private IP addresses where necessary.
