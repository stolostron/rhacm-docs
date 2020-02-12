---

copyright:
  years: 2019
lastupdated: "2019-12-03"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Cannot edit from _Topology_: replica number and cluster selector

You are not able to update your _replica number_ or _cluster selector_ from the _Topology_ page without the following workaround. <!-- #1340 -->
{:shortdesc}

## Symptom

You are not able to update your replica or cluster selector from the Topology page because the buttons do not work.

## Resolving the problem

1. Navigate to **Topology** > **Applications**.

2. Select an application that has a `placement rule` assigned to it.
  
3. Click the `placement rule`, then a dialog box opens.

4. Edit _replica number_ or _cluster selector_ from that dialog box.
