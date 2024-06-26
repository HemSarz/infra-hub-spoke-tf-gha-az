resource "azurerm_firewall" "tfazfw" {
  name                = "${var.prefix}-fw01-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfazrg.name
  sku_tier            = "Standard"
  sku_name            = "AZFW_VNet"

  ip_configuration {
    name                 = "${var.prefix}-fwipconfig-${var.env}"
    subnet_id            = azurerm_subnet.fwsub.id
    public_ip_address_id = azurerm_public_ip.fwpip.id
  }
}

## Force all traffic to pass through the FW

## Route tables
resource "azurerm_route_table" "hub-rt" {
  name                = "${var.prefix}-hub-rt-${var.env}"
  resource_group_name = azurerm_resource_group.tfazrg.name
  location            = azurerm_resource_group.tfazrg.location
}

resource "azurerm_route_table" "spoke01-rt" {
  name                = "${var.prefix}-spoke01-rt-${var.env}"
  resource_group_name = azurerm_resource_group.tfazrg.name
  location            = azurerm_resource_group.tfazrg.location
}

resource "azurerm_route_table" "spoke02-rt" {
  name                = "${var.prefix}-spoke02-rt-${var.env}"
  resource_group_name = azurerm_resource_group.tfazrg.name
  location            = azurerm_resource_group.tfazrg.location
}

##Routes
resource "azurerm_route" "rt_hub_fw" {
  name                   = "${var.prefix}-rt-hub-to-fw-${var.env}"
  resource_group_name    = azurerm_resource_group.tfazrg.name
  route_table_name       = azurerm_route_table.hub-rt.name
  address_prefix         = var.rtadrprefix
  next_hop_in_ip_address = azurerm_firewall.tfazfw.ip_configuration[0].private_ip_address
  next_hop_type          = var.next_hop_type
}

resource "azurerm_route" "rt_spoke01_fw" {
  name                   = "${var.prefix}-rt-spoke01-fw-${var.env}"
  resource_group_name    = azurerm_resource_group.tfazrg.name
  route_table_name       = azurerm_route_table.spoke01-rt.name
  address_prefix         = var.rtadrprefix
  next_hop_in_ip_address = azurerm_firewall.tfazfw.ip_configuration[0].private_ip_address
  next_hop_type          = var.next_hop_type
}

resource "azurerm_route" "rt_spoke02_fw" {
  name                   = "${var.prefix}-rt-spoke02-fw-${var.env}"
  resource_group_name    = azurerm_resource_group.tfazrg.name
  route_table_name       = azurerm_route_table.spoke02-rt.name
  address_prefix         = var.rtadrprefix
  next_hop_in_ip_address = azurerm_firewall.tfazfw.ip_configuration[0].private_ip_address
  next_hop_type          = var.next_hop_type
}

## Route association
resource "azurerm_subnet_route_table_association" "hubsub_assoc" {
  subnet_id      = azurerm_subnet.hubsub.id
  route_table_id = azurerm_route_table.hub-rt.id
}

resource "azurerm_subnet_route_table_association" "spokesub01_assoc" {
  subnet_id      = azurerm_subnet.spokesub01.id
  route_table_id = azurerm_route_table.spoke01-rt.id
}

resource "azurerm_subnet_route_table_association" "spokesub02_assoc" {
  subnet_id      = azurerm_subnet.spokesub02.id
  route_table_id = azurerm_route_table.spoke02-rt.id
}

## Network rule connection
resource "azurerm_firewall_network_rule_collection" "fw-rtr-coll" {
  name                = "${var.prefix}-frc-traffic-fw-${var.env}"
  azure_firewall_name = azurerm_firewall.tfazfw.name
  resource_group_name = azurerm_resource_group.tfazrg.name
  priority            = 100
  action              = "Allow"

  rule {
    name                  = "Allow-All-Traffic"
    source_addresses      = ["0.0.0.0/0"]
    destination_addresses = ["0.0.0.0/0"]
    destination_ports     = ["*"]
    protocols             = ["Any"]
  }
}
