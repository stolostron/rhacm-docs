# Summary
 * [About](about/intro.md) **(Brandi and Chris)**
 * [Release notes](about/release_notes.md) 
   * [Architecture](about/architecture.md)
   * [What's new](about/whats_new.md)
   * [Known issues and limitations](about/known_issues.md)
   * [Considerations for GDPR readiness](about/gdpr_readiness.md)
   * [Considerations for FIPS readiness](about/fips_compliance.md)
 * [Installation and upgrade](install/installation.md) **(Chris--decides what we need from this section/create issues if needed)**
   * [Installation file part numbers](install/part_numbers.md)
   * [Requirements](install/requirements.md)
   * [Hardware requirements and recommendations](install/hardware_reqs.md)
   * [Supported operating systems and platforms](install/supported_os.md)
   * [Supported browsers](install/supported_browsers.md)
   * [Supported cloud providers](install/supported_clouds.md)
   * [Sizing your cluster](install/plan_capacity.md)
   * [Preparing to secure your cluster](install/plan_security.md)
   * [Endpoints](install/cluster_endpoints.md)
   * [Cluster configuration ConfigMap](install/configmap_cluster.md)
   * [Supported environments](install/environments_overview.md)
   * [Configuration options](install/config_install.md)
 * [IBM Multicloud Manager Governance and risk](compliance/compliance_intro.md) **(Mikela--decides how best to structre the directory)**
   * [IBM Multicloud Manager policy overview](compliance/policy_overview.md)
   * [IBM Multicloud Manager policy controllers](compliance/policy_controllers.md)
     * [Configuration policy controller](manage_policies/config_policy_ctrl.md)
     * [Certificate policy controller](manage_policies/cert_policy_ctrl.md)
     * [Audit logging policy controller](compliance/audit_policy_ctrl.md) <!--would like to move this controller into the manage_policies folder later so that all controllers are in one folder-->
     * [Secret encryption policy controller](manage_policies/encrypt_policy.md)
     * [IAM policy controller](compliance/iam_policy_ctrl.md) <!--TBD; if it is ported I want to move the folder into the manage_policis folder-->
     * [CIS policy controller](compliance/cis_policy.md)<!--also want to move this controller into the manage_policies folder-->
     * [Network policy controller](manage_policies/nw_policy_ctrl.md)<!--new controller; made up the "potential" file name-->
   * [IBM Multicloud Manager policy example](compliance/policy_example.md)
   * [IBM Multicloud Management policy samples](manage_policies/policy_samples.md)
   * [Creating an IBM Multicloud Manager policy](compliance/create_policy.md)
   * [Managing a security policy](manage_cluster/manage_grc_policy.md)
   * [Deleting an IBM Multicloud Manager policy](compliance/delete_policy.md)<!--not too much info here; I would like to move the content into the manage_cluster/manage_grc_policy.md-->
   * [Using a notary service for image signing](compliance/notary_server.md)
   * [Image signing support for image policies](compliance/image_policy_signing.md)
 * [Service discovery](working_serv_intro.md) **(???? what devs cover this? Does this change?)**
   * [IBM Multicloud Manager service discovery overview](serv_overview.md)
 * [Cluster management](manage_cluster/intro.md)**(Chris, review and open issues if scale, create, import changes)**
   * [Creating a cluster](manage_cluster/create.md)
     * [Creating an IBM Kubernetes Service cluster](manage_cluster/create_iks..md)
     * [Creating a Google Kubernetes Engine cluster](manage_cluster/create_gke.md)
     * [Creating an Azure Kubernetes Service cluster](manage_cluster/create_aks.md)
     * [Creating an Amazon Elastic Kubernetes Service cluster](manage_cluster/create_eks.md)
     * [Creating an OpenShift on Amazon Web Services cluster](manage_cluster/create_ocp_aws.md)
   * [Scaling your clusters](manage_cluster/scale_mcm.md)
   * [Importing a target managed cluster](manage_cluster/import.md)
     * [Importing a cluster with the IBM Multicloud Manager management console](manage_cluster/import_gui.md)
     * [Importing a cluster with the CLI](manage_cluster/import_cli.md)
     * [Importing a managed cluster in an air gapped environment](manage_cluster/offline_endpoint.md)
     * [Modifying the multicluster endpoint settings for your cluster](manage_cluster/modify_mc_end.md)
   * [Upgrading multicluster endpoint](manage_cluster/upgrade_mc_endpoint.md)
 * [Application management](manage_applications/overview.md)
   * [Application lifecycle](manage_applications/app_lifecycle.md)
   * [Application resources](manage_applications/app_resources.md)
     * [Managing application resources](manage_applications/managing_apps.md)
       * [Managing deployables](manage_applications/managing_deployables.md)
       * [Managing channels](manage_applications/managing_channels.md)
       * [Managing subscriptions](manage_applications/managing_subscriptions.md)
       * [Managing placement rules](manage_applications/managing_placement_rules.md)
       * [Managing secrets](manage_applications/managing_secrets.md)
       * [Deploying an application resource](manage_applications/deployment_app.md)
       * [Deploying an application resource with a rolling update](manage_applications/deployment_rollout.md)
       * [Managing applications with the console](manage_applications/managing_apps_console.md)
       * [Migrating subscriptions](manage_applications/migrate_subscriptions.md)
 *  [IAM](iam_intro.md) **(????)**
 *  [Multitenancy](multitenancy.md)**(????)**
 *  [Administering](admin/intro.md)**(????)**
 *  [Services and components](components.md)**(????)**
 *  [Cloudctl](cloudctl_intro.md) (**????**)
   *  [Installing cloudctl](install_cli.md)
   *  [Multicluster commands (mc)](cli_mc_commands.md)
 *  [User management: Role based access control](user_management/assign_role.md)(**???**)
    * [Teams](user_management/teams.md)
     * [Create teams](user_management/create_team.md)
     * [Add users to a team](user_management/add_user.md)
     * [Add groups to a team](user_management/add_group.md)
    * [Remove teams](user_management/remove_team.md)
    * [Namespaces](user_management/projects.md)     
 * [APIs](apis/cfc_api.md) (**all ID squad, no swagger**)
    * [{{site.data.keyword.mcm_notm}} APIs](apis/mcm_apis.md)
      * [Applications](apis/applications.json)<!--need to change to .md file bc swagger is not supported for RH doc-->
      * [Channels](apis/channels.json)<!--same issue-->
      * [Deployables](apis/deployables.json)<!--not sure if this should brought over; same issue-->
      * [Placement rules](apis/placementRules.json)<!--same-->
      * [Policies](apis/policies.json)<!--same-->
      * [Subscriptions](apis/subscriptions.json)<!--same-->
      * [System healthcheck service](apis/system_hc_api.json)<!--need to verify that system healthchek is coming to RACM-->
 * [Support](troubleshoot/support.md) (**Mikela leading**)
    * [Support types](troubleshoot/support_types.md)
    * [Open source support](troubleshoot/opensource_support.md)
