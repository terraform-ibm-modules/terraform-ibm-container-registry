#!/bin/bash
set -euo pipefail

INPUT=$(cat)
REGION=$(echo "$INPUT" | jq -r '.REGION')
IBMCLOUD_API_KEY=$(echo "$INPUT" | jq -r '.IBMCLOUD_API_KEY')
export IBMCLOUD_API_KEY

if [[ -z "${IBMCLOUD_API_KEY}" || "${IBMCLOUD_API_KEY}" == "null" ]]; then
  echo '{"error": "IBMCLOUD_API_KEY is required"}'
  exit 0
fi

if [[ -z "${REGION}" || "${REGION}" == "null" ]]; then
  echo '{"error": "REGION is required"}'
  exit 0
fi

if ! ibmcloud login -r "${REGION}" --quiet > /dev/null 2>&1; then
  printf '{"error": "Failed to login using: ibmcloud login -r %s"}' "$REGION"
  exit 0
fi

# extract registry value from text "You are targeting region 'us-south', the registry is 'us.icr.io'."
# at the moment `ibmcloud cr region` command does not support JSON output.
registry=$(ibmcloud cr region | grep -o "'[^']*'" | tail -n1 | tr -d "'")

# Validate registry value
if [[ -z "$registry" ]]; then
  echo '{"error": "Failed to parse registry region from ibmcloud cr region"}'
  exit 0
fi

echo "{\"registry\": \"${registry}\"}"
