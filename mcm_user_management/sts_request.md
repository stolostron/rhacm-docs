---

copyright:
  years: 2019
lastupdated: "2019-09-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Enable the key management service to use secure token service

**{{site.data.keyword.tech_prev}}**

Enable the key management service (KMS) that is configured in your cluster to use the secure token service (STS).
{:shortdesc}

## Prerequisites

- You must configure KMS in your {{site.data.keyword.product_tm}} cluster. For more information, see [Configuring Key Management Service](kms_server.md).
- You must have the source resource ID from {{site.data.keyword.Bluemix}}. For example, `crn:v1:staging:public:sts:us-south:a/1234c123456789::`.
- You must onboard the KMS service. For more information, see [Onboarding a service to use KMS](kms_server.md#onboard_serv). After you onboard the KMS service, you get the target KMS instance ID. For example, `crn:v1:icp:private:kms:mycluster:n/kube-system:0d705d95- e216-4ce4-9c81-38eeef4eee3b::` You also get the API key value. Use the following procedure to add or update the API Key in the secure token service configuration:
  1. Encode the API key value to base64.
    ```
    echo -n <API-key>|base64
    ```
    {: codeblock}

  2. Update the API key value in the `sts-apikey` secret with the encoded API key value. You need `kubectl` to run the command. For more information about installing `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).  
    ```
    kubectl edit secret sts-apikey -n istio-system
    ```
    {: codeblock}

  3. Restart the `sts` pod.
    ```
    kubectl delete pod <tokenadapter-<ID>> -n istio-system
    ```
    {:codeblock}

## Enable KMS to use STS

Before you begin, install the following CLIs:

  - Install `kubectl`. For more information, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).
  - Install `istioctl`. For more information, see [Installing the Istio CLI (istioctl)](../../istio-cli/install_istioctl.md).

1. Save the current KMS deployment to a file.
  ```
  kubectl get deployment key-management-api -n kube-system -o yaml > kms-api-deployment.yaml
  ```
  {: codeblock}

2. Inject the Istio proxy sidecar to the KMS API service. You get a new KMS deployment YAML file.
  ```
  istioctl kube-inject -f kms-api-deployment.yaml > kms-api-deployment-injected.yaml
  ```
  {: codeblock}

3. Delete the existing KMS deployment.
  ```
  kubectl delete deployment key-management-api -n kube-system
  ```
  {: codeblock}

4. Redeploy the KMS service by using the new deployment file.
  ```
  kubectl apply -f  kms-api-deployment-injected.yaml -n kube-system
  ```
  {: codeblock}

5. Create a certificate resource YAML file. You must use `istio-ingressgateway-certs` as the name of the secret. See the following sample file:
  ```
   apiVersion: certmanager.k8s.io/v1alpha1
   kind: Certificate
   metadata:
    name: istio-ingressgateway-certs
    namespace: istio-system
   spec:
    secretName: istio-ingressgateway-certs
    issuerRef:
      name: icp-ca-issuer
      kind: ClusterIssuer
    commonName: “istio-service”
    dnsNames:
    - 9.42.136.50
   ```
   {: codeblock}

6. Generate the certificate and secret by running the following command:
  ```
  kubectl apply -f certificate.yaml
  ```
  {: codeblock}

7. Create a `gateway.yaml` file with the Istio ingress gateway parameters. See the following sample configuration:
  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: Gateway
  metadata:
    name: kmsgateway
    namespace: kube-system
  spec:
    selector:
      istio: ingressgateway
    servers:
    - port:
        name: https
        number: 443
        protocol: HTTPS
      tls:
        mode: SIMPLE
        serverCertificate: /etc/istio/ingressgateway-certs/tls.crt
        privateKey: /etc/istio/ingressgateway-certs/tls.key
      hosts:
      - "*"
  ```
  {: codeblock}

8. Deploy the Istio ingress gateway.
  ```
  kubectl apply -f gateway.yaml
  ```
  {: codeblock}

9. Create a `virtualservice.yaml` file that defines the rules to route the request to the correct service. See the following sample configuration:
  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    name: kmsvservice
    namespace: kube-system
  spec:
    hosts:
    - "*"
    gateways:
    - kmsgateway
    http:
    - match:
      - uri:
          prefix: /kms/api
      rewrite:
          uri: /api
      route:
      - destination:
          host: kms-api
          port:
            number: 28674
  ```
  {: codeblock}

10. Deploy the virtual service.
  ```
  kubectl apply -f virtualservice.yaml
  ```
  {: codeblock}

11. Create a `destinationrule.yaml` file with the destination rule. See the following sample configuration:
  ```
    apiVersion: "networking.istio.io/v1alpha3"
    kind: "DestinationRule"
    metadata:
      namespace: "kube-system"
      name: "kms-api-tls"
    spec:
      host: kms-api
      trafficPolicy:
        tls:
          mode: SIMPLE
  ```
  {: codeblock}

12. Deploy the destination rule.
  ```
  kubectl apply -f destinationrule.yaml
  ```
  {: codeblock}

13. Create a `sample-policy.yaml` file with the policies for identity mapping. See the following sample configuration:
  ```
    apiVersion: policy.ibm.com/v1alpha1
    kind: IdentityMappingPolicy
    metadata:
      name: stspolicy
      namespace: istio-system
    spec:
      identityMapping:
        sourceIdentity: 'crn:v1:staging:public:sts:us-south:a/1234:123456789::'
        targetCredentials:
          apiKeyRef:
            propertyName: apikey
            secretName: sts-apikey
      mappingType: inbound
      sourceAuthority: ibm-cloud-iam
      targetResources:
      - 'crn:v1:icp:private:kms:mycluster:n/kube-system:0d705d95-e216-4ce4-9c81-38eeef4eee3b::'
  ```
  {: codeblock}

  Following are the parameter descriptions:  
  - `sourceIdentity` is the Cloud Resource Name (CRN) that represents the identity of the source resource on {{site.data.keyword.Bluemix}}.
  - `apiKeyRef` represents the credentials on {{site.data.keyword.product}} for identity mapping. The secret `sts-apikey` with `apikey` data is generated when the Helm chart is deployed. Do not change these values.
  - `mappingType` is the flow of the request. Only inbound request is supported. Do not change this value.
  - `sourceAuthority` is the source of request. Only `ibm-cloud-iam` is supported in the current release. Do not change this value.
  - `targetResources` is the list of CRNs that represents the identity of the target resource on {{site.data.keyword.product}}. Only the CRN of Key Management Service is supported in the current release.

14. Apply the STS policy.
  ```
  kubectl apply -f sample-policy.yaml
  ```
  {: codeblock}
