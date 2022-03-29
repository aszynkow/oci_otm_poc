variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}

variable existing_vcn_name {
default = "vcn1"
}

variable netwrok_compartment_id {
    default = "ocid1.compartment.oc1..aaaaaaaask65vhp2lvg4wgh6wwojervl56v64vcr6bglfldlnvutxabqnpmq"
}

variable existing_drg_id {
    default = "ocid1.drg.oc1.ap-sydney-1.aaaaaaaa2nyev6iwogcz7mxofwjhpxq5qehs5lds45pgrcigytvlv5zn3asq"
}

variable sub01_ip_range {
    default = "10.201.0.64/27"#"10.24.0.64/27"
}

variable sub02_ip_range {
    default = "10.201.0.96/27"#"10.24.0.96/27"
}

variable lb_subnet_cidr {
    default = "10.201.0.32/27"#"10.24.0.32/27"
}


variable on_prem_ip_range {
    default = "10.0.0.0/8"
}

variable ssh_authorized_keys {
    default = ""#"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgGSK4Q1fDVHojkHxDXJDz8bgEZ4+kWhAWG0TMNYovpG6pJe9TM0s0Qo7iZYxKaj0utY9WisptIS9nzBX7Mhb36QI4Je/i7MlMO+f5Vfsol5isjRlObDiW2GcoPL+EZIdNUgU8R3ovaUGcsx8dM4+RWQw/LKhbsYMWiFJwFr1e0ETnMM4WaZfyKM7uyq5SubEaoPiflwCueXksE5pSeuP/ov3Q82UkX2XZGjDALcMmE6xI91to64WLvovHmg7xmQZr0lsiyKiA3AaXVGuB95/Ngeq4e6DU4OZy1aDC2gyyW2jTpPwvbXbcki12ISuzkr+XRn0XS1hxrFhqIjFd1Ggt adam_szynk@d54895260571"
}

variable env_name {
    default = "otmspoc"
}

variable lb_shape {
    default = "flexible"
}

variable  maximum_bandwidth_in_mbps {
    default ="10"
}

variable minimum_bandwidth_in_mbps {
    default = "10"
}

variable bastion_client_cidr_block_allow_list {
    default = "0.0.0.0/0"
}

variable max_session_ttl_in_seconds {
    default = "10800"

}
variable bastion_type {
    default = "STANDARD"
}

#AllVMS
variable vm_device {
    default = "/dev/oracleoci/oraclevdb"
}

variable vm_user {
    default = "opc"
}

variable web_vm_mnt_path {
    default = "/mnt1"
}

#WebVms
variable vm_count {
    default = "4"
}

variable vm_hostname {
    default = ["oemwebvm01","oemwebvm02","otmwebvm01","otmwebvm02"]
}

variable image_shape {
 default = "VM.Standard.E3.Flex"
}

variable vm_shape {
    default = ["VM.Standard.E3.Flex","VM.Standard.E3.Flex","VM.Standard.E3.Flex","VM.Standard.E3.Flex"]
}

variable boot_volume_size_in_gbs {
    default = ["50","50","50","50"]
}

variable vm_state {
    default = ["RUNNING","RUNNING","RUNNING","RUNNING"]
}

variable memoery_in_gbs {
    default = ["64","64","64","64"]
}

variable  ocpus {
 default = ["1","1","1","1"]
}                     

#AppVMS
variable app_vm_count {
    default = "6"
}

variable app_no_web_vm_count {
    default = "2"
}

variable app_image_shape {
 default = "VM.Standard.E4.Flex"
}
variable app_vm_hostname {
    default = ["obiappvm01","obiappvm02","otmappvm01","otmappvm02","oeappvm01","oeappvm02"]
}

variable app_vm_shape {
    default = ["VM.Standard.E4.Flex","VM.Standard.E4.Flex","VM.Standard.E4.Flex","VM.Standard.E4.Flex","VM.Standard.E4.Flex","VM.Standard.E4.Flex"]
}

variable app_boot_volume_size_in_gbs {
    default = ["50","50","50","50","50","50"]
}

variable app_vm_state {
    default = ["RUNNING","RUNNING","RUNNING","RUNNING","RUNNING","RUNNING"]
}

variable app_memoery_in_gbs {
    default = ["64","64","64","64","64","64"]
}

variable  app_ocpus {
 default = ["1","1","1","1","1","1"]
}                     