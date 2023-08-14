# Microsoft Azure Overview

## Regions / Availability Zones

[Azure regions and availability zones](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview)(https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview)

[Azure regions and availability zones](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview)

1. How many Regions does Azure operate in?
60 +
2. What is an Azure Region?
(multiple) datacentres deployed within a latency-defined perimeter (geography)
3. What is an Availability Zone?
within (some) regions, seperate, isolated, syncable data centres for fault tolerance/ DR purposes
4. What is an Availability Set and how is it different to an Availability Zone?
grouping of VMs to increase fault tolerance -> places VMs in differing fault domains (fault domain is the domain of common power & networking for all contained VMs)
## Subscriptions, Resource groups, Management groups

1. What is a Tenant?
dedicated instance of Azure AD that an organization or app developer receives at the beginning of a relationship with Microsoft
2. What is a Subscription?
Azure Subscriptions are a logical unit of Azure services that are linked to an Azure account.
Therefore allow multiple billing/ subaccoutns within a single organisation account
3. What is a Resource Group?
a container that holds related resources for an Azure solution. Actually contains spun up resoruces
4. What is a Management Group?
manage access, policy, and compliance across multiple subscriptions. Essentially RBAC

### Azure Active Directory Excerise

**PLEASE BE CAREFUL IN HERE - YOU ARE ABLE TO DELETE EACH OTHER!!!**

1. Can you each create a user in Active Directory within our Academy Directory with a very unique name (Bonus point for the best name!) and assign them to a security group called 'BKPA 2023 Team *insert team name here*' that you will need to create (1 per team).

2. Set the 'Usage Location' of your user to be 'United Kingdom'

3. Give the user a 'Job Title' and a 'Department'

4. Assign the role of 'User Administrator' to your user

5. Open a new 'Private' tab in your browser, and log in to the Azure Portal using the email/password of your new user.

6. Using the new user - Create another User in Active Directory with the same name (but with a '2' at the end)

## Azure pricing calculator

[Azure pricing calculator](https://azure.microsoft.com/en-gb/pricing/calculator/)

### Using the Azure Pricing calculator
### Exercise

**Using the Azure Pricing calculator**

In this exercise, you will create a price estimate with the Azure Pricing calculator; the estimate will be for a simple single-instance Windows VM hosted in the North Europe (Dublin) region.

1. Open a browser and sign into the Azure pricing calculator using your Microsoft account: https://azure.microsoft.com/pricing/calculator.

2. From the products tab, click Virtual Machines.

3. Scroll down to the VM line item that has been added to the estimate.

4. Adjust the default VM settings to the following for this exercise (or as required):

   * Region: North Europe.
   * Operating System: Windows.
   * Type: (OS only).
   * Tier: Standard.
   * Category: General purpose.
   * Instance Series: Dds v4-series (or as required).
   * Instance: D2ds v4 (or as required).
   * Virtual Machines: Leave as qty of 1 and running for 730 hours.
   * Leave Savings options as is.

5. Expand Managed Disks and adjust the default settings to the following for this exercise:

   * Tier: Premium SSD
   * Disk Size: P15: 256 GiB
   * Disk Size: S15: 256 GiB
   * Disks (qty): 1
   * Leave Storage Transactions as is.

6. Expand Bandwidth and adjust the default settings to the following for this exercise:

   * Data transfer type: Internet egress
   * Source region: North Europe
   * Routed via: Microsoft Global Network
   * Outbound data transfer: 10 GiB
   * Leave Support as is.
   * Leave Programmes and Offers as is.
   * From the bottom right of the estimate screen, set the currency as required.

7. From the bottom left of the Estimate screen, click Save as and enter a name for your estimate. You will see a message stating that the estimate has been saved and that it can be viewed by clicking on the Saved estimates tab. Click Done.
    * To export the estimate, click Export.
    * To share the estimate, click Share.

https://azure.com/e/3d31ecea20b749519f34f159da4a0782

### Questions

1. What is the lowest price a 'B1s' Virtual Machine could cost per hour in UK South running Ubuntu if you needed the machine for 1 year?
https://azure.com/e/d09a9dcf348f4bd8834431dfe22c1731

2. For 'Compute' resources, What are the differences between: 'Pay as you go', 'Azure savings plan for compute', 'Reserved Instances' and 'Spot Instances'

PAYG - Pay for compute capacity by the second
Savings plan - committing to spend a fixed hourly amount for 1 or 3 years
Reserved - reserving specific types/ quantity of compute -> cheaper but less flexible than savigns plans
Spot - Buy unused Azure compute capacity at deep discounts to run interruptible workloads - not always available

4. Find 2 services that don't cost money when they're not doing anything
Advisor
Static Web Apps

## Virtual Machines

1. What is VMSS (Virtual Machine Scale Sets) and what are the benefits?
Azure Virtual Machine Scale Sets let you create and manage a group of load balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule.

All VMs are identical, allowing for them to be spun up/ shut down as well as interact with in a known way.
Traffic across the (many) VMs is done via load balancers to ensure even loading across the set

2. What would the use cases be for 'General Purpose', 'Memory optimized' and 'Compute optimized' workload types?
general purpose - catchall system types including testing/dev small dbs and low-med web traffic with balanced compute-memory
memory optimised - high memory intensive opperations e.g. (volitile) dbs, caches, and in-memory analytics
compute optimised - high opperation instances such as high web traffic request volumes, network appliances, and low latency apps
4. You can log on to a VM using SSH from your local machine... But what is Azure Bastion and how does it work?
Fully managed RDP/ SSH
Allows access to VMs without exposing endpints to public internet, instead going through the azure portal
Doesnt require any additonal setup VM side. Behaves (from VM perspective) as standard SSH/ RDP connections
6. Using this guide [https://learn.microsoft.com/en-us/azure/bastion/quickstart-host-portal], configure Bastion and use it to ssh to your VM from last weeks Task 1 execercise.


## Storage

1. What are 5 types of storage services in Azure?
Blob - Object based storage - scalable and primarily designed for datalake style work
Files - managed file shares for cloud OR on-prem. More traditional file hosting w/ lift and shift
Queue - primarily for messages, up to 64k in size. Allows requests/ communication between apps & components 
Table - No-SQL structured data store (classic key-pair style) - also can now use Cosmo for tables
Managed Disks - block level storage for VMs. Emulate physical drive in on-prem setting

3. What is Azure Blob storage? Find examples of what it is designed for
binary blob of unstructured data, useful as a mixed media store as can handle almost all file types/ sizes.
Also useful for;
- backups
- analysis pools (in analytics pipeline where size may not be known
- log files
- rich media 

5. What are the different types of replication in Azure Storage
- always has multiple copies of data stored
- local (same region)
  - exists in at least 3 places (locally redundant sotorage) 11 9's
  - accross 3 availability zones (zone redundant storage) 12 9's
  - 
-secondary
  - geo-redundancy 3 times locally + single location in 2nd region 16 9's
  - geo-zone-redundancy 3 availability zones using ZRS, + 2nd region x3 16 9's
6. What are the different Access tiers for data? What do they each do?
 
Hot - high freq access, highest storage cost /gb
Cool - infrequent (min 30 days storage) 
Cold - lesser access, at least 90 days
Archive - offline tier (tape) 180 days +

7. Using the Azure CLI, create a Storage Account and create, download and list blobs [https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-cl]

   - Resource Group Name: yourname-sa-rg
   - Storage Account: yournamesa
   - Container Name: yourname-files
   - Location: East US
   - SKU: Standard_LRS
   - Encryption-services: blob

Once you have completed the tutorial, clean up your resources.
