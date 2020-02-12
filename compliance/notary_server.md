---

copyright:
  years: 2019
lastupdated: "2019-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Using a notary service for image signing

Notary service is a tool that is used to sign a trusted collection of content such as metadata. You can sign trusted metadata, push an image into the repository, and verify the integrity of the image by using this signed metadata.
{: shortdesc}

Notary service helps to ensure the integrity and freshness of content. Notary service is a combination of notary server and signer. The notary server stores and updates the signed The Update Framework (TUF) metadata. The notary signer stores private signing keys and performs signing operations for a server.

Learn more about the notary service in the following topics:

- [GitHub-notary ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/theupdateframework/notary){: new_window}
- [Notary-architecture ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/theupdateframework/notary/blob/master/docs/service_architecture.md){: new_window}
- [DockerDoc-Notary ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.docker.com/notary/getting_started/){: new_window}
- [TUF-metadata ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/theupdateframework/tuf/blob/1bed3e09a478c2c918ffbff10b9118f6e52ee129/docs/tuf-spec.txt#L348){: new_window}

## Installation

Complete the following steps to deploy the notary server and signer on {{site.data.keyword.product}}. After successful deployment, the notary server is available to the `docker client` on `https://<ClusterIP>:<ClusterPort>/notary`.

1. Deploy the notary Helm chart in one of the following ways:
   - Run the following Helm command to install the chart.
     ```
     helm install mgmt-charts/notary --name notary --namespace kube-system --tls
     ```
     {: codeblock}

   - Use the {{site.data.keyword.product}} {{site.data.keyword.gui}} to install a chart from the Catalog.

   The notary service is successfully deployed when the notary server and signer pods are available.      

2. You are now ready to sign your images and push them to your registry. If you are working with a local registry, make sure that it is available and that you are authenticated with the registry.

## Configuring the Docker client and signing images

Use the Docker client to sign and push your images. You can push images to the cluster registry or to an external private registry.

### Configuring Docker client to authorize and trust the notary server
{: #trust_not}

Complete the following steps to add the `ca.crt` for the notary server. The following steps are valid for a {{site.data.keyword.linux}} system.

1. Use 'ssh' to access the master node of a cluster on a {{site.data.keyword.linux_notm}} system.

2. Install the {{site.data.keyword.product}} CLI. See [Installing the {{site.data.keyword.product}} CLI ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.1/manage_cluster/install_cli.html){: new_window} to get started.

3. Get the `ca.crt` for the notary server.
   ```
   kubectl -n kube-system get secret notary-server-cert -o yaml | grep ca.crt | awk '{print $2}' | base64 -d > notary-server-ca.crt
   ```
   {: codeblock}

4. Create new directory, `/usr/local/share/ca-certificates`.
   ```
   sudo mkdir /usr/local/share/ca-certificates/notary
   ```
   {: codeblock}

5. Copy or move the notary server `ca.crt` to the new directory.
   ```
   sudo cp notary-server-ca.crt /usr/local/share/ca-certificates/notary
   ```
   {: codeblock}

6. Assign appropriate permissions to the directory and certificates.

7. Update the certificates.
   ```
   sudo update-ca-certificates
   ```
   {: codeblock}

**Note:** Mac users can add the notary server `ca.crt` in the keychain.

### Pushing the images

1. Select one of the following methods.
   - Use Docker to pull a trusted image.
     ```
     docker pull <image>
     ```
     {: codeblock}

   - Build your own image.
     ```
     docker build -t <registryURI>:<registry_port>/<image_name>:<image_tag>
     ```
     {: codeblock}

2. Prepare Docker image and Docker client for signing the image. Retag the image to your registry URI, if needed.
     ```
     docker tag <image> <registryURI>:<registry_port>/<image_name>:<image_tag>
     ```
     {: codeblock}

3. Set your Docker trust to be your running notary server.
   ```
   export DOCKER_CONTENT_TRUST_SERVER=https://<ClusterIP>:<cluster_port>/notary
   ```
   {: codeblock}

4. Enable content trust. Set the parameter value to `1` to enable and `0` to disable.
   ```
   export DOCKER_CONTENT_TRUST=1
   ```
   {: codeblock}

5. Docker uses a push command to sign the image. Now you can push the image to your registry. You are prompted to create a password for the root key and for the repository key.

   **Note:** The root key is important. Keep a backup of the root key in a secure location. If you lose the root key, there is no way to recover it or the data that depends on that root key. Because notary runs on your private cloud, Docker support is not able to help in this situation.

   For more information about keys, including their structure and use, see [Content trust in Docker ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.docker.com/engine/security/trust/content_trust/){: new_window} and [Manage keys for content trust ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.docker.com/engine/security/trust/trust_key_mng/){: new_window}.

- You must generate a signer private-public key pair. The public key is created in the current directory. The private key is in the  `~/.docker/trust/private` directory. This public key is pushed in notary and verifies while pods are being deployed.
     ```
     docker trust key generate <name-of-signer>
     ```
     {: codeblock}

     **Note:** You can specify any name for the signer. You need this name when you create secrets for image signing.

- Add the signer to the repository by using the user's public key.
     ```
     docker trust signer add <name-of-signer> <registryURI>:<registry_port>/<image_name> --key <name-of-signer>.pub
     ```
     {: codeblock}

  - Sign the image.

   **Tip:** The value of `image_tag` is for the image that is being signed.

   ```
   docker push <registryURI>:<registry_port>/<image_name>:<image_tag>
   ```
   {: codeblock}

6. Docker content trust is now enabled. It can pull only the trusted and signed images. Pull the signed image to test it.
   ```
   docker pull <registryURI>:<registry_port>/<image_name>:<image_tag>
   ```
   {: codeblock}

### Notary CLI client
Use notary CLI clients for key rotation and listing signed images. Learn more about the notary CLI clients in the following topics:
 - [Configure your notary client ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/docker/docker.github.io/blob/master/datacenter/dtr/2.4/guides/user/access-dtr/configure-your-notary-client.md){: new_window} and [Configure the client ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/theupdateframework/notary/blob/master/docs/getting_started.md#configure-the-client){: new_window}

- [Notary command reference ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://github.com/theupdateframework/notary/blob/master/docs/getting_started.md#configure-the-client){: new_window}

## Example - Using a notary service for image signing

The following components are used in this example:

- Docker image named `busybox`
- {{site.data.keyword.product}} registry on port 8500
- A notary that runs in the cluster.

Pull the `busybox` image:
```
docker pull busybox
```
{: codeblock}

Log in to the registry:
```
docker login https://<mycluster.mcm>:8500
```
{: codeblock}

Tag the image:
```
docker tag busybox <mycluster.mcm>:8500/mybusybox:latest
```
{: codeblock}

Export your Docker trust variables:
```
export DOCKER_CONTENT_TRUST_SERVER=https://<ClusterIP>:<ClusterPort>/notary
export DOCKER_CONTENT_TRUST=1
```
{: codeblock}

Push and sign the image:
```
docker push <mycluster.mcm>:8500/mybusybox:latest
```
{: codeblock}

```
The push refers to repository [mycluster.mcm:8500/mybusybox]
6c0ea40aef9d: Mounted from mybb
latest: digest: sha256:dd97a3fe6d721c5cf03abac0f50e2848dc583f7c4e41bf39102ceb42edfd1808 size: 527
Signing and pushing trust metadata
Enter passphrase for root key with ID eac7770:
Enter passphrase for new repository key with ID 9b00892:
Repeat passphrase for new repository key with ID 9b00892:
Finished initializing "mycluster.mcm:8500/mybusybox"
Successfully signed mycluster.mcm:8500/mybusybox:latest
```
{: codeblock}

Pull the signed image:
```
docker pull <mycluster.mcm>:8500/mybusybox:latest
```
{: codeblock}

```
Pull (1 of 1): mycluster.mcm:8500/mybusybox:latest@sha256:dd97a3fe6d721c5cf03abac0f50e2848dc583f7c4e41bf39102ceb42edfd1808
sha256:dd97a3fe6d721c5cf03abac0f50e2848dc583f7c4e41bf39102ceb42edfd1808: Pulling from mybusybox
Digest: sha256:dd97a3fe6d721c5cf03abac0f50e2848dc583f7c4e41bf39102ceb42edfd1808
Status: Image is up to date for mycluster.mcm:8500/mybusybox@sha256:dd97a3fe6d721c5cf03abac0f50e2848dc583f7c4e41bf39102ceb42edfd1808
Tagging mycluster.mcm:8500/mybusybox@sha256:dd97a3fe6d721c5cf03abac0f50e2848dc583f7c4e41bf39102ceb42edfd1808 as mycluster.mcm:8500/mybusybox:latest
mycluster.mcm:8500/mybusybox:latest
```
{: codeblock}

## Troubleshooting

Error message | Cause | Solution
--------------|--------|---------
Error: error contacting notary server: x509: certificate signed by unknown authority | Docker is not trusting notary server | Follow steps in [Configuring Docker client to authorize and trust the notary server](#trust_not)
