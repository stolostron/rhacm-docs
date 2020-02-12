---

copyright:
  years: 2019
lastupdated: "2019-05-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Docker login results in unencrypted password warning

After you log in to your private image registry with the Docker login command, a warning is displayed that indicates that your password is stored unencrypted. 
{:shortdesc}

## Symptoms

A warning message is displayed when you log in to your private image registry with the following command:

```
docker login <cluster_CA_domain>:8500
```
In this command, `<cluster_CA_domain>` is the certificate authority (CA) domain that was set in the `config.yaml` file during installation.

The command output includes the following warning:

```
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
```

## Causes

By default, Docker stores the login password unencrypted within the `/root/.docker/config.json` Docker configuration file. This is the default Docker behavior.

## Resolving the problem

You can store your user credentials in an external credentials store instead of within the Docker configuration file. Storing your credentials in a credentials store is more secure than storing the credentials in the Docker configuration file. For more information, see the [Docker community credentials store documentation ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.docker.com/engine/reference/commandline/login/#credentials-store).
