# Glossary of terms 

Red Hat Advanced Cluster Management for Kubernetes consists of several multicluster components that are defined in the following sections. Additionally, some common Kubernetes terms are used within the product. Terms are listed alphabetically.

## Relevant standardized glossaries

- [Kubernetes glossary](https://kubernetes.io/docs/reference/glossary/?fundamental=true)


## Red Hat Advanced Cluster Management for Kubernetes terms

- Application lifecycle: The processes that are used to manage application resources on your managed clusters. A multicluster application uses a Kubernetes specification, but with additional automation of the deployment and lifecycle management of resources to individual clusters.

- Channel: A custom resource definition that points to repositories where Kubernetes resources are stored, such as a GitHub repository, Helm chart repository, object store, or hub cluster namespace. Channels support multiple subscriptions from multiple targets.

- Cluster lifecycle: Defines the process of creating, importing, and managing clusters across public and private clouds. 

- Console: The graphical user interface for Red Hat Advanced Cluster Management.

- Governance and risk: The  Red Hat Advanced Cluster Management processes used to manage security and compliance.

- Hub cluster:  The central controller that runs in a Red Hat Advanced Cluster Management for Kubernetes cluster. From the hub cluster, you can access the console and components found on that console, as well as APIs.

- Managed cluster: Created and imported clusters with the `multicluster-endpoint`, which is the agent that initiates a connection to the Red Hat Advanced Cluster Management for Kubernetes hub cluster. The managed cluster receives and applies requests, then returns the results. 

- Multicluster-endpoint: The agent on the managed cluster that initiates a connection to the Red Hat Advanced Cluster Management for Kubernetes hub cluster.  

- Placement policy: A policy that defines where the application components should be deployed and how many replicas there should be.

- Placement rule: A rule that defines the target clusters where subscriptions are delivered. For instance, verify the cluster name, resource annotations, or resource label(s).

- Subscriptions: Identify Kubernetes resources within channels (resource repositories). The subscription places the Kubernetes resources in the same namespace, where it is created on the subscribed target clusters. 

