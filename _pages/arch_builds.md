---
permalink: /arch_builds
title: "Portal refreshes"
---

We refresh weekly.

After you get all the access that you need, you can refresh by following these steps:  

## Prerequisites

(Maybe prereqs/access info here)

1. If you are refreshing the current published version, create a PR from `stage` to `prod`. Get it approved and merged.

2. If you are pusbishing a staged version for GA, you will need to create the `prod` branch right before you publish.

3. Do not push any PR to `prod` if you are only building `stage`.

## Run a build

1. Run the following command to sign in:

   ```
   ssh root@oseccs.bne.redhat.com
   ```

2. Enter the following password: 

   ```
   redhat1!
   ```

3. Run the following to change your directory: 

   ```
   cd /root/sync/
   ```

4. Run the follwoing command, where `X.X doc_branch` is the version number and either `stage` for daily work, or `prod` for a live refresh or stage build.

   ```
   ./acm_sync_asciidoc.sh <X.X X.X_branch>
   ```
   Example:

   ```
   ./acm_sync_asciidoc.sh 2.1 2.1_stage 
   ```
   
   ## Publish a GA version
   
   
