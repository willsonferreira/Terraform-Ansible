resource "azurerm_network_security_group" "acessos" {
    name                = "acessos"
    location            = var.localizacao
    resource_group_name = azurerm_resource_group.ADS01.name

    security_rule {
        name                       = var.acesso_ssh.nome
        priority                   = var.acesso_ssh.prioridade
        direction                  = var.acesso_ssh.direcao
        access                     = var.acesso_ssh.acesso
        protocol                   = var.acesso_ssh.protocolo
        source_port_range          = "*"
        destination_port_range     = var.acesso_ssh.porta_destino
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = var.acesso_http.nome
        priority                   = var.acesso_http.prioridade
        direction                  = var.acesso_http.direcao
        access                     = var.acesso_http.acesso
        protocol                   = var.acesso_http.protocolo
        source_port_range          = "*"
        destination_port_range     = var.acesso_http.porta_destino
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = var.acesso_https.nome
        priority                   = var.acesso_https.prioridade
        direction                  = var.acesso_https.direcao
        access                     = var.acesso_https.acesso
        protocol                   = var.acesso_https.protocolo
        source_port_range          = "*"
        destination_port_range     = var.acesso_https.porta_destino
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    
    tags = {
        environment = "aula infra"
    }

    depends_on = [ azurerm_resource_group.ADS01 ]
}