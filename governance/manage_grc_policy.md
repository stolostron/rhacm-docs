# Managing a security policy

Manage your cluster policy to remediate and edit your security policy. 

- [Updating your security policy from the cosole](#updating-your-security-policy-from-the-cosole)
- [Viewing cluster policy violations from the console](#viewing-cluster-violations-from-the-console)
- [Viewing image vulnerability violations from the console](#viewing-image-vulnerability-violations-from-the-console)
- [Disabling your security policy from the console](#disabling-your-security-policy-from-the-console)
- [Deleting an Red Hat Advanced Cluster Management for Kubernetes policy](#deleting-an-red-hat-advanced-cluster-management-for-kubernetes-policy)

## Updating your security policy from the console

1. From the navigation menu, click **Govern risk**.
2. Click the _Policies_ tab.
3. Select a policy and click the **Options** icon. 
4. Click **Edit**. The YAML file appears in the _Edit policy_ modal.
5. Click **Submit**.

Your policy is updated. 

## Viewing cluster policy violations from the console

1. From the navigation menu, click **Govern risk**.
2. From the _Policies_ tab, select a policy to view more details.
3. Click the _Violations_ tab to view the table list of violations.

## Viewing image vulnerability violations from the console

1. From the navigation menu, click **Govern risk**. 
2. Select the **`policy-imagemanifestvulnpolicy`** policy > **_Violations_ tab** to view the cluster location of the violation.

   Your image vulnerability violation might resemble the following:

   ```
   imagemanifestvulns exist and should be deleted: [sha256.7ac7819e1523911399b798309025935a9968b277d86d50e5255465d6592c0266] in namespace default; [sha256.4109631e69d1d562f014dd49d5166f1c18b4093f4f311275236b94b21c0041c0] in namespace calamari; [sha256.573e9e0a1198da4e29eb9a8d7757f7afb7ad085b0771bc6aa03ef96dedc5b743, sha256.a56d40244a544693ae18178a0be8af76602b89abe146a43613eaeac84a27494e, sha256.b25126b194016e84c04a64a0ad5094a90555d70b4761d38525e4aed21d372820] in namespace multicluster-endpoint; [sha256.64320fbf95d968fc6b9863581a92d373bc75f563a13ae1c727af37450579f61a] in namespace openshift-cluster-version
   ```

3. Navigate to your OpenShift Container Platform console by selecting the _Cluster_ link.

4. From the navigation menu on the OpenShift Container Platform console, click **Administratio** > **Custom Resource Definitions**.

5. Select **`imagemanifestvulns`** > **_Instances_ tab** to view all of the `imagemanifestvulns` instances. 

6. Select an entry to view more details. 

## Disabling your security policy from the console

After you create a security policy, it is enabled by default. Complete the following steps to disbale your policy:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.

2. From the navigation menu, click **Govern risk**.

3. View a table list of your policies.

4. Disable your policy by clicking the **Options** icon > **Disable**. The _Disable Policy_ dialog box appears.

5. Click **Disable policy**. 

Your policy is disbaled. 

## Deleting an Red Hat Advanced Cluster Management for Kubernetes policy

Delete your Red Hat Advanced Cluster Management for Kubernetes security policy.

### Deleting an Red Hat Advanced Cluster Management for Kubernetes policy from the command line (CLI)

Complete the following steps to delete your policy:

1. Delete a policy by running the following command:

    ```
    kubectl delete policy <policy-name> -n <mcm namespace>  
    ```

    After your policy is deleted, it is removed from your target cluster or clusters.

2. Verify that your policy is removed by running the following command:

    ```
    kubectl get policy <policy-name> -n <mcm namespace>
    ```

### Deleting an Red Hat Advanced Cluster Management for Kubernetes policy from the console

Complete the following steps to delete your policy:

1. From the navigation menu, click **Govern risk**.
2. Click the _Policies_ tab. 
3. Click the **Options** icon for the policy you want to delete in the policy violation table.
4. Click **Remove**.
5. From the _Remove policy_ dialog box, click **Remove policy**. 

Your policy is deleted.

See [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../governance/compliance_intro.md) for more policy topics.




