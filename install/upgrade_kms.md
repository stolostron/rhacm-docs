---

copyright:
  years: 2016, 2019
lastupdated: "2019-09-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Upgrading Key Management Service Helm charts

Complete the following steps to upgrade Hardware Security Module (HSM):
{: shortdesc}

1. Log in to the boot node as a user with root permissions. The boot node is usually your master node.

2. Export the previously generated Secret `hsm-secret` into `hsm-Secret.yaml`.
   ```
   kubectl get secret hsm-secret --export -o yaml > hsm-Secret.yaml
   ```
   {: codeblock}

3. Follow the steps in [Configuring Key Management Service](../mcm_user_management/kms_server.md) to install the Key Management HSM package and to create the `overrides_hsm.yaml` file.

4. Run the following command to upgrade the `key-management-hsm` Helm chart:
   ```
   helm upgrade <HELM_RELEASE_NAME> mgmt-charts/key-management-hsm --force -f overrides_hsm.yaml --namespace kube-system --version <VERSION> --tls
   ```
   {: codeblock}

5. Import the `hsm-Secret.yaml` file into the cluster.   
   ```
   kubectl apply -f hsm-Secret.yaml -n kube-system
   ```
   {: codeblock}

6. Verify the creation of your secret.
   ```
   kubectl get secret hsm-secret -n kube-system -o yaml
   ```
   {: codeblock}

**Note:** SoftHSM does not support Helm upgrade. You must remove the previous Helm release and install the Helm release that you want.
