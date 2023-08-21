# AWS Overview

## Regions / Availability Zones

[AWS regions and availability zones](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html)

1. How many Regions does AWS operate in?

28 +

2. Desribe the difference between the following:
    - AWS Region
    - AWS Availibility Zones
    - AWS Local Zones
    - AWS Regional Edge Caches

2. Excercise: Using the AWS CLI, find the following information:
    - List all regions in AWS
    - List regions that are enabled on your AWS Account
    - Get the display name of eu-west-1
    - List the Availibilty Zones in eu-west-1

## AWS IAM

[https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html](https://docs.aws.amazon.com/cli/latest/reference/iam/)

1. What is IAM?
    - Identiy access management - what it says on the tin
    - defines users, access, and permissions
2. How does IAM work?
    - centrally managed auth/access controls
    - ![image](https://github.com/rory-loughrey-kainos/Platform_Academy_Clone/assets/141819259/e02be4b9-ac99-4128-9af1-5cdc896af0ff)
3. What are the four key concepts of IAM?
    - resources - user, group, role, policy, and identity provider objects that IAM stores
    - identities - identify & group resource objects
    - entities - objects used to authenticate - users & roles
    - principals - person or app that uses IAM to be federated onto AWS 
4. Excercise: Using the CLI: 
    - Create a user account with a login password
    - Add it to the ReadOnlyEC2 User Group
    - List the Group attached to your user
    - List the Policies attached to the ReadOnlyEC2 User Group

# Compute

## AWS Elastic Compute Cloud (EC2)

Intro to EC2
[https://www.youtube.com/watch?v=TsRBftzZsQo]

[https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html]


1. What is Amazon EC2?
    - Essentially AWS VMs
2. What are the high-level features of EC2?
    - deploying pre-built or custom images to run compute workloads
    - can attach services such as storage, as well as clustering VMs
3. Describe the four different storage options availble to EC2 instances
    - EBS - elastic block store (equiv of v-disks)
    - S3 - general blco storage
    - EFS - extended file service - useful for fileshares
    - EC2 instance store - temp storage directly connected to instance (local on instance therefore volatile with instance)
4. Excercise: Tutorial Amazon Linux 2023
    - Stand up Amazon Linux 2023 instance from getting started tutorial
    - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html

## AWS Elastic Container Service (ECS)

1. What is AWS ECS?
   
3. How many container platforms does ECS support?

4. What advantages does running ECS with AWS Fargate give?

# Storage

## AWS Simple Storage Service (S3)

1. What is AWS S3?
   Simple blob storage - used for shared/ basic storage

2. Describe the following S3 storage classes 
    - S3 Standard
      - default, low latency
    - S3 Standard Infrequent Access
      - long lived, less frequent access 
    - S3 Standard Reduced Redundancy Storage
      - non-crit data
    - S3 Intelligent-Tiering
      - behind the scenes magic, moves data dynamically according to user defined rules
    - Glacier
      - (now tiered) archival storage - payed retrieval
    - One Zone Infrequent Access
      - infrequent access, stays in single zone (price or regulatory reasons)

3. What are the two Lifecycle Management actions and how do they differ?

4. What is a S3 Bucket Policy and find out two common uses for it
   - IAM policy to allow/ deny principle permissions
   - To enforce connection standards - e.g. TLS version
   - To enforce encryption

# Databases

## AWS Relational Database Service (RDS) 

[https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html]

1. What is RDS?

2. What is a RDS DB instance & Describe the following components of RDS DB instance:
    - DB engines
    - DB instance classes
    - DB instance storage

## Amazon DynamoDB (NoSQL)

1. What is DynamoDB and what is it used for?

2. What are the advantages of using DynamoDB?

## Excercise: Create a Web server with a RDS DB Instance

[https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/TUT_WebAppWithRDS.html]

Follow the tutorial on docs.aws.amazon.com to stand up an LAMP Web Server that uses RDS to host its MariaDB Instance

- Web server
    - Name: lamp-server-<yourname>
    - AMI: Amazon Linux 2023
    - 64bit Architecture
    - Instance type: t2.micro
    - Networking
        - VPC and subnet: default
        - Auto public IP
        - Allow SSH from my IP
        - Security group name: lamp-server-<yourname>-sg
    - Storage: 1 x 8GB gp3

- RDS Instance
    - DB Engine: MySQL
    - Template: Free Tier
    - DB instance identifier: db-instance-<yourname>
    - Master username:<yourname>
    - Auto generate a password: false
    - Master password:<enter a password>
    - Instance configuration
        - Burstable classe: db.t3.micro
        - Storage: GP SSD, 20GiB
        - Enable storage autoscaling: false
    - Connectivity
        - Connect to an EC2 compute resource: true
        - ECS Instance: Instance ID of lamp-server-<yourname>
        - DB subnet group
            - Choose existing: default
        - VPC security group
            - Create new
            - VPC security group name: db-instance-<yourname>-sg
    - Database authentication: Password Auth
    - Additional configuration
        - Initial database name: sample
        - Backup: false

# Serverless

## AWS Lambda

1. What is AWS Lambda?

2. Whats the advantages of Lambda over EC2?

3. Find out 5 different code languages that AWS Lambda supports natively 

4. Excerise: Using an Amazon S3 trigger to invoke a Lambda function. Take a look at the excerise below, but use Terraform to configure and provision resources
[https://docs.aws.amazon.com/lambda/latest/dg/with-s3-example.html]

    - Lambda name: s3-logging-<yourname>
    - S3 Bucket name: s3-upload-<yourname>
    - Lambda IAM Role name: lambda-role-<yourname>



