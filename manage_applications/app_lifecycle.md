# Application management lifecycle

Red Hat Advanced Cluster Management for Kubernetes provides enhanced application management capabilities through a Kubernetes resource based application model. The application model centers around managed clusters subscribing to repositories. The application model groups all subscriptions related to an application and displays a topology that is easy to understand and use. The topology view can scale with the number of managed clusters, providing insight and management, without context switching between clusters.

The Application model consists of the following Kubernetes custom resources:

   - Channel: Resource representing a source repository such as a Github repository, Helm chart repository, Objectstore with YAML, or namespace containing Kubernetes resource templates(deployables)
   - Subscription: Subscribes a repository and delivers kubernetes resources.
   - Placement Rule: Referenced by subscriptions, and supplies the target managed clusters that must subscribe to a channel.
   - Application: Used to select all of the subscriptions that are part of your application(a visual aid)

Learn more about the Application lifecycle from the following topics.

  * [Application model and definitions](app_model.md)
  * [Applications console](app_console.md)