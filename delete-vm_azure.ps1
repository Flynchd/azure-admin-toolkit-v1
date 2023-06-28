# Variables
$ResourceGroupName = 'MyResourceGroup'

# Delete Resource Group and all its resources
Remove-AzResourceGroup -Name $ResourceGroupName -Force -AsJob
