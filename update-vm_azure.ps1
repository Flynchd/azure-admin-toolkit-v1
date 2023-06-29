# Variables
$ResourceGroupName = 'MyResourceGroup'
$VMName = 'MyVM'
$NewSize = 'Standard_D16s_v3'  # The size with 16 vCPU and 32 GB memory

# Stop and deallocate the VM
Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName -Force

# Get the VM object based on the VM name and resource group
$VM = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName

# Update the VM size
$VM.HardwareProfile.VmSize = $NewSize

# Update the VM
Update-AzVM -VM $VM -ResourceGroupName $ResourceGroupName

# Start the VM
Start-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName

