# AWS Overview

## Regions / Availability Zones

[AWS regions and availability zones](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html)

1. How many Regions does AWS operate in?

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

2. How does IAM work?

3. What are the four key concepts of IAM?

4. Excercise: Using the CLI: 
    - Create a user account with a login password
    - Add it to the ReadOnlyEC2 User Group
    - List the Group attached to your user
    - List the Policies attached to the ReadOnlyEC2 User Group

# Compute

## AWS Elastic Compute Cloud (EC2)
>>>>>>> 54dd87a (Updates and additions to Getting started, Weeks 2 & 3)

Intro to EC2
[https://www.youtube.com/watch?v=TsRBftzZsQo]

[https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html]


1. What is Amazon EC2?

2. What are the high-level features of EC2?

3. Describe the four different storage options availble to EC2 instances

4. Excercise: Tutorial Amazon Linux 2023
    - Stand up Amazon Linux 2023 instance from getting started tutorial
    - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html

## AWS Elastic Container Service (ECS)

1. What is AWS ECS?

2. How many container platforms does ECS support?

3. What advantages does running ECS with AWS Fargate give?

# Storage

## AWS Simple Storage Service (S3)
>>>>>>> 54dd87a (Updates and additions to Getting started, Weeks 2 & 3)

1. What is AWS S3?

2. Describe the following S3 storage classes 
    - S3 Standard
    - S3 Standard Infrequent Access 
    - S3 Standard Reduced Redundancy Storage
    - S3 Intelligent-Tiering
    - Glacier
    - One Zone Infrequent Access

3. What are the two Lifecycle Management actions and how do they differ?

4. What is a S3 Bucket Policy and find out two common uses for it

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
>>>>>>> 54dd87a (Updates and additions to Getting started, Weeks 2 & 3)

1. What is AWS Lambda?

2. Whats the advantages of Lambda over EC2?

3. Find out 5 different code languages that AWS Lambda supports natively 

4. Excerise: Using an Amazon S3 trigger to invoke a Lambda function. Take a look at the excerise below, but use Terraform to configure and provision resources
[https://docs.aws.amazon.com/lambda/latest/dg/with-s3-example.html]

    - Lambda name: s3-logging-<yourname>
    - S3 Bucket name: s3-upload-<yourname>
    - Lambda IAM Role name: lambda-role-<yourname>



