# Variables
$ResourceGroupName = 'MyResourceGroup'
$VMName = 'MyVM'

# Get VM Details
$VM = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName

# Display VM Details
$VM | Format-List *

# SPECIFIC DETAILS 
$VM | Format-List HardwareProfile, StorageProfile.OsDisk
