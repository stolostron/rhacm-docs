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

# Create namespace

Create a new namespace.
{:shortdesc}

```
POST /namespaces
```
{: codeblock}

## Description

Create a new namespace.

## Parameters

|Type|Name|Description|Schema|Default|Required|
|----|----|-----------|------|-------|--------|
|Body|body|User Information|CreateNamespace| |Yes|
{: caption="Table 1. The parameters that you use to create a namespace" caption-side="top"}

## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|Create success|No content|
|default|Unexpected error|No content|
{: caption="Table 2. The responses that are returned when you create a namespace" caption-side="top"}

## Tags

* Namespaces
