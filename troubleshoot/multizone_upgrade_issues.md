---

copyright:
  years: 2019
lastupdated: "2019-09-23"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Multizone upgrade issues

**{{site.data.keyword.tech_prev}}**

Troubleshoot multizone upgrade issues.
{: shortdesc}

## upgrade-prepare command failed 

You might see the following error:

```
TASK [upgrade-check : Validating registry disk space] **********************************************************************************************************************************************************
fatal: [9.21.52.205 -> 9.21.52.200]: FAILED! => changed=true
  cmd: |-
    free_disk_registry=$(df -BG --output=avail /var/lib/registry | awk '{sum += $1};END {print sum}')
     if [[ $free_disk_registry -lt 48 ]]; then
     echo "/var/lib/registry directory available disk space ${free_disk_registry} GB, it should be greater than or equal to 48 GB" 1>&2
     exit 1
     fi
  delta: '0:00:00.013641'
  end: '2019-09-10 01:17:13.909716'
  msg: non-zero return code
  rc: 1
  start: '2019-09-10 01:17:13.896075'
  stderr: /var/lib/registry directory available disk space 21 GB, it should be greater than or equal to 48 GB
  stderr_lines: <omitted>
  stdout: ''
  stdout_lines: <omitted>

NO MORE HOSTS LEFT *********************************************************************************************************************************************************************************************

PLAY RECAP ***********************************************************************************************************

[root@dc1m1 cluster]# mount | grep /var/lib/registry
9.21.58.182:/root/nfs_multidc/registry on /var/lib/registry type nfs4 (rw,relatime,vers=4.1,rsize=8192,wsize=8192,namlen=255,hard,proto=tcp,timeo=14,retrans=2,sec=sys,clientaddr=n.n.n.n,local_lock=none,addr=m.m.m.m)
```
{: pre}

### Resolve the issue

Log in to the Network File System (NFS) server node and release disk space. Then, run the command to upgrade.

For more information, see [Upgrading the {{site.data.keyword.cloud_pak_mcm}}](../../install/upgrade_offline.md).

## Upgrading web-terminal chart failed 

You might see the following error:  

```
Error: Get https://n.n.n.n:8001/api/v1/namespaces/kube-system/pods?labelSelector=app%3Dhelm%2Cname%3Dtiller: net/http: TLS handshake timeout
```
{: pre}

### Resolve the issue

The API server might not be stable. Run the `upgrade-chart` command again.

For more information, see [Upgrading the {{site.data.keyword.cloud_pak_mcm}}](../../install/upgrade_offline.md).



