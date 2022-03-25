
resource oci_core_volume_group webvolgroup {
  #count = local.vm_count
  availability_domain = local.ad
  backup_policy_id = oci_core_volume_backup_policy.silver_bckp_policy.id 
  compartment_id = var.compartment_ocid
  display_name = join("web",[local.volgroup_name,""])
  source_details {
      type = "volumeIds"
     
            #volume_group_backup_id = <<Optional value not found in discovery>>
            #volume_group_id = <<Optional value not found in discovery>>
      volume_ids = [
            oci_core_volume.vol_web_attachment01[0].id,
            oci_core_instance.webvm[0].boot_volume_id,
             oci_core_volume.vol_web_attachment01[1].id,
            oci_core_instance.webvm[1].boot_volume_id,
             oci_core_volume.vol_web_attachment01[2].id,
            oci_core_instance.webvm[2].boot_volume_id,
             oci_core_volume.vol_web_attachment01[3].id,
            oci_core_instance.webvm[3].boot_volume_id
            ]
          }
}

resource oci_core_volume_group appvolgroup {
  availability_domain = local.ad
  backup_policy_id = oci_core_volume_backup_policy.silver_bckp_policy.id 
  compartment_id = var.compartment_ocid
  display_name = join("app",[local.volgroup_name,""]) 
 source_details {
    type = "volumeIds"
    volume_ids = [
        oci_core_volume.vol_app_attachment01[0].id,
       oci_core_instance.appvm[0].boot_volume_id,    
             oci_core_volume.vol_app_attachment01[1].id,
       oci_core_instance.appvm[2].boot_volume_id,
             oci_core_volume.vol_app_attachment01[3].id,
       oci_core_instance.appvm[3].boot_volume_id,
             oci_core_volume.vol_app_attachment01[4].id,
       oci_core_instance.appvm[4].boot_volume_id,
             oci_core_volume.vol_app_attachment01[5].id,
       oci_core_instance.appvm[5].boot_volume_id
        ]
  }
}