# Microsoft Azure Networking

## VNets

1. What is a VNET and why is it used?
Virtual network that is used to run VMs etc in the cloud within a 'closed' environment
2. What are the 2 types of VNet Peering and why are they used?

Virtual Network Peering - same region 
Global Virtual Peering - accross regions

Reasons:
low latency, high bandwidth connections between different vnets
visability & data transfer between vnets, subscriptions, tenents & region (if global)

All private by default (encrypted)

4. What do you need to assign in order to allow inbound traffic to a resource from the internet?

public IP or load balancer
    
## Private/Public IP Addressing / Subnets

1. What are Private and Public IP Addresses?

Public allow internet resources to communicate inbound to Azure & Azure outbound

Privata allows communication between resources in Azure

2. If I created a subnet range of 10.10.0.0/16, which reserved IP Addresses would be unavailable to allocate? What does the /nn mean?

/16 is 16 bit left mask

2^16 addresses available

AZ takes first 4, and last addresses

10.10.0.4 - 10.10.255.254 available

3. [Exercise: Creating a VNET/VM Public IPs](https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%204)

## VPN gateway

1. What is Azure VPN Gateway?

Used to send encrypted traffic between AZ virt network and on-prem over the internet

2. How many Azure VPN Gateways can an Azure virtual network support?

Uno

3. A VPN Gateway needs IP Addresses to use - what do you need to create in order to have IP Addresses available for the VPN Gateway?

Gateway Subnet

4. What are the two Gateway types and what are their use cases?

VPN - encrypted traffic accross public internet (s2s, p2p, or Vnet-2-Vnet)
usecase - secure cnet access remotely
 
ExpressRoute - extends on-prem to microsoft network via partner networks (not public internet). Also at lower level (layer 3), built in redundnacy & higher bandwidth
usecase - enterprise class access (mission critical with slas for uptime etc)

## Express Route (Theory)

1. What is Azure ExpressRoute?

## Azure VNet Peering

1. What are the two types of Azure Virtual Network Peering and what are their differences?

2. [Exercise: Configuring Peering](https://learn.microsoft.com/en-us/azure/virtual-network/tutorial-connect-virtual-networks-portal)

## DNS - Public & Private

1. What is Azure DNS?

2. [Exercise: Public DNS](https://learn.microsoft.com/en-us/azure/dns/dns-getstarted-portal)

3. [Exercise: Private DNS](https://learn.microsoft.com/en-us/azure/dns/private-dns-getstarted-portal)

2. [Public DNS Exercise](https://learn.microsoft.com/en-us/azure/dns/dns-getstarted-portal)

3. [Private DNS Exercise](https://learn.microsoft.com/en-us/azure/dns/private-dns-getstarted-portal)

## Virtual Network Service Endpoints

1. What are Virtual Network Service Endpoints?

2. What are the benefits of using them?

3. What services support Endpoints?


## Azure Security: Security centre, KeyVaults, NSGs etc

[https://learn.microsoft.com/en-us/azure/security/fundamentals/overview](https://learn.microsoft.com/en-us/azure/security/fundamentals/overview)

1. What is KeyVault? What are the 3 object types you can store?

Secure 'repo' for protected credentials in the cloud
supports storing;
- software or HSM-backed keys
- secrets
- certs

2. [Exercise: Create a Keyvault](https://learn.microsoft.com/en-us/azure/key-vault/secrets/quick-create-portal)

3. What is an NSG?

Network security group filters traffic between Az resources WITHIN vnets. NSGs consist of rules allowing/ denying inbound/outbound traffic based on port, protocol, source and destination

4. [Exercise: Create a NSG](https://learn.microsoft.com/en-us/azure/virtual-network/tutorial-restrict-network-access-to-resources)

2. [Exercise](https://learn.microsoft.com/en-us/azure/key-vault/secrets/quick-create-portal)

3. What is an NSG?

4. [Exercise](https://learn.microsoft.com/en-us/azure/virtual-network/tutorial-restrict-network-access-to-resources)

## Azure landing zone  - Hub/spoke setup and sharing components between services

1. What is an Azure landing zone? [Video](https://www.microsoft.com/en-us/videoplayer/embed/RE4xdvm?postJsllMsg=true)

1st step to migration, defined best practices to use as a jumping off point for a more bespoke cloud deployment.
Stable base & all basics included to build out.
including; 
- Networking - ip address mapping, firewalls, routing etc
- ID management - keys, sso, RBAC
- Governance - policies, compliance (legal & bespoke/corporate)
- Security - threat monitoring/ detection, data security, protective measures (encryption)
- Management - Monitoring, DR, logging 

2. What is Hub and Spoke?

Central (hub) that controls network io, between internet, on-prem or spokes
including; AD, DNS, Flow Control, Firewall(s), VPNs, Access controls

Modular spokes attached in order to accomplish certain (possibly bespoke) workloads or manage environments
including; load balanced VM pool, additional access controls, seperate VNETs
## Azure firewalls

1. How many sku types of Azure Firewall are there and what are the differences between them?

3 skus; Basic, Standard, Premium

"> money, > bandwidth"
THreat detection for standard + enriched at premium
DNS & filtering locked at basic level

## Azure Loadbalancering Services

## Load balancer
1. When should we use an Azure Load Balancer?

when expecting changes in demand ofr a service (such as web portal), allowing for distrobution of flow over multiple service nodes

- can also be used when possibility of downtime/ to aid redundancy i.e. to allow continuity of service during updates

2. What are the four components that need to be configured in order to implement a Load Balancer?

frontend IP config (pub or private)
backend pool (group of services that are being balanced)
health probe to monitor health of pool
load balancer ruleset to defien traffic i/o

3. [Excercise Create Loadbalancer](https://learn.microsoft.com/en-gb/azure/load-balancer/quickstart-load-balancer-standard-public-portal)

## Application Gateway

1. What is an Application Gateway and how is it different to an Azure Load Balancer?

2. What additional setting can be implemented to improve security?

## Front Door

1. What is Azure Front Door?

magic CDN that allows for a backend to to cached

2. [Bonus exercise](https://learn.microsoft.com/en-us/azure/frontdoor/quickstart-create-front-door)
## Traffic Manager

1. What is Azure Traffic Manager and when should it be used?
