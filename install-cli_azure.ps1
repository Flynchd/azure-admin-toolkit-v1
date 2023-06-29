# Check if Azure CLI is installed
if (!(az --version)) {

    # Download the install script from Microsoft
    Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi

    # Install Azure CLI
    Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

    # Remove the installer
    Remove-Item .\AzureCLI.msi
}

# Test the Azure CLI
az version
