#!/usr/bin/env bash

POPULATE_POD=$(kubectl -n openverso get pod --output=jsonpath={.items..metadata.name} -l app.kubernetes.io/component=populate)

update_local_files () {
    kubectl cp -n openverso $POPULATE_POD:/time_to_populate_database.txt ./time_to_populate_database.txt
}

update_local_files
