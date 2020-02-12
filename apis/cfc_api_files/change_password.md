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

# Change password

Change the password for a user.
{:shortdesc}

```
PUT /users/{uid}
```
{: codeblock}

## Description

Use this endpoint to change user password.

## Parameters

|Type|Name|Description|Schema|Default|Required|
|----|----|-----------|------|-------|--------|
|Path|uid |ID of the user|string| |Yes|
|Body|body|Password change request|ChangePassword| |Yes|
{: caption="Table 1. The parameters that you use to change a password" caption-side="top"}

## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|Create success|No content|
|default|Unexpected error|Error|
{: caption="Table 2. The responses that are returned when you change a password" caption-side="top"}

## Tags

* Users
