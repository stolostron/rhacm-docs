---

copyright:
  years: 2019
lastupdated: "2019-12-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Upgrading {{site.data.keyword.ocp}}
{: shortdesc}

Before you upgrade {{site.data.keyword.ocp_tm}}, you must disable the `MutatingWebhookConfiguration` and `ValidatingWebhookConfiguration` webhooks in the image enforcement policy. Then, you enable the webhooks after the upgrade is complete.
{:shortdesc}

Follow these steps before you upgrade {{site.data.keyword.ocp}}:

1. Disable the webhook of the image enforcement policy before {{site.data.keyword.ocp}} upgrade.

    1. Back up the webhook
        ```
        oc get mutatingwebhookconfiguration image-admission-config -o yaml > image-admission-config-mutating.yaml
        oc get validatingwebhookconfiguration image-admission-config -o yaml > image-admission-config-validating.yaml
        ```
        {: codeblock}

    2.  Remove the webhook
        ```
        oc delete mutatingwebhookconfiguration image-admission-config
        oc delete validatingwebhookconfiguration image-admission-config
        ```
        {: codeblock}

2. Enable the webhook after upgrade.
Make sure that the image enforcement policy pod is running:
    ```
    # oc -n kube-system get pods |grep enforce
    ibmcloud-image-enforcement-5c86cccb54-xxggm                    1/1     Running     0          1h
    ```
    {: codeblock}
1. Create the webhook again:
    ```
    oc apply -f image-admission-config-mutating.yaml
    oc apply -f image-admission-config-validating.yaml
    ```
     {: codeblock}

2. Try to create a sample application to make sure that image enforcement policy is working.
3. Upgrade {{site.data.keyword.ocp_tm}} by following the {{site.data.keyword.open_s_tm}} documentation.
