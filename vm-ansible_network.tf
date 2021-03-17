resource "azurerm_public_ip" "resippublicovmansible" {
    name                         = "resippublicovmansible"
    location                     = var.localizacao
    resource_group_name          = azurerm_resource_group.ADS01.name
    allocation_method            = "Static"
    idle_timeout_in_minutes = 30

    tags = {
        environment = "aula infra",
        tool = "ansible"
    }
}


resource "azurerm_network_interface" "interfaces_vm_ansible" {
    name                      = "interfaces_vm_ansible"
    location                  = var.localizacao
    resource_group_name       = azurerm_resource_group.ADS01.name

    ip_configuration {
        name                          = var.vm_ansible.nome_nic_interna
        subnet_id                     = azurerm_subnet.subnet_aula.id
        private_ip_address_allocation = "Static"
        private_ip_address            = var.vm_ansible.ip_interno
        public_ip_address_id          = azurerm_public_ip.resippublicovmansible.id
    }

    tags = {
        environment = "aula infra",
        tool = "ansible"
    }
}


resource "azurerm_network_interface_security_group_association" "sg_vm_ansible" {
    network_interface_id      = azurerm_network_interface.interfaces_vm_ansible.id
    network_security_group_id = azurerm_network_security_group.acessos.id

}

data "azurerm_public_ip" "ip_publico_vm_ansible" {
  name                = azurerm_public_ip.resippublicovmansible.name
  resource_group_name = azurerm_resource_group.ADS01.name
}