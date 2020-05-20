# Policy controllers

Use the Red Hat Advanced Cluster Management for Kubernetes governance and risk policy framework to create custom policy controllers. The policy controllers are Kubernetes CustomResourceDefinition (CRD) instance. For more information about CRDs, see [Extend the Kubernetes API with CustomResourceDefinitions](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/).

Create and customize policies with the out of the box policy templates. **Important**: Some policy controllers may not support the enforce feature. If the enforce feature is not supported by the controller, you must remediate it manually. Only the configuration policy controller supports the `enforce` feature.

View the following topics to learn more about the following Red Hat Advanced Cluster Management for Kubernetes policy controllers:

- [Configuration policy controller](config_policy_ctrl.md)
- [Certificate policy controller](cert_policy_ctrl.md)
- [IAM policy controller](iam_policy_ctrl.md)
- [CIS policy controller](cis_policy_ctrl.md)

Refer to [Governance and risk](compliance_intro.md) for more topics about managing your policies.
