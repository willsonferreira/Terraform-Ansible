#nao suportou underline, traco, ponto, maiusculo nem nada, so direto minusculo
resource "azurerm_storage_account" "stgaccvmansiblesda" { 
    name                        = "stgaccvmansiblesda"
    resource_group_name         = azurerm_resource_group.ADS01.name
    location                    = var.localizacao
    account_tier                = var.vm_ansible.tier_storage_sda
    account_replication_type    = var.vm_ansible.replicacao_storage_sda

    tags = {
        environment = "aula infra",
        tool = "ansible"
    }

}

# o computername vmansible e o mesmo caso da linha 1 nao suportou qualquer separacao
resource "azurerm_linux_virtual_machine" "vmansible" {
    name                  = var.vm_ansible.nome 
    location              = var.localizacao
    resource_group_name   = azurerm_resource_group.ADS01.name
    network_interface_ids = [azurerm_network_interface.interfaces_vm_ansible.id]
    size                  = var.vm_ansible.vm_tipo
    os_disk {
        name              = var.vm_ansible.nome_disco
        caching           = var.vm_ansible.cache
        storage_account_type = var.vm_ansible.tipo_storage
    }

    source_image_reference {
        publisher = var.vm_ansible.editor
        offer     = var.vm_ansible.distribuicao
        sku       = var.vm_ansible.versao
        version   = var.vm_ansible.build
    }

    computer_name  = var.vm_ansible.nome
    admin_username = var.usuario
    admin_password = var.senha
    disable_password_authentication = false

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stgaccvmansiblesda.primary_blob_endpoint
    }

    tags = {
        environment = "aula infra",
        tool = "ansible"
    }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [azurerm_linux_virtual_machine.vmansible]
  create_duration = "30s"
}

resource "null_resource" "upload" {
    provisioner "file" {
        connection {
            type = "ssh"
            user = var.usuario
            password = var.senha
            host = data.azurerm_public_ip.ip_publico_vm_ansible.ip_address
        }
        source = "ansible"
        destination = "/home/impacta"
    }

    depends_on = [ time_sleep.wait_30_seconds ]
}

resource "null_resource" "deploy" {
    triggers = {
        order = null_resource.upload.id
    }
    provisioner "remote-exec" {
        connection {
            type = "ssh"
            user = var.usuario
            password = var.senha
            host = data.azurerm_public_ip.ip_publico_vm_ansible.ip_address
        }
        inline = [
            "sudo apt-get update",
            "sudo apt-get install -y software-properties-common",
            "sudo apt-add-repository --yes --update ppa:ansible/ansible",
            "sudo apt-get -y install python3 ansible",
            "ansible-playbook -i /home/impacta/ansible/hosts /home/impacta/ansible/main.yml"
        ]
    }
}

output "exibe_ip_publico_vm_ansible" {
  value = data.azurerm_public_ip.ip_publico_vm_ansible.ip_address
}
