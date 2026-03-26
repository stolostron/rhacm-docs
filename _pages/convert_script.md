---
layout: page
title: Running the conversion script
permalink: /convert_script
horizontal: false
render_with_liquid: false
---

Run the conversion script to quickly convert existing guides and prepare them for the DITA migration.

  **Important:** The conversion script only converts the basic outline of an AsciiDoc file. You still have to manually review each file and make additional content, structural, or architectural changes as needed.

## Prerequisites

- You need the `convert.sh` file. Contact the tools focal to get the file or download it from the team Slack channel.

## Converting a guide

To convert a guide, complete the following steps:

1. Copy the `convert.sh` file to the main directory of the `rhacm-docs` project.

2. In the command line, navigate to the main directory of the `rhacm-docs` project. Use the `cd` command.

3. Make the script executable. Run the following command:

   ```
   chmod +x convert.sh
   ```

4. Run the conversion script on the guide that you want to convert. Run the following command. Replace `<path-to-guide>` with the directory path to the guide you want to convert. For example, `cluster/cluster_lifecycle`:

   ```
   ./convert.sh <path-to-guide>
   ```

5. Delete the `convert.sh` file before committing and pushing any changes.
