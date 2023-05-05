# Team Exercise 3

## Keep your teams



* Create a CodeBuild Build Project and connect to your GitHub repository using a PAT token.

* Create build jobs: Dev Plan, Dev Apply, Live Plan and Live Apply. All need to make use of the correct tfvars files from Exercise 2

* Create Pipelines: Dev Update, Live Update.

Dev Update runs your Dev Plan job, then asks for manual approval, then runs Dev Apply if approved.
Live Update runs your Live Plan job, then asks for manual approval, then runs Live Apply if approved.