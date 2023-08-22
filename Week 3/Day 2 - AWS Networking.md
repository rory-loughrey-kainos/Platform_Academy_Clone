# AWS Networking
[https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html]

## VPC and Core Networking

1. What is an AWS VPC?
virtual private cloud - comparable to azure vnet
2. List the features of a VPC with a brief description
subnets
ip addressing - addressing & structure to resource locals
routing - io between resources
gateways - io
peering - between vnets
traffic monitoring - network traffic logs sent to external monitoring
transit gateways - central hub between vpcs
vpc logs - metadata 
vpn connections - private links to on-prem
3. What are the differences between an Internet Gateway, NAT Gateway & NAT Instance
internat gateway - exposes to internet
nat gateway - translates priv-public ip (outpbound only)
nat instance - instance that provides NAT as a service

## DNS (Route 53)

1. What is Route 53 and what are its three main functions?
DNS service (port 53 is dns)
2. 

3. What is a Hosed Zone and what is the difference between a Public and Private Hosted Zone?
hosted zone is a container for records (address book)
public - route traffic on the internet
private - route traffic within AWS backbone/vpc
4. Using the AWS CLI, list the records in the <name-of-hosted-zone>
aws route53 list-resource-record-sets --hosted-zone-id Z05741183MSRC4DP35IFW

## Elastic Network Interfaces / Elastic IP Addresses

1. What is the purpose of an ENI?
acts as a virtual network card, independant from the EC2 instance - more vpc based
2. When would we want to attach multiple ENIs to an instance?
high availability (associate with 2 subnets)
3. What advantage does an Elastic IP address give when attached to an EC2 instance? 
indenpendant from the ec2 instsance, therefore can be re-assigned in the event of a single instance failur, without affecting the rest of the network

##  Privatelink & VPC Endpoints

1. What is AWS Privatelink?
aws backbone vpn = connecting vpc's accross the internal network
2. What AWS Networking resource needs to be deployed to support Privatelink on a VPC?
vpc endpoint - creating eni
2. What are VPC endpoints?
endpoint accessable from beyond the virtual network within the aws landscape
3. What are Interface Endpoints? 
only allow traffic from VPC out to other resources e.g. logs
4. What are Gateway Endpoints? 
    - How are they different to Inteface Endpoints
    s3/ dynamo connection without requiring internet gateways or NAT devices
    - Name the two services they support
    s3 & dynamoDB

## VPC Peering

1. What is VPC Peering?
    Ability to 'link' vpcs accross and between regions
2. What are the advantages of using VPC Peering?
    'Loose linkage'
    can connect & communicate as if they are in the same network, while geographically seperate - replication of data and services globally via the aws backbone

## Security Groups & Network ACLs (NACL)

1. What are Security Groups used for in AWS?
virtual firewall acting as a firewall for EC2 instances, controling in/outgress traffic from an instance
    - What are they attached to?
    attached to an EC2 instnace in a given VPC
    - Give an example of a SG attached to the interface of an EC2 Instance
    restricting to only port 80 inbound to a webserver
2. What is a Network ACL?
        access control rules to a environment - similar to sg's, but allows & denys
    - How many Network ACLs can be associated to a VPC subnet?
        there can only be one
3. What are the differences between a SG & NACL?
    nacls at subnet
    sg at instance level - indivdual EC2 dependant

## Elastic Load Balancing

1. What is Elastic Load Balancing and list its main benefits
    load balancer 101 - distrobutes load/ traffic across targets in group of resources - automatically rsponding to chnges in traffic (elastic)
2. In what situations should you use the following types of Elastic Loadbalancing?
    - Application Load Balancer (ALB)
        high level (layer 7) - http(s) - webserver
    - Network Load Balancer (NLB)
        mid level (layer 4) - ideal for low latency
    - Gateway Load Balancer
    - Classic Load Balancer
        

3. Tutorial: Create an AWS ALB via the CLI [https://docs.aws.amazon.com/elasticloadbalancing/latest/application/tutorial-application-load-balancer-cli.html]


## Cloudfront

1. What is Amazon CloudFront and how does it work?

2. Excerise: Use Terraform to deploy a static website using S3 & Cloudfront

    - Using the example found at [https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/GettingStarted.SimpleDistribution.html], deploy using Terraform
    - You can use the static files at [https://github.com/aws-samples/amazon-cloudfront-secure-static-site] for the content of the static website

