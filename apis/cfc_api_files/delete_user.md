---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-24"

---

# Delete user

Delete a specific user.

```
DELETE /users/{uid}
```

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
