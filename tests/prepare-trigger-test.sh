#!/bin/sh
set -e

# Host to use. Needs to include the protocol.
host=$1
# Credentials to use for the test. USER:PASS format.
credentials=$2
# Name of the trigger to create and test.
trigger=$3

# create a noop trigger
echo "Creating trigger $trigger"
curl -u "$credentials" "$host/api/v1/namespaces/_/triggers/$trigger&overwrite=true" --insecure -XPUT -d '{"name":"$trigger"}' -H "Content-Type: application/json"

# fire the noop trigger
echo "Running $trigger once to assert an intact system"
curl -u "$credentials" "$host/api/v1/namespaces/_/triggers/$trigger" --insecure -XPOST