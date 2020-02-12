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

# Delete user

Delete a specific user.
{:shortdesc}

```
DELETE /users/{uid}
```
{: codeblock}

## Description

Delete a specific user.

## Parameters

|Type|Name|Description|Schema|Default|Required|
|----|----|-----------|------|-------|--------|
|Body|uid|ID of the user|string| |Yes|
{: caption="Table 1. The parameters that you use to delete a user" caption-side="top"}

## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|Delete success|No content|
|default|Unexpected error|Error|
{: caption="Table 2. The responses that are returned when you delete a user" caption-side="top"}

## Tags

* Users
