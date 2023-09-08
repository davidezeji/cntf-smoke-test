#!/usr/bin/env bash
set -x # run in debug mode (see every step of script printed on console)
set -e # quit script as soon as an error occurs
set -o pipefail # ensure failure of pipe commands is accurately accounted for

POPULATE_POD=$(kubectl -n openverso get pod --output=jsonpath={.items..metadata.name} -l app.kubernetes.io/component=populate)

install_dependencies () {
    apt update
    apt install -y curl
    curl --version
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    mv kubectl /usr/local/bin/
    kubectl version --client
    curl -LO https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz
    tar -zxvf helm-v3.7.0-linux-amd64.tar.gz
    mv linux-amd64/helm /usr/local/bin/helm
    helm version
}

digits=10
a=$(date +%s)
b=$((a*RANDOM))

while [ ${#b} -lt 12 ]; do
    b="${b}$RANDOM"
done

IMSI_ID=$(echo "${b:0:digits}")
printf $IMSI_ID

install_dependencies

{ time -p kubectl -n openverso exec $POPULATE_POD -- open5gs-dbctl add_ue_with_slice ${CI_PIPELINE_ID} 465B5CE8B199B49FAA5F0A2EE238A6BC E8ED289DEBA952E4283B54E88E6183CA internet 1 111111; } 2>&1 | grep real | awk '{print "creation_time_db: " $2}' >> time_to_populate_database.txt

