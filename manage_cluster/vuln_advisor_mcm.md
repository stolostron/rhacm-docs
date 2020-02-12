---

copyright:
  years: 2016, 2020
lastupdated: "2020-01-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Vulnerability Advisor

Use the advisor to get security status for container images in your {{site.data.keyword.product_tm}} private registry. The Vulnerability Advisor also runs security checks on running containers in your environment.
{:shortdesc}

For more information about the Vulnerability Advisor, see the _About Vulnerability Advisor_ section in the [{{site.data.keyword.cloud_notm}} Docs ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://console.bluemix.net/docs/services/va/va_index.html#about){: new_window}.

The Vulnerability Advisor feature is supported for multi-node clusters. You can enable the VA on {{site.data.keyword.product}}. For more information, see [Enabling the Vulnerability Advisor with {{site.data.keyword.open_s}} logging](va_openshift_mcm.md).
- [Supported operating systems](#os)
- [Supported container runtime](#runtime)
- [VA components](#components)
- [Mutation Advisor Advanced (MA++) components](#maplus)

## Supported operating systems
{: #os}

View the following table for a list of operating systems that the Vulnerability Advisor supports:

|Operating system|Version|
|---------|-------|
|Ubuntu|<ul><li>18.04</li><li>17.10</li><li>16.10</li><li>16.04</li><li>15.10</li> <li>15.04</li><li>14.04</li><li>12.04</li><li>13.10</li><li>13.04</li><li>12.10</li><li>11.10</li><li>11.04</li><li>10.10</li><li>10.04</li></ul>|
|Alpine|2.7-3.8|
|{{site.data.keyword.rhel}}|all base images|
|Centos|all base images|
|Debian|<ul><li>7</li><li>8</li><li>9</li></ul>|
{: caption="Table 1. Operating systems that Vulnerability Advisor supports." caption-side="top"}

## Supported container runtime
{: #runtime}

View the following table for a list of supported container runtimes that the Vulnerability Advisor supports:

| Component | CPU  | Memory        |
|------------------|--------------------|--------------|
|`docker` | 210 m | 660 MB|
|`cri-o` | 70 m | 220 MB|
{: caption="Table 2. Supported container runtime for VA" caption-side="top"}

## Vulnerability Advisor components
{: #components}

View the following table for a description of components for Vulnerability Advisor (VA).

| Component                | Version  | Location           | Role                                            |
|--------------------------|----------|--------------------|-------------------------------------------------|
| Kafka                    | 0.10.0.4 | VA node | Data pipeline component that is used for data ingestion and curation.                     |
| VA-Minio                 | RELEASE.2019-04-09T01-22-30Z.1 | VA node | Objective data store component that is used for indexing and querying Vulnerability Advisor data.                           |
| VA-minioCleaner          | RELEASE.2019-04-03T17-59-57Z.1 | VA node | Used to manage Vulnerability Advisor data size and prune old data. The VA-minioCleaner curator is deployed as a CronJob.                           |
| Security Analytics Service (SAS) components <ul><li>SAS API server</li></ul>| 3.2.0| VA node |  Vulnerability Advisor frontend service components. SAS components provide RESTful APIs for the Vulnerability Advisor crawlers and the Vulnerability Advisor dashboard. <p>The crawlers output scanned container and image information, which are known as frames, into the Vulnerability Advisor data pipeline by using the SAS APIs.</p> <p>The Vulnerability Advisor dashboard, also uses SAS APIs to report Vulnerability Advisor findings. </p>                          |
| Statsd                   | 0.7.2.1    | VA node | Used by the Vulnerability Advisor service for internal system monitoring.                                              |
|VA Annotators <ul><li>MA File Annotator</li><li>Process MA Annotator</li><li>VA Compliance annotator</li><li>VA Config parser</li><li>VA Password annotator</li><li>VA Rootkit annotator</li><li>VA Vulnerability annotator</li></ul>|3.2.0|VA node|Vulnerability Advisor data pipeline components that improve the security of scanned containers and image data by using various analytics, including vulnerability analysis, compliance checking, password analysis, configuration analysis, and rootkit detection. <p>These annotators use internal and external security and compliance information to improve the security of your containers and images.</p>|
|VA Indexers <ul><li>VA COS indexer</li><li>VA Generic indexer</li></ul>| 3.2.0 | VA node |Data pipeline components that are used to index Vulnerability Advisor findings into the Vulnerability Advisor backend.|
|VA Usncrawler|3.2.0|VA node|Data pipeline component that is used to ingest and aggregate external security notices for the Vulnerability Advisor analytics components.|
|VA Crawlers|3.2.0|all nodes|Vulnerability Advisor data collectors, also known as crawlers, that inspect running containers and air gap images. <p>These crawlers extract system and application information that is used by all the Vulnerability Advisor analytics components.</p> <p>Live and metrics crawlers run on worker nodes and are deployed as DaemonSets.</p> <p>The registry crawlers runs as a separate deployment and scans images that are deployed into the {{site.data.keyword.product}} image registry.</p>|
|MA mcm controller |3.2.0|VA node|MA policy controller that is used to get MA result and perform MCM MA policies on {{site.data.keyword.product}} cluster.|
| Zookeeper                | 3.4.10    |VA node | Used by the kafka component in the Vulnerability Advisor.                        |
{: caption="Table 3. Vulnerability Advisor node components" caption-side="top"}

## Mutation Advisor Advanced (MA++) components
{: #maplus}

View the following table for a description of components for Mutation Advisor Advanced (MA++).

| Component | Version | Location | Role |
| ---- | ---- | ---- | ---- |
| MA++ Crawler            | 1.2.0 | all nodes | MA++ data collectors, (`mapp-crawlers`), capture system level events in containers by using Sysdig to detect unexpected process run and file changes in real time. This crawler is deployed as DaemonSets. |
| MA++ Inlet              | 1.2.0 | VA node   | MA++ event collection endpoint that is accessed from MA++ crawlers. |
| MA++ API                | 1.2.0 | VA node   | MA++ frontend service components. This component provide RESTful APIs for the MA++ dashboard and VA SAS API server. |
| MA++ Minio      | RELEASE.2019-04-09T01-22-30Z.3 | VA node | Objective data storage component that is used to index and query Mutation Advisor Advanced data. |
| MA++ minioCleaner      | RELEASE.2019-04-03T17-59-57Z.3 | VA node | Used to manage MA++ data size. The MA++ minioCleaner curator is deployed as a CronJob. |
| {{site.data.keyword.product}} MA++ policy controller | 3.4.0 | VA node | MA policy controller is used to create and remediate mutation policies on {{site.data.keyword.product}} clusters.  |
{: caption="Table 4. Mutation Advisor Advanced (MA++) node components" caption-side="top"}

To enable the Vulnerability Advisor post installation of your cluster, complete the steps in the following sections:

* [Enabling and disabling {{site.data.keyword.product}} management services ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.1/manage_applications/disable_service.html){: new_window}
* [Configuring Vulnerability Advisor](#configure)
  * [Configuring the Vulnerability Advisor container crawler](#configure_c_crawler)
  * [Configuring the Vulnerability Advisor image crawler](#configure_i_crawler)
  * [Configuring the Vulnerability Advisor image crawler to rescan images](#configure_rescan)
  * [Configuring the number of rows for list views of containers and images ](#configure_rows)
* [Logs and report management](#logs)
  * [Configuring data curation interval of VA Minio cleaner](#configure_data)
  * [Accessing the Mutation Advisor](#mutation_advisor)
  * [Configuring log clean-up interval of Kafka cluster](#configure_logc)
* [Deploying VA services on your nodes with a given label](#deploy_va)
* [Viewing security reports](#view_report)
* [Managing policies](#manage_policy)
  * [Timing policy](#timing)
* [Updating security notices for the Vulnerability Advisor components](#update_security)

## Configuring Vulnerability Advisor
{: #configure}

### Configuring the Vulnerability Advisor container crawler
{: #configure_c_crawler}

1. From the navigation menu, click **Configuration** > **ConfigMaps**.
2. In the search box type "live-crawler".
3. For the `vulnerability-advisor-live-crawler` ConfigMap, select **Action** > **Edit**. The `vulnerability-advisor-live-crawler` JSON file displays.
4. Modify the value of the `enabled` parameter.
   * To disable crawler, set the `enabled` parameter to `false`.
   * To enable crawler, set the `enabled` parameter to `true`.
5. (Optional) You can also configure the time interval for scanning containers on the host. To configure the time interval, modify the value of the `live-crawler.crontab` parameter. The default value is `"59 22 * * *"`. 

6. Click **Submit**. The crawler container restarts automatically and is deployed as DaemonSets named `vulnerability-advisor-live-crawler`.

### Configuring the Vulnerability Advisor image crawler
{: #configure_i_crawler}

1. From the navigation menu, click **Configuration** > **ConfigMaps**.
2. In the search box type "registry-crawler".
3. For the `vulnerability-advisor-registry-crawler` ConfigMap, select **Action** > **Edit**. The `vulnerability-advisor-registry-crawler` JSON file displays.
4. Modify the value of the `enabled` parameter.
   * To disable crawler, set the `enabled` parameter to `false`.
   * To enable crawler, set the `enabled` parameter to `true`.
6. Click **Submit**.

### Configuring the Vulnerability Advisor image crawler to rescan images
{: #configure_rescan}

1. From the navigation menu, click **Workloads** > **Deployments**.
2. In the search box type "registry-crawler".
3. For the `vulnerability-advisor-registry-crawler` deployment, select **Action** > **Edit**. The `vulnerability-advisor-registry-crawler` JSON file displays.
4. Modify the value of the following parameters.
   * To rescan images that were successfully scanned, set the `RESET_WHITELIST` option to `true`.
   * To rescan images that failed to scan, set the `RESET_BLACKLIST` option to `true`.
5. Click **Submit**.

### Configuring the number of rows for list views of containers and images
{: #configure_rows}

1. From the navigation menu, click **Add-ons** > **Vulnerability Advisor**.
2. Select one namespace from the table. The **Vulnerability Advisor (List Containers)** window is displayed. Each row in the table includes a report for each container. There are 50 rows that are displayed per page with a maximum of 100 rows.
3. To configure the number of rows, add the `max` parameter in the URL of the page. For example, when you add `&max=200` parameter in the URL, a maximum of 200 rows in total are displayed.
4. To increase the number of displayed rows in each page, add the `count` parameter in the URL of the page. For example, when you add the `&count=100` parameter to the URL, each page includes a maximum of 100 rows.
5. You can configure both `max` and `count` parameters. For example, when you add `&max=300&count=100` to the URL, each page displays a maximum of 100 rows, and a maximum of 300 rows (maximum 3 pages) in total.
   ```
   https://xxx.xxx.xxx.xxx:8443/va/ui/list?access_group=kube-system&max=300&count=100
   ```
   {: codeblock}

   `max` and `count` URL parameters are enabled for the following tasks:
   - Vulnerability Advisor (List Containers)
   - Vulnerability Advisor (List Images)
   - Mutation Advisor (List Containers)

## Logs and report management
{: #logs}

The Vulnerability Advisor components, Kafka log and Minio data, consume a large amount of disk space on the VA nodes. By default, Kafka retains 600 minutes (10 hours) of logs, and Minio retains 30 days of data. This data includes container reports. 

Keep the data size of your log minimal with retention policies. For more information, see [Modifying the data retention policy for logging services](security_advisor.md).

### Configuring data curation interval of VA Minio cleaner
{: #configure_data}

1. From the navigation menu, click **Configuration** > **ConfigMaps**.
2. For the `vulnerability-advisor-minio-cleaner-config` ConfigMap, select **Action** > **Edit**. The `vulnerability-advisor-minio-cleaner-config` JSON file displays.
3. Modify the value of each Minio bucket `vacos:30 vacos-hf:5 vacos-ma:30 vacos-summary:30` in the `data.clean.sh` section. The unit is days.
4. Click **Submit**.

### Accessing the Mutation Advisor (deprecated)
{: #mutation_advisor}

You can view the modification alerts of system files, configuration files, content files, or the operating system process. Mutation Advisor is integrated with the Security Advisor indexer (`sa-indexer`). Install the Security findings API to enable the `sa-indexer` to view the Mutation Advisor alerts and notifications from the SA dashboard. You can access the Mutation Advisor from the {{site.data.keyword.product}} {{site.data.keyword.gui}}. Complete the following steps to access MA:

   1. Log in to your {{site.data.keyword.product}} {{site.data.keyword.gui}}.
   2. From the navigation menu, click **Tools** > **Vulnerability Advisor** > **namespaces**. 
   3. Select the **Go to Mutation Advisor** button to view alerts.

You can also install Mutation Advisor Advanced (MA++). For more information, see [Enabling Mutation Advisor Advanced (MA++)](../manage_cluster/ma_adv_mcm.md).

#### Configuring the Mutation Advisor process crawler (deprecated)

1. From the navigation menu, click **Configuration** > **ConfigMaps**.
2. In the search box, type _ma-crawler_.
3. For the `vulnerability-advisor-process-ma-crawler` ConfigMap, select **Action** > **Edit**. The `vulnerability-advisor-process-ma-crawler` JSON file displays.
4. Modify the value of the `enabled` parameter.
  * To disable crawler, set the `enabled` parameter to `false`.
  * To enable crawler, set the `enabled` parameter to `true`.
5. (Optional) You can also configure the time interval for scanning containers on the host. To configure the time interval, modify the value of the `live-crawler.crontab` parameter. The default value is `"*/15 * * * *"`.
6. Click **Submit**. The crawler container is deployed as DaemonSets named `vulnerability-advisor-process-ma-crawler`.

#### Configuring the Mutation Advisor file crawler (deprecated)

File Mutation is also implemented by the Vulnerability Advisor container crawler. For information, see [Configuring the Vulnerability Advisor container crawler](#configure_c_crawler).
 
#### Configuring Mutation Advisor whitelists (deprecated)

Mutation Advisor supports configuring whitelists of common file and process mutations to reduce false alarms. The system generates candidate whitelists that can be either enabled or disabled in the {{site.data.keyword.gui}}.

Complete the following steps to configure the Mutation Advisor whitelists.

1. From the Mutation Advisor page, click **Manage Whitelist**.
2. Decide whether you want a whitelist for file mutation or process mutation. In the **Scope** section, select **File** or **Process** from the drop-down menu.
3. Associate containers with a whitelist in one of the following ways:
   - Select **All containers in the current namespace**.
   - Select **Only containers created using the image below** and provide the full image name as defined in the Kubernetes `.yaml spec`.
   - Select an image from the drop-down list to use an image with an existing whitelist.
4. Update the rules. In the **Rules** section, click **New rule**. In the pop-up window, enter a **Patten** name, and select an **Action** for the match rules. Click **Create**.
5. Your new rule is added to the **Rules** table.
6. Enable or disable a rule by toggling the **ON/OFF** radio buttons.
7. You can remove a rule. In the Delete column, check the box associated with the rule that you want to remove.
8. Click **Save Whitelist** to save configurations.

### Configuring log clean-up interval of Kafka cluster
{: #configure_logc}

1. Set up the `kubectl` CLI. See [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

2. Edit the `vulnerability-advisor-kafka` StatefulSet object to re-configure Kafka.
    ```
    kubectl --namespace=kube-system edit StatefulSet vulnerability-advisor-kafka
    ```
    {: codeblock}

3. Modify the value of the `KAFKA_LOG_RETENTION_MINUTES` environment variable. The default value is 600 minutes (10 hours).

4. Save the changes.

## Deploying VA services on your nodes with a given label
{: #deploy_va}

You can deploy the Vulnerability Advisor service on your nodes. Complete the following steps:

1. Deploy VA services by labeling your node role, run the following command:

   ```
   kubectl label --overwrite node $nodename node-role.kubernetes.io/va=true
   ```
   {: codeblock}
   
2. Label your node by running the following command:

   ```
   kubectl label --overwrite node $nodename  va=true
   ```
   {: codeblock}
 
3. Add your VA node into the your `<installation_directory>/cluster/config.yaml` file. Your `config.yaml` file might resemble the following content:

   ```
   vulnerability-advisor:
     nodeSelector:
       va: 'true'
     kafka:
       nodeSelector:
         va: 'true'
   ```
   {: pre}
 
   
## Viewing security reports
{: #view_report}

From the {{site.data.keyword.gui}}, you can view security reports for containers and images organized by namespace. These security reports are generated by using a default policy.

1. From the navigation menu, click **Add-ons** > **Vulnerability Advisor**.
2. Select the namespace that you want to view. The Vulnerability Advisor dashboard displays. From this dashboard, you can review the reports for containers and images in the selected namespace. The report details the following information on each container or image:
    * Name - name of the container or image
    * Owner - the namespace that the image or container belongs to.
    * Latest Scan - the timestamp when the image or container was scanned.
    * Type - specifies whether the object is a container or image
    * Organizational Policies - the security policy that is being used. This is set in the [Managing policies](#manage_policy) section.
    * Vulnerable Packages - current vulnerabilities that are identified for the container or image.
    * Container Settings -  summary of potential security and compliance issues. Recommendations for security are also presented here.

Use the VA API commands to manage security reports. For more information, see [Vulnerability Advisor API](../../apis/va_api.md).

## Managing policies
{: #manage_policy}

1. From the navigation menu, click **Add-ons** > **Vulnerability Advisor**.
2. Select the namespace that you want to view reports for. The Vulnerability Advisor dashboard displays.
2. From the horizontal navigation menu of the Vulnerability Advisor dashboard, select **Manage Policies**.
3. On the Manage policies page, select the policy changes that you want to make by toggling the **ON/OFF** radio buttons.
4. Click **Submit Policy**.

### Timing policy
{: #timing}

Create a timing policy to schedule a specific time to scan Vulnerability Advisor (VA) pods, VA images, and the Mutation Advisor (MA) process. View the following sections to update your timing policy: 

* Change the YAML file for the VA pod scan: 

   1. Update the YAML file for the VA pod scan by running the following command:

     ```
     kubectl edit cm vulnerability-advisor-live-crawler -nkube-system
     ```
     {: codeblock}

   2. Edit the `live-crawler.crontab` parameter in the VA pod YAML file. Your YAML file might resemble the following configuration map:

       ```
       apiVersion: v1
       data:
         enabled: "true"
         live-crawler.crontab: 59 22 * * *
         kind: ConfigMap
       ```
       {: pre}

* Change the YAML file for the VA image scan: 

   1. Update the YAML file for the VA image scan by running the following command:

      ```
      kubectl edit cm vulnerability-advisor-registry-crawler -nkube-system
      ```
      {: codeblock}
   
   2. Edit the `reg-crawler.crontab` parameter in the VA image YAML file. Your YAML file might resemble the following configuration map:

      ```
      apiVersion: v1
      data:
        enabled: "true"
        reg-crawler.crontab: 0 10 * * *
      kind: ConfigMap
      metadata:
      ```
      {: pre}

* Change the YAML file for the MA process scan:

   1. Update the YAML file for the MA process scan by running the following command:

      ```
      kubectl edit cm vulnerability-advisor-process-ma-crawler -nkube-system
      ```
      {: codeblock}

   2. Edit the `live-crawler.crontab` parameter in the MA process YAML file. Your YAML file might resemble the following configuration map:

      ```
      apiVersion: v1
      data:
        enabled: "true"
        live-crawler.crontab: '*/15 * * * *'
      kind: ConfigMap
      metadata:
      ```
      {: pre}

* Change the CronTab time string to update the frequency of the scans: 

  View the following example of a CronTab time string: 

     ```
     # ┌───────────── minute (0 - 59)
     # │ ┌───────────── hour (0 - 23)
     # │ │ ┌───────────── day of the month (1 - 31)
     # │ │ │ ┌───────────── month (1 - 12)
     # │ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday;
     # │ │ │ │ │                                   7 is also Sunday on some systems)
     # │ │ │ │ │
     # │ │ │ │ │
     # *  *  * *  *
     ```
     {: pre}

     View the following examples of a CronTab time string:
     
     - A CronTab time string to run every two hours might resemble the following string:

        ```
        0 */2 * * *
        ```
        {: pre}
     
     - A CronTab time string to run one minute past midnight (00:01) every day might resemble the following string:
     
        ```
        1 0 * * *
        ```
        {: pre}
     
     - A CronTab time string to run 15 minutes before midnight (23:45 or 11:45 PM) every Saturday might resemble the following string:
     
        ```
        45 23 * * 6 
        ```
        {: pre}

A timing policy is created for the Vulnerability Advisor (VA) pods scan, VA images scan, and the Mutation Advisor (MA) process scan.

## Updating security notices for the Vulnerability Advisor components
{: #update_security}

Security notices for all supported {{site.data.keyword.linux}} distribution are preloaded in the Elasticsearch cluster for the Vulnerability Advisor. However, security notices for each {{site.data.keyword.linux_notm}} distribution are updated periodically on the Internet.

 {{site.data.keyword.IBM_notm}} publishes security notices by pushing a new `usnloader` image to Docker Hub at 00:00am E.S.T daily. New `usnloader` images are tagged with a time stamp. For example, security notices that are released in May 10th 2018 are tagged as `cloudviz/usnloader: 20180510`. An image tagged `latest` is also pushed daily when the build completes at 00:00am E.S.T. Each timestamped version of the `usnloader` image, is available on Docker Hub for 7 days.

### Prerequisites
If your environment does not have Internet access, you need to manually pull the `usnloader` image from Docker Hub daily. To set up a manual pull, complete the following steps:

1. Create a {{site.data.keyword.linux_notm}} Cron Job on a host that has Internet access. Schedule the Cron Job to pull the `usnloader` image every day at 5:00pm E.S.T.
2. Push the latest `usnloader` image to your {{site.data.keyword.product}} private registry. See [Pushing and pulling images
](../../catalog/3.4.0/using_docker_cli.md).
3. Complete the procedure for updating security notices. Ensure to update the `image` specification in the Kubernetes CronJob `usnloader.yaml` to point to the image in the {{site.data.keyword.product}} private registry. For example `image: mycluster.cpmcm:8500/services/usnloader:latest`.

### Procedure

To update the security notices for your {{site.data.keyword.product}} cluster, complete the following steps:

1. Set up the `kubectl` CLI. See [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

2. Create a Kubernetes CronJob `usnloader.yaml` by using the following specifications.

  	```
    ---
    apiVersion: batch/v1beta1
    kind: CronJob
    metadata:
     labels:
       app: usnloader
       component: vulnerability-advisor
     name: usnloader
     namespace: kube-system
    spec:
     concurrencyPolicy: Replace
     failedJobsHistoryLimit: 1
     successfulJobsHistoryLimit: 3
     schedule: '0 6 * * *'
     suspend: false
     jobTemplate:
       spec:
         template:
           spec:
             containers:
             - command: ["python2.7", "/opt/usnloader/usnloader.py",
                         "--elasticsearch-urls", "https://elasticsearch:9200", "--ca-file", "/tls/ca.crt",
                         "--client-cert", "/tls/curator.crt", "--client-key", "/tls/curator.key"]
               env:
               - name: SEC_TEMPLATE_FILE_NAME
                 value: index_template_6.json
               - name: RA_TEMPLATE_FILE_NAME
                 value: ra_index_template_6.json
               image: cloudviz/usnloader-es6:latest
               imagePullPolicy: Always
               name: usnloader
               volumeMounts:
               - mountPath: /var/log/cloudsight/
                 name: log
               - mountPath: /tls
                 name: certs
                 readOnly: true
             nodeSelector:
               va: "true"
             restartPolicy: OnFailure
             tolerations:
             - effect: NoSchedule
               key: "dedicated"
               operator: "Exists"
             - key: "CriticalAddonsOnly"
               operator: "Exists"
             volumes:
             - name: certs
               secret:
                 defaultMode: 420
                 secretName: logging-elk-certs
             - emptyDir: {}
               name: log
  	```
    {: codeblock}

    To load security notices for a specific date, you can create a Kubernetes batch job `usnloader.yaml` and specify the image for the desired date. The batch job might resemble the following code:

    ```
    ---
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: usnloader
      namespace: kube-system
      labels:
        app: usnloader
        component: vulnerability-advisor
    spec:
      template:
        metadata:
          annotations:
            scheduler.alpha.kubernetes.io/critical-pod: ""
          name: vulnerability-advisor-usncrawler
        spec:
          containers:
          - command:
            - python2.7
            - /opt/usnloader/usnloader.py
            - --elasticsearch-urls
            - https://elasticsearch:9200
            - --ca-file
            - /tls/ca.crt
            - --client-cert
            - /tls/curator.crt
            - --client-key
            - /tls/curator.key
            env:
            - name: SEC_TEMPLATE_FILE_NAME
              value: index_template_6.json
            - name: RA_TEMPLATE_FILE_NAME
              value: ra_index_template_6.json
            image: cloudviz/usnloader-es6:latest
            imagePullPolicy: Always
            name: usnloader
            volumeMounts:
            - mountPath: /var/log/cloudsight/
              name: log
            - mountPath: /tls
              name: certs
              readOnly: true
          dnsPolicy: ClusterFirst
          nodeSelector:
            va: "true"
          priorityClassName: system-cluster-critical
          restartPolicy: OnFailure
          terminationGracePeriodSeconds: 30
          tolerations:
          - effect: NoSchedule
            key: dedicated
            operator: Exists
          volumes:
          - name: certs
            secret:
              defaultMode: 420
              secretName: logging-elk-certs
          - emptyDir: {}
            name: log
    ```
    {: codeblock}

3. Launch the usnloader Job.

    ```
    kubectl apply -f usnloader.yaml
    ```
    {: codeblock}

4. Check the job.

    ```
    kubectl -n kube-system get cronjob | grep usnloader
    ```
    {: codeblock}

    The output resembles the following code:
    ```
    NAME                                          SCHEDULE      SUSPEND   ACTIVE    LAST SCHEDULE   AGE
    usnloader                                     0 6 * * *     False     1         29s             4m
    ```
    {: pre}

    The CronJob pulls the latest image from Docker Hub, and loads the latest security notices into the Elasticsearch component of your Vulnerability Advisor.

    ```
    kubectl -n kube-system get job | grep usnloader
    ```
    {: codeblock}

    The output resembles the following code:
    ```
    usnloader-1526436600                                     1         0            33s
    ```
    {: pre}

    ```
    kubectl -n kube-system get pods --show-all | grep usnloader
    ```
    {: codeblock}

    The output resembles the following code:
    ```
    apiVersion: batch/v1beta1
    usnloader-1526436600-846nf                                       0/1       Completed   0          59s
    ```
    {: pre}

    ```
    kubectl -n kube-system logs -f usnloader-1526436600-846nf
    ```
    {: codeblock}

    The output resembles the following code:
    ```
    2018-05-16 02:10:20,581 INFO 63 usnloader: Arguments received from the command line
    2018-05-16 02:10:20,582 INFO 66 usnloader: {'elastic_search': 'vulnerability-advisor-elasticsearch:9200', 'elastic_search_password': '**********'}
    2018-05-16 02:10:42,731 INFO 79 usnloader: No new usns
    2018-05-16 02:10:42,744 INFO 58 log_update_status: [
      {
        "latest_advisory": "deb-2018-msg00126.html",
        "index_load_time": "2018-05-16T02:10:07.866827",
        "distro": "debian"
      },
      {
        "latest_advisory": "alpine_git_commit:",
        "index_load_time": "2018-05-15T03:02:11.375949",
        "distro": "alpine"
      },
      {
        "latest_advisory": "RHSA-2018:0998",
        "index_load_time": "2018-05-16T02:10:07.744258",
        "distro": "redhat"
      },
      {
        "latest_advisory": "centos-2018-May.txt.gz",
        "index_load_time": "2018-05-16T02:10:07.832857",
        "distro": "centos"
      },
      {
        "latest_advisory": "FEDORA-2018-05",
        "index_load_time": "2018-05-16T02:10:07.656827",
        "distro": "fedora"
      },
      {
        "latest_advisory": "ubuntu-2018-May.txt.gz",
        "index_load_time": "2018-05-16T02:10:07.551024",
        "distro": "ubuntu"
      }
    ]
    ```
    {: pre}

You are now ready to use the Vulnerability Advisor with updated security notices. You can also scan external image registries with the Vulnerability Advisor. See [Scanning an image registry with the Vulnerability Advisor (VA)](../manage_cluster/external_scan.md) for more details.
