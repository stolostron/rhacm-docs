---

copyright:
  years: 2016, 2019
lastupdated: "2019-12-11"


---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Pod security

Learn how to secure pods and containers that are running in your cluster.
{:shortdesc}

Kubernetes is a container orchestration platform. Container images can come from various sources and have different operating system requirements. Some containers are written to be self-contained such that they do not require any host operating system features. Other containers require access to the host operating system, such as the host network or file system.

It is important to identify what features are required so that running containers can be efficiently colocated or isolated from one another.

Pod security policies can be used to enforce container image security for the pods in your cluster. A pod security policy is a cluster level resource that controls the security sensitive aspects of pod specification and the set of conditions that must be met for a pod to be admitted into the cluster. The pod security policy is applied to the namespace by creating a *ClusterRoleBinding* or *RoleBinding* with the respective pod security policy `ClusterRole` for all ServiceAccounts in the namespace. Pod security policies allow cluster administrators to create pod isolation policies, and assign them to namespaces and worker nodes. For more information about isolated pods, see [Pod isolation](../../pod-security/3.4.0/iso_pod.md). For more information about pod security policy, see _Pod Security Policies_ on the [Kubernetes Concepts page  ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){: new_window}.


**Important:** Multiple pod security policies can be associated with a namespace or ServiceAccount. Pods can resolve to any of the compatible defined policies. For more information about policy order, see _Policy Order_ on the [Kubernetes Concepts page  ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#policy-order){: new_window}.

A Kubernetes [Pod ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://kubernetes.io/docs/concepts/workloads/pods/pod/) is a set of 1 or more colocated containers. The Pod Admission Controller prevents the creation of a pod if the pod security policy does not allow the privileged feature. The Pod Admission Controller can also set default values in the pod and container, preventing or allowing runtime access to privileged features.

All {{site.data.keyword.contain_softs}} provide detailed container security requirements. For more information, see [{{site.data.keyword.contain_soft}} Security Policy definitions ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/IBM/cloud-pak/tree/master/spec/security/psp){: new_window}.  

See [Isolation on {{site.data.keyword.product}}](../../iam/3.4.0/iso_icp.md) to learn more about pod isolation.

## Predefined pod security policies

{{site.data.keyword.product_tm}} provides predefined policies that you can apply to your pod by associating them to a namespace during namespace creation. These predefined pod security policies apply to most of the {{site.data.keyword.IBM_notm}} content charts. The following list shows the types and descriptions that range from the most restrictive to the least restrictive:

  * `ibm-restricted-psp`: This policy requires pods to run with a non-root user ID, and prevents pods from accessing the host.
  * `ibm-anyuid-psp`: This policy allows pods to run with any user ID and group ID, but prevents access to the host.
  * `ibm-anyuid-hostpath-psp`: This policy allows pods to run with any user ID and group ID and any volume, including the host path. **Attention:** This policy allows hostPath volumes. Ensure that is level of access that you want to provide.
  * `ibm-anyuid-hostaccess-psp`: This policy allows pods to run with any user ID and group ID, any volume, and full access to the host. **Attention:**  This policy allows full access to the host and network. Ensure that is level of access that you want to provide.
  * `ibm-privileged-psp`: This policy grants access to all privileged host features and allows a pod to run with any user ID and group ID and any volume. **Attention:**  This policy is the least restrictive and must be used only for cluster administration. Use with caution.

For more details about the policy definitions, see the [{{site.data.keyword.contain_soft}} Pod Security Policy Definitions ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://ibm.biz/cpkspec-psp){: new_window}.

If you install {{site.data.keyword.product}} version {{site.data.keyword.version}} or later as a new installation, the default pod security policy setting is the `ibm-restricted-psp` policy, which is applied to all of the existing and newly created namespaces. If you upgrade to version {{site.data.keyword.version}} or later from an earlier version, the default pod security is the `ibm-anyuid-hostpath-psp` policy, which is unrestricted and is applied by default to all of the existing and newly created namespaces. The upgraded settings are unrestricted to prevent any disruptions with access issues on the applications and pods that are already running in your cluster.

You can also use the {{site.data.keyword.product}} CLI commands to view the current settings of the cluster, and to toggle the pod security policy between restricted and unrestricted modes. See [{{site.data.keyword.product}} CLI cm commands (cm)](../../cloudctl/3.2.3/cli_cm_commands.md) for more information about using these commands. 

You can view the PodSecurityPolicy CLI command settings information in the {{site.data.keyword.product}} {{site.data.keyword.gui}} by selecting the settings icon on the Pod Security page. 

The *namespace overview* page shows the pod security policies for every namespace. See [Namespaces](../../iam/3.4.0/projects.md) for more information about namespaces.

When you create a namespace, you can now associate the pod security policy to the namespace, which can be used to deploy content or a chart. See [Creating a namespace](../../iam/3.4.0/create_project.md) for more details about associating a pod security policy to a namespace.

The pod security policy requirements are displayed on the *chart configuration* page to help facilitate namespace selection and deployment. See [Deploying Helm charts in the {{site.data.keyword.catalog}}](../../catalog/3.4.0/create_release.md).
 
## Customized pod security policies

You can also create your own pod security policies. 

See the following topics to manage your pod security policy:

- {: child} [Creating pod security policies](../../pod-security/3.4.0/custom_psp.md)
- {: child} [{{site.data.keyword.product}} CLI cm commands (cm)](../../cloudctl/3.2.3/cli_cm_commands.md)
{: childlinks}
