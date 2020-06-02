# Application management lifecycle

The application model centers around the notion of subscribing to one or more Kubernetes resource repositories (channel resource) containing resources to be deployed on managed clusters. The subscription component uses a placement rule resource to define the managed clusters where the Kubernetes resource will be deployed to.
The last piece in the application model is the application resource referencing one or more repositories subscriptions. The only purpose for the application is to group deployed Kubernetes resources and thus provide data aggregation that is easy to understand and manage. <!-- come back and edit -->
Learn more about the Application lifecycle from the following topics.

  * [Application model and definitions](app_model.md)
  * [Applications console](app_console.md)
  * [Deploying applications](deployment_app.md)
