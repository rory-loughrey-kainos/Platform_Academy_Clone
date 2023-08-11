# Team Exercise

## Split into Team A & Team B


* Create a GitHub Repository and share it between you all.

* Everyone clone the Repo to your local Laptop.

* Create an S3 bucket in AWS and make sure it includes either 'Team A' or 'Team B'.

* One person share your screen and create a basic provider tf file in the repo and then store the Remote State in AWS.

* Push the code back to GitHub

* Everyone do a git pull

* All work going forward needs to be done 1 step at a time and using branches and Pull Requests to review and merge code into the master branch before running the code on one machine to apply the resources to AWS.

* All resources to have a default tag of either 'Team A' or 'Team B'

* Use the following module to create a VPC [https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)

* Create 3 EC2 instances - one in each of the public subnets using object mapping

* Create 3 EC2 instances one in each of the private subnets using object mapping

* Each Public EC2 instance must be able to connect via private IP to the corresponding box in the private subnet AZ and act as a Bastion

* Think about any other resources that you will need in order to achieve the above... Can some of your previous code be copied and reused?

* Once complete - any hard coded information that you think could/should be a variable should now me turned into variables... BUT, not in a variables.tf file. I want you to create a tfvars file and then feed this tfvars file into a 'terraform apply' and make sure that there are no changes to your resources when you run this.