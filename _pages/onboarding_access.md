---
layout: page
title: Set up access
permalink: /onboarding_access
horizontal: false
---

Before starting at Red Hat, you need to set up VPN access to the Red Hat environment, create required passwords to access Red Hats tools, and understand information security expectations regarding the use of your non-Red Hat device to access Red Hat tools.

## Red Hat Environment Overview

Most of our shared service applications (email, support portal) are available via the public network. To access these applications you will just need your Red Hat credentials. Other applications like software development tools and financial applications require you to access the Red Hat private network first before you can enter your Red Hat credentials to gain access.

Become familiar with the following terms before proceeding:

**VPN:** A secure connection accessed by two-factor authentication that allows
users to interface with internal Red Hat systems.

**Kerberos:** One of our network authentication protocols
used at Red Hat. Kerberos authentication is widely used to access engineering
environments. It is also used to establish your two-factor PIN + token.

**PIN + token:** Two-factor authentication password for accessing the majority of
our business applications.

## Prerequisites

Red Hat requires that all devices accessing Red Hat resources meet the following
requirements before accessing our network and tools:

- Your device storage must employ encryption
- The system must have up to date antivirus
- The system must be up to date on software and operating system patches

After ensuring your device meets the security requirements, contact your
manager to get your Red Hat credentials. This includes your username and a
temporary token code that will give you to access our systems to set up your
permanent passwords and authentication tokens.

Your username is sometimes referred to as a Kerberos ID. Use the username provided
by your manager in the _username_ field as shown in the following image:

![Kerberos ID](/assets/img/kerberoslogin.png)

The password for SSO is referred to as PIN + token at Red Hat. Use the temporary token provided by your manager in the _password_ field until you have successfully ceated a PIN + token. Additionally, any prompt asking for a PIN + token will require the temporary token. Temporary tokens expire after five days.

## VPN access

Depending on your operating system, there are different methods for installing
and configuring the VPN. Choose the method that matches your operating
system:

### Linux
1. Navigate to [Help](help.redhat.com) (requires your temporary token), and type KB0005424 into the search field.
2. Click on the article titled _Configure Network Manager for the Red Hat VPN on Fedora/non-CSB Linux_.
3. Follow all the steps listed in the article.

### Windows
1. Navigate to [Help](help.redhat.com) (requires your temporary token), and type KB0002244 in the search field.
2. Click on the article titled _OpenVPN Client Setup on non-CSB Windows_.
3. Follow all the steps listed in the article.

### MacOS
1. Navigate to [Help](help.redhat.com) (requires your temporary token), and type KB0008320 in the search field.
2. Click on the article entitled _Install and Configure VPN for Non-CSB MacOS_.
3. Follow all the steps listed in the article.

To use the VPN client, you should navigate to [Help](help.redhat.com) and type the
following in the search field based on your OS:

### Linux
- KB0005418: Connect to the Red Hat VPN using OpenVPN on Fedora/non-CSB Linux

### Windows
- KB0002244: OpenVPN Client Setup on non-CSB Windows

### MacOS
- KB0005419: Connect to the Red Hat VPN on MacOS

## Kerberos Password
1. Connect to the Red Hat VPN.
2. Navigate to [Password settings](https://password.corp.redhat.com/) and follow the guidelines.

**Note:** This process takes up to 30 minutes.

## PIN + token
Red Hat recommends using either the [FreeOTP Authenticator](https://freeotp.github.io/) or [Google Authenticator](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en_US&gl=US) app on your mobile device for setting up two-factor authentication.

### FreeOTP Authenticator
After installing FreeOTP Authenticator, complete the following steps.

1. On your device, connect to the Red Hat VPN.
2. Navigate to [Help](help.redhat.com) (requires your temporary token).
3. In the search field, type KB0004383.
4. Click on the article _Set Up a FreeOTP Soft Token at token.redhat.com_ and follow the instructions.

### Google Authenticator
After installing Google Authenticator, complete the following steps.
1. On your device, connect to the Red Hat VPN.
2. Navigate to [Help](help.redhat.com) (requires your temporary token).
3. In the search field, type KB0001372.
4. Click on the article _Setting up a Google Authenticator Soft Token and token.redhat_.com’ and follow the instructions.