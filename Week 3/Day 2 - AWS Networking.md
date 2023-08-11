# AWS Networking
[https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html]

## VPC and Core Networking

1. What is an AWS VPC?

2. List the features of a VPC with a brief description

3. What are the differences between an Internet Gateway, NAT Gateway & NAT Instance


## DNS (Route 53)

1. What is Route 53 and what are its three main functions?

2. 

3. What is a Hosed Zone and what is the difference between a Public and Private Hosted Zone?

4. Using the AWS CLI, list the records in the <name-of-hosted-zone>


## Elastic Network Interfaces / Elastic IP Addresses

1. What is the purpose of an ENI?

2. When would we want to attach multiple ENIs to an instance?

3. What advantage does an Elastic IP address give when attached to an EC2 instance? 


##  Privatelink & VPC Endpoints

1. What is AWS Privatelink?

2. What AWS Networking resource needs to be deployed to support Privatelink on a VPC?

2. What are VPC endpoints?

3. What are Interface Endpoints? 

4. What are Gateway Endpoints? 
    - How are they different to Inteface Endpoints
    - Name the two services they support


## VPC Peering

1. What is VPC Peering?

2. What are the advantages of using VPC Peering?


## Security Groups & Network ACLs (NACL)

1. What are Security Groups used for in AWS?
    - What are they attached to?
    - Give an example of a SG attached to the interface of an EC2 Instance

2. What is a Network ACL?
    - How many Network ACLs can be associated to a VPC subnet?

3. What are the differences between a SG & NACL?


## Elastic Load Balancing

1. What is Elastic Load Balancing and list its main benefits

2. In what situations should you use the following types of Elastic Loadbalancing?
    - Application Load Balancer (ALB)
    - Network Load Balancer (NLB)
    - Gateway Load Balancer
    - Classic Load Balancer

3. Tutorial: Create an AWS ALB via the CLI [https://docs.aws.amazon.com/elasticloadbalancing/latest/application/tutorial-application-load-balancer-cli.html]


## Cloudfront

1. What is Amazon CloudFront and how does it work?

2. Excerise: Use Terraform to deploy a static website using S3 & Cloudfront

    - Using the example found at [https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/GettingStarted.SimpleDistribution.html], deploy using Terraform
    - You can use the static files at [https://github.com/aws-samples/amazon-cloudfront-secure-static-site] for the content of the static website

