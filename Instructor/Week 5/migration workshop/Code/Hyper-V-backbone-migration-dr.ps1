
$ResourceGroupName = "hyperv-lan-migration-dr"
$EnvironmentLocation = "westus2"
$HyperVvnetName = "landingzone-vnet-dr"
$HyperVvnetAddressPrefix = "192.168.0.0/16"

$WorkspaceName = "thomasmigrationladr"

# Deploy Resource Group
New-AzResourceGroup -Name $ResourceGroupName -Location $EnvironmentLocation
$ResourceGroup = Get-AzResourcegroup -name $ResourceGroupName


# Deploy Azure vNET
$virtualNetwork = New-AzVirtualNetwork `
-ResourceGroupName $ResourceGroup.resourcegroupname `
-Location $EnvironmentLocation `
-Name $HyperVvnetName `
-AddressPrefix $HyperVvnetAddressPrefix

#$virtualNetwork = Get-AzVirtualNetwork -name $HyperVvnetName
# Add subnets
 $subnetConfigGateway = Add-AzVirtualNetworkSubnetConfig `
-Name GatewaySubnet `
-AddressPrefix "192.168.0.0/24" `
-VirtualNetwork $virtualNetwork

$subnetConfigAzFirewall = Add-AzVirtualNetworkSubnetConfig `
-Name AzureFirewallSubnet `
-AddressPrefix "192.168.1.0/24" `
-VirtualNetwork $virtualNetwork

$subnetConfigAzFirewall = Add-AzVirtualNetworkSubnetConfig `
-Name DomainControllerSubnet `
-AddressPrefix "192.168.2.0/24" `
-VirtualNetwork $virtualNetwork

$subnetConfigAzFirewall = Add-AzVirtualNetworkSubnetConfig `
-Name smartHotelWAFSubnet `
-AddressPrefix "192.168.3.0/24" `
-VirtualNetwork $virtualNetwork

$subnetConfigAzFirewall = Add-AzVirtualNetworkSubnetConfig `
-Name smartHotelWeb1Subnet `
-AddressPrefix "192.168.4.0/24" `
-VirtualNetwork $virtualNetwork

$subnetConfigAzFirewall = Add-AzVirtualNetworkSubnetConfig `
-Name smartHotelWeb2Subnet `
-AddressPrefix "192.168.5.0/24" `
-VirtualNetwork $virtualNetwork

$subnetConfigAzFirewall = Add-AzVirtualNetworkSubnetConfig `
-Name smartHotelSQLSubnet `
-AddressPrefix "192.168.6.0/24" `
-VirtualNetwork $virtualNetwork

$subnetConfigAzFirewall = Add-AzVirtualNetworkSubnetConfig `
-Name Server2003Subnet `
-AddressPrefix "192.168.7.0/24" `
-VirtualNetwork $virtualNetwork

$virtualNetwork | Set-AzVirtualNetwork


#Create ASGs
$asgs = @("dcasg","wafasg","web1asg","web2asg","dbasg")

foreach ($asg in $asgs) {
    New-AzApplicationSecurityGroup -Name $asg -ResourceGroupName $ResourceGroupName  -Location  $EnvironmentLocation
}

# Create NSG
    New-AzNetworksecuritygroup -Name "migration-nsg" -ResourceGroupName $ResourceGroupName -Location $EnvironmentLocation

# Create Log Analytics Workspace
    New-AzOperationalInsightsWorkspace -Location $EnvironmentLocation -Name $WorkspaceName -Sku Standard -ResourceGroupName $ResourceGroupName
