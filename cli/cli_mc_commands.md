# Multicluster commands (mc)

Learn about the `oc mc` commands that you can run to access your Red Hat Advanced Cluster Management for Kubernetes cluster.

Many of the `oc mc` commands correspond to `kubectl` commands that are similar. In most cases, the `oc mc` command provides the same functionality as its `kubectl` counterpart, but the `oc mc` commands apply to a multi-cluster environment. 

For example, the `oc mc get pods` command lists the pods on one or more managed clusters, while the `kubectl get pods` command lists the pods in the current namespace. 

The options that are available for the `oc mc` commands are generally a subset of the options that are available with the `kubectl` commands, but the content and format of the results that are returned from the `oc mc` commands should be similar to the results from the `kubectl` commands.

## oc mc

 * [oc mc apply](#oc-mc-apply)
 * [oc mc cluster import](#oc-mc-cluster-import)
 * [oc mc cluster list](#oc-mc-cluster-list)
 * [oc mc cluster remove](#oc-mc-cluster-remove)
 * [oc mc cluster template](#oc-mc-cluster-template)
 * [oc mc create](#oc-mc-create)
 * [oc mc create helmrepo](#oc-mc-create-helmrepo)
 * [oc mc delete](#oc-mc-delete)
 * [oc mc deploy application](#oc-mc-deploy-application)
 * [oc mc describe](#oc-mc-describe)
 * [oc mc edit](#oc-mc-edit)
 * [oc mc get](#oc-mc-get)
 * [oc mc label](#oc-mc-label)
 * [oc mc logs](#oc-mc-logs)

## oc mc apply

Apply a configuration to a resource by `filename` or `stdin`.

- Example
  
```
oc mc apply -f FILENAME [options]

OPTIONS:
   --alsologtostderr    Log to standard error, as well as files
   --cluster, -c        Name of the cluster
   --cluster-namespace  Namespace of the cluster
   --cluster-selector   Selector (label query) that is used to filter clusters; supports '=', '==', and '!=' (-l key1=value1,key2=value2)
   --filename, -f       Filename, directory, or URL to files create -f filename
   --kubeconfig         Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at   When logging hits line file:N, emit a stack trace
   --log-dir            If non-empty, write log files in this directory
   --logtostderr        Log to standard error instead of files
   --namespace, -n      Namespace of the object
   --recursive, -R      Process the directory used in -f, --filename recursively; useful when you want to manage related manifests organized within the same directory
   --stderrthreshold    Logs at or more than this threshold go to stderr
   -v, -v               Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule            Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc cluster import

Import a cluster

- Example
  
```
oc mc cluster import -f {config.yaml} [-C|--cluster-context {context}] [-K|--cluster-kubeconfig {path}] [-b|--bootstrap-namespace {namespace}] [-t|--timeout {time}]

OPTIONS:
   --alsologtostderr          Log to standard error, as well as files
   --bootstrap-namespace, -b  The namespace that the bootstrap will run in to import the cluster
   --cluster-context, -C      The name of the Kubernetes context of the cluster to import within the default configuration path, or within the path set with --cluster-kubeconfig, run 'kubectl config get-contexts' to list contexts
   --cluster-kubeconfig, -K   The path to the alternate Kubernetes config file containing the cluster to import configuration from. Use --cluster-context if the cluster is not the current context in the configuration
   --dry-run                  If true, only print the YAML that would be used, but do not apply it
   --filename, -f             Filename, directory, or URL to files import -f config.yaml file
   --kube-host                Override the Kubernetes host and port that the cluster to import will connect to
   --kubeconfig               Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at         When logging hits line file:N, emit a stack trace
   --log-dir                  If non-empty, write log files in this directory
   --logtostderr              Log to standard error instead of files
   --recursive, -R            Process the directory used in -f, --filename recursively; useful when you want to manage related manifests organized within the same directory
   --stderrthreshold          Logs at or prior to this threshold go to stderr
   --timeout, -t              The length of time to wait for the cluster to join the hub cluster
   -v, -v                     Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule                  Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc cluster list

List the clusters imported

- Example
  
```
oc mc cluster list

OPTIONS:
   --alsologtostderr   Log to standard error, as well as files
   --kubeconfig        Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at  When logging hits line file:N, emit a stack trace
   --log-dir           If non-empty, write log files in this directory
   --logtostderr       Log to standard error instead of files
   --stderrthreshold   Logs at or more than this threshold go to stderr
   -v, -v              Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule           Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc cluster remove

Remove an imported cluster

- Example
  
```
oc mc cluster remove {name} [-n|--namespace {namespace}] [-C|--cluster-context {context}] [-K|--cluster-kubeconfig {path}] [-b|--bootstrap-namespace {namespace}]

OPTIONS:
   --alsologtostderr         Log to standard error, as well as files
   --boostrap-namespace, -b  The namespace that the bootstrap will run in to import the cluster
   --cluster-context, -C     The name of the Kubernetes context of the cluster to remove within the default configuration path or within the path set with --cluster-kubeconfig; run 'kubectl config get-contexts' to list contexts
   --cluster-kubeconfig, -K  The path to the alternate kubeconfig file containing the cluster to be removed, use --cluster-context if the cluster is not the current context in the configuration
   --dry-run                 If true, only print the YAML that would be used, but do not apply it
   --kubeconfig              Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at        When logging hits line file:N, emit a stack trace
   --log-dir                 If non-empty, write log files in this directory
   --logtostderr             Log to standard error instead of files
   --namespace, -n           The namespace in the hub cluster to manage the imported cluster. A namespace matching the cluster name will be used if not set.
   --stderrthreshold         Logs at or more than this threshold go to stderr
   -v, -v                    Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule                 Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc cluster template

Output a template config.yaml file used for cluster import

- Example
  
```
oc mc cluster template {name} [-n|--namespace {namespace}]

OPTIONS:
   --alsologtostderr   Log to standard error, as well as files
   --kubeconfig        Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at  When logging hits line file:N, emit a stack trace
   --log-dir           If non-empty, write log files in this directory
   --logtostderr       Log to standard error instead of files
   --namespace, -n     The namespace in the hub cluster for the target cluster
   --stderrthreshold   Logs at or more than this threshold go to stderr
   -v, -v              Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule           Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc create

Create a resource from a file or from stdin

- Example
  
```
oc mc create -f FILENAME [options]

OPTIONS:
   --alsologtostderr    Log to standard error, as well as files
   --cluster, -c        Name of the cluster
   --cluster-namespace  Namespace of the cluster
   --cluster-selector   Selector (label query) that is used to filter clusters; supports '=', '==', and '!=' (-l key1=value1,key2=value2)
   --filename, -f       Filename, directory, or URL to files create -f filename
   --kubeconfig         Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at   When logging hits line file:N, emit a stack trace
   --log-dir            If non-empty, write log files in this directory
   --logtostderr        Log to standard error instead of files
   --namespace, -n      Namespace of the object
   --recursive, -R      Process the directory used in -f, --filename recursively; useful when you want to manage related manifests organized within the same directory
   --stderrthreshold    Logs at or more than this threshold go to stderr
   -v, -v               Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule            Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc create helmrepo

Create a Helm repository

- Example
  
```
oc mc create helmrepo --repo-name <repo_name> --repo-url <repo_url>

OPTIONS:
   --alsologtostderr    Log to standard error, as well as files
   --cluster, -c        Name of the cluster
   --cluster-namespace  Namespace of the cluster
   --cluster-selector   Selector (label query) that is used to filter clusters; supports '=', '==', and '!=' (-l key1=value1,key2=value2)
   --kubeconfig         Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at   When logging hits line file:N, emit a stack trace
   --log-dir            If non-empty, write log files in this directory
   --logtostderr        Log to standard error instead of files
   --namespace, -n      Namespace of the object
   --repo-name          Name of Repository
   --repo-url, -u       URL of Repository
   --stderrthreshold    Logs at or more than this threshold go to stderr
   -v, -v               Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule            Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc delete

Delete resources by file names, stdin, resources and names, or by resources and label selector

- Example
  
```
oc mc delete ([-f FILENAME] | TYPE [(NAME | -l label | --all)]) [options]

OPTIONS:
   --all                Delete all resources, including uninitialized ones, in the namespace of the specified resource types.
   --alsologtostderr    Log to standard error, as well as files
   --cluster, -c        Name of the cluster
   --cluster-namespace  Namespace of the cluster
   --cluster-selector   Selector (label query) that is used to filter clusters; supports '=', '==', and '!=' (-l key1=value1,key2=value2)
   --field-selector     Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector key1=value1,key2=value2); the server only supports a limited number of field queries per type
   --filename, -f       Filename, directory, or URL to files delete -f filename
   --kubeconfig         Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at   When logging hits line file:N, emit a stack trace
   --log-dir            If non-empty, write log files in this directory
   --logtostderr        Log to standard error instead of files
   --namespace, -n      Namespace of the object
   --output, -o         Output mode; use "-o name" for shorter output (resource/name)
   --recursive, -R      Process the directory used in -f, --filename recursively; useful when you want to manage related manifests organized within the same directory
   --selector, -l       Selector (label query) to filter on, not including uninitialized ones.
   --stderrthreshold    Logs at or more than this threshold go to stderr
   -v, -v               Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule            Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc deploy application

Deploy an application

- Example
  
```
oc mc deploy application <app_name> --cluster-replica <number_of_clusters> --cluster-selector <key=value>

OPTIONS:
   --alsologtostderr    Log to standard error, as well as files
   --cluster, -c        Name of the cluster
   --cluster-namespace  Namespace of the cluster
   --cluster-replica    Number of clusters to deploy the application to
   --cluster-selector   Selector (label query) that is used to filter clusters; supports '=', '==', and '!=' (-l key1=value1,key2=value2)
   --kubeconfig         Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at   When logging hits line file:N, emit a stack trace
   --log-dir            If non-empty, write log files in this directory
   --logtostderr        Log to standard error instead of files
   --namespace, -n      Namespace of the object
   --resource-selector  Resource selector
   --stderrthreshold    Logs at or more than this threshold go to stderr
   -v, -v               Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule            Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc describe

Show details of a specific resource or group of resources

- Example
  
```
oc mc describe (-f FILENAME | TYPE [NAME_PREFIX | -l label] | TYPE/NAME) [options]

OPTIONS:
   --all-namespaces         If present, list the requested object(s) across all namespaces; namespace in current context is ignored even if specified with --namespace
   --alsologtostderr        Log to standard error, as well as files
   --cluster, -c            Name of the cluster
   --cluster-namespace      Namespace of the cluster
   --cluster-selector       Selector (label query) that is used to filter clusters; supports '=', '==', and '!=' (-l key1=value1,key2=value2)
   --filename, -f           Filename, directory, or URL to files containing the resource to describe
   --include-uninitialized  If true, the kubectl command applies to uninitialized objects; if explicitly set to false, this flag overrides other flags that make the kubectl commands apply to uninitialized objects, such as, "--all"; objects with empty metadata.initializers are regarded as initialized
   --kubeconfig             Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at       When logging hits line file:N, emit a stack trace
   --log-dir                If non-empty, write log files in this directory
   --logtostderr            Log to standard error instead of files
   --namespace, -n          Namespace of the object
   --recursive, -R          Process the directory used in -f, --filename recursively; useful when you want to manage related manifests organized within the same directory
   --selector, -l           Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
   --show-events            If true, display events related to the described object.
   --stderrthreshold        Logs at or more than this threshold go to stderr
   -v, -v               Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule                Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc edit

Edit a resource from the default editor

- Example
  
```
oc mc edit (<resource_type/resource_name> | -f <filename>)

OPTIONS:
   --alsologtostderr       Log to standard error, as well as files
   --cluster, -c           Name of the cluster
   --cluster-namespace     Namespace of the cluster
   --cluster-selector      Selector (label query) that is used to filter clusters; supports '=', '==', and '!=' (-l key1=value1,key2=value2)
   --kubeconfig            Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at      When logging hits line file:N, emit a stack trace
   --log-dir               If non-empty, write log files in this directory
   --logtostderr           Log to standard error instead of files
   --namespace, -n         Namespace of the object
   --output, -o            Output format; one of: json|yaml|wide|custom-columns=...|custom-columns-file=...|go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=... See custom columns [http://kubernetes.io/docs/user-guide/kubectl-overview/#custom-columns], golang template [http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template [http://kubernetes.io/docs/user-guide/jsonpath]
   --output-patch          Output the patch if the resource is edited
   --stderrthreshold       Logs at or more than this threshold go to stderr
   -v, -v               Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule               Comma-separated list of pattern=N settings for file-filtered logging
   --windows-line-endings  Defaults to the line ending native to your platform.
```

## oc mc get

Display one or many resources

- Example
  
```
oc mc get [(-o|--output=)json|yaml|wide|go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=...] (TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags]

OPTIONS:
   --all-namespaces               If present, list the requested object(s) across all namespaces; namespace in current context is ignored even if specified with --namespace
   --allow-missing-template-keys  If true, ignore any errors in templates when a field or map key is missing in the template; only applies to golang and jsonpath output formats
   --alsologtostderr              Log to standard error, as well as files
   --cluster, -c                  Name of the cluster
   --cluster-namespace            Namespace of the cluster
   --cluster-selector             Selector (label query) that is used to filter clusters; supports '=', '==', and '!=' (-l key1=value1,key2=value2)
   --field-selector               Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
   --kubeconfig                   Path to a kubeconfig file, which overrides $KUBECONFIG
   --label-columns, -L            Accepts a comma separated list of labels that are going to be presented as columns; names are case-sensitive; you can also use multiple flag options such as -L label1 -L label2...
   --label-selector, -l           Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
   --log-backtrace-at             When logging hits line file:N, emit a stack trace
   --log-dir                      If non-empty, write log files in this directory
   --logtostderr                  Log to standard error instead of files
   --namespace, -n                Namespace of the object
   --no-headers                   When using the default or custom-column output format, do not print headers (default: print headers)
   --output, -o                   Output format. One of: json|yaml|wide|name|custom-columns=...|custom-columns-file=...|go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=... See custom columns [http://kubernetes.io/docs/user-guide/kubectl-overview/#custom-columns], golang template [http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template [http://kubernetes.io/docs/user-guide/jsonpath].
   --server-print                 Enable server print
   --show-labels                  When printing, show all labels as the last column (default hide labels column)
   --sort-by                      If non-empty, sort list types using this field specification; the field specification is expressed as a JSONPath expression (e.g. '{.metadata.name}'); the field in the API resource specified by this JSONPath expression must be an integer or a string
   --stderrthreshold              Logs at or more than this threshold go to stderr
   --template                     Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates [http://golang.org/pkg/text/template/#pkg-overview].
   -v, -v               Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule                      Comma-separated list of pattern=N settings for file-filtered logging
   --watch, -w                    After listing/getting the requested object, watch for changes; uninitialized objects are excluded if no object name is provided
```

## oc mc label

Update the labels on a resource

- Example
  
```
oc mc label [--overwrite] (-f FILENAME | TYPE NAME) KEY_1=VAL_1 ... KEY_N=VAL_N [--resource-version=version] [options]

OPTIONS:
   --all                Select all resources, including uninitialized ones, in the namespace of the specified resource types
   --alsologtostderr    Log to standard error, as well as files
   --cluster, -c        Name of the cluster
   --cluster-namespace  Namespace of the cluster
   --cluster-selector   Selector (label query) that is used to filter clusters; supports '=', '==', and '!=' (-l key1=value1,key2=value2)
   --field-selector     Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector key1=value1,key2=value2); the server only supports a limited number of field queries per type
   --kubeconfig         Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at   When logging hits line file:N, emit a stack trace
   --log-dir            If non-empty, write log files in this directory
   --logtostderr        Log to standard error instead of files
   --namespace, -n      Namespace of the object
   --selector, -l       Selector (label query) to filter on, not including uninitialized ones, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2).
   --stderrthreshold    Logs at or more than this threshold go to stderr
   -v, -v               Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule            Comma-separated list of pattern=N settings for file-filtered logging
```

## oc mc logs

Print the logs for a container in a pod

- Example
  
```
oc mc logs [-f] [-p] (POD | TYPE/NAME) [-c CONTAINER] [options]

OPTIONS:
   --alsologtostderr    Log to standard error, as well as files
   --cluster, -c        Name of the cluster
   --cluster-namespace  Namespace of the cluster
   --cluster-selector   Selector (label query) that is used to filter clusters; supports '=', '==', and '!=' (-l key1=value1,key2=value2)
   --container          Print the logs of this container
   --follow, -f         Specify if the logs should be streamed
   --kubeconfig         Path to a kubeconfig file, which overrides $KUBECONFIG
   --log-backtrace-at   When logging hits line file:N, emit a stack trace
   --log-dir            If non-empty, write log files in this directory
   --logtostderr        Log to standard error instead of files
   --namespace, -n      Namespace of the object
   --previous, -p       If true, print the logs for the previous instance of the container in a pod if it exists
   --since              Only return logs newer than a relative duration, such as 5s, 2m, or 3h.; defaults to all logs
   --stderrthreshold    Logs at or more than this threshold go to stderr
   --tail               Lines of recent log file to display, defaults to -1 (show all lines)
   --timestamps         Include timestamps on each line in the log output
   -v, -v               Sets the verbosity level of the information returned in the logs with an integer between 0 and 9, where 9 is the most verbose (default v=0) 
   --vmodule            Comma-separated list of pattern=N settings for file-filtered logging
```
