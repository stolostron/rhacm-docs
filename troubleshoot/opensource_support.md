---

copyright:
  years: 2016, 2018
lastupdated: "2018-02-08"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Open source support
Because the product contains open source software, IBM offers some support for the open source software that it uses.
{:shortdesc}

IBM uses open source software in three ways:
* To help its valued customers avoid vendor lock-in
* To ensure compatibility with the broadest ecosystem of software
* To accelerate development of its products

The mature, enterprise-level open source components that are used were carefully selected, integrated, and tested to work as described in the product documentation and licenses. The components include integral open source components like Kubernetes, Docker Engine, Helm, ELK stack, and Cloud Foundry.

The {{site.data.keyword.IBM}} Software Support Handbook is the definitive reference for IBM's open source support statement. To review IBM's open source support statement, see [Third party software and Open Source software ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://www-304.ibm.com/support/customercare/sas/f/handbook/policies.html#thirdparty){: new_window} in the IBM Software Support Handbook. The support team uses the information in this statement to scope its interactions with you.

The main goal of the support team is to help paying customers get the supported product functional again as quickly as possible. Although the community support options are available for users, contacting IBM Support is the best support option for users of the different bundled enterprise editions of the product. See [product support types](support_types.md) for more information.


When you contact IBM support, there are two phases of open source support:
1. The problem determination phase. During this phase, support engineers determine whether the root cause of an issue is due to open source code or IBM code.
2. The open source support phase. If the root cause is due to open source code, support engineers identify which open source project contains the issue and work with you to identify next steps.

If a critical defect is found in the open source software within the product, IBM engineers use open source community resources to deliver a fix to the problem. The resulting fix is integrated, tested, and released to customers as an emergency update and in the next product release. If no fix is available from the community for a critical defect, IBM might use reasonable commercial efforts to provide a test fix to customers and then work with the specific open source community to create an official fix. The final arbiter over whether a supported fix can be provided belongs to the open source community.

Note that if any enterprise-level open source project has a critical defect, many clients are affected, and the community works as fast as possible to resolve it. It is unusual for only one customer to encounter a critical open source defect.

IBM cannot support any open source software that is not packaged with the product. In addition, if a client chooses to make any additions, subtractions, or upgrades to the product open source code outside of product updates, that code is not supported. For {{site.data.keyword.cf}}, IBM might assist you with reporting defects in community buildpacks and runtimes to the appropriate open source community. IBM cannot provide fixes for these {{site.data.keyword.cf}} community buildpacks and runtimes.

**Note:** Support can help with new versions of supported operating systems, Kubernetes, Docker, and other dependent infrastructure when new versions are fully tested by the IBM product team.

If you need more support, IBM can help. See [product support types](support_types.md) in the product documentation for more information about Premium Support.
