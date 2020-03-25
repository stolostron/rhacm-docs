---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-24"

---

# Get all namespaces

Get a list of all available namespaces in the cluster.

```
GET /namespaces
```

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
