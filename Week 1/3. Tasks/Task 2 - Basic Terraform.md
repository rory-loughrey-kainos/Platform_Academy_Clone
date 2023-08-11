## Terraform Basics

# What is terraform? 
<<<<<<< HEAD
Infrastructure as code tool that we use to automate the deployment of infrastructure tasks.

# Install and check Terraform commands

You should have terraform already configured from the earlier installation tasks but confirm so by running the version command
```
terraform -v
```

Further info of common terraform commands can be found running the help command
    
```
terraform -help
terraform <command> -help
```

## Creating your first project - Hello World
=======
Infrastrucute as code tool that we use to automate the deployment of infrastructure tasks.

# Install and check Terraform commands

You should have terraform already configured from the eariler installation tasks but confirm so by running the version command

    terraform -v

Further info of common terraform commands can be found running the help command

    terraform -help
    terraform <command> -help

## Creating your first project - Hello 
>>>>>>> b831e2b (Updating basic terraform task in week 1)

A Terraform project is just a set of files in a directory containing resource definitions - these files end with the .tf extension

1. Create new folder called 'hello_terraform' and create main.tf file inside it
<<<<<<< HEAD

2. Within the main.tf file copy in the code below:

    ```
=======
2. Within the main.tf file copy in the code below:

>>>>>>> b831e2b (Updating basic terraform task in week 1)
    provider "local" {}

    resource "local_file" "hello" {
        content = "Hello, World"
        filename = "hello.txt"
    }
<<<<<<< HEAD
    ```

 3. Run 'terraform init' to initialize the project - what happens after you have ran this command?

 4. Run 'terraform plan' to plan the build of the project - what is the output?

 5. Run 'terraform apply' build the build of the project - what is the result?

 6. Finally if we wanted to destroy the resources created by terraform, what command could we run? Is there a way to plan this action?

 terraform destroy

 7. How can we use terraform input variables to replace some of the hardcoded elements of the code? Create a variable to replace the content and filename.

 8. Finally, we should be able to output the filename as a terraform output resource, how can we do this?
=======

 3. Run 'terraform init' to initalise the project - what happens after you have ran this command?
 4. Run 'terraform plan' to plan the build of the project - what is the output?
 5. Run 'terraform apply' build the build of the project - what is the result?
 6. Finally if we wanted to destroy the resources created by terraform, what command could we run? Is there a way to plan this action?
 7. How can we use terraform input variables to replace some of the hardcoded elements of the code? Create a variable to replace the content and filename.
 8. Finally, we should be able to output the filename as a terrafrom output resource, how can we do this?
>>>>>>> b831e2b (Updating basic terraform task in week 1)


## Recreate the VM from Task 1 - Simple Webserver

For this exercise we're going to recreate the Apache2 web server from Task 1 as an AWS EC2 instance using terraform. Use the Terraform Registry for more detailed information related to the AWS provider and its resources - https://registry.terraform.io/providers/hashicorp/aws/latest/docs

<<<<<<< HEAD
The main objectives are

- Create the EC2 VM
- Create the networking settings and give it a public IP
- Configure the security group settings for http access to the webserver
- Use terraform tfvars file to define the server & aws config

# Using terraform to create your webserver 

1. Create new folder to store the terraform files - simple_webserver

2. It is recommended to create the following files inside the folder and use them as described:
    - provider.tf - declare the latest AWS terraform provider
    - main.tf - this should contain code for the creation of your EC2 instance
    - vpc.tf - this should contain code for the networking configuration
    - sg.tf - this should contain code for the security group configuration
    - variables.tf - terraform variables should be declared in here
    - outputs.tf - any outputs required should be here (for this task we only need to output the public IP address of your new EC2 instance)
    - aws.tfvars - use a tfvars files to define the value of your variables.
    - locals.tf - this is for local variables, optional to use but try using one or two locals to avoid hardcoding.

3. Its good practice to keep your code well formatted, what terraform command can we use to achieve this?

4. Initialise your terraform project and run the validate command

5. Plan and apply your code to create your webserver. Any issues during the plan/apply stage go back and debug

## Extra steps - 
You can complete these whenever you have your webserver up and you can resolve the apache2 landing page
### Configuring SSH access

1. How can you configure your EC2 instance to accept an ssh key created form your laptop?

2. What else would we need to configure to achieve ssh access?

### Updating your webserver

1. Using terraform how can you updated your EC2 instance with an additional data disk?

2. If we want to use an AWS Spot instance, how can your EC2 instance be updated?

3. How can you update your terraform in order for the EC2 instance to make use of availability zones?

4. How can you configure the public IP address to remain the same after plan/apply recreates the ec2 instance?

=======
# Using terraform to create your webserver 

1. Create new folder to store the terraform files - simple_webserver
2. It is recommended to create the following files inside the folder and use them as described:
    - provider.tf - declare the latest AWS terraform provider
    - main.tf - this should contain code for the creation of your EC2 instance
    - vpc.tf - this should contain code for the netorking configuration
    - sg.tf - this should contain code for the security group configuration
    - variables.tf - terraform variables should be delcared in here
    - outputs.tf - any outputs required should be here (for this task we only need to output the public IP address of your new EC2 instance)
    - aws.tfvars - use a tfvars files to define the value of your variables.
3. Its good practice to keep your code well formatted, what terraform command can we use to achieve this?
4. Initialise your terraform project and run the validate command
5. Plan and apply your code to create your webserver

# Configuring SSH access

1. How can you configure your EC2 instance to accept an ssh key created form your laptop? 
2. What else would we need to configure to achieve ssh access?


# Updating your webserver

1. Using terraform how can you updated your EC2 instance with an additional data disk?
2. If we want to use an AWS Spot instance, how can your EC2 instance be updated?
3. How can you update your terraform in order for the EC2 instance to make use of availability zones?
>>>>>>> b831e2b (Updating basic terraform task in week 1)
