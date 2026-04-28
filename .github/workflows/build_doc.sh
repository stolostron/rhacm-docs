#! /bin/bash

# Fetch all AsciiDoc files in the current directory and its subdirectories
files=$(find . -type f -name \*.adoc)

# Iterate through each file and check for errors
for file in ${files}; do
  # Run Asciidoctor with failure level WARN, trace, verbose, and warnings
  errors=$(asciidoctor --failure-level WARN --trace --verbose --warnings "${file}" 2>&1 >/dev/null) || exit_code=$?
  # If there are errors, print the file and the errors
  if [[ -n "${errors}" ]]; then
    echo "Errors found in ${file}"
    echo "--------------------------------"
    echo "${errors}" | while read -r line; do
      echo "${line}"
      if [[ ${line} == *"ERROR:"* ]]; then
        # Extract file, line, and message
        file_log=$(echo "${line}" | cut -d':' -f3 | sed 's/^ //')
        if [[ ${file_log} == "main.adoc" ]]; then
          file_log=$(dirname "${file}")/main.adoc
        fi
        line_log=$(echo "${line}" | cut -d':' -f4)
        message=$(echo "${line}" | cut -d':' -f5- | sed 's%/home/runner/work/rhacm-docs/rhacm-docs/%%')
        # Ignore errors about level 0 sections when doctype is book since they could be false positives
        if [[ ${message} == " level 0 sections can only be used when doctype is book" ]]; then
          continue
        fi
        echo "::error file=${file_log#./},line=${line_log# line }::${message# }"
      fi
    done
    echo
  fi
done

exit "${exit_code:-0}"
