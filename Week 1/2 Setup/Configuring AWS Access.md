## AWS Management Console SSO

1. Open https://apps.kainos.com and sign in with you Kainos credentials

2. Click on AWS Single Sign On and you should see 2023-Summer-Platforms-Academy-Belfast listed, expand it, click on Management Console

## AWS CLI SSO

1. First ensure you have the latest version of the AWS CLI & pipx installed as listed in 'Install list.md' doc

2. From your terminal run 'aws configure', leave AWS Access Key ID & AWS Secret Access Key blank

    - AWS Access Key ID [None]: 
    - AWS Secret Access Key [None]: 
    - region name [None]: eu-west-1
    - Default output format [None]: json

3. Open the aws config file and paste in the following config below the default profile. (Located in </your-home-folder>/.aws/)

    - [profile KPA-Belfast-23]
    - sso_start_url = https://kainos.awsapps.com/start#
    - sso_account_id = 138588690193
    - sso_region = eu-west-1
    - sso_registration_scopes = sso:account:access
    - sso_role_name = AdministratorAccess
    - credential_process = aws-sso-util credential-process --profile KPA-Belfast-23
    - sso_auto_populated = true
    - region = eu-west-1
    - output = json

4. Install the aws sso untilities and the Awsume tools. Run the awsume-configure tool to setup awsume with defaults.
    
    - pipx install aws-sso-util
    - brew install awsume
    - awsume-configure

5. Login to the SSO account, your browser will open and ask for permission, click Allow

    - aws-sso-util login

6. Assume the sso session in your terminal using awsume

    - awsume KPA-Belfast-23

7. Check that you are logged in with the 'aws sts get-caller-identity' command

9. Anytime you wish to get a session run the 'aws-sso-util login' & 'awsume KPA-Belfast-23' commands again. You can use 'awsume -l' to view configured profiles
    - aws-sso-util: logs you on to AWS
    - awsume: allows your terminal to use the SSO session
