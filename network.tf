resource "azurerm_virtual_network" "blprincpal" {
    name                = "blprincpal"
    address_space       = [var.bloco]
    location            = var.localizacao

    resource_group_name = azurerm_resource_group.ADS01.name

    tags = {
        environment = "aula infra"
    }

    depends_on = [ azurerm_resource_group.ADS01 ]
}

resource "azurerm_subnet" "subnet_aula" {
    name                 = "subnet_aula"
    resource_group_name  = azurerm_resource_group.ADS01.name
    virtual_network_name = azurerm_virtual_network.blprincpal.name
    address_prefixes       = [var.subnet_aula_rede]

}


