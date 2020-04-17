# Known issues

Review the known issues for Red Hat Advanced Cluster Management for Kubernetes. 

  - [Certificate manager must not exist during an installation](#certificate-manager-must-not-exist-during-an-installation)
  - [LDAP user names are case-sensitive](#ldap-user-names-are-case-sensitive)
  - [CIS policy controller is not installed](#cis-policy-controller-is-not-installed)
  - [Console features might not display in Firefox earlier versions](#console-features-might-not-display-in-firefox-earlier-versions)
  - [Host adoption failed](#host-adoption-failed)
  - [Unable to search using values with empty spaces](#unable-to-search-using-values-with-empty-spaces)

## Certificate manager must not exist during an installation

Certificate manager must not exist on a cluster when you install Red Hat Advanced Cluster Management for Kubernetes.

When certificate manager already exists on the cluster, Red Hat Advanced Cluster Management for Kubernetes installation fails. 

To resolve this issue, verify if the certificate manager is present in your cluster by running the following command: 

   ```
   kubectl get crd | grep certificates.certmanager
   ```

## LDAP user names are case-sensitive

LDAP user names are case-sensitive. You must use the name exactly the way it is configured in your LDAP directory.

## CIS policy controller is not installed

The CIS policy controller is disabled by default when you install Red Hat Advanced Cluster Management for Kubernetes, If you create a CIS policy, you might receive the following message:

   ```
   CIS policy controller is not installed
   ```

You must enable the CIS policy controller. For more information, see _Enable the CIS controller_ on the [CIS policy controller page](../governance/cis_policy_ctrl.md#cis-policy-controller-page).

## Console features might not display in Firefox earlier versions

The product supports Mozilla Firefox 74.0 or the latest version that is available for Linux, macOS, and Windows. Upgrade to the latest version for the best console compatibility. 

## Host adoption failed

Bare metal hosts are not supported. An error message appears when you try to validate the host adoption. 

## Unable to search using values with empty spaces

From the console and Visual Web Terminal, users are unable to search for values that contain an empty space. 
