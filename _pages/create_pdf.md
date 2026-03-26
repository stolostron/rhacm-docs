---
layout: page
title: Creating a PDF
permalink: /create_pdf
horizontal: false
render_with_liquid: false
---

You can manually create a PDF from the AsciiDoc source code. You might need to manually create a PDF if the feature is disabled on Pantheon, or to create a preview when you are offline.

## Prerequisites

- You need `asciidoctor`

## Creating a PDF for a guide

To manually create a PDF from AsciiDoc code, complete the following steps:

1. In the command line, navigate to the main folder of the guide that you want to create PDF for. Use the `cd` command.

   **Note:** The `main.adoc` file in the folder determines how the PDF is built.

2. Build the PDF by running the following command:

   ```
   asciidoctor-pdf -v main.adoc
   ```

After the build process completes, you can find the PDF in the guide folder where the `main.adoc` file is.