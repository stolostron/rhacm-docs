---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-24"

---

# Red Hat Advanced Cluster Management for Kubernetes policy samples

View a description of the the policy samples that are included in your Red Hat Advanced Cluster Management for Kubernetes installation.

* [Memory usage policy](#memory-usage-policy) 
* [Namespace policy](#namespace-policy)
* [Network policy](#network-policy)
* [Pod nginx policy](#pod-nginx-policy)
* [Pod security policy](#pod-security-policy)
* [Role policy](#role-policy)
* [Rolebinding policy](#rolebinding-policy)


**Note**: You must create a placement policy and placement binding policy to apply your policies on to your cluster. For more information, see [Red Hat Advanced Cluster Management for Kubernetes policy example](../governance/policy_example.md).

## Memory usage policy

Apply the limit range policy to limit your memory usage. Your memory usage policy might resemble the following YAML file:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-limitrange
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
           apiVersion: v1
           kind: LimitRange # limit memory usage
           metadata:
             name: mem-limit-range
           spec:
             limits:
             - default:
                 memory: 512Mi
               defaultRequest:
                 memory: 256Mi
               type: Container
           ...
   ```
   
### Applying the memory usage policy

Complete the following steps to apply the memory usage policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Governance and risk**. 
3. Click **Create policy**. 
4. Select **Limitrange** from the _Specifications_ field.

## Namespace policy

Apply the namespace policy to define specific rules for your namespace. Your namespace policy might resemble the following YAML file:
  
   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-namespace-1
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
           kind: Namespace # must have namespace 'prod'
           apiVersion: v1
           metadata:
             name: prod
        ...
   ```
   
### Applying the namespace policy

Complete the following steps to apply the memory usage policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Governance and risk**. 
3. Click **Create policy**. 
4. Select **Namespace** from the _Specifications_ field.

        
## Network

Apply the network policy to define which network request to deny. For more information about network policies, see _Network Policy_ from the [Kubernetes documentation]( https://kubernetes.io/docs/concepts/services-networking/network-policies/).

Your network policy might resemble the following YAML file:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-networkpolicy
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
        kind: NetworkPolicy # deny network request
        apiVersion: networking.k8s.io/v1
        metadata:
          name: deny-from-other-namespaces
        spec:
          podSelector:
            matchLabels:
          ingress:
          - from:
            - podSelector: {} # accept ingress from all pods within this namespace only
       ...     
   ```
 
### Applying the network policy

Complete the following steps to apply the network policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **Networkpolicy** from the _Specifications_ field.

## Pod nginx policy

Apply the pod policy to define the container rules for your pods. A nginx pod must exist in your cluster. Your pod policy nginx policy might resemble the following YAML file:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-pod
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
           apiVersion: v1
           kind: Pod # nginx pod must exist
           metadata:
             name: nginx-pod
           spec:
             containers:
             - image: nginx:1.7.9
               name: nginx
               ports:
               - containerPort: 80
        ...
   ```

### Applying the pod policy

Complete the following steps to apply the pod policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **Pod** from the _Specifications_ field.

## Pod security policy

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

## Role policy

Apply a role policy to set rules and permissions for specific roles in your cluster. For more information on roles, see [Role-based access control (RBAC)](../governance/security.md). Your role policy might resemble the following YAML file:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-role
     namespace: mcm
   spec:
     complianceType: musthave
     remediationAction: inform
     namespaces:
       exclude: ["kube-*"]
       include: ["default"]
     role-templates:
       - apiVersion: roletemplate.mcm.ibm.com/v1alpha1 # role must follow defined permissions
         metadata:
           namespace: "" # will be inferred
           name: operator-role-policy 
         selector:
           matchLabels:
             dev: "true"
         complianceType: musthave # at this level, it means the role must exist with the rules that it must have the following
         rules:
           - complianceType: musthave # at this level, it means if the role exists the rule is a musthave
             policyRule:
               apiGroups: ["extensions", "apps"]
               resources: ["deployments"]
               verbs: ["get", "list", "watch", "create", "delete","patch"]
          - complianceType: "mustnothave" # at this level, it means if the role exists the rule is a mustnothave
            policyRule:
              apiGroups: ["core"]
              resources: ["secrets"]
              verbs: ["get", "list", "watch","delete", "create", "update", "patch"]
         ...
   ```

### Applying a role policy

Complete the following steps to apply the role policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **Role** from the _Specifications_ field.

## Role binding policy

Apply a role binding policy to bind a policy to a namespace in your cluster. Your role binding policy might resemble the following YAML file:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-rolebinding
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
           kind: RoleBinding # role binding must exist
           apiVersion: rbac.authorization.k8s.io/v1
           metadata:
             name: operate-pods-rolebinding
           subjects:
           - kind: User
             name: admin # Name is case sensitive
             apiGroup: rbac.authorization.k8s.io
           roleRef:
             kind: Role #this must be Role or ClusterRole
             name: operator # this must match the name of the Role or ClusterRole you wish to bind to
             apiGroup: rbac.authorization.k8s.io
       ...
   ```
   
### Apply a role policy

Complete the following steps to apply the role binding policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **Rolebinding** from the _Specifications_ field.
          
          
  See [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../governance/compliance_intro.md) for more information about policies.
