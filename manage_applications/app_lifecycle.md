# Application management lifecycle

The application model is based on subscribing to one or more Kubernetes resource repositories (channel resource) that contains resources that are deployed on managed clusters. 

The subscription component uses a _placement rule_ resource to define the managed clusters where the Kubernetes resource will be deployed. The last piece in the application model is the application resource that references one or more repositories subscriptions. The only purpose for the application is to group deployed Kubernetes resources and provide data aggregation that is easy to understand and manage. 

Learn more about the Application lifecycle from the following topics.

  * [Application model and definitions](app_model.md)
  * [Applications console](app_console.md)
  * [Deploying applications](deployment_app.md)
