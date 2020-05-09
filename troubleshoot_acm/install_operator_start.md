# Troubleshooting multiclusterhub-operator start

If the `multiclusterhub-operator` fails to run after you the `start.sh` script.

## Symptom: multiclusterhub-operator start

Installation process fails to start the `multiclusterhub-operator` after running the `start.sh` script.

## Identifying the problem: multiclusterhub-operator start

The installation output shows that the installation timed out during the `Wait for multiclusterhub-operator to reach running state (4 min)` step.

## Resolving the problem: multiclusterhub-operator start

The following workarounds might help resolve this issue:

* An incorrect snapshot format was entered. The correct format is `1.0.0-SNAPSHOT-2020-04-01-02-43-31`. The previous snapshot value that was entered becomes the default value. If it was entered incorrectly, then the correct value must be entered manually during a new installation attempt.

  Run the installation again with the correct snapshot value to resolve this problem.

* An incorrect pull-secret was used. Make sure you selected the *Kubernetes Secret* when you generated the pull secret from Quay. If it is a different format, the output displays the following error when applying the prerequisites:

  ```
  Failed to read Resources YAML file [pull-secret.yaml] encounters a format error.
  ```

  Repeat the steps to create your pull secret, and download the *Kubernetes Secret* to resolve this issue.
