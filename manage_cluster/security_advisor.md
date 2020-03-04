---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# {{site.data.keyword.cloud_pak_mcm}} security findings

Use {{site.data.keyword.cloud}} Security Advisor (SA) to manage your cluster security findings. 
{:shortdesc}

{{site.data.keyword.cloud_notm}} Security Advisor (SA) is a security dashboard to manage any application and system security findings in your {{site.data.keyword.product}} cluster. SA displays any security alerts or vulnerabilities in your cluster as **Security findings** on the **Governance and risk** page of the {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}}.

View the descriptions of the following core microservices from SA in {{site.data.keyword.cloud_pak_mcm}}:

* Grafeas: A microservice that implements the Grafeas standard and specification. Grafeas is used to track and govern software resources using metadata called *notes*. For example, *occurrences* are descriptions of when and where the note is identified on your cluster.
* Legato: A microservice that provides GraphQL query access to the security findings data.
* Findings API: A microservice that uses Grafeas and Legato to provide a standard API for managing security findings.

For more information about SA, see _About Security Advisor_ in the [{{site.data.keyword.cloud_notm}} documentation](https://cloud.ibm.com/docs/services/security-advisor?topic=security-advisor-about&cm_mc_uid=95759852225815619569856&cm_mc_sid_50200000=32048651564509423304&cm_mc_sid_52640000=58119541564420278259#about).

View the descriptions of the three data sources that comprise the Security Advisor:

* _Policy adapter_ creates security findings for non-compliant policies. 
* [_Security Advisor API_](../manage_cluster/security_advisor.md#sa_api) can be used to create, update, query and delete security findings.

## Security findings

Security findings in SA is called an `occurrence`. Security Advisor uses the `policy-adapter` microservice on the hub cluster to report non-compliant policies to the SA. An occurrence is created for each policy that is non-compliant on any managed cluster. An SA occurrence created by the policy adapter might resemble the following example:

   ```
   {
      "author": {
        "account_id": "ServiceId-4294102b-f0c6-4b47-8215-a748bba6fc85",
        "email": "example@email.com",
        "id": "iam-ServiceId-4294102b-f0c6-4b47-8215-a748bba6fc85",
        "kind": "service-id"
      },
      "context": {
        "account_id": "id-mycluster-account",
        "cluster_name": "clusterhub",
        "namespace_name": "Excludes: [kube-*], Includes: [default]",
        "region": "clusterhub",
        "resource_id": "777f5cb2-c360-11e9-bb07-005056a0c35d",
        "resource_name": "cert-expiration",
        "resource_type": "Policy",
        "service_name": "security-advisor"
      },
      "create_time": "2019-08-20T17:32:09.633473Z",
      "create_timestamp": 1566322329633,
      "finding": {
        "next_steps": [
          {
            "title": "View the details for the compliance problem in the occurrence of the findings."
          }
        ],
        "severity": "HIGH"
      },
      "id": "clusterhub-policy-777f5cb2-c360-11e9-bb07-005056a0c35d",
      "insertion_timestamp": 1566322329634,
      "kind": "FINDING",
      "long_description": "MCM Policy that is not compliant",
      "name": "id-mycluster-account/providers/security-advisor/occurrences/clusterhub-policy-777f5cb2-c360-11e9-bb07-005056a0c35d",
      "note_name": "id-mycluster-account/providers/security-advisor/notes/policy-not-compliant",
      "provider_id": "security-advisor",
      "provider_name": "id-mycluster-account/providers/security-advisor",
      "remediation": "NonCompliant; Non-compliant certificates (expires in less than 50h0m0s) in kube-system[1]: [test-policy-cert, test-policy-cert-secret]",
      "reported_by": {
        "id": "mcm-policy-adapter",
        "title": "Security Advisor MCM Policy Findings Adapter"
      },
      "security_classification": {
        "security_categories": [
          "SystemAndCommunicationsProtections"
        ],
        "security_control": "CertManager",
        "security_standards": [
          "PCI"
        ]
      },
      "short_description": "Policy that is not compliant",
      "update_time": "2019-08-20T17:32:09.633506Z",
      "update_timestamp": 1566322329634,
      "update_week_date": "2019-W34-2"
    }
   ```
   {: pre}

### Security findings data retention policy

**Required access**: At least Operator

Use the security findings data retention policy to manage data size from your findings. By default, all of the security findings are retained in MongoDB in 90 days. You can modify your security findings data retention policy and filtering policy with the {{site.data.keyword.ocp}} {{site.data.keyword.gui}}. For more information, see _ConfigMaps_ in the [{{site.data.keyword.ocp}} documentation ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/3.11/dev_guide/configmaps.html).

**Note**: You must install {{site.data.keyword.cloud_pak_mcm}} hub chart. For more information, see [Installation and upgrade](../../install/overview.md). 

#### Modifying your security findings data retention policy

Complete the following steps to modify your security findings data retention policy:

1. Log in to the {{site.data.keyword.ocp}} {{site.data.keyword.gui}}.
2. From the navigation menu, select **Workloads** > **Config Maps**.
3. Update the Project field by selecting the drop-down arrow. Select **kube-system**.
4. Find the `<mcm-chart-release-name>-findingsapi-configuration` in the list of configuration maps.
5. Click the **Actions** icon and select **Edit Config Map**. The YAML editor appears.
6. Set the `FINDINGS_OCCURRENCES_RETENTION_DAYS` parameter value to the wanted number of days. For example, set the retention days to 180 days. Your retention policy might resemble the following content:

    ```
    "FINDINGS_OCCURRENCES_RETENTION_DAYS": "180"
    ```
    {: pre}

7. Set the `DELETE_ALL_FINDINGS_OCCURRENCES_BY_PROVIDERS` parameter value to the target providers. For example, to delete the security findings for the `security-advisor` providers, your retention policy might resemble the following content:

    ```
    "DELETE_ALL_FINDINGS_OCCURRENCES_BY_PROVIDERS": "security-advisor"
    ```
    {: pre}

8. Click **Save**.

Your security findings retention policy is successfully updated.

#### Modifying your security findings filtering policy

Modify your policy to avoid creating security findings for policies that are not security related. Complete the following steps to skip non-security findings:

1. From the navigation menu, click **Workloads** > **Config Maps**.
2. Update the Project field by selecting the drop-down arrow. Select **kube-system**.
3. Search and select the `<mcm-chart-release-name>-policy-adapter-configuration` configuration map. 
4. Click the **Actions** icon and select **Edit Config Map**. The YAML editor appears.
5. Update the 
`SKIP_SECURITY_FINDINGS_CREATION_BY_POLICY_TEMPLATE_KINDS` parameter value to `LimitRange, Pod, Namespace`. Your updated parameter might resemble the following content:

   ```
   "SKIP_SECURITY_FINDINGS_CREATION_BY_POLICY_TEMPLATE_KINDS": "LimitRange, Pod, Namespace"
   ```
   {: pre}

6. Click **Save**.
7. Restart the `<mcm-chart-release-name>-policy-adapter` pod by removing it. 

   1. From the navigation menu, click **Workloads** > **Pods**.
   2. Search for the `<mcm-chart-release-name>-policy-adapter` pod.
   3. Click the **Actions** icon and select **Delete Pod**.

Non-security findings are skipped.

Learn how to view your security findings from the {{site.data.keyword.gui}}. For more information, see the _Viewing security findings_ section on the [Managing a security policy](manage_grc_policy.md) page.

## Security Advisor API
{: #sa_api}

Before you run Security Advisor API commands, retrieve the authentication token and download the CA certificate for your cluster. For more information, see [Preparing to run component or management API commands](../../iam/3.4.0/apis/access_api.md). Complete the following steps to access the SA API: 

1. Access the SA API by providing your user access token. Run the following command to specify your token:

   ```
   curl -k --request GET --url "https://<Cluster Master Host>:<Cluster Master API Port>/findings/v1/id-mycluster-account/providers/security-advisor/occurrences" --header 'accept: application/json' --header "Authorization: Bearer $ACCESS_TOKEN"
   ```
   {: codeblock}

   * (Optional) Access the SA API by providing the ID token and access token. Run the following command shows to specify both tokens:

     ```
     curl -k --request GET  --url "https://<Cluster Master Host>:<Cluster Master API Port>/findings/v1/id-mycluster-account/providers/security-advisor/occurrences" --header 'accept: application/json' --header "Authorization: Bearer $ID_TOKEN" --header "AccessToken: $ACCESS_TOKEN"
     ```
     {: codeblock}

2. To access the SA API with an API key, provide only the ID token for authorization. Run the following command to obtain the token from an API key:

   ```
   curl -k -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Accept: application/json" -d "grant_type=urn:ibm:params:oauth:grant-type:apikey&apikey=$API_KEY&response_type=cloud_iam" https://<Cluster Master Host>:<Cluster Master API Port>/iam-token/oidc/token
   ```
   {: codeblock}

  * The following sample command shows how to specify the token that is obtained from the API key to make API requests to the Security Advisor.  The `ID_TOKEN` is the value returned as the `access_token` from the previous command:

     ```
     curl -k --request GET  --url "https://<Cluster Master Host>:<Cluster Master API Port>/findings/v1/id-mycluster-account/providers/security-advisor/occurrences" --header 'accept: application/json' --header "Authorization: Bearer $ID_TOKEN"
     ```
     {: codeblock} 

   **Notes**: 
   * You can replace the `-k` option in the curl commands with `--cacert <downloaded CA cert file>` to create a secure connection.
   * You are able to modify the `id-mycluster-account` value. Run the following command to decide which account ID to use for the SA API: `cloudctl iam accounts`.
   
You can access the SA API. For more information, see [Security findings API](../../apis/sa_api.json).

## Security Advisor RBAC

Security Advisor supports role-based access control for SA APIs. View the following access control table:

| Access control | Role | Description |
|---------------- | --------------| --------------------- |
| security-advisor.metadata.write | Operator | Create SA metadata |
| security-advisor.metadata.read | Viewer | Query and read SA metadata |
| security-advisor.findings.read | Viewer | Query and read SA findings |
| security-advisor.metadata.delete | Operator | Delete SA metadata |
| security-advisor.findings.delete | Operator | Delete SA findings |
| security-advisor.findings.write | Editor | Create SA findings |
| security-advisor.findings.update | Editor | Update SA findings |
| security-advisor.metadata.update | Operator | Update SA metadata |
{: caption="Table 1. Security Advisor API roles and actions" caption-side="top"} 

## Third-party data providers

Third-party providers must have access control to the Security Advisor services. See the following descriptions of the SA Grafeas services:

* `grafeas-admin-service-id`: Create, update, view, and delete notes and occurrences with the `admin` service. You can create metadata and use the pruning microservice with the `admin` service.

* `grafeas-internal-service-id`: Create, update, and view occurrences with the `internal` service for internal communications between services. You can only view notes with the `internal` service.

* `grafeas-external-service-id`: Create, view, and update occurrences with the `external` service. You can only view notes with the `external` service. Use the `external` service to allow communication between third-party providers and the SA.

* `grafeas-viewer-service-id`: View notes and occurrences with the `viewer` service. Use the `viewer` service to allow third-party data consumers to have access to the SA. 

IAM access control policies exist on each of the SA Grafeas service IDs. Any API keys created are limited to only the functions described previously.


See [{{site.data.keyword.cloud_pak_mcm}} Governance and risk](../compliance/compliance_intro.md) for more policy topics.
  
