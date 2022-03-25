output "Home_Region_Name" {
 value = local.home_region
}

output "DeploymentCompartmentId" {
    value = local.DeploymentCompartment_id
}

output "Vcn_id" {
    value = local.Okit_Vcn001_id
}

output "ssh_private_key" {
  value =  var.ssh_authorized_keys !=null ? "Provided by user" : nonsensitive(local.gen_priv_key)
   #sensitive = true
}

output "ssh_public_key" {
  value = local.ssh_authorized_keys
}