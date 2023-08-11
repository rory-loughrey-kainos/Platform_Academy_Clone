# Team Exercise 2

## Keep your teams

**There is a diagram in the folder**


* Fork your repository and rename it to show it's Week 4 Exercise 2

* Pull a copy of the forked repository

* Continue to use Git Branches and PRs

* Separate (or create new) tfvars files - One with reference to 'Dev' or 'Development' and one with reference to 'Prod' or 'Live' in the names of resources.

* Dev and Live to sit in the same Region - PER ENVIRONMENT: reduce your EC2 instances to 2 (1 in each private subnet/AZ) 

* Create a Load Balancer to balance any incoming traffic equally across the 2 ec2 instances (and create anything needed to allow internet traffic in)

* Create an Auto Scaling Group for the EC2 instances - allow horizontal scaling of up to 1 extra EC2 instance per AZ

* Create an RDS Database per AZ with Multi-AZ (Sync Replication)