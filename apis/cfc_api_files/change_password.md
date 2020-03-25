---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-24"

---


# Change password

Change the password for a user.
{:shortdesc}

```
PUT /users/{uid}
```

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
