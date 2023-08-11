# Microsoft Azure Overview

## Regions / Availability Zones

<<<<<<< HEAD
[Azure regions and availability zones](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview)(https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview)
=======
[Azure regions and availability zones](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview)
>>>>>>> bafd1cf (removed instructor files (moved to another repo) and moved files out of folder)

1. How many Regions does Azure operate in?

2. What is an Azure Region?

3. What is an Availability Zone?

<<<<<<< HEAD
4. What is an Availability Set and how is it different to an Availability Zone?

## Subscriptions, Resource groups, Management groups

1. What is a Tenant?

2. What is a Subscription?

3. What is a Resource Group?

4. What is a Management Group?


## Azure Active Directory (Azure AD)

[https://learn.microsoft.com/en-GB/azure/active-directory/fundamentals/active-directory-whatis]

1. What is Azure Active Directory?

2. Who uses Azure AD?

3. What are the Azure AD licenses?

4. Which features work in Azure AD?

### Azure Active Directory Excerise

**PLEASE BE CAREFUL IN HERE - YOU ARE ABLE TO DELETE EACH OTHER!!!**

1. Can you each create a user in Active Directory within our Academy Directory with a very unique name (Bonus point for the best name!) and assign them to a security group called 'BKPA 2023 Team *insert team name here*' that you will need to create (1 per team).

2. Set the 'Usage Location' of your user to be 'United Kingdom'

3. Give the user a 'Job Title' and a 'Department'

4. Assign the role of 'User Administrator' to your user

5. Open a new 'Private' tab in your browser, and log in to the Azure Portal using the email/password of your new user.

6. Using the new user - Create another User in Active Directory with the same name (but with a '2' at the end)
=======

## Subscriptions, Resource groups, Management groups

1. What is a Subscription?

2. What is a Resource Group?

3. What is a Management Group?
>>>>>>> bafd1cf (removed instructor files (moved to another repo) and moved files out of folder)


## Azure pricing calculator

[Azure pricing calculator](https://azure.microsoft.com/en-gb/pricing/calculator/)

<<<<<<< HEAD
### Using the Azure Pricing calculator
=======
### Exercise

**Using the Azure Pricing calculator**
>>>>>>> bafd1cf (removed instructor files (moved to another repo) and moved files out of folder)

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
<<<<<<< HEAD
   * Disk Size: P15: 256 GiB
=======
   * Disk Size: S15: 256 GiB
>>>>>>> bafd1cf (removed instructor files (moved to another repo) and moved files out of folder)
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

### Questions

<<<<<<< HEAD
1. What is the lowest price a 'B1s' Virtual Machine could cost per hour in UK South running Ubuntu if you needed the machine for 1 year?
=======
1.  What is the lowest price a 'B1s' Virtual Machine could cost per hour in UK South running Ubuntu if you needed the machine for 1 year?
>>>>>>> bafd1cf (removed instructor files (moved to another repo) and moved files out of folder)

2. For 'Compute' resources, What are the differences between: 'Pay as you go', 'Azure savings plan for compute', 'Reserved Instances' and 'Spot Instances'

3. Find 2 services that don't cost money when they're not doing anything


## Virtual Machines

1. What is VMSS (Virtual Machine Scale Sets) and what are the benefits?

2. What would the use cases be for 'General Purpose', 'Memory optimized' and 'Compute optimized' workload types?

3. You can log on to a VM using SSH from your local machine... But what is Azure Bastion and how does it work?

<<<<<<< HEAD
4. Using this guide [https://learn.microsoft.com/en-us/azure/bastion/quickstart-host-portal], configure Bastion and use it to ssh to your VM from last weeks Task 1 execercise.


## Storage

1. What are 5 types of storage services in Azure?

2. What is Azure Blob storage? Find examples of what it is designed for

3. What are the different types of replication in Azure Storage

4. What are the different Access tiers for data? What do they each do?

5. Using the Azure CLI, create a Storage Account and create, download and list blobs [https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-cl]

   - Resource Group Name: yourname-sa-rg
   - Storage Account: yournamesa
   - Container Name: yourname-files
   - Location: East US
   - SKU: Standard_LRS
   - Encryption-services: blob

Once you have completed the tutorial, clean up your resources.
=======

## Storage

1. What are 5 types of storage in Azure?

2. What are the different types of replication in Azure Storage

3. What are the different Access tiers for data? What do they each do?


## Azure Active Directory: IAM and permissions

1. Can you each create a user in Active Directory within our Academy Directory with a very unique name (Bonus point for the best name!) and assign them to a security group called 'BKPA 2023 Team *insert team name here*' that you will need to create (1 per team).

2. Set the 'Usage Location' of your user to be 'United Kingdom'

3. Give the user a 'Job Title' and a 'Department'

4. Assign the role of 'User Administrator' to your user

5. Open a new 'Private' tab in your browser, and log in to the Azure Portal using the email/password of your new user.

6. Using the new user - Create another User in Active Directory with the same name (but with a '2' at the end)
>>>>>>> bafd1cf (removed instructor files (moved to another repo) and moved files out of folder)
