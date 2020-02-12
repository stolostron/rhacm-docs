---

copyright:
  years: 2016, 2018
lastupdated: "2018-01-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Get all namespaces

Get a list of all available namespaces in the cluster.
{:shortdesc}

```
GET /namespaces
```
{: codeblock}

## Description

Get a list of all available namespaces in the cluster.

## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|An array of namespaces|Namespace|
|default|Unexpected error|Error|
{: caption="Table 1. The responses that are returned when you request a list all namespaces" caption-side="top"}

## Tags

* Namespaces
