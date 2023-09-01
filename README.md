# CNTF - Smoke Test

## Purpose
This source code repository stores the configurations to subscribe and connect a new UE to the 5g network and make multiple HTTP requests to webservers. This test will simulate HTTP requests being made while the UE is both connected & disconnected from the 5g network. This gives baseline insights to how well data is sent/received by using the network vs without using the network.

## Deployment
Prerequisites:

* *Please ensure that you have configured the AWS CLI to authenticate to an AWS environment where you have adequate permissions to create an EKS cluster, security groups and IAM roles*: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html
* *Please ensure that the "CNTF-Main" branch has been deployed, as this ensures that the cluster and other necessary AWS infrastructure are available to support the execution of scripts in this repository.*  

Steps:
1. Mirror this repository in Gitlab or connect this repository externally to Gitlab 
2. Authenticate Gitlab with AWS: https://docs.gitlab.com/ee/ci/cloud_deployment/
3. In Gitlab, click the drop-down arrow next to "Build" and select "Pipelines"
4. In the top right hand corner select "Run Pipeline"
5. In the drop-down under "Run for branch name or tag" select the appropriate name for this branch and click "Run Pipeline"
6. Once again, click the drop-down arrow next to "Build" and select "Pipelines", you should now see the pipeline being executed

## Project structure
```
├── open5gs
|   ├── infrastructure                 contains infrastructure-as-code and helm configurations for open5gs & ueransim
|      	├── eks
|           └── fluentd-override.yaml  configures fluentd daemonset within the cluster
|           └── otel-override.yaml     configures opentelemtry daemonset within the cluster
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
└── ueransim_smoke_test.sh             performs a curl test over both the 5g network and the internet
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

