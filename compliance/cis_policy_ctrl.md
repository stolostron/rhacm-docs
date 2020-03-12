---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# CIS policy controller

You can use the Center for Internet Security (CIS) policy controller to receive notifications about non-compliant clusters.
{:shortdesc}

* [CIS policy](#cis_policy)
* [CIS policy elements](#cis_elements)
* [Creating a CIS policy](#create_policy)
* [Viewing a CIS policy](#view_policy)
* [CIS risk score](#risk_score)
* [CIS policy controller components](#contr_comp) <!--suggest the the controller components be placed before CIS policy section 03/12/2020 MD-->

The CIS policy controller monitors the nodes in a cluster for compliance against CIS Kubernetes benchmark checks. The CIS policies that list the rules to exclude can be applied to the managed clusters. The controller checks the cluster for any violations that are not in the exclude list. CIS Kubernetes Benchmark Version 1.4.0 is used.

## CIS policy
{: #cis_policy}

The CIS policy controller watches policies of `kind:` `CISPolicy` and updates the status of the policy by checking whether the managed cluster is compliant or not. The policy itself includes a list of CIS controls that need to be excluded from checking. All the CIS controls that are not listed in the policy are checked for compliance. The controller uses `aqua-security` `kube-bench` tool for checking the master and worker nodes in the managed cluster for compliance.

The CIS policy can be created at the Red Hat Advanced Cluster Management for Kubernetes hub or on the managed cluster itself. When created at the Red Hat Advanced Cluster Management for Kubernetes hub, it is embedded into a parent policy. The policy can then be propagated to managed clusters in the Red Hat Advanced Cluster Management for Kubernetes hub based on the placement policy.

The set of rules that constitute CIS controls is different on an OpenShift Container Platform cluster. On OpenShift, the kube-bench tools use rules based on the Red Hat OpenShift Hardening Guide.

### Sample CIS policy (non-OpnShift Container Platform)
```
apiVersion: policies.ibm.com/v1alpha1
kind: CisPolicy
metadata:
  labels:
    controller-tools.k8s.io: "1.0"
    pci-category: "system-integrity"
  name: cispolicy-pci-sample
spec:
  cisSpecVersion: 1.4
  severity: medium
  kubernetesCisPolicy:
    masterNodeExcludeRules:
    - 1.1.11 Ensure that the admission control plugin AlwaysPullImages is set
    - 1.1.12 Ensure that the admission control plugin DenyEscalatingExec is set
    - 1.1.13 Ensure that the admission control plugin SecurityContextDeny is set
    - 1.1.15 Ensure that the --audit-log-path argument is set as appropriate
    - 1.1.16 Ensure that the --audit-log-maxage argument is set to 30 or as appropriate
    - 1.1.17 Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate
    - 1.1.18 Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate
    - 1.1.34 Ensure that the --experimental-encryption-provider-config argument is set as appropriate
    - 1.1.35 Ensure that the encryption provider is set to aescbc
    - 1.3.6 Ensure that the RotateKubeletServerCertificate argument is set to true
    - 1.4.1 Ensure that the API server pod specification file permissions are set to 644 or more restrictive
    - 1.4.2 Ensure that the API server pod specification file ownership is set to root:root
    - 1.4.3 Ensure that the controller manager pod specification file permissions are set to 644 or more restrictive
    - 1.4.4 Ensure that the controller manager pod specification file ownership is set to root:root
    - 1.4.5 Ensure that the scheduler pod specification file permissions are set to 644 or more restrictive
    - 1.4.6 Ensure that the scheduler pod specification file ownership is set to root:root
    - 1.4.7 Ensure that the etcd pod specification file permissions are set to 644 or more restrictive
    - 1.4.8 Ensure that the etcd pod specification file ownership is set to root:root
    - 1.4.9 Ensure that the Container Network Interface file permissions are set to 644 or more restrictive
    - 1.4.10 Ensure that the Container Network Interface file ownership is set to root:root
    - 1.4.11 Ensure that the etcd data directory permissions are set to 700 or more restrictive
    - 1.4.12 Ensure that the etcd data directory ownership is set to etcd:etcd
    - 1.4.13 Ensure that the admin.conf file permissions are set to 644 or more restrictive
    - 1.4.14 Ensure that the admin.conf file ownership is set to root:root
    - 1.4.15 Ensure that the scheduler.conf file permissions are set to 644 or more restrictive
    - 1.4.16 Ensure that the scheduler.conf file ownership is set to root:root
    - 1.4.17 Ensure that the controller-manager.conf file permissions are set to 644 or more restrictive
    - 1.4.18 Ensure that the controller-manager.conf file ownership is set to root:root
    - 1.4.19 Ensure that the Kubernetes PKI directory and file ownership is set to root:root
    - 1.4.20 Ensure that the Kubernetes PKI certificate file permissions are set to 644 or more restrictive
    - 1.4.21 Ensure that the Kubernetes PKI certificate file permissions are set to 600 or more restrictive
    - 1.5.2 Ensure that the --client-cert-auth argument is set to true
    - 1.5.4 Ensure that the --peer-cert-file and --peer-key-file arguments are set as appropriate
    - 1.5.5 Ensure that the --peer-client-cert-auth argument is set to true
    - 1.5.6 Ensure that the --peer-auto-tls argument is not set to true
    - 1.5.7 Ensure that a unique Certificate Authority is used for etcd
    - 1.6.1 Ensure that the cluster-admin role is only used where required
    - 1.6.2 Create administrative boundaries between resources using namespaces
    - 1.6.3 Create network segmentation using Network Policies
    - 1.6.4 Ensure that the seccomp profile is set to docker/default in your pod definitions
    - 1.6.5 Apply Security Context to Your Pods and Containers
    - 1.6.6 Configure Image Provenance using ImagePolicyWebhook admission controller
    - 1.6.7 Configure Network policies as appropriate
    - 1.6.8 Place compensating controls in the form of PSP and RBAC for privileged containers usage
    - 1.7.1 Do not admit privileged containers
    - 1.7.2 Do not admit containers wishing to share the host process ID namespace
    - 1.7.3 Do not admit containers wishing to share the host IPC namespace
    - 1.7.4 Do not admit containers wishing to share the host network namespace
    - 1.7.5 Do not admit containers with allowPrivilegeEscalation
    - 1.7.6 Do not admit root containers
    - 1.7.7 Do not admit containers with dangerous capabilities

 workerNodeExcludeRules:
    - 2.1.1 Ensure that the --anonymous-auth argument is set to false
    - 2.1.2 Ensure that the --authorization-mode argument is not set to AlwaysAllow
    - 2.1.3 Ensure that the --client-ca-file argument is set as appropriate
    - 2.1.4 Ensure that the --read-only-port argument is set to 0
    - 2.1.5 Ensure that the --streaming-connection-idle-timeout argument is not set to 0
    - 2.1.6 Ensure that the --protect-kernel-defaults argument is set to true
    - 2.1.8 Ensure that the --hostname-override argument is not set
    - 2.1.9 Ensure that the --event-qps argument is set to 0
    - 2.1.10 Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate
    - 2.1.12 Ensure that the --rotate-certificates argument is not set to false
    - 2.1.13 Ensure that the RotateKubeletServerCertificate argument is set to true
    - 2.1.14 Ensure that the Kubelet only makes use of Strong Cryptographic Ciphers
    - 2.2.1 Ensure that the kubelet.conf file permissions are set to 644 or more restrictive
    - 2.2.2 Ensure that the kubelet.conf file ownership is set to root:root
    - 2.2.3 Ensure that the kubelet service file permissions are set to 644 or more restrictive
    - 2.2.4 Ensure that the kubelet service file ownership is set to root:root
    - 2.2.5 Ensure that the proxy kubeconfig file permissions are set to 644 or more restrictive
    - 2.2.6 Ensure that the proxy kubeconfig file ownership is set to root:root
    - 2.2.7 Ensure that the certificate authorities file permissions are set to 644 or more restrictive
    - 2.2.8 Ensure that the client certificate authorities file ownership is set to root:root
    - 2.2.9 Ensure that the kubelet configuration file ownership is set to root:root
    - 2.2.10 Ensure that the kubelet configuration file has permissions set to 644 or more restrictive
```
{: codeblock}

### Sample CIS policy 
```
apiVersion: policies.ibm.com/v1alpha1
kind: CisPolicy
metadata:
  labels:
    controller-tools.k8s.io: "1.0"
  name: cispolicy-pci-ocp
spec:
  cisSpecVersion: 1.4
  severity: medium
  kubernetesCisPolicy:
    masterNodeExcludeRules:
    - 1.1 Maintain default behavior for anonymous access
    - 1.3 Insecure Tokens
    - 1.8 Do not expose API server profiling data
    - 1.11 Manage the AlwaysPullImages admission controller
    - 1.12 Use Security Context Constraints instead of DenyEscalatingExec admission
    - 1.13 Use Security Context Constraints instead of the SecurityContextDeny admission controller
    - 1.15 Configure API server auditing - audit log file path
    - 1.16 Configure API server auditing - audit log retention
    - 1.17 Configure API server auditing - audit log backup retention
    - 1.18 Configure audit log file size
    - 1.23 Verify that the service account lookup flag is not set
    - 1.24 Verify the PodSecurityPolicy is disabled to ensure use of SecurityContextConstraints
    - 1.31 Verify that the authorization-mode argument is not set
    - 1.34 Set the encryption provider to aescbc for etcd data at rest
    - 1.35 Enable the EventRateLimit plugin
    - 1.37 Adjust the request timeout argument for your cluster resources
    - 2.1 Verify that Scheduler profiling is not exposed to the web
    - 3.1 Adjust the terminated-pod-gc-threshold argument as needed
    - 3.2 Verify that Controller profiling is not exposed to the web
    - 3.6 Verify that Security Context Constraints are applied to Your Pods and Containers
    - 3.7 Manage certificate rotation
    - 4.6 Verify the scheduler pod specification file ownership set by OpenShift
    - 4.9 Verify the default OpenShift Container Network Interface file permissions
    - 4.12 Verify the default OpenShift etcd data directory ownership
    - 5.1 Verify the default OpenShift cert-file and key-file configuration
    - 5.2 Verify the default OpenShift setting for the client-cert-auth argument
    - 5.3 Verify the OpenShift default values for etcd_auto_tls
    - 5.4 Verify the OpenShift default peer-cert-file and peer-key-file arguments for etcd
    - 5.5 Verify the OpenShift default configuration for the peer-client-cert-auth
    - 5.6 Verify the OpenShift default configuration for the peer-auto-tls argument
    - 5.7 Optionally modify the wal-dir argument
    - 5.8 Optionally modify the max-wals argument
    - 5.9 Verify the OpenShift default configuration for the etcd Certificate Authority
    - 6.1 Ensure that the cluster-admin role is only used where required
    - 6.2 Verify Security Context Constraints as in use
    - 6.3 Use OpenShift projects to maintain boundaries between resources
    - 6.4 Create network segmentation using the Multi-tenant plugin or Network Policies
    - 6.5 Enable seccomp and configure custom Security Context Constraints
    - 6.7 Manage Image Provenance using ImagePolicyWebhook admission controller
    - 6.8 Configure Network policies as appropriate
    - 6.9 Use Security Context Constraints as compensating controls for privileged containers

    workerNodeExcludeRules:
    - 7.1 Use Security Context Constraints to manage privileged containers as needed
    - 7.2 Ensure anonymous-auth is not disabled
    - 7.7 Verify the OpenShift defaults for the protect-kernel-defaults argument
    - 7.9 Verify that the --keep-terminated-pod-volumes argument is set to false
    - 7.10 Verify the OpenShift defaults for the hostname-override argument
    - 7.12 Verify the OpenShift cert-dir flag for HTTPS traffic
    - 8.2 Verify the kubeconfig file ownership of root:root
    - 8.4 Verify the kubelet service file ownership of root:root
    - 8.6 Verify the proxy kubeconfig file ownership of root:root
    - 8.8 Verify the client certificate authorities file ownership of root:root
```
{: codeblock}

## CIS policy elements
{: #cis_elements}

### masterNodeExcludeRules
The rules applicable to master nodes that are to be exempted from checking. In order for master node to be compliant, this list must include any rules that must be checked manually or those rules that require extra configuration.

### workerNodeExcludeRules
The rules applicable to worker nodes that are to be exempted from checking. In order for worker node to be compliant, this list must include any rules that must be checked manually or those rules that require more configuration.

For more information see, [CIS rules specifications](../compliance/cis_policy_rules.md)

## Creating a CIS policy
{: #create_policy}

A CIS policy can be created either from the command line by using kubectl or from the console.

* [Creating a CIS policy from the command line](#create_policy_cli)
* [Create a CIS policy from Red Hat Advanced Cluster Management for Kubernetes console](#create_policy_gui)

### Creating a CIS policy from the command line
{: #create_policy_cli}

Complete the following steps to create a certificate policy from the command line interface (CLI):

1. Create a YAML file for your CIS policy by including a set of exclude rules for master node and worker node. See [Creating a YAML file for an Red Hat Advanced Cluster Management for Kubernetes policy](../compliance/create_policy.md#yaml) for more information about policy requirements.
```
apiVersion: policies.ibm.com/v1alpha1
kind: CisPolicy
metadata:
  labels:
    controller-tools.k8s.io: "1.0"
    pci-category: "system-integrity"
  name: cispolicy-pci-sample
spec:
  cisSpecVersion: 1.4
  severity: medium
  kubernetesCisPolicy:
    masterNodeExcludeRules:
    - 1.1.11 Ensure that the admission control plugin AlwaysPullImages is set
    - 1.1.12 Ensure that the admission control plugin DenyEscalatingExec is set
    - 1.1.13 Ensure that the admission control plugin SecurityContextDeny is set
    - 1.1.15 Ensure that the --audit-log-path argument is set as appropriate
    - 1.1.16 Ensure that the --audit-log-maxage argument is set to 30 or as appropriate
    - 1.1.17 Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate
    - 1.1.18 Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate
```
{: codeblock}

2. Apply the policy by running the following command:
```
kubectl apply -f <cis-policy-file> --namespace=<mcm_namespace>
```
{: codeblock}

3. Verify and list the policies by running the following command:
```
kubectl get cispolicy --namespace=<mcm_namespace>
```
{: codeblock}

### Viewing a CIS policy from command line interface (CLI)
Complete the following steps to view the CIS policy from the CLI:

1. View details for a specific CIS policy by running the following command:
```
kubectl get cispolicy <policy-name> -n <mcm_namespace> -o yaml
```
{: codeblock}

2. View a description of your CIS policy by running the following command:
```
kubectl describe cispolicy <name> -n <namespace>
```
{: codeblock}

### Creating a CIS policy from Red Hat Advanced Cluster Management for Kubernetes console
{: #create_policy_gui}

1. Log in to Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Govern risk**.
3. Click **Create Policy**.
4. Enter the name for the CIS policy in the **Name** field.
5. For **Specifications**, select either `Cispolicy-cis compliance` or `Cispolicy-cis compliance for OCP` from the drop-down list.
6. Use the drop-down list and make selections for the following parameters:
    - Cluster selector
    - Standards
    - Categories
    - Controls
7. Click **Create**.

A policy is created and the CIS policy is embedded into the parent policy. The `.yaml` resembles the following example.
```
apiVersion: policy.mcm.ibm.com/v1alpha1
kind: Policy
metadata:
  name: cis-sample-policy
  namespace: kube-system
  annotations:
    policy.mcm.ibm.com/categories: SystemAndInformationIntegrity
    policy.mcm.ibm.com/controls: ''
    policy.mcm.ibm.com/standards: PCI
    seed-generation: '1'
  finalizers:
    - finalizer.policies.ibm.com
    - propagator.finalizer.mcm.ibm.com
  generation: 1
  resourceVersion: '1906605'
spec:
  complianceType: musthave
  namespaces:
    exclude:
      - kube-*
    include:
      - default
  policy-templates:
    - objectDefinition:
        apiVersion: policies.ibm.com/v1alpha1
        kind: CisPolicy
        metadata:
          name: cis-sample-policy-pci-example
          labels:
            controller-tools.k8s.io: '1.0'
            pci-category: system-integrity
        spec:
          cisSpecVersion: 1.4
          kubernetesCisPolicy:
            masterNodeExcludeRules:
              - >-
                1.1.11 Ensure that the admission control plugin AlwaysPullImages
                is set
              - >-
                1.1.12 Ensure that the admission control plugin
                DenyEscalatingExec is set
              - >-
                1.1.13 Ensure that the admission control plugin
                SecurityContextDeny is set
              - >-
                1.1.15 Ensure that the --audit-log-path argument is set as
                appropriate
              - >-
                1.1.16 Ensure that the --audit-log-maxage argument is set to 30
                or as appropriate
              - >-
                1.1.17 Ensure that the --audit-log-maxbackup argument is set to
                10 or as appropriate
              - >-
                1.1.18 Ensure that the --audit-log-maxsize argument is set to
                100 or as appropriate
              - >-
                1.1.34 Ensure that the --experimental-encryption-provider-config
                argument is set as appropriate
              - 1.1.35 Ensure that the encryption provider is set to aescbc
              - >-
                1.3.6 Ensure that the RotateKubeletServerCertificate argument is
                set to true
              - >-
                1.4.1 Ensure that the API server pod specification file
                permissions are set to 644 or more restrictive
              - >-
                1.4.2 Ensure that the API server pod specification file
                ownership is set to root:root
              - >-
                1.4.3 Ensure that the controller manager pod specification file
                permissions are set to 644 or more restrictive
              - >-
                1.4.4 Ensure that the controller manager pod specification file
                ownership is set to root:root
              - >-
                1.4.5 Ensure that the scheduler pod specification file
                permissions are set to 644 or more restrictive
              - >-
                1.4.6 Ensure that the scheduler pod specification file ownership
                is set to root:root
              - >-
                1.4.7 Ensure that the etcd pod specification file permissions
                are set to 644 or more restrictive
              - >-
                1.4.8 Ensure that the etcd pod specification file ownership is
                set to root:root
              - >-
                1.4.9 Ensure that the Container Network Interface file
                permissions are set to 644 or more restrictive
              - >-
                1.4.10 Ensure that the Container Network Interface file
                ownership is set to root:root
              - >-
                1.4.11 Ensure that the etcd data directory permissions are set
                to 700 or more restrictive
              - >-
                1.4.12 Ensure that the etcd data directory ownership is set to
                etcd:etcd
              - >-
                1.4.13 Ensure that the admin.conf file permissions are set to
                644 or more restrictive
              - >-
                1.4.14 Ensure that the admin.conf file ownership is set to
                root:root
              - >-
                1.4.15 Ensure that the scheduler.conf file permissions are set
                to 644 or more restrictive
              - >-
                1.4.16 Ensure that the scheduler.conf file ownership is set to
                root:root
              - >-
                1.4.17 Ensure that the controller-manager.conf file permissions
                are set to 644 or more restrictive
              - >-
                1.4.18 Ensure that the controller-manager.conf file ownership is
                set to root:root
              - >-
                1.4.19 Ensure that the Kubernetes PKI directory and file
                ownership is set to root:root
              - >-
                1.4.20 Ensure that the Kubernetes PKI certificate file
                permissions are set to 644 or more restrictive
              - >-
                1.4.21 Ensure that the Kubernetes PKI certificate file
                permissions are set to 600 or more restrictive
              - 1.5.2 Ensure that the --client-cert-auth argument is set to true
              - >-
                1.5.4 Ensure that the --peer-cert-file and --peer-key-file
                arguments are set as appropriate
              - >-
                1.5.5 Ensure that the --peer-client-cert-auth argument is set to
                true
              - >-
                1.5.6 Ensure that the --peer-auto-tls argument is not set to
                true
              - >-
                1.5.7 Ensure that a unique Certificate Authority is used for
                etcd
              - >-
                1.6.1 Ensure that the cluster-admin role is only used where
                required
              - >-
                1.6.2 Create administrative boundaries between resources using
                namespaces
              - 1.6.3 Create network segmentation using Network Policies
              - >-
                1.6.4 Ensure that the seccomp profile is set to docker/default
                in your pod definitions
              - 1.6.5 Apply Security Context to Your Pods and Containers


              - >-
                1.6.6 Configure Image Provenance using ImagePolicyWebhook
                admission controller
              - 1.6.7 Configure Network policies as appropriate
              - >-
                1.6.8 Place compensating controls in the form of PSP and RBAC
                for privileged containers usage
              - 1.7.1 Do not admit privileged containers
              - >-
                1.7.2 Do not admit containers wishing to share the host process
                ID namespace
              - >-
                1.7.3 Do not admit containers wishing to share the host IPC
                namespace
              - >-
                1.7.4 Do not admit containers wishing to share the host network
                namespace
              - 1.7.5 Do not admit containers with allowPrivilegeEscalation
              - 1.7.6 Do not admit root containers
              - 1.7.7 Do not admit containers with dangerous capabilities
            workerNodeExcludeRules:
              - 2.1.1 Ensure that the --anonymous-auth argument is set to false
              - >-
                2.1.2 Ensure that the --authorization-mode argument is not set
                to AlwaysAllow
              - >-
                2.1.3 Ensure that the --client-ca-file argument is set as
                appropriate
              - 2.1.4 Ensure that the --read-only-port argument is set to 0
              - >-
                2.1.5 Ensure that the --streaming-connection-idle-timeout
                argument is not set to 0
              - >-
                2.1.6 Ensure that the --protect-kernel-defaults argument is set
                to true
              - 2.1.8 Ensure that the --hostname-override argument is not set
              - 2.1.9 Ensure that the --event-qps argument is set to 0
              - >-
                2.1.10 Ensure that the --tls-cert-file and
                --tls-private-key-file arguments are set as appropriate
              - >-
                2.1.12 Ensure that the --rotate-certificates argument is not set
                to false
              - >-
                2.1.13 Ensure that the RotateKubeletServerCertificate argument
                is set to true
              - >-
                2.1.14 Ensure that the Kubelet only makes use of Strong
                Cryptographic Ciphers
              - >-
                2.2.1 Ensure that the kubelet.conf file permissions are set to
                644 or more restrictive
              - >-
                2.2.2 Ensure that the kubelet.conf file ownership is set to
                root:root
              - >-
                2.2.3 Ensure that the kubelet service file permissions are set
                to 644 or more restrictive
              - >-
                2.2.4 Ensure that the kubelet service file ownership is set to
                root:root
              - >-
                2.2.5 Ensure that the proxy kubeconfig file permissions are set
                to 644 or more restrictive
              - >-
                2.2.6 Ensure that the proxy kubeconfig file ownership is set to
                root:root
              - >-
                2.2.7 Ensure that the certificate authorities file permissions
                are set to 644 or more restrictive
              - >-
                2.2.8 Ensure that the client certificate authorities file
                ownership is set to root:root
              - >-
                2.2.9 Ensure that the kubelet configuration file ownership is
                set to root:root
              - >-
                2.2.10 Ensure that the kubelet configuration file has
                permissions set to 644 or more restrictive
          severity: medium
  remediationAction: inform
  disabled: false
```
{: codeblock}

## Viewing a CIS policy
{: #view_policy}

View any CIS Policy and its status from the console.
1. Log in to the Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Govern risk**.
3. Click the _Policies_ tab to view a summary of your policies and a table list of your policies.

**Note:** You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab.
Select one of your policies.

## CIS risk score
{: #risk_score}

When a managed cluster is non-compliant, the CIS controller assigns a risk score. Each CIS rule that fails the check is assigned a score. The risk score that is assigned to the non-compliant cluster is the maximum of all the scores that are assigned to failed checks.

The risk score is on a scale of 1 to 10.
*  If the score is less than 4, then the risk category is `low`.
*  If the score is greater than or equal to 4, but less than or equal to 7, then the risk category is `medium`.
*  If the score is greater than 7, then the risk category is `high`.

You can assign a custom risk score to each CIS rule:

1. Edit configmap, `<helm-release>-cis-controller-config`.
   ```
   kubectl -n <namespace> edit configmap <helm-release>-cis-controller-config
   ```
   {: codeblock}

2. In the `cis_risk_score.yaml` section, locate the rule for which you want to assign a custom risk score.
3. Replace the existing score with the custom score and save the changes.
4. Restart the `cis-controller pod` by deleting it.
    ```
    kubectl -n <namespace> delete pod pod_name
    ```
    {: codeblock}

## CIS policy controller components
{: #contr_comp}

The CIS policy controller consists of the following four components.

### cis-controller-minio
The `cis-controller-minio` object store is used to store the artifacts that are collected by the CIS crawler that runs on all the master and worker nodes. The results from running the aqua-security kube-bench tool are also stored in the CIS Minio object store.

**Important:** You must create a secret that contains configuration credentials for the MinIO instance. Your secret might resemble the following YAML file: 

```
apiVersion: v1
kind: Secret
metadata:
  name: cis-controller-secret
type: Opaque
data:
  secret_key: <base64-encoded username for MinIO>
  access_key: <base64-encoded username for MinIO>
  location: <base64-encoded label for controller location>
```
{: codeblock}

### cis-crawler
The `cis-crawler` collects information about Kubernetes processes, binary files, and configuration files and stores them in the Minio object store. The crawler runs on the master and worker nodes. By default, it runs every 24 hours. To change the crawler frequency, complete the following steps.

1. Edit configmap, `<helm-release>-cis-crawler-config`.
   ```
   kubectl -n <namespace> edit configmap <helm-release>-cis-crawler-config
   ```
   {: codeblock}

2. Change the value of the `FREQUENCY` property to the wanted number of seconds and save the changes.
3. Restart the CIS crawler pods by deleting them.
   ```
   kubectl -n <namespace> delete pod <pod_name>
   ```
   {: codeblock}

### drishti-cis
The `drishti-cis` component runs the aqua-security kube-bench tool against the artifacts that are collected by the `cis-crawler` and stores the results in `cis-controller-mino` object store. By default, it scans the artifacts every 24 hours. To change the frequency, complete the following steps.
1. Edit the configmap, `<helm-release>-drishti-cis-config`.
   ```
   kubectl -n <namespace> edit configmap <helm-release>-drishti-cis-config
   ```
   {: codeblock}

2. Change the value of the `CIS_CHECK_FREQUENCY` property to the wanted number of seconds and save the changes.
3. Restart the `drishti-cis` pod by deleting it.
   ```
   kubectl -n <namespace> delete pod <pod_name>
   ```
   {: codeblock}

### cis-controller
The `cis-controller` scans the `cis-controller-minio` object store for results that are generated by the aqua-security kube-bench tool and updates the CIS policy status. By default, it scans the results every 24 hours or whenever the policy is updated. To change the frequency, complete the following steps.
1. Edit configmap, `<helm-release>-cis-controller-config`.
   ```
   kubectl -n <namespace> edit configmap <helm-release>-cis-controller-config
   ```
   {: codeblock}
2. Change the value of the `UPDATE_FREQUENCY` property to the wanted number of seconds and save the changes.
3. Restart the cis-controller pod by deleting it.
   ```
   kubectl -n <namespace> delete pod <pod_name>
   ```
   {: codeblock}

**Note: Frequency**
The `cis-controller` depends on the results that are posted by `drishti-cis`, which in turn depends upon the data that is collected by the `cis-crawler`. `cis-crawler`, `drishti-cis`, and `cis-controller` run at frequent intervals. The default interval for all three components is 24 hours. Staggering the frequencies helps the `cis-controller` evaluate the compliance status based on more recent data.

For more information about other policy controllers, see [{Red Hat Advanced Cluster Management for Kubernetes policy controllers](../compliance/policy_controllers.md). For more information about policies, see [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../compliance/compliance_intro.md).
