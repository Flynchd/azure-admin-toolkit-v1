# Variables
$ResourceGroupName = 'MyResourceGroup'
$Location = 'US West'
$VMName = 'MyVM'
$VNetName = 'MyVNet'
$SubnetName = 'MySubnet'
$SecurityGroupName = 'MyNSG'
$PublicIpName = 'MyPublicIP'
$OpenPorts = 80,3389
$Size = 'Standard_D32s_v3' # This size has 32 vCPU and 32 GB RAM
$StorageType = 'Premium_LRS' # SSD storage
$DiskSizeGB = 100 # 100 GB SSD
$OS = 'Windows Server 2016 Datacenter' # Specify the OS

# Create a resource group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location

# Create a subnet configuration
$SubnetConfig = New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix 192.168.1.0/24

# Create a virtual network
$VNet = New-AzVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName -Location $Location `
  -AddressPrefix 192.168.0.0/16 -Subnet $SubnetConfig

# Create a network security group
$NSG = New-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location `
  -Name $SecurityGroupName 

# Create a public IP address
$PIP = New-AzPublicIpAddress -Name $PublicIpName -ResourceGroupName $ResourceGroupName -Location $Location `
  -AllocationMethod Dynamic

# Create an inbound network security group rule for port 3389
$NsgRuleRDP = New-AzNetworkSecurityRuleConfig -Name 'RDPRule' -Protocol Tcp `
  -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * `
  -DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow

# Create an inbound network security group rule for port 80
$NsgRuleWeb = New-AzNetworkSecurityRuleConfig -Name 'WebRule'  -Protocol Tcp `
  -Direction Inbound -Priority 1001 -SourceAddressPrefix * -SourcePortRange * `
  -DestinationAddressPrefix * -DestinationPortRange 80 -Access Allow

# Add the inbound security rules to the network security group
$NSG | Add-AzNetworkSecurityRuleConfig -Name 'RDPRule' -NetworkSecurityRule $NsgRuleRDP
$NSG | Add-AzNetworkSecurityRuleConfig -Name 'WebRule' -NetworkSecurityRule $NsgRuleWeb

# Create a virtual network card and associate with public IP address and NSG
$NIC = New-AzNetworkInterface -Name $VMName -ResourceGroupName $ResourceGroupName -Location $Location `
  -SubnetId $VNet.Subnets[0].Id -PublicIpAddressId $PIP.Id -NetworkSecurityGroupId $NSG.Id

# Define a credential object
$Credential = Get-Credential -Message "Enter a username and password for the virtual machine."

# Create a virtual machine configuration
$VMConfig = New-AzVMConfig -VMName $VMName -VMSize $Size | `
Set-AzVMOperatingSystem -Windows -ComputerName $VMName -Credential $Credential -ProvisionVMAgent -EnableAutoUpdate | `
Set-AzVMSourceImage -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus $OS -Version 'latest' | `
Set-AzVMOSDisk -StorageAccountType $StorageType -DiskSizeGB $DiskSizeGB -CreateOption FromImage

# Create a virtual machine
New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VMConfig -NetworkInterfaceId $NIC.Id
