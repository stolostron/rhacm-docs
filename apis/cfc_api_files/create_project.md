---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-24"

---

# Create namespace

Create a new namespace.

```
POST /namespaces
```

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
