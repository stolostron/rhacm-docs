---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-24"

---

# CIS rules specifications

Refer to the Center for Internet Security (CIS) rules when you create CIS policies for non-OpenShift Container Platform environments. When creating rules for OpenShift Container Platform environments, refer to the Red Hat OpenShift Hardening rules.
{:shortdesc}

* [CIS rules for non-OpenShift Container Platform](#cis-rules-for-non-openshift-container-platform)
* [CIS rules for OpenShift Container Platform](#cis-rules-for-openshift-container-platform)

## CIS rules for non-OpenShift Container Platform

### Master node rules for non-OpenShift Container Platform
```
1.1.1 Ensure that the --anonymous-auth argument is set to false
1.1.2 Ensure that the --basic-auth-file argument is not set
1.1.3 Ensure that the --insecure-allow-any-token argument is not set
1.1.4 Ensure that the --kubelet-https argument is set to true
1.1.5 Ensure that the --insecure-bind-address argument is not set
1.1.6 Ensure that the --insecure-port argument is set to 0
1.1.7 Ensure that the --secure-port argument is not set to 0
1.1.8 Ensure that the --profiling argument is set to false
1.1.9 Ensure that the --repair-malformed-updates argument is set to false
1.1.10 Ensure that the admission control plugin AlwaysAdmit is not set
1.1.11 Ensure that the admission control plugin AlwaysPullImages is set
1.1.12 Ensure that the admission control plugin DenyEscalatingExec is set
1.1.13 Ensure that the admission control plugin SecurityContextDeny is set
1.1.14 Ensure that the admission control plugin NamespaceLifecycle is set
1.1.15 Ensure that the --audit-log-path argument is set as appropriate
1.1.16 Ensure that the --audit-log-maxage argument is set to 30 or as appropriate
1.1.17 Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate
1.1.18 Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate
1.1.19 Ensure that the --authorization-mode argument is not set to AlwaysAllow
1.1.20 Ensure that the --token-auth-file parameter is not set
1.1.21 Ensure that the --kubelet-certificate-authority argument is set as appropriate
1.1.22 Ensure that the --kubelet-client-certificate and --kubelet-client-key arguments are set as appropriate
1.1.23 Ensure that the --service-account-lookup argument is set to true
1.1.24 Ensure that the admission control plugin PodSecurityPolicy is set
1.1.25 Ensure that the --service-account-key-file argument is set as appropriate
1.1.26 Ensure that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate
1.1.27 Ensure that the admission control plugin ServiceAccount is set(Scored)
1.1.28 Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate
1.1.29 Ensure that the --client-ca-file argument is set as appropriate
1.1.30 Ensure that the API Server only makes use of Strong Cryptographic Ciphers
1.1.31 Ensure that the --etcd-cafile argument is set as appropriate
1.1.32 Ensure that the --authorization-mode argument is set to Node
1.1.33 Ensure that the admission control plugin NodeRestriction is set
1.1.34 Ensure that the --experimental-encryption-provider-config argument is set as appropriate
1.1.35 Ensure that the encryption provider is set to aescbc
1.1.36 Ensure that the admission control plugin EventRateLimit is set
1.1.37 Ensure that the AdvancedAuditing argument is not set to false
1.1.38 Ensure that the --request-timeout argument is set as appropriate
1.1.39 Ensure that the --authorization-mode argument includes RBAC
1.2.1 Ensure that the --profiling argument is set to false
1.2.2 Ensure that the --address argument is set to 127.0.0.1
1.3.1 Ensure that the --terminated-pod-gc-threshold argument is set as appropriate
1.3.2 Ensure that the --profiling argument is set to false
1.3.3 Ensure that the --use-service-account-credentials argument is set to true
1.3.4 Ensure that the --service-account-private-key-file argument is set as appropriate
1.3.5 Ensure that the --root-ca-file argument is set as appropriate
1.3.6 Ensure that the RotateKubeletServerCertificate argument is set to true
1.3.7 Ensure that the --address argument is set to 127.0.0.1
1.4.1 Ensure that the API server pod specification file permissions are set to 644 or more restrictive
1.4.2 Ensure that the API server pod specification file ownership is set to root:root
1.4.3 Ensure that the controller manager pod specification file permissions are set to 644 or more restrictive
1.4.4 Ensure that the controller manager pod specification file ownership is set to root:root
1.4.5 Ensure that the scheduler pod specification file permissions are set to 644 or more restrictive
1.4.6 Ensure that the scheduler pod specification file ownership is set to root:root
1.4.7 Ensure that the etcd pod specification file permissions are set to 644 or more restrictive
1.4.8 Ensure that the etcd pod specification file ownership is set to root:root
1.4.9 Ensure that the Container Network Interface file permissions are set to 644 or more restrictive
1.4.10 Ensure that the Container Network Interface file ownership is set to root:root
1.4.11 Ensure that the etcd data directory permissions are set to 700 or more restrictive
1.4.12 Ensure that the etcd data directory ownership is set to etcd:etcd
1.4.13 Ensure that the admin.conf file permissions are set to 644 or more restrictive
1.4.14 Ensure that the admin.conf file ownership is set to root:root
1.4.15 Ensure that the scheduler.conf file permissions are set to 644 or more restrictive
1.4.16 Ensure that the scheduler.conf file ownership is set to root:root
1.4.17 Ensure that the controller-manager.conf file permissions are set to 644 or more restrictive
1.4.18 Ensure that the controller-manager.conf file ownership is set to root:root
1.4.19 Ensure that the Kubernetes PKI directory and file ownership is set to root:root
1.4.20 Ensure that the Kubernetes PKI certificate file permissions are set to 644 or more restrictive
1.4.21 Ensure that the Kubernetes PKI certificate file permissions are set to 600 or more restrictive
1.5.1 Ensure that the --cert-file and --key-file arguments are set as appropriate
1.5.2 Ensure that the --client-cert-auth argument is set to true
1.5.3 Ensure that the --auto-tls argument is not set to true
1.5.4 Ensure that the --peer-cert-file and --peer-key-file arguments are set as appropriate
1.5.5 Ensure that the --peer-client-cert-auth argument is set to true
1.5.6 Ensure that the --peer-auto-tls argument is not set to true
1.5.7 Ensure that a unique Certificate Authority is used for etcd
1.6.1 Ensure that the cluster-admin role is only used where required
1.6.2 Create administrative boundaries between resources using namespaces
1.6.3 Create network segmentation using Network Policies
1.6.4 Ensure that the seccomp profile is set to docker/default in your pod definitions
1.6.5 Apply Security Context to Your Pods and Containers
1.6.6 Configure Image Provenance using ImagePolicyWebhook admission controller
1.6.7 Configure Network policies as appropriate
1.6.8 Place compensating controls in the form of PSP and RBAC for privileged containers usage
1.7.1 Do not admit privileged containers
1.7.2 Do not admit containers wishing to share the host process ID namespace
1.7.3 Do not admit containers wishing to share the host IPC namespace
1.7.4 Do not admit containers wishing to share the host network namespace
1.7.5 Do not admit containers with allowPrivilegeEscalation
1.7.6 Do not admit root containers
1.7.7 Do not admit containers with dangerous capabilities
```

### Worker node rules for non-OpenShift Container Platform
```
2.1.1 Ensure that the --anonymous-auth argument is set to false
2.1.2 Ensure that the --authorization-mode argument is not set to AlwaysAllow
2.1.3 Ensure that the --client-ca-file argument is set as appropriate
2.1.4 Ensure that the --read-only-port argument is set to 0
2.1.5 Ensure that the --streaming-connection-idle-timeout argument is not set to 0
2.1.6 Ensure that the --protect-kernel-defaults argument is set to true
2.1.7 Ensure that the --make-iptables-util-chains argument is set to true
2.1.8 Ensure that the --hostname-override argument is not set
2.1.9 Ensure that the --event-qps argument is set to 0
2.1.10 Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate
2.1.11 Ensure that the --cadvisor-port argument is set to 0
2.1.12 Ensure that the --rotate-certificates argument is not set to false
2.1.13 Ensure that the RotateKubeletServerCertificate argument is set to true
2.1.14 Ensure that the Kubelet only makes use of Strong Cryptographic Ciphers
2.2.1 Ensure that the kubelet.conf file permissions are set to 644 or more restrictive
2.2.2 Ensure that the kubelet.conf file ownership is set to root:root
2.2.3 Ensure that the kubelet service file permissions are set to 644 or more restrictive
2.2.4 Ensure that the kubelet service file ownership is set to root:root
2.2.5 Ensure that the proxy kubeconfig file permissions are set to 644 or more restrictive
2.2.6 Ensure that the proxy kubeconfig file ownership is set to root:root
2.2.7 Ensure that the certificate authorities file permissions are set to 644 or more restrictive
2.2.8 Ensure that the client certificate authorities file ownership is set to root:root
2.2.9 Ensure that the kubelet configuration file ownership is set to root:root
2.2.10 Ensure that the kubelet configuration file has permissions set to 644 or more restrictive
```

## CIS rules for OpenShift Container Platform

### Master node rules for OpenShift Container Platform
```
1.1 Maintain default behavior for anonymous access
1.2 Verify that the basic-auth-file method is not enabled
1.3 Insecure Tokens
1.4 Secure communications between the API server and master nodes
1.5 Prevent insecure bindings
1.6 Prevent insecure port access
1.7 Use Secure Ports for API Server Traffic
1.8 Do not expose API server profiling data
1.9 Verify repair-malformed-updates argument for API compatibility
1.10 Verify that the AlwaysAdmit admission controller is disabled
1.11 Manage the AlwaysPullImages admission controller
1.12 Use Security Context Constraints instead of DenyEscalatingExec admission
1.13 Use Security Context Constraints instead of the SecurityContextDeny admission controller
1.14 Manage the NamespaceLifecycle admission controller
1.15 Configure API server auditing - audit log file path
1.16 Configure API server auditing - audit log retention
1.17 Configure API server auditing - audit log backup retention
1.18 Configure audit log file size
1.19 Verify that authorization-mode is not set to AlwaysAllow
1.20 Verify that the token-auth-file flag is not set
1.21 Verify the API server certificate authority
1.22 Verify the API server client certificate and client key
1.23 Verify that the service account lookup flag is not set
1.24 Verify the PodSecurityPolicy is disabled to ensure use of SecurityContextConstraints
1.25 Verify that the service account key file argument is not set
1.26 Verify the certificate and key used for communication with etcd
1.27 Verify that the ServiceAccount admission controller is enabled
1.28 Verify the certificate and key used to encrypt API server traffic
1.29 Verify that the --client-ca-file argument is not set
1.30 Verify the CA used for communication with etcd
1.31 Verify that the authorization-mode argument is not set
1.32 Verify that the NodeRestriction admission controller is enabled
1.33 Configure encryption of data at rest in etcd datastore
1.34 Set the encryption provider to aescbc for etcd data at rest
1.35 Enable the EventRateLimit plugin
1.36 Configure advanced auditing
1.37 Adjust the request timeout argument for your cluster resources
2.1 Verify that Scheduler profiling is not exposed to the web
3.1 Adjust the terminated-pod-gc-threshold argument as needed
3.2 Verify that Controller profiling is not exposed to the web
3.3 Verify that the --use-service-account-credentials argument is set to true
3.4 Verify that the --service-account-private-key-file argument is set as appropriate
3.5 Verify that the --root-ca-file argument is set as appropriate
3.6 Verify that Security Context Constraints are applied to Your Pods and Containers
3.7 Manage certificate rotation
4.1 Verify the OpenShift default permissions for the API server pod specification file
4.2 Verify the OpenShift default file ownership for the API server pod specification file
4.3 Verify the OpenShift default file permissions for the controller manager pod specification file
4.4 Verify the OpenShift default ownership for the controller manager pod specification file
4.5 Verify the OpenShift default permissions for the scheduler pod specification file
4.6 Verify the scheduler pod specification file ownership set by OpenShift
4.7 Verify the OpenShift default etcd pod specification file permissions
4.8 Verify the OpenShift default etcd pod specification file ownership
4.9 Verify the default OpenShift Container Network Interface file permissions
4.10 Verify the default OpenShift Container Network Interface file ownership
4.11 Verify the default OpenShift etcd data directory permissions
4.12 Verify the default OpenShift etcd data directory ownership
4.13 Verify the default OpenShift admin.conf file permissions
4.14 Verify the default OpenShift admin.conf file ownership
4.15 Verify the default OpenShift scheduler.conf file permissions
4.16 Verify the default OpenShift scheduler.conf file ownership
4.17 Verify the default Openshift controller-manager.conf file permissions
4.18 Ensure that the controller-manager.conf file ownership is set to root:root (Scored)
5.1 Verify the default OpenShift cert-file and key-file configuration
5.2 Verify the default OpenShift setting for the client-cert-auth argument
5.3 Verify the OpenShift default values for etcd_auto_tls
5.4 Verify the OpenShift default peer-cert-file and peer-key-file arguments for etcd
5.5 Verify the OpenShift default configuration for the peer-client-cert-auth
5.6 Verify the OpenShift default configuration for the peer-auto-tls argument
5.7 Optionally modify the wal-dir argument
5.8 Optionally modify the max-wals argument
5.9 Verify the OpenShift default configuration for the etcd Certificate Authority
6.1 Ensure that the cluster-admin role is only used where required
6.2 Verify Security Context Constraints as in use
6.3 Use OpenShift projects to maintain boundaries between resources
6.4 Create network segmentation using the Multi-tenant plugin or Network Policies
6.5 Enable seccomp and configure custom Security Context Constraints
6.6 Review Security Context Constraints
6.7 Manage Image Provenance using ImagePolicyWebhook admission controller
6.8 Configure Network policies as appropriate
6.9 Use Security Context Constraints as compensating controls for privileged containers
```

### Worker node rules for OpenShift Container Platform
```
7.1 Use Security Context Constraints to manage privileged containers as needed
7.2 Ensure anonymous-auth is not disabled
7.3 Verify that the --authorization-mode argument is set to WebHook
7.4 Verify the OpenShift default for the client-ca-file argument
7.5 Verify the OpenShift default setting for the read-only-port argument
7.6 Adjust the streaming-connection-idle-timeout argument
7.7 Verify the OpenShift defaults for the protect-kernel-defaults argument
7.8 Verify the OpenShift default value of true for the make-iptables-util-chains argument
7.9 Verify that the --keep-terminated-pod-volumes argument is set to false
7.10 Verify the OpenShift defaults for the hostname-override argument
7.11 Set the --event-qps argument to 0
7.12 Verify the OpenShift cert-dir flag for HTTPS traffic
7.13 Verify the OpenShift default of 0 for the cadvisor-port argument
7.14 Verify that the RotateKubeletClientCertificate argument is set to true
7.15 Verify that the RotateKubeletServerCertificate argument is set to true
8.1 Verify the OpenShift default permissions for the kubelet.conf file
8.2 Verify the kubeconfig file ownership of root:root
8.3 Verify the kubelet service file permissions of 644
8.4 Verify the kubelet service file ownership of root:root
8.5 Verify the OpenShift default permissions for the proxy kubeconfig file
8.6 Verify the proxy kubeconfig file ownership of root:root
8.7 Verify the OpenShift default permissions for the certificate authorities file.
8.8 Verify the client certificate authorities file ownership of root:root
```
