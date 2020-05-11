# Managing a CIS policy

Learn to create, apply, and view your CIS policies.

## Creating a CIS policy 

You can create a YAML file for your CIS policy or create a CIS policy from the console. View the following sections to create a certificate policy:

### Creating a CIS policy from the command line

Complete the following steps to create a certificate policy from the command line interface (CLI):

1. Create a YAML file for your CIS policy by including a set of exclude rules for master node and worker node. Run the following command:

  ```
  kubectl create -f CisPolicy.yaml
  ```
  Your YAML might resemble the following file:

  ```yaml
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
  ```

2. Apply the policy by running the following command:

   ```
   kubectl apply -f <cis-policy-file> --namespace=<namespace>
   ```

3. Verify and list the policies by running the following command:

   ```
   kubectl get cispolicy --namespace=<namespace>
   ```

#### Viewing a CIS policy from command line interface (CLI)

Complete the following steps to view the CIS policy from the managed cluster CLI. View non-compliant policies by completing the following steps:

1. Get a list of the CIS policies that are on your hub cluster by running the following command:

   ```
   oc get cispolicy --all-namespaces
   ```

2. Run the following command to view which policies are listed `NonCompliant`:

   ```
   oc describe cispolicy -n <namespace> <policyname>
   ```

   Your output might resemble the following response:

     ```
     Status:
       Cis Policy Status:
         Endpoint 4:
           Cluster Name:  endpoint4
           Compliancy:    NonCompliant
           Node Status:
             150 . 238 . 253 . 105:  NonCompliant
             150 . 238 . 253 . 106:  NonCompliant
             150 . 238 . 253 . 121:  NonCompliant
           Risk Score:
             Highest Risk Score:  5
             Risk Category:       medium
        Observed Generation:       2
     Events:
       Type     Reason       Age                From            Message
       ----     ------       ----               ----            -------
       Warning  Medium Risk  12s (x2 over 26s)  cis-controller  Medium Risk detected!
     ```

3. Verify which nodes are non-compliant by running the following commands:

   ```
   oc get nodes -o wide

   oc describe node <node-name>
   ```

   **Note**: The node name that appear might be a label for the node, for instance `ibm-cloud.kubernetes.io/external-ip=150.238.253.106`.

4. View the risk scores for the CIS rules in your policy by running the following command:

  ```
  kubectl -n <namespace> describe configmap endpoint-cisctrl-controller-config
  ```


### Creating a CIS policy from the console

1. Log in to Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Govern risk**.
3. Click **Create Policy**.
4. Enter the name for the CIS policy in the **Name** field.
5. For **Specifications**, select `Cispolicy-cis compliance for OCP` from the drop-down list.

  **Note**: You must enable the feature flag to make the `Cispolicy-cis compliance for OCP` option available.

6. Use the drop-down list and make selections for the following parameters:
    - Cluster selector
    - Standards
    - Categories
    - Controls
7. Click **Create**.

A policy is created and is embedded into the policy. View a sample of the CIS policy, see _CIS policy sample_ from [CIS policy controller](cis_pol_ctrl.md). 


#### Viewing a CIS policy from the console

View any CIS Policy and its status from the console.
1. Log in to the Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Govern risk** to view a table list of your policies.

  **Note:** You can filter the table list of your policies by selecting the _All policies_ tab or _Cluster violations_ tab.

3. Select one of your policies.


## Remediating CIS policy violation

Verify rule failures to remediate your CIS policy violations. Complete the following steps:

1. Log in to your OpenShift Container Platform from the CLI. Run the following command to port-forward the CIS controller MinIO endpoint:

   ```
   oc port-forward endpoint-cisctrl-minio-0 9123:9000
   ```

2. Log in to your MinIO account with your access key and secret key, which is contained on the endpoint in a secret. Obtain the endpoint secret by running the following command:

  ```
  oc get secret -n multicluster-endpoint endpoint-cisctrl-secret -o yaml
  ```

3. Decode the encoded values by completing the following steps:

  1. Decode the access key and secret key by running the following commands:

     ```
     echo <encoded_access_key_value> | base64 --decode

     echo <encoded_secret_key_value> | base64 --decode
     ```

  2. Copy and paste the decoded values into the appropriate fields from the MinIO console.

4. Verify what nodes are labeled `NonCompliant`. From the MinIO menu browser, select **cis-k8s** > **icp-local** > **recent** > **IP address for worker or master node**.

5. Click the non-compliant node and select the attached file to download. Click **Download object** and then open the file. The nodes rules that have failed are shown with the following label: `[FAIL]`.

6. Remediate the non-compliant node manually by referencing the `Remediation` section of the attached file. If a rule does not apply to your environment, add the rule to the `masterNodeExcludeRules` or `workerNodeExcludeRules` in your CIS policy. Your `Remediation` section might resemble the following content:

   ```
   == Remediations ==
   7.9 Reset to the OpenShift defaults

   7.12 Reset to the OpenShift default values.

   7.14 Edit the Openshift node config file /etc/origin/node/node-config.yaml and set RotateKubeletClientCertificate to true.

   7.15 Edit the Openshift node config file /etc/origin/node/node-config.yaml and set RotateKubeletServerCertificate to true.

   8.2
   8.3 Run the below command on each worker node.
   chmod 644 $nodesvc

   8.4 audit test did not run: failed to run: stat -c %U:%G $nodesvc, command: [stat -c %U:%G $nodesvc], error: exit status 1
   ```

See [Configuration policy samples](../governance/policy_samples.md) to view policy samples that can be applied to your CIS policies.

For more information about other policy controllers, see [Policy controllers](../governance/policy_controllers.md).

<!--do we want to point users to the sample of CIS rules; cis_policy_rules-->