# Install on Restricted Networks

ACM can be installed into OCP clusters that reside in a restricted networks.

If ACM is available in the OLM Operator Catalogs, you can follow these steps:

1. Enable disconnected OLM
2. Install ACM (reference the same steps in `install_connected.md`)

If ACM is not yet in the OLM Operator Catalog, then you need to follow these steps:

1. Enable disconnected OLM
2. Manually mirror ACM
3. Install ACM (reference the same steps in `install_connected.md`)

## Enable disconnected OLM

Follow the steps in the Openshift documentatoon for configuring disconnected OLM for the Red Hat Operator catalog and the Community Operator catalog here:

https://docs.openshift.com/container-platform/4.4/operators/olm-restricted-networks.html

If you do not already have a mirror registry, you can follow the instructions here:

https://docs.openshift.com/container-platform/4.4/installing/install_config/installing-restricted-networks-preparations.html#installing-restricted-networks-preparations

## Manually Mirror ACM

This section describes the steps that can be followed if installing ACM in a disconnected environment before ACM is added to the OLM Catalog.

Steps:

1. Select the snapshot version of ACM you want to install.
2. Extract the image manifest.json from the multiclusterhub operator image
3. Parse the manifest.json and mirror the images into your mirror registry (see Sample Script below)
4. Create the ImageContentSourcePolicy that maps the quay.io image path to your mirror registry

### 1. Select the SNAPSHOT version of ACM

You can find a list of available tags in the [Quay.io multiclusterhub-operator-index](https://quay.io/open-cluster-management/multiclusterhub-operator-index)

Then pull the `multiclusterhub-operator` image with the desired SNAPSHOT tag.

Examples:

```bash
podman pull quay.io/open-cluster-management/multiclusterhub-operator:1.0.0-SNAPSHOT-2020-05-07-19-51-26
```

### 2. Extract the manifest.json from the ACM Operator

```bash
mkdir tmp.work && cd tmp.work
CONTAINERID=$(podman create quay.io/open-cluster-management/multiclusterhub-operator:1.0.0-SNAPSHOT-2020-05-07-19-51-26 ls)
podman export ${CONTAINERID} | tar xf -
cp ./image-manifests/*.json ..
cd .. && rm -rf tmp.work
```

### Parse the manifest.json and mirror the images

Reference OCP docs on using `skopeo`
Reference the python script to do this:

### Create the ImageContentSourcePolicy
