# Troubleshooting

**Important**: Install the Kubernetes CLI to run the troubleshooting commands. For more information, see _Install and Set Up kubectl_ in the [Kubernetes documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-macos).

View the list of troubleshoot topics for Red Hat Advanced Cluster Management for Kubernetes:

* [Troubleshooting cert-manager-webhook](trouble_cert_webhook.md)
* [Troubleshooting cluster in console with unknown status](trouble_import_status.md)
* [Troubleshooting cluster with unknown status](trouble_console_status.md)


## Troubleshooting installation

Use this section to troubleshoot issues when installing Red Hat Advanced Cluster Management for Kubernetes.

### Symptom {#symptom-4}

Installation process fails to start the `multiclusterhub-operator` after running the `start.sh` script.

### Identifying the problem {#identifying-the-problem-4}

The installation output shows that the installation timed out during the `Wait for multiclusterhub-operator to reach running state (4 min)` step.

### Resolving the problem {#resolving-the-problem-4}

The following workarounds might help resolve this issue:

* An incorrect snapshot format was entered. The correct format is `1.0.0-SNAPSHOT-2020-04-01-02-43-31`. The previous snapshot value that was entered becomes the default value. If it was entered incorrectly, then the correct value must be entered manually during a new installation attempt.

  Run the installation again with the correct snapshot value to resolve this problem.

* An incorrect pull-secret was used. Make sure you selected the *Kubernetes Secret* when you generated the pull secret from Quay. If it is a different format, the output displays the following error when applying the prerequisites:

  ```
  Failed to read Resources YAML file [pull-secret.yaml] encounters a format error.
  ```

  Repeat the steps to create your pull secret, and download the *Kubernetes Secret* to resolve this issue.
