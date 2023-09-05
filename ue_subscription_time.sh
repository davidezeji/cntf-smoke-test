#!/usr/bin/env bash

digits=10
a=$(date +%s)
b=$((a*RANDOM))

while [ ${#b} -lt 12 ]; do
    b="${b}$RANDOM"
done

IMSI_ID=$(echo "${b:0:digits}")
printf $IMSI_ID

# exec into populate pod and create UE subscription with that number
POPULATE_POD=$(kubectl -n openverso get pod --output=jsonpath={.items..metadata.name} -l app.kubernetes.io/component=populate)
time $(kubectl -n openverso exec $POPULATE_POD --  open5gs-dbctl add_ue_with_slice ${CI_PIPELINE_ID} 465B5CE8B199B49FAA5F0A2EE238A6BC E8ED289DEBA952E4283B54E88E6183CA internet 1 111111) > time_to_populuate_database.txt
# write the IMSI_ID as an artifact to be used in later jobs
echo $IMSI_ID > IMSI_ID
