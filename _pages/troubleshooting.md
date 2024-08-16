Learn the basic format and elements of a troubleshooting topic, as well as other considerations.

**Note:** The format for RHAMC troubelshooting doc comes from feedback from developers and support focals.

## Location and basic format

- Troubleshooting files are located in the _Troubleshooting_ folder.
- For MCE, or the _Cluster lifeycle_ feature for RHACM, there is a separate Troubleshooting guide.
- When placing the new file, writers need to know if the issue is for ACM with the MCE operator, or for MCE-only (cluster only).
- Create the files with the same format:
  - Title: Ensure the title is specific and concise
  - Symptom: Explain what the user sees or experiences that indicates a problem.
  - Identifying the problem: The user further completes a procedure to find the specific problem.
  - Resolving the problem: User action to workaround or resolve the issue.

## Considerations

- Identifying the problem is not needed only if the symptom gives enough detail. It is needed if the user completes an action to find more about the problem. 

See the following examples:
  
**Example Symptom: Cluster with pending import status**
  
Your cluster is stuck in `pending import` status with no error.

**Example Identifying the problem: Cluster with pending import status**

1. Run the following command on the managed cluster to view the Kubernetes pods that have the issue:

    `kubectl get pod -n open-cluster-management-agent | grep klusterlet-registration-agent`

2. Run the following command on the managed cluster to find the log entry for the error:

    `kubectl logs <registration_agent_pod> -n open-cluster-management-agent`


4. Search the returned results for text that indicates there was a networking connectivity problem. Example includes: `no such host.`

- When you build a `.adoc` file, you do not have to repeat the title in the ID. You can keep the ID short. 


    `[#trouble-grafana-timeout]`
    `= Troubleshooting Grafana explorer gateway timeout`

- You should have a verification step from the tech leads that tells the user how to check for success. 

- If you do not, don't assume the result. For example, don't write: `The import issue is resolved`. 

- Example of a verification step:

  `Refresh the Grafana page and try to query the metrics again.`

- It is understood that if this doesn't work, users should contact support or check for other problems.
