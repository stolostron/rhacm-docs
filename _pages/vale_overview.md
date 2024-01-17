---
layout: page
title: Vale overview
permalink: /vale_overview
horizontal: false
render_with_liquid: false
---

Vale is a command-line tool that can check your writing against a set of style or grammar rules. You can use Vale in your workflow to improve the accuracy of your writing and fix styles issues before creating a PR.

## Installing Vale on macOS

See the following topics to install Vale and the `RedHat` style package on macOS. For other operating systems, see [Installing Vale](https://redhat-documentation.github.io/vale-at-red-hat/docs/main/user-guide/installing-vale-cli/).

### Prerequisite

- You must have the latest Asciidoctor installed

    **Tip:** You can check which Asciidoctor version is installed by running the following command: 

    `asciidoctor -v`

    You can install Asciidoctor by running the following:

    `brew install asciidoctor`

### Installing the Vale command-line tool

Run the following command to install the Vale command-line tool:

`brew install vale`

### Installing the `RedHat` style package

The `RedHat` style package contains the style and grammar rules set by the latest version of the IBM Style guide, IBM Developer Editorial Style guide, Red Hat supplementary style guide, and the Vale dictionary for American English.

To install the `RedHat` style package, complete the following steps:

1. Create the `.vale.ini` configuration file in your home directory and add the following content to it:

    ```
    StylesPath = .vale/styles

    MinAlertLevel = suggestion

    IgnoredScopes = code, tt, img, url, a, body.id

    SkippedScopes = script, style, pre, figure, code, tt, blockquote, listingblock, literalblock

    Packages = RedHat

    [*.adoc]

    BasedOnStyles = RedHat

    [*.md]

    BasedOnStyles = RedHat

    # Ignore code surrounded by backticks or plus sign, parameters defaults, URLs.
    TokenIgnores = (\x60[^\n\x60]+\x60), ([^\n]+=[^\n]*), (\+[^\n]+\+), (http[^\n]+\[)

    # Match INI files. See: https://docs.errata.ai/vale/scoping
    [*.ini]

    BasedOnStyles = RedHat

    # Ignore code surrounded by backticks or plus sign, parameters defaults, URLs.
    TokenIgnores = (\x60[^\n\x60]+\x60), ([^\n]+=[^\n]*), (\+[^\n]+\+), (http[^\n]+\[)

    # Disabling rules (NO)
    RedHat.CaseSensitiveTerms = NO
    RedHat.ConfigMap = NO
    RedHat.Definitions = NO
    RedHat.Slash = NO
    RedHat.Spacing = NO
    RedHat.Spelling = NO
    RedHat.TermsSuggestions = NO
    ```

2. Save the file and run the following command:

    `vale sync`

    See the following example of a successful output:

    ```
    SUCCESS  Downloaded package 'RedHat'
    Downloading packages [1/1]
    ```

**Tip:** You can repeat step 2 to update Vale.

**Note:** You can also add the configuration file to the repository of the project you are working on. If you add the configuration file to the repository, it overrides the settings of your local configuration file. 

## Using Vale with the command-line

To use Vale in the command-line, complete the following steps:

1. Navigate to the folder that contains the file you want to check. See the following example:

    `cd Documents/Project/Modules`

2. Select the file you want to check and run Vale. See the following example:

    `vale myfile.adoc`

    The output is a table with the following structure:

    Column 1: Line number

    Column 2: Character number

    Column 3: Type of warning

    Column 4: Suggested improvement

    Column 5: Location of style rule

## Using Vale with Visual Studio Code

After installing Vale on macOS, install the latest version of the `Vale VSCode` extension to enable real time Vale checks in Visual Studio Code.

## Troubleshooting

If you receive an error after running `vale sync`, check if the `.vale` folder was downloaded correctly to your home folder. If the folder is missing, download it from a team member and manually add it to your home folder.
