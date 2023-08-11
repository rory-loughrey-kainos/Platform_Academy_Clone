## Azure Portal Access

1. Open https://portal.azure.com and sign in with you Kainos credentials

## Azure CLI

1. Ensure you have the latest version of the Azure CLI installed first

2. Run the 'az login' command, your browser will prompt you for you Kainos credentials

3. Get the subscription ID and set it

    ```
    az account list
    az account set --subscription 2023-Summer-Platforms-Academy-Belfast
    ```

4. Run 'az account show' to verify it has been set.