---
layout: page
title: Set up access
permalink: /onboarding_access
horizontal: false
---

Before starting at Red Hat, you need to set up VPN access to the Red Hat environment, create required passwords to access Red Hats tools, and understand information security when using personal devices.

## Red Hat environment overview

Most of our shared service applications (email, support portal) are available via the public network. To access these applications you just need your Red Hat credentials. Other applications like software development tools access to the Red Hat private network before entering your Red Hat credentials.

Become familiar with the following terms before proceeding:

**VPN:** A secure connection accessed by two-factor authentication that allows
users to interface with internal Red Hat systems.

**Kerberos:** One of our network authentication protocols
used at Red Hat.

**PIN + token:** Two-factor authentication password.

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
by your manager in the _username_ field during login.

Use the temporary token provided by your manager in the _password_ field until you have a PIN + token. Until then, prompts asking for a PIN + token require the temporary token. Temporary tokens expire after five days.

## Installing the VPN

To install the VPN, see the following topics for instructions based on your operating system:

### Linux
1. Navigate to [Help](help.redhat.com) and type KB0005424 in the search field.
2. Click on the article _Configure Network Manager for the Red Hat VPN on Fedora/non-CSB Linux_.
3. Follow the steps in the article.

### Windows
1. Navigate to [Help](help.redhat.com) and type KB0002244 in the search field.
2. Click on the article _OpenVPN Client Setup on non-CSB Windows_.
3. Follow the steps in the article.

### MacOS
1. Navigate to [Help](help.redhat.com) and type KB0008320 in the search field.
2. Click on the article _Install and Configure VPN for Non-CSB MacOS_.
3. Follow the steps in the article.

## Using the VPN

To use the VPN, see the following topics for instructions based on your operating system:

### Linux
1. Navigate to [Help](help.redhat.com) and type KB0005418 in the search field.
2. Click on the article _Connect to the Red Hat VPN using OpenVPN on Fedora/non-CSB Linux_.
3. Follow the steps in the article.

### Windows
1. Navigate to [Help](help.redhat.com) and type KB0002244 in the search field.
2. Click on the article _OpenVPN Client Setup on non-CSB Windows_.
3. Follow the steps in the article.

### MacOS
1. Navigate to [Help](help.redhat.com) and type KB0005419 in the search field.
2. Click on the article _Connect to the Red Hat VPN on MacOS_.
3. Follow the steps in the article.

## Kerberos password

To set up your Kerberos password, complete the following steps:

1. Connect to the Red Hat VPN.
2. Navigate to [Password settings](https://password.corp.redhat.com/) and follow the instructions.

**Note:** This process takes up to 30 minutes.

## Configring the PIN + token

Red Hat recommends using either the [FreeOTP Authenticator](https://freeotp.github.io/) or [Google Authenticator](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en_US&gl=US) app on your mobile device for setting up two-factor authentication.

### FreeOTP Authenticator

After installing FreeOTP Authenticator, complete the following steps:

1. Connect to the Red Hat VPN.
2. Navigate to [Help](help.redhat.com) and type KB0004383 in the search field.
3. Click on the article _Set Up a FreeOTP Soft Token at token.redhat.com_.
4. Follow the steps in the article.

### Google Authenticator

After installing Google Authenticator, complete the following steps:

1. Connect to the Red Hat VPN.
2. Navigate to [Help](help.redhat.com) and type KB0001372 in the search field.
3. Click on the article _Setting up a Google Authenticator Soft Token and token.redhat.com_.
4. Follow the steps in the article.
