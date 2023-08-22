#!/bin/bash

set -euo pipefail

RESOURCE_GROUP_ID="$1"

# Expects the environment variable $IBMCLOUD_API_KEY to be set
if [[ -z "${IBMCLOUD_API_KEY}" ]]; then
    echo "API key must be set with IBMCLOUD_API_KEY environment variable" >&2
    exit 1
fi

if [[ -z "${RESOURCE_GROUP_ID}" ]]; then
    echo "Resource_group_id must be passed as second input script argument" >&2
    exit 1
fi

# Login to ibmcloud with cli
attempts=1
until ibmcloud login -q -g "${RESOURCE_GROUP_ID}" || [ $attempts -ge 3 ]; do
    attempts=$((attempts+1))
    echo "Error logging in to IBM Cloud CLI..." >&2
    sleep 5
done

# Reset IBM Container Registry plan
attempts=1
until ibmcloud icr plan-upgrade standard || [ $attempts -ge 3 ]; do
    attempts=$((attempts+1))
    echo "Error upgrading container registry plan..." >&2
    sleep 5
done
