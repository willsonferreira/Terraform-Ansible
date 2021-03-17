# localidade do projeto no azure
variable "localizacao" {
    type = string
    default = "eastus"
}

# usuario padrao das instalacoes
variable "usuario" {
    type = string
    default = "impacta"
}

# senha padrao das instalacoes
variable "senha" {
    type = string
    default = "Impacta1!"
}

# nome do resource-group
variable "grupo" {
    type = string
    default = "ADS01"
}

# definicacao do bloco de rede
variable "bloco" {
    type = string
    default = "10.100.0.0/16"
}

# definicao da subnet
variable "subnet_aula_rede" {
    type = string
    default = "10.100.1.0/24"
}

# nome da subnet
variable "subnet_aula_nome" {
    type = string
    default = "subnet_aula"
}

# grupo de objetos para o acesso SSH
variable "acesso_ssh" {
    type = object({
        nome = string
        prioridade = number
        direcao = string
        acesso = string
        protocolo = string
        porta_destino = number
    })
    default = {
        nome = "ssh"
        prioridade = 100
        direcao = "Inbound"
        acesso = "Allow"
        protocolo = "Tcp"
        porta_destino = 22
    }
}

# grupo de objetos para o acesso http
variable "acesso_http" {
    type = object({
        nome = string
        prioridade = number
        direcao = string
        acesso = string
        protocolo = string
        porta_destino = number
    })
    default = {
        nome = "http"
        prioridade = 101
        direcao = "Inbound"
        acesso = "Allow"
        protocolo = "Tcp"
        porta_destino = 80
    }
}

# grupo de objetos para o acesso https
variable "acesso_https" {
    type = object({
        nome = string
        prioridade = number
        direcao = string
        acesso = string
        protocolo = string
        porta_destino = number
    })
    default = {
        nome = "https"
        prioridade = 102
        direcao = "Inbound"
        acesso = "Allow"
        protocolo = "Tcp"
        porta_destino = 443
    }
}

# grupo de objetos de configuracao da VM ansible
variable "vm_ansible" {
    type = object({
        nome = string
        vm_tipo = string
        nome_nic_interna = string
        ip_interno = string
        storage_sda = string
        tier_storage_sda = string
        replicacao_storage_sda = string
        nome_disco = string
        cache = string
        tipo_storage = string
        editor = string
        distribuicao = string 
        versao = string
        build = string

    })
    default = {
        # dados vm
        nome = "vmansible" # o nome da vm nao suporta caracteres especiais
        vm_tipo = "Standard_DS1_v2"
        # rede
        nome_nic_interna = "vm_ansible_nic_interna"
        ip_interno = "10.100.1.10"
        # dados storage/disco sda/1 
        storage_sda = "vm_ansible_storage_sda"
        tier_storage_sda = "Standard"
        replicacao_storage_sda = "LRS"
        nome_disco = "sda"
        cache = "ReadWrite"
        tipo_storage = "Premium_LRS"
        # imagem 
        editor = "Canonical" 
        distribuicao = "UbuntuServer" 
        versao = "18.04-LTS"
        build = "latest"
    }
}
