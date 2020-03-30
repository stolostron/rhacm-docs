---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-24"

---

# Definitions

Terms used in the user management and authentication APIs.

## Change password

|Parameter|Description|Schema|
|---------|-----------|------|
|original_password|Current password|string|
|password|New password to be set|string|
{: caption="Table 1. The parameters that you use to change a password" caption-side="top"}

## Create namespace

|Parameter|Description|Schema|
|---------|-----------|------|
|description|Description of namespace|string|
|name|Name of namespace|string|
{: caption="Table 2. The parameters that you use to create a namespace" caption-side="top"}

## Create user

|Parameter|Description|Schema|
|---------|-----------|------|
|email|Email address for the user|string|
|name|The name of the user|string|
|password|The password for the user|string|
|namespace|The namespace that the user is associated with|string|
{: caption="Table 3. The parameters that you use to create a user" caption-side="top"}

## Namespace

|Parameter|Description|Schema|
|---------|-----------|------|
|description|Description of namespace|string|
|name|Name of namespace|string|
|projectid|Unique identifier for the namespace|string|
{: caption="Table 4. Additional parameters for a namespace" caption-side="top"}

## User

|Parameter|Description|Schema|
|---------|-----------|------|
|email|Email address for the user| |
|name|The name of the user| |
|namespace|The namespace that the user is associated with| |
|uid|Unique identifier for the user| |
{: caption="Table 5. Additional parameters for a user" caption-side="top"}
