resource "null_resource" "web_via_bastion" {
  count = var.vm_count
  depends_on = [oci_core_instance.webvm, oci_core_volume_attachment.vmvolumeattachment01]

  provisioner "remote-exec" {
    connection {
      host        = oci_core_instance.webvm[count.index].private_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = local.gen_priv_key

      bastion_host        = "host.bastion.${var.region}.oci.oraclecloud.com"
      bastion_user        =  oci_bastion_session.web_ssh_via_bastion_service[count.index].id
      bastion_private_key = local.gen_priv_key
    }

    inline = [
      "sudo /bin/su -c \"mkfs.xfs -f ${var.vm_device}\"",
      "sudo /bin/su -c \"mkdir ${var.web_vm_mnt_path}\"",
      "sudo /bin/su -c \"echo '${var.vm_device} ${var.web_vm_mnt_path} xfs _netdev,defaults 0 0' >> /etc/fstab\"",
      "sudo /bin/su -c \"mount -a\""
    ]
  }
}

resource "null_resource" "app_via_bastion" {
  count = var.app_vm_count
  depends_on = [oci_core_instance.appvm, oci_core_volume_attachment.appvolumeattachment01]

  provisioner "remote-exec" {
    connection {
      host        = oci_core_instance.appvm[count.index].private_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = local.gen_priv_key

      bastion_host        = "host.bastion.${var.region}.oci.oraclecloud.com"
      bastion_user        =  oci_bastion_session.app_ssh_via_bastion_service[count.index].id
      bastion_private_key = local.gen_priv_key
    }

    inline = [
      "sudo /bin/su -c \"mkfs.xfs -f ${var.vm_device}\"",
      "sudo /bin/su -c \"mkdir ${var.web_vm_mnt_path}\"",
      "sudo /bin/su -c \"echo '${var.vm_device} ${var.web_vm_mnt_path} xfs _netdev,defaults 0 0' >> /etc/fstab\"",
      "sudo /bin/su -c \"mount -a\""
    ]
  }
}