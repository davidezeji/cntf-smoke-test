# CNTF - Smoke Test

## Purpose
This source code repository stores the configurations to subscribe and connect new UEs to the 5g network and make HTTP requests to webservers over the internet and 5g network.

## Project structure
```
├── open5gs
|   ├── infrastructure                 contains infrastructure-as-code and helm configurations for open5gs & ueransim
|      	├── eks
|           └── fluentd-override.yaml  configures fluentd daemonset within the cluster
            └── otel-override.yaml     configures opentelemtry daemonset within the cluster
|           └── provider.tf
|           └── main.tf                    
|           └── variables.tf                
|           └── outputs.tf 
|           └── versions.tf
|
└── .gitlab-ci.yml                     contains configurations to run CI/CD pipeline
|
|
└── README.md  
|
|
└── open5gs_values.yml                 these values files contain configurations to customize resources defined in the open5gs & ueransim helm charts
└── openverso_ueransim_gnb_values.yml                 
└── openverso_ueransim_ues_values.yml 
|
|
└── ueransim_smoke_test.sh             performs a curl test over both the network and the internet
|
|
└── over5g.json                        local storage file for test results performed on "ueransim-gnb-ues" pod (curl over 5g network)
|
|
└── overinternet.json                  local storage file for test results performed on "ueransim-gnb-ues" pod (curl over internet) 
|
|
└── s3_test_results_coralogix.py       converts local files into s3 objects 
|  
|            
└── ue_populate.sh                     subscribes a ue (user equipment) to the 5g network
|
|
└── update_test_results.sh             updates test result data from "ueransim-gnb-ues" pod both locally and in aws                                           
```

