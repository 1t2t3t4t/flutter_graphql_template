#!/bin/bash

./update_graphql_schema.sh

flutter pub run build_runner build || flutter pub run build_runner build --delete-conflicting-outputs
