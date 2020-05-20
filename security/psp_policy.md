# Pod security policy

Kubernetes configuration policy controller monitors the status of the memory usage policy. Apply a pod security policy to secure pods and containers. For more information, see _Pod Security Policies_ in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/). Learn more details about the pod security policy structure in the following sections.

## Pod security policy YAML structure

```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-podsecuritypolicy
     namespace:
   spec:
     complianceType:
     remediationAction:
     namespaces:
       exclude:
       include:
     object-templates:
       - complianceType:
         objectDefinition:
           apiVersion:
           kind: PodSecurityPolicy # no privileged pods
           metadata:
             name:
             annotations:
           spec:
             privileged:
             allowPrivilegeEscalation:
             allowedCapabilities:
             volumes:
             hostNetwork:
             hostPorts:
             hostIPC:
             hostPID:
             runAsUser:
               rule:
             seLinux:
               rule:
             supplementalGroups:
               rule:
             fsGroup:
               rule:
        ...
   ```
   
## Pod security policy table

<!--just a place holder until i go through the parameters-->
|Field|Description|
|-- | -- |
| apiVersion | Required. Set the value to `policy.mcm.ibm.com/v1alpha1`. <!--current place holder until this info is updated--> |
| kind | Required. Set the value to `Policy` to indicate the type of policy. |
| metadata.name | Required. The name for identifying the policy resource. |
| metadata.namespaces | Optional. |
| spec.namespace | Required. The namespaces within the hub cluster that the policy is applied to. Enter parameter values for `include`, which are the namespaces you want to apply to the policy to. `exclude` specifies the namespaces you explicitly do not want to apply the policy to. **Note**: A namespace that is specified in the object template of a policy controller, overrides the namespace in the corresponding parent policy.|
| remediationAction | Optional. Specifies the remediation of your policy. The parameter values are `enforce` and `inform`. **Important**: Some policies may not support the enforce feature.|
| disabled | Required. Set the value to `true` or `false`. The `disabled` parameter provides the ability to enable and disable your policies.|
| spec.complianceType | Required. Set the value to `"musthave"`|
| spec.object-template| Optional. Used to list any other Kubernetes object that must be evaluated or applied to the managed clusters. |
{: caption="Table 1. Required and optional definition fields" caption-side="top"}

## Pod security policy sample

Your pod security policy might resemble the following YAML file:
 
   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-podsecuritypolicy
     namespace: mcm
   spec:
     complianceType: musthave
     remediationAction: inform
     namespaces:
       exclude: ["kube-*"]
       include: ["default"]
     object-templates:
       - complianceType: musthave
         objectDefinition:
           apiVersion: policy/v1beta1
           kind: PodSecurityPolicy # no privileged pods
           metadata:
             name: restricted-mcm
             annotations:
            seccomp.security.alpha.kubernetes.io/allowedProfileNames: '*'
           spec:
             privileged: false # no priviliedged pods
             allowPrivilegeEscalation: false
             allowedCapabilities:
             - '*'
             volumes:
             - '*'
             hostNetwork: true
             hostPorts:
             - min: 1000 # ports < 1000 are reserved
               max: 65535
             hostIPC: false
             hostPID: false
             runAsUser:
               rule: 'RunAsAny'
             seLinux:
               rule: 'RunAsAny'
             supplementalGroups:
               rule: 'RunAsAny'
             fsGroup:
               rule: 'RunAsAny'
        ...
   ```

See [Managing pod security policies](create_psp_policy.md) for more information. View other configuration policies that are monitored by controller, see the [Kubernetes configuration policy controller](config_policy_ctrl.md) page.
