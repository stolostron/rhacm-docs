---
layout: page
title: Deprecating and removing
permalink: /deprecate_remove
horizontal: false
---

We document when parts of the product are deprecated or removed. We also need to give users the alternative actions in the _Recommended action_ and details, which display in the tables for the current release and for two prior releases. See release notes for examples.

(We brought this deprecation and removal strategy with us from IBM Doc Strategy because it works well, RH did not have a consistent strategy, and STSMs and DEs approved this process.)

## Definitions

**Deprecation:** A piece of the product will no longer be developed or updated. These components or features are highlighted in the doc.
**Removed:** A piece of the product is removed. All mention of this feature or component is removed from the doc for the version that it is removed.

A deprecated component, feature, or service is supported, but no longer recommended for use and might become obsolete in future releases. Place alternative actions in the _Recommended action_ and details that are provided in the following table:

A removed item is typically function that was deprecated in previous releases and is no longer available in the product. usually these are removed after two releases, but the support manager, tech leads, and product managers will decide to remove. Users use alternatives in the _Recommended action_.

## Process

* A developer story or epic would indicated if something is deprecated or removed. They will create a doc issue to deprecate or remove an item.

 1. Update the table in the _Deprecations and removals_ part of the release notes. These do not go in the new release notes.
 2. Go to places where the item is documented and highlight it with **Deprecation**, or remove the file or section if it is a removal.
 3. For removals, you need to work with engineering to ensure the meaning of the topic has not changed if you only removed a piece of the procedure.
 4. Ensure the table is reviewed each release for existing and outdated content. A cross-squad issue with the release manager is an efficient way to get dev teams to review existing content. For new entries, developers need to open new issues for doc.
 5. Remove content that is not within the n-2 support structure.

## Notes:

* Usually before something is removed, it was already deprecated for at least two releases. There are rare occasions where this is missed by the product team, but it is not ideal for the customer.

* API deprecations and removals: follows the Kubernetes deprecation guidelines for APIs. See the [Kubernetes Deprecation Policy](https://kubernetes.io/docs/reference/using-api/deprecation-policy/) for more details about that policy. 

* APIs are only deprecated or removed outside of the following timelines:
  
  - All `V1` APIs are generally available and supported for 12 months or three releases, whichever is greater. V1 APIs are not removed, but can be deprecated outside of that time limit.
  - All `beta` APIs are generally available for nine months or three releases, whichever is greater. Beta APIs are not removed outside of that time limit.
  - All `alpha` APIs are not required to be supported, but might be listed as deprecated or removed if it benefits users.
  


