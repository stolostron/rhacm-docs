---
layout: page
title: Deprecations and discontinuation strategy
permalink: /plan_deprecation
horizontal: false
---

We document when parts of the product are deprecated or removed. We also need to give users the alternative actions in the _Recommended action_ and details, which display in the tables for the current release and for two prior releases. See release notes for examples.

A _deprecated_ component, feature, or service is supported, but no longer recommended for use and might become obsolete in future releases. Place alternative actions in the _Recommended action_ and details that are provided in the following table:

A _removed_ item is typically function that was deprecated in previous releases and is no longer available in the product. You must use alternatives for the removed function. Consider the alternative actions in the _Recommended action_ and details that are provided in the following table:

Keep content only for two releases unless not removed and only deprecated. Use a cross-squad issue to get the topic examined every issue. For new entries, developers need to open new issues for doc.

API deprecations and removals: follows the Kubernetes deprecation guidelines for APIs. See the [Kubernetes Deprecation Policy](https://kubernetes.io/docs/reference/using-api/deprecation-policy/) for more details about that policy. 

APIs are only deprecated or removed outside of the following timelines:
  
  - All `V1` APIs are generally available and supported for 12 months or three releases, whichever is greater. V1 APIs are not removed, but can be deprecated outside of that time limit.
  - All `beta` APIs are generally available for nine months or three releases, whichever is greater. Beta APIs are not removed outside of that time limit.
  - All `alpha` APIs are not required to be supported, but might be listed as deprecated or removed if it benefits users.
  


