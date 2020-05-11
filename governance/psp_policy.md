# Pod security policy

## Pod security policy YAML structure

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
   
## Pod security policy table

## Pod security policy sample

Apply a pod security policy to secure pods and containers. For more information, see _Pod Security Policies_ in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/).

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
   
### Applying a pod security policy

Complete the following steps to apply the pod security policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **Podsecuritypolicy** from the _Specifications_ field.