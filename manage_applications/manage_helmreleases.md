---

copyright:
  years: 2016, 2019
lastupdated: "2019-11-19"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Managing Helm releases

View the list of Helm releases that you can manage. You can read more about releases in the [Helm Glossary ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://v2.helm.sh/docs/glossary/){: new_window}.
{:shortdesc}


- [View Helm releases](#view_release)
- [Upgrade Helm release version](#upgrade_release)
- [Rollback Helm release version](#rollback_release)
- [Delete Helm release ](#delete_release)

## View Helm releases
{: #view_release}

To view Helm releases, complete the following steps:

1. From the navigation menu, click **Workloads** > **Helm releases**.
2. Click each release to view the details of all the resources that are available.


## Upgrade Helm release version
{: #upgrade_release}

You can upgrade your current Helm release to any patch, minor, or major version changes that are available. During an upgrade, you can make modifications to the charts configuration parameters.

| Upgrade Paths | Current version | New version |
|-----------|:------------------:|--------------|
| Patch     | 1.0.0              | 1.0.1        |
| Minor     | 1.0.0              | 1.1.0        |
| Major     | 1.0.0              | 2.0.0        |                                       
{: caption="Table 1. Helm release upgrade paths" caption-side="top"}

To upgrade your Helm release version, complete the following steps:

1. From the navigation menu, click **Workloads** > **Helm releases**.
2. Review the **AVAILABLE VERSION** column to see if any version updates are available for the Helm releases.
3. For the Helm release that you want to upgrade, select **Action** > **Upgrade**.
4. From the **Version** option select the patch, major or minor update version that you want.

   **Note** The menu includes versions of the Helm release that are earlier versions than your current version.
5. Select which configuration settings you want to use for the upgrade by using the slider. The following options are available:
    - **Reuse values** This setting retains the values that were used during the previous upgrade, where possible.
    - **Reset values** This setting replaces the previously used settings with the default values that are provided in the yaml file.
6. Modify the individual configuration settings as needed. **Tip:** Select **All Parameters** to view the customizable parameters.

 **Note:** Ensure that you verify your configuration parameters since parameters are not validated when you upgrade the Helm release.
7. Click **Upgrade**.

## Rollback Helm release version
{: #rollback_release}

You can rollback your current Helm release to any past versions of the release that was previously configured.

To rollback your Helm release version, complete the following steps:

1. From the navigation menu, click **Workloads** > **Helm releases**.
2. For the Helm release that you want to rollback, select **Action** > **Rollback**.
3. Select the version that you want to rollback to.
4. Click **Rollback**.

## Delete Helm release
{: #delete_release}

To delete a Helm release, complete the following steps:

1. From the navigation menu, click **Workloads** > **Helm releases**.
3. For the Helm release that you want to rollback, select **Action** > **Delete**.
5. Click **Remove**.
