Here is where you find a basic format, as well as other considerations for Troubleshooting. 

**Note:** The format for RHAMC troubelshooting doc comes from feedback from developers and support teams.

- Troubleshooting files are located in the _Troubleshooting_ folder.
- Create the files with the same format:
  - Title
  - Symptom
  - Identifying the problem: Not needed only is the symptom covers this. Needed if the user completes an action to find the problem.
  - Resolving the problem
- Identifying the problem is not needed only if the symptom covers this. It is needed if the user completes an action to find the problem. See the following example:
  
```
Identifying the problem: Cluster with pending import status
Run the following command on the managed cluster to view the Kubernetes pod names that are having the issue:

kubectl get pod -n open-cluster-management-agent | grep klusterlet-registration-agent
Run the following command on the managed cluster to find the log entry for the error:

kubectl logs <registration_agent_pod> -n open-cluster-management-agent
Replace registration_agent_pod with the pod name that you identified in step 1.

Search the returned results for text that indicates there was a networking connectivity problem. Example includes: no such host.
```
```
[#trouble-grafana-timeout]
= Troubleshooting Grafana 
#You do not have to repeat the title in the ID

When you query some time-consuming metrics in the Grafana explorer, you might encounter a `Gateway Time-out` error.

[#symptom-grafana-timeout]
== Symptom: Grafana explorer gateway timeout

If you hit the `Gateway Time-out` error when you query some time-consuming metrics in the Grafana explorer, it is possible that the timeout is caused by the Grafana in the `open-cluster-management-observability` namespace.

[#resolving-grafana-explorer-gateway-timeout]
== Resolving the problem: Configure the Grafana

Complete the following steps to configure Grafana:

. Verify that the default configuration of Grafana has expected timeout settings:
.. To verify that the default timeout setting of Grafana, run the following command:
+
----
oc get secret grafana-config -n open-cluster-management-observability -o jsonpath="{.data.grafana\.ini}" | base64 -d | grep dataproxy -A 4
----
+
The following timeout settings should be displayed:
+
----
[dataproxy]
timeout = 300
dial_timeout = 30
keep_alive_seconds = 300
----
.. To verify the default data source query timeout for Grafana, run the following command: 
+
----
oc get secret/grafana-datasources -n open-cluster-management-observability -o jsonpath="{.data.datasources\.yaml}" | base64 -d | grep queryTimeout
----
+
The following timeout settings should be displayed:
+
----
queryTimeout: 300s
----
. If you verified the default configuration of Grafana has expected timeout settings, then you can configure the Grafana in the `open-cluster-management-observability` namespace by running the following command:
+
----
oc annotate route grafana -n open-cluster-management-observability --overwrite haproxy.router.openshift.io/timeout=300s
----

Refresh the Grafana page and try to query the metrics again.
#Don't tell the user here that the issue is solved. It may not be. It is understood that if this doesn't work, they contact support or look for other problems.
```
