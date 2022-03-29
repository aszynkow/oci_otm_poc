resource "oci_bastion_bastion" "otm_bastion" {
    #Required
	#count                        = var.use_bastion_service ? 1 : 0
    bastion_type = var.bastion_type
    compartment_id = local.Okit_Comp002_id
    target_subnet_id = local.Okit_Sn001_id

    #Optional
    client_cidr_block_allow_list = [var.bastion_client_cidr_block_allow_list]
    max_session_ttl_in_seconds = var.max_session_ttl_in_seconds
    name = local.bastion_name
}

resource "oci_bastion_session" "web_ssh_via_bastion_service" {
  count      = var.vm_count
  bastion_id = oci_bastion_bastion.otm_bastion.id

  key_details {
    public_key_content = tls_private_key.ssh_key.public_key_openssh#local.ssh_authorized_keys
  }

  target_resource_details {
    session_type                               = "MANAGED_SSH"
    target_resource_id                         = oci_core_instance.webvm[count.index].id
    target_resource_operating_system_user_name = var.vm_user
    target_resource_port                       = 22
    target_resource_private_ip_address         = oci_core_instance.webvm[count.index].private_ip
  }

  display_name           = join("",["webshh",count.index])
  key_type               = "PUB"
  session_ttl_in_seconds = 1800
}

resource "oci_bastion_session" "app_ssh_via_bastion_service" {
  count      = var.app_vm_count
  bastion_id = oci_bastion_bastion.otm_bastion.id

  key_details {
    public_key_content = tls_private_key.ssh_key.public_key_openssh#local.ssh_authorized_keys
  }

  target_resource_details {
    session_type                               = "MANAGED_SSH"
    target_resource_id                         = oci_core_instance.appvm[count.index].id
    target_resource_operating_system_user_name = var.vm_user
    target_resource_port                       = 22
    target_resource_private_ip_address         = oci_core_instance.appvm[count.index].private_ip
  }

  display_name           = join("",["appshh",count.index])
  key_type               = "PUB"
  session_ttl_in_seconds = 1800
}