resource oci_core_volume vol_app_attachment01 {
  count = local.app_vm_count
  availability_domain = local.ad
  #block_volume_replicas_deletion = <<Optional value not found in discovery>>
  compartment_id = var.compartment_ocid
  display_name = join("",["appvol",count.index])
  is_auto_tune_enabled = "false"
  #kms_key_id = <<Optional value not found in discovery>>
  size_in_gbs = "200"
  #volume_backup_id = <<Optional value not found in discovery>>
  vpus_per_gb = "10"
}

resource oci_core_volume vol_web_attachment01 {
  count = local.vm_count
  availability_domain = local.ad
  #block_volume_replicas_deletion = <<Optional value not found in discovery>>
  compartment_id = var.compartment_ocid
  display_name = join("",["webvol",count.index])
  is_auto_tune_enabled = "false"
  #kms_key_id = <<Optional value not found in discovery>>
  size_in_gbs = "100"
  #volume_backup_id = <<Optional value not found in discovery>>
  vpus_per_gb = "10"
}

resource oci_core_volume_attachment vmvolumeattachment01 {
  count = local.vm_count #- 1
  attachment_type = "paravirtualized"
  device          = "/dev/oracleoci/oraclevdb"
  display_name    =  join("",["webvolatt",count.index])
  #encryption_in_transit_type = <<Optional value not found in discovery>>
  instance_id                         = oci_core_instance.webvm[count.index].id
  is_pv_encryption_in_transit_enabled = "false"
  is_read_only                        = "false"
  is_shareable = "false"
  #use_chap = <<Optional value not found in discovery>>
  volume_id = oci_core_volume.vol_web_attachment01[count.index].id

  #depends_on = [oci_core_volume_attachment.mastervolatt1,oci_core_volume_attachment.mastervolatt1,]
}

resource oci_core_volume_attachment appvolumeattachment01 {
  count = local.app_vm_count #- 1 
  attachment_type = "paravirtualized"
  device          = "/dev/oracleoci/oraclevdb"
  display_name    = join("",["appvolatt",count.index])
  #encryption_in_transit_type = <<Optional value not found in discovery>>
  instance_id                         = oci_core_instance.appvm[count.index].id
  is_pv_encryption_in_transit_enabled = "false"
  is_read_only                        = "false"
  is_shareable = "false"
  #use_chap = <<Optional value not found in discovery>>
  volume_id = oci_core_volume.vol_app_attachment01[count.index].id
  #depends_on = [oci_core_volume_attachment.mastervolatt1,oci_core_volume_attachment.mastervolatt2,]
}