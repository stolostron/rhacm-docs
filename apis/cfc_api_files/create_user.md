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

# Create user

Create a user.
{:shortdesc}

```
POST /users
```
{: codeblock}

## Description

Create a user.

## Parameters

|Type|Name|Description|Schema|Default|Required|
|----|----|-----------|------|-------|--------|
|Body|body|User Information|CreateUser| |Yes|
{: caption="Table 1. The parameters that you use to create a user" caption-side="top"}

## Responses

|HTTP Code|Description|Schema|
|---------|-----------|------|
|200|An array of price estimates by product|No content|
|default|Unexpected error|No content|
{: caption="Table 2. The responses that are returned when you create a user" caption-side="top"}

## Tags

* Users
