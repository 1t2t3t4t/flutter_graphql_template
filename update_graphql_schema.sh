#!/bin/bash

GRAPHQL_ENDPOINT=https://countries.trevorblades.com
SCHEMA_PATH=./lib/graphql/schema.graphql

apollo client:download-schema --endpoint=$GRAPHQL_ENDPOINT $SCHEMA_PATH