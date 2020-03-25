---

copyright:
  years: 2018, 2020
lastupdated: "2020-03-25"

---

# Red Hat Advanced Cluster Management for Kubernetes policy overview

An Red Hat Advanced Cluster Management for Kubernetes template is defined within a policy document. Each policy document can have at least one or multiple templates.

**Important**: Each client and cloud provider is responsible for ensuring that the cloud environment that they manage meets their enterprise security standards and any regulatory compliance requirements.

## Policy elements

Each _policy_ within the policy document contains the following elements:

  - An `annotations` parameter is used to specify a set of security details that describes the set of standards the policy is trying to validate. View the following descriptions of the security policy annotations:
      * `policy.mcm.ibm.com/standards` - The name or names of security standards the policy is related to. For example, National Institute of Standards and Technology (NIST) and Payment Card Industry (PCI).
      * `policy.mcm.ibm.com/categories` - The security control category the policy applies to. For example, Access Control, System and Information Integrity.
      * `policy.mcm.ibm.com/controls` - The name of the security control that is being checked. For example, Center of Internet Security (CIS) and certificate policy controller.
      
        **Note**: Use your internal security standards or industry standards for the `annotations` field. You can view policy violations based on the standards and categories that you define for your policy on the _Policies_ page, from the console.

  - A `namespace` selector that specifies which namespaces within the cluster that the policy is applied to.

  - A list of `templates`, such as `role-templates`, `object-templates`, and `policy-templates` within the policy that describes how a resource in Kubernetes might be defined, and whether it is allowed to exist.

    - A `role-template` is used to list RBAC roles that must be evaluated or applied to the managed clusters. Role templates are treated as a special category of templates, as they have rules inside that can be analyzed and compared to evaluate the compliance of a cluster.

    - An `object-template` is used to list any other Kubernetes object that must be evaluated or applied to the managed clusters. An example of object can be a pod security policy, an image policy, or a limit range.
    
    - A `policy-template` is used to create one or more policies for third party or external security controls. For example, you can create a certificate expiration policy with the certificate policy controller. 
    
    Create custom policy controllers to validate the compliance of your policies. For more information about other policy controllers, see [Red Hat Advanced Cluster Management for Kubernetes policy controllers](../compliance/policy_controllers.md).

See [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](compliance_intro.md) for more policy topics.
