#Subscription (AzureMigrate)
Select-AzSubscription -Subscriptionid "27f048cd-d37e-4655-8fbe-2e41b14d7327"

$ResourceGroupName = "hyperv-lan-bradt-demo"
$EnvironmentLocation = "eastus2"
$HyperVvnetName = "hyperv-vnet"
$HyperVvnetAddressPrefix = "10.2.0.0/16"
$snapshotresourcegroup = "thomas-migrationworkshop"

# Create Hyper-V VM
$VirtualMachineName = "hyper-v-vm"
$VirtualMachineSize = "Standard_D4s_v3"
$VirtualMachineDiskName = "hyper-v-vm-os"
$VirtualMachineDataDiskName = "hyper-v-vm-data"
#$snapshotOSdiskName = "vpninstall-osdisk"
#$snapshotDatadiskName = "vpninstall-datadisk"
$snapshotOSdiskName = "sqlfix-osdisk"
$snapshotDatadiskName = "vpninstall-datadisk"

$RouteTableName = "hyper-v-routetable"

# Deploy Resource Group
New-AzResourceGroup -Name $ResourceGroupName -Location $EnvironmentLocation
$ResourceGroup = Get-AzResourcegroup -name $ResourceGroupName

# Deploy Azure vNET
  New-AzVirtualNetwork `
  -ResourceGroupName $ResourceGroup.resourcegroupname `
  -Location $EnvironmentLocation `
  -Name $HyperVvnetName `
  -AddressPrefix $HyperVvnetAddressPrefix

  $virtualNetwork = Get-AzVirtualNetwork -name $HyperVvnetName -ResourceGroupName $ResourceGroupName
# Add subnets
   $subnetConfiglan = Add-AzVirtualNetworkSubnetConfig `
  -Name lan `
  -AddressPrefix "10.2.1.0/24" `
  -VirtualNetwork $virtualNetwork

  $subnetConfignat = Add-AzVirtualNetworkSubnetConfig `
  -Name nat `
  -AddressPrefix "10.2.0.0/24" `
  -VirtualNetwork $virtualNetwork

  $virtualNetwork | Set-AzVirtualNetwork


# Copy snapshots to Resource group
$snapshotfind = @("$snapshotOSdiskName","$snapshotDatadiskName")
$snapshots = @()

foreach ($snapshotget in $snapshotfind) {

  $snapshots += Get-AzSnapshot -ResourceGroupName $snapshotresourcegroup -SnapshotName $snapshotget

}

foreach ($snapshot in $snapshots){

  $snapshotConfig = New-AzSnapshotConfig -SourceResourceId $snapshot.Id -Location $snapshot.Location -CreateOption Copy -SkuName Standard_LRS
  New-AzSnapshot -Snapshot $snapshotConfig -SnapshotName $snapshot.name -ResourceGroupName $ResourceGroupName

}


# Create Hyper-V VM
# OS Disk
$snapshotOSdisk = Get-AzSnapshot -ResourceGroupName $ResourceGroupName -name $snapshotOSdiskName
$diskConfig = New-AzDiskConfig -Location $snapshotOSdisk.Location -SourceResourceId $snapshotOSdisk.Id -CreateOption Copy -skuName StandardSSD_LRS
$disk = New-AzDisk -Disk $diskConfig -ResourceGroupName $resourceGroupName -DiskName $VirtualMachineDiskName

# Data disk
$snapshotDatadisk = Get-AzSnapshot -ResourceGroupName $ResourceGroupName -name $snapshotDatadiskName
$DatadiskConfig = New-AzDiskConfig -Location $snapshotDatadisk.Location -SourceResourceId $snapshotDatadisk.Id -CreateOption Copy -skuName StandardSSD_LRS
$datadisk = New-AzDisk -Disk $DatadiskConfig -ResourceGroupName $resourceGroupName -DiskName $VirtualMachineDataDiskName

$VirtualMachine = New-AzVMConfig -VMName $VirtualMachineName -VMSize $VirtualMachineSize
$VirtualMachine = Set-AzVMOSDisk -VM $VirtualMachine -ManagedDiskId $disk.Id -CreateOption Attach -Windows
$VirtualMachine = Add-AzVMDataDisk -VM $VirtualMachine -Name $VirtualMachineDataDiskName -CreateOption Attach -ManagedDiskId $datadisk.Id -Lun 1
$publicIp = New-AzPublicIpAddress -Name ($VirtualMachineName.ToLower()+'_pip') -ResourceGroupName $resourceGroupName -Location $snapshotOSdisk.Location -AllocationMethod Dynamic

$vnet = Get-AzVirtualNetwork -Name $HyperVvnetName -ResourceGroupName $ResourceGroupName
$nic = New-AzNetworkInterface -Name ($VirtualMachineName.ToLower()+'_nic') -ResourceGroupName $resourceGroupName -Location $snapshot.Location -SubnetId $vnet.Subnets[1].Id -PublicIpAddressId $publicIp.Id
$lannic = New-AzNetworkInterface -Name ($VirtualMachineName.ToLower()+'_lannic') -ResourceGroupName $resourceGroupName -Location $snapshot.Location -SubnetId $vnet.Subnets[0].Id

$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $nic.Id -Primary
$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $lannic.Id

New-AzVM -VM $VirtualMachine -ResourceGroupName $resourceGroupName -Location $EnvironmentLocation


# Create NSG
$nsgname = "hyperv-lan-nsg"
$nsg = New-AzNetworkSecurityGroup -Name $nsgname -ResourceGroupName $ResourceGroupName -Location $EnvironmentLocation

$nsg | Add-AzNetworkSecurityRuleConfig -Name "allow-all-sourceip" -Description "Add RDP" -Access Allow -Protocol * -Direction Inbound -Priority 100 -SourceAddressPrefix "109.155.76.16" -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange *

$nsg | Set-AzNetworkSecurityGroup

$nic.NetworkSecurityGroup = $nsg 
$nic | Set-AzNetworkInterface

# Deploy Route Table
$routeTablePublic = New-AzRouteTable -Name $RouteTableName -ResourceGroupName $ResourceGroupName -location $EnvironmentLocation

# Create Route
Get-AzRouteTable `
  -ResourceGroupName $ResourceGroupName `
  -Name $RouteTableName `
  | Add-AzRouteConfig `
  -Name "Route-to-hyperv-vms" `
  -AddressPrefix 10.2.2.0/24 `
  -NextHopType "VirtualAppliance" `
  -NextHopIpAddress 10.2.1.4 `
 | Set-AzRouteTable