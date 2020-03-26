---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-24"

---

# Associate namespace

Associate a user to a namespace.

```
PUT /namespaces/{projectid}/{uid}
```

## Description

This endpoint is used to associate a user to a namespace.

## Parameters

|Type|Name|Description|Schema|Default|Required|
|----|----|-----------|------|-------|--------|
|Path|projectid|Namespace ID|string| |Yes|
|Path|uid|User ID|string| |Yes|
{: caption="Table 1. The parameters that you use to associate a user to a namespace" caption-side="top"}

## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|Associate success|No content|
|default|Unexpected error|Error|
{: caption="Table 2. The responses that are returned when you associate a user to a namespace" caption-side="top"}

## Tags

* Namespaces
