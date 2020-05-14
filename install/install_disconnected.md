# Install on Restricted Networks for Technical Preview

ACM can be installed into OCP clusters that reside in a restricted networks.

These are the manual steps to follow to copy ACM images into the mirror registry as preperation for installing ACM in a Restricted Network.

1. Enable disconnected OLM Redhat Operators and Community Operators
2. Manually mirror ACM images and setup ImageContentSourcePolicy
3. Install ACM (reference the same steps in `install_connected.md`)

## 1. Enable disconnected OLM

Follow the steps in the Openshift documentatoon for configuring disconnected OLM for the Red Hat Operator catalog and the Community Operator catalog here:

https://docs.openshift.com/container-platform/4.4/operators/olm-restricted-networks.html

If you do not already have a mirror registry, you can follow the instructions here:

https://docs.openshift.com/container-platform/4.4/installing/install_config/installing-restricted-networks-preparations.html#installing-restricted-networks-preparations

## 2. Manually Mirror ACM Images

This section describes the steps that can be followed to install ACM in a disconnected environment before ACM is added to the OLM Catalog.

### Dependencies

- Ensure you have `skopeo` tool on your system that will perform the image mirror
- Ensure you have a mirror registry. See these steps for guidance.

### Steps

1. Clone this github repo: https://github.com/cdoan1/tech-preview.git

   ```bash
   git clone https://github.com/cdoan1/tech-preview.git
   ```

2. Prepare a pull secret that allows access to your mirror registry and the quay.io/acm-d registry. The your pull secret will look something like this, given an example where the mirror registry is `registry.example.com`:

   ```bash
   cat acmd-pull-secret.json
   {
   "auths": {
       "registry.example.com:5000": {
        "auth": "REDACTED"
       },
       "quay.io": {
        "auth": "REDACTED"
       },
       ...
   }
   ```

3. Run the following python script to mirror the images into your registry.

   ```bash
   ./mirror-image.py -p acmd-pull-secret.json -m registry.example.com:5000
   ```

4. Apply the generated ICSP manifest.

   > WARNING: Applying the ImageContentSourcePolicy will update and reboot all the nodes in your cluster.

   ```bash
   oc apply -f 99-acm-images-icsp.yaml
   ```
