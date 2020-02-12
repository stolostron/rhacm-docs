---

copyright:
  years: 2016, 2019
lastupdated: "2019-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Accessibility features for {{site.data.keyword.product}}

Accessibility features assist users who have a disability, such as restricted mobility or limited vision, to use information technology content successfully.
{:shortdesc}

## Overview

{{site.data.keyword.product}} includes the following major accessibility features:

* Keyboard-only operations
* Screen reader operations
* Command line interface (CLI) to manage the cluster

{{site.data.keyword.product}} uses the latest W3C Standard, [WAI-ARIA 1.0 ![External link icon](images/icons/launch-glyph.svg "External link icon")](http://www.w3.org/TR/wai-aria/){: new_window}, to ensure compliance with [Section 508 Standards for Electronic and Information Technology ![External link icon](images/icons/launch-glyph.svg "External link icon")](http://www.access-board.gov/guidelines-and-standards/communications-and-it/about-the-section-508-standards/section-508-standards){: new_window} and [Web Content Accessibility Guidelines (WCAG) 2.0 ![External link icon](images/icons/launch-glyph.svg "External link icon")](http://www.w3.org/TR/WCAG20/){: new_window}. To take advantage of accessibility features, use the latest release of your screen reader and the latest web browser that is supported by {{site.data.keyword.product}}.

The {{site.data.keyword.product}} online product documentation in IBM Knowledge Center is enabled for accessibility. The accessibility features of IBM Knowledge Center are described in the [Accessibility section of the IBM Knowledge Center release notes ![External link icon](images/icons/launch-glyph.svg "External link icon")](http://www.ibm.com/support/knowledgecenter/about/releasenotes.html){: new_window}. For general accessibility information, see [Accessibility in IBM ![External link icon](images/icons/launch-glyph.svg "External link icon")](http://www.ibm.com/accessibility/us/en/){: new_window}.

## Hyperlinks

All external links, which are links to content that is hosted outside of the IBM Knowledge Center, open in a new window. These external links are also flagged with an external link icon (![External link icon](images/icons/launch-glyph.svg "External link icon")).

## Keyboard navigation

{{site.data.keyword.product}} uses standard navigation keys.

{{site.data.keyword.product}} uses the following keyboard shortcuts.

|Action|Shortcut for Internet Explorer|Shortcut for Firefox|
|------|------------------------------|--------------------|
|Move to the Contents View frame|Alt+C, then press Enter and Shift+F6|Shift+Alt+C and Shift+F6|
{: caption="Table 1. Keyboard shortcuts in {{site.data.keyword.product}}" caption-side="top"}

## Interface information

Use the latest version of a screen reader with {{site.data.keyword.product}}.

The {{site.data.keyword.product}} user interfaces do not have content that flashes 2 - 55 times per second.

The {{site.data.keyword.product}} web user interface relies on cascading style sheets to render content properly and to provide a usable experience. The application provides an equivalent way for low-vision users to use system display settings, including high-contrast mode. You can control font size by using the device or web browser settings.

You can access the {{site.data.keyword.product}} on the following supported browsers:

|Platform|Supported browsers|
|--------|------------------|
|{{site.data.keyword.windows}}|<ul><li>Edge - latest version</li><li>Mozilla Firefox - latest version for Windows</li><li>Google Chrome - latest version for {{site.data.keyword.windows_notm}}</li></ul>|
|{{site.data.keyword.linux}}|<ul><li>Mozilla Firefox - latest version for {{site.data.keyword.linux_notm}}</li><li>Google Chrome - latest version for {{site.data.keyword.linux_notm}}</li></ul>|
|macOS|<ul><li>Mozilla Firefox - latest version for Mac</li><li>Google Chrome - latest version for Mac</li><li>Safari - latest version</li></ul>|
{: caption="Table 2. Supported browsers" caption-side="top"}

To access the {{site.data.keyword.gui}}, open a web browser and navigate to the following URL:

`https://<Cluster Master Host>:<Cluster Master API Port>`

Where, `<Cluster Master Host>:<Cluster Master API Port>` is defined in [Endpoints](installer/3.2.2/cluster_endpoints.md). The username and password are defined in the config.yaml file.

The {{site.data.keyword.gui}} does not rely on cascading style sheets to render content properly and to provide a usable experience. However, the product documentation, which is available in the IBM Knowledge Center, does rely on cascading style sheets. {{site.data.keyword.product}} provides an equivalent way for low-vision users to use system display settings, including high-contrast mode. You can control font size by using the device or browser settings. Take note that the product documentation contains file paths, environment variables, commands, and other content that might be mispronounced by standard screen readers. For the most accurate descriptions, configure your screen reader settings to read all punctuation.


## Vendor software

{{site.data.keyword.product}} includes certain vendor software that is not covered under the IBM license agreement. IBM makes no representation about the accessibility features of these products. Contact the vendor for accessibility information about its products.

## Related accessibility information

In addition to standard IBM help desk and support websites, IBM has a TTY telephone service for use by deaf or hard of hearing customers to access sales and support services:

TTY service
 800-IBM-3383 (800-426-3383)
 (within North America)

For more information about the commitment that IBM has to accessibility, see [IBM Accessibility ![External link icon](images/icons/launch-glyph.svg "External link icon")](http://www.ibm.com/able){: new_window}.
