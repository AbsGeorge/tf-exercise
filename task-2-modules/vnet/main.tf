

// Virtual Network
resource "azurerm_virtual_network" "t1" {
  name                = "${var.project_name}-vnet1"
  location            = var.location
  resource_group_name = var.group_name
  address_space       = ["10.0.0.0/16"]
}

// Public Subnet with NSG allowing SSH from everywhere

resource "azurerm_subnet" "public" {
  name                 = "${var.project_name}-public"
  resource_group_name  = var.group_name
  virtual_network_name = azurerm_virtual_network.t1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public" {
  name                = "${var.project_name}-publicIP"
  resource_group_name = var.group_name
  location            = var.location
  allocation_method   = "Static"
}

//resource "azurerm_public_host" "example" {
  //name                = "examplebastion"
  //location            = azurerm_resource_group.t1.location
 // resource_group_name = azurerm_resource_group.t1.name

 // ip_configuration {
 //   name                 = "configuration"
  //  subnet_id            = azurerm_public_subnet.public.id
  //  public_ip_address_id = azurerm_public_ip.public.id
 // }
//}


resource "azurerm_network_security_group" "public" {
  name                = "${var.project_name}-public"
  location            = var.location
  resource_group_name = var.group_name

  security_rule {
    name                       = "access"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

// Network Interface/NSG Group Association

resource "azurerm_network_interface_security_group_association" "public" {
  network_interface_id = azurerm_network_interface.public.id
  network_security_group_id = azurerm_network_security_group.public.id
}


// Network Interface
resource "azurerm_network_interface" "public" {
  name                = "${var.project_name}-public"
  location            = var.location
  resource_group_name = var.group_name

  ip_configuration {
    name                          = "publicconfiguration"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public.id
  }
}


// Private Subnet with NSG allowing SSH only from public subnet

resource "azurerm_subnet" "private" {
  name                 = "${var.project_name}-private"
  resource_group_name  = var.group_name
  virtual_network_name = azurerm_virtual_network.t1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "private" {
  name                = "${var.project_name}-private"
  resource_group_name = var.group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "private" {
  name                = "${var.project_name}-nsg2"
  location            = var.location
  resource_group_name = var.group_name

  security_rule {
    name                       = "access2"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "private" {
  name                = "${var.project_name}-private"
  location            = var.location
  resource_group_name = var.group_name

  ip_configuration {
    name                          = "privateconfiguration"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.private.id
  }
}
