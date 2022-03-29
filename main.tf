#output "Home_Region" {
locals {
#    HomeRegion = [for x in data.oci_identity_region_subscriptions.RegionSubscriptions.region_subscriptions: x if x.is_home_region][0]
#    home_region = lookup(
#        {
#            for r in data.oci_identity_regions.Regions.regions : r.key => r.name
#        },
#        data.oci_identity_tenancy.Tenancy.home_region_key
#    )

    vm_count = var.vm_count !=null ? var.vm_count : 0
    app_vm_count = var.app_vm_count !=null ? var.app_vm_count : 0
    app_no_web_vm_count = var.app_no_web_vm_count !=null ? var.app_no_web_vm_count : 0
    ad = data.oci_identity_availability_domains.AvailabilityDomains.availability_domains["1" - 1]["name"]
    home_region = lookup(element(data.oci_identity_region_subscriptions.HomeRegion.region_subscriptions, 0), "region_name")

    #lb_certificate_id = data.oci_certificates_management_certificate.lb_certificate.id

    DeploymentCompartment_id              = var.compartment_ocid
    Okit_Vcn001_id = data.oci_core_vcns.otm_vcns.virtual_networks.0.id
    Okit_Drg001_id = var.existing_drg_id
    Okit_Sg001_id = data.oci_core_service_gateways.otm_service_gateways.service_gateways.0.id
    Okit_Ng001_id = data.oci_core_nat_gateways.otm_nat_gateways.nat_gateways.0.id
    vcn_ip_range = data.oci_core_vcns.otm_vcns.virtual_networks.0.cidr_block
    Okit_Igw01_id = data.oci_core_internet_gateways.otm_internet_gateways.gateways.0.id
    Okit_Vcn001_dhcp_options_id = data.oci_core_vcns.otm_vcns.virtual_networks.0.default_dhcp_options_id
    Okit_Sg001Servicedest = data.oci_core_services.RegionServices.services[1]["cidr_block"]
    #Network_comp_id = var.net_compartment_id
    env_name = var.env_name
    #vcn_name = join("",[local.env_name,"vcn"])
    subnet_name = join("",[local.env_name,"websub"])
    subnet_name_02 = join("",[local.env_name,"appsub"])
    #subnet_name_03 = join("",[local.env_name,"dbbkpsub"])
    #igw_name = join("",[local.env_name,"igw"])
    #sgw_name = join("",[local.env_name,"sgw"])
    #nat_name = join("",[local.env_name,"nat"])
    sl1_name = join("",[local.env_name,"sl1"])
    sl2_name = join("",[local.env_name,"sl2"])
    rt1_name = join("",[local.env_name,"rt1"])
    rt2_name = join("",[local.env_name,"rt2"])
    #drgat_name = join("",[local.env_name,"drgat"])
    nsg1_name = join("",[local.env_name,"nsg1"])
    #dhcp_name = join("",[local.env_name,"dhcp"])
    #vm1_name = var.vm1_name#join("",[local.env_name,"gg1vm"])
    #vm2_name = join("",[local.env_name,"gg2vm"])
    #drgrt_name = join("",[local.env_name,"drgrt"])
    #sgwrt_name = join("",[local.env_name,"sgwrt"])

    lb_name = join("",[local.env_name,"publb"])
    lbsl_name = join("",[local.env_name,"lbsl1"])
    lstn1_name = join("",[local.env_name,"lstn1"])
    #lstn2_name = join("",[local.env_name,"lstn2"])
    nsglb1_name = join("",[local.env_name,"nsglb1"])
    nsgprivlb1_name = join("",[local.env_name,"nsgprivlb1"])
    bcknd1_name = join("",[local.env_name,"bcknd1"])
    bcknd2_name = join("",[local.env_name,"bcknd2"])
    lbsubnet_name = join("",[local.env_name,"lbsub"])
    lbdns_name = join("",[local.env_name,"lbsub"])
    lbrt_name = join("",[local.env_name,"lbrt"])

    gold_policy_name = join("",[local.env_name,"goldbckp"])
    brz_policy_name = join("",[local.env_name,"bronzbckp"])
    silver_policy_name = join("",[local.env_name,"silverbckp"])
    volgroup_name = join("",[local.env_name,"volgrp"])

    bastion_name = join("",[local.env_name,"bst1"])

    gen_public_key = chomp(tls_private_key.ssh_key.public_key_openssh)
    gen_priv_key = tls_private_key.ssh_key.private_key_pem

    ssh_authorized_keys = var.ssh_authorized_keys !="" ? var.ssh_authorized_keys : local.gen_public_key
}