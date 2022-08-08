---
layout: page
title: Creating and editing images
permalink: /images_guide
horizontal: false
---

Our diagrams are somewhat standardized on the Customer Portal. There is a graphic design team that specializes in creating and editing these diagrams. Our contact at this time is Jess Schaefer, if you have questions.

## Tools to use for specific purposes

**Screenshots:** GIMP 

**Diagrams:** Adobe Illustrator

**Illustrations:** Inkscape  

## Requesting a diagram

Submit a [Technical Diagram Request Form](https://docs.google.com/forms/d/e/1FAIpQLSdF8V0n3E-aAfRen8vZchXCxwA0iDTd0QYyASnutznfGLATvA/viewform) for a diagram.

Based on the form, expect to receive confirmation of your request within 1-2 days. Otherwise, allow about 4 days for a single diagram. If you submit a few, it will likely take more time. Review the artwork and provide comments (usually through email). They can also work with a SME, when needed. When they complete your artwork, the design team will send you a final copy of the diagram in PNG format for you to add to our *images* folder.

The design team will keep the source file so they can use it for any updates. 

## Standards for creating diagrams

- Generally use blue colors (not red)
- Sentence-style capitalization

## How to add images to the rhacm-docs repository

1. After you recieve the link from the designer, download the image locally.
2. From Visual Studio Code (VSC), create a new branch.
3. If you are using MacOS, use the Finder application to view the new downloaded file.
4. Click, hold the file and drag it to VSC. Be sure to add the image into the `images` folder.

## When to use diagrams

Diagrams include flow charts, and artwork that use shapes and objects to show relationships and transfer of information. To add a diagram into the product documentation, use similar syntax that you use for linking. For example, reference the Governance architecture diagram with following syntax:

```
image:../images/governance_arch_2.4.png[Governance architecture diagram]
```


