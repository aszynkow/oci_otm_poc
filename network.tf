resource oci_core_subnet otm_lbsub {
  #availability_domain = <<Optional value not found in discovery>>
  cidr_block     = var.lb_subnet_cidr
  compartment_id = var.compartment_ocid
  dhcp_options_id = local.Okit_Vcn001_dhcp_options_id
  display_name    = local.lbsubnet_name#"lbsub"
  dns_label       = local.lbdns_name#"lbsub"
  #freeform_tags = var.#freeform_tags
  #ipv6cidr_block = <<Optional value not found in discovery>>
  #prohibit_internet_ingress  = "true"
  #prohibit_public_ip_on_vnic = "true"
  route_table_id             = oci_core_route_table.otm_lbrt.id
  security_list_ids = [
    oci_core_security_list.otm_empty.id,
  ]
  vcn_id = local.Okit_Vcn001_id   
}

resource oci_core_route_table otm_lbrt {
  compartment_id = var.compartment_ocid
  display_name = local.lbrt_name
  #freeform_tags = var.#freeform_tags
  route_rules {
    description       = "Internet"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = local.Okit_Igw01_id
  }
  vcn_id = local.Okit_Vcn001_id 
}

resource oci_core_security_list otm_empty {
  compartment_id = var.compartment_ocid
  display_name = local.lbsl_name
  egress_security_rules {
    #description = <<Optional value not found in discovery>>
    destination      = var.sub01_ip_range
    destination_type = "CIDR_BLOCK"
    #icmp_options = <<Optional value not found in discovery>>
    protocol  = "6"
    stateless = "false"
    tcp_options {
      max = "80"
      min = "80"
      #source_port_range = <<Optional value not found in discovery>>
    }
  }
  ingress_security_rules {
        # Required
        protocol    = "all"
        source      = "0.0.0.0/0"
        # Optional
        source_type  = "CIDR_BLOCK"
        description  = ""
    }  
  vcn_id = local.Okit_Vcn001_id  
}


locals {
    Okit_Comp002_id = local.DeploymentCompartment_id#oci_identity_compartment.Okit_Comp002.id
}

# ------ Create Security List
resource "oci_core_security_list" "Okit_Sl002" {
    # Required
    compartment_id = local.Okit_Comp002_id
    vcn_id         = local.Okit_Vcn001_id
    egress_security_rules {
        # Required
        protocol    = "all"
        destination = "0.0.0.0/0"
        # Optional
        destination_type  = "CIDR_BLOCK"
        description  = ""
    }
    ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    #icmp_options = <<Optional value not found in discovery>>
    protocol    = "6"
    source      = var.on_prem_ip_range
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
      #source_port_range = <<Optional value not found in discovery>>
    }
    #udp_options = <<Optional value not found in discovery>>
  }

  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    #icmp_options = <<Optional value not found in discovery>>
    protocol    = "all"
    source      = local.vcn_ip_range
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    #tcp_options = <<Optional value not found in discovery>>
    #udp_options = <<Optional value not found in discovery>>
  }

    display_name   = local.sl2_name
    #freeform_tags  =   var.#freeform_tags
}

locals {
    Okit_Sl002_id = oci_core_security_list.Okit_Sl002.id
}


# ------ Create Route Table
# ------- Update VCN Default Route Table
/*resource "oci_core_default_route_table" "Okit_Rt001" {
    # Required
    manage_default_resource_id = local.Okit_Vcn001_default_route_table_id
    #compartment_id = local.Okit_Comp002_id
    #vcn_id         = local.Okit_Vcn001_id
    route_rules    {
        destination_type  = "CIDR_BLOCK"
        destination       = var.on_prem_ip_range
        network_entity_id = local.Okit_Drg001_id
        description       = ""
    }
    # Optional
    display_name   = local.rt1_name
}

locals {
    Okit_Rt001_id = oci_core_default_route_table.Okit_Rt001.id
    }

*/
# ------ Create Route Table

resource "oci_core_route_table" "Okit_Rt002" {
    # Required
    compartment_id = local.Okit_Comp002_id
    vcn_id         = local.Okit_Vcn001_id
    route_rules    {
        destination_type  = "CIDR_BLOCK"
        destination       = "0.0.0.0/0"
        network_entity_id = local.Okit_Ng001_id
        description       = ""
    }
    route_rules    {
        destination_type  = "CIDR_BLOCK"
        destination       = var.on_prem_ip_range
        network_entity_id = local.Okit_Drg001_id
        description       = "ON-prem"
    }

    route_rules    {
        destination_type  = "SERVICE_CIDR_BLOCK"
        destination       = local.Okit_Sg001Servicedest#var.service_dest#lookup([for x in data.oci_core_services.RegionServices.services: x if substr(x.name, 0, 3) == var.service_name][0], "cidr_block")
        network_entity_id = local.Okit_Sg001_id
        description       = "OSN"
    }


    # Optional
    display_name   = local.rt2_name
    #freeform_tags  =   var.#freeform_tags
}

locals {
    Okit_Rt002_id = oci_core_route_table.Okit_Rt002.id
}


/*
resource "oci_core_route_table" "Okit_drgrt" {
    # Required
    compartment_id = local.Okit_Comp002_id
    vcn_id         = local.Okit_Vcn001_id

    route_rules    {
        destination_type  = "SERVICE_CIDR_BLOCK"
        destination       = var.service_dest#lookup([for x in data.oci_core_services.RegionServices.services: x if substr(x.name, 0, 3) == var.service_name][0], "cidr_block")
        network_entity_id = local.Okit_Sg001_id
        description       = "OSN"
    }


    # Optional
    display_name   = local.drgrt_name
    #freeform_tags  =   var.#freeform_tags
}

locals {
    Okit_drgrt_id = oci_core_route_table.Okit_drgrt.id
}

resource "oci_core_route_table" "Okit_sgwrt" {
    # Required
    compartment_id = local.Okit_Comp002_id
    vcn_id         = local.Okit_Vcn001_id

   route_rules    {
        destination_type  = "CIDR_BLOCK"
        destination       = var.on_prem_ip_range
        network_entity_id = local.Okit_Drg001_id
        description       = "ON-prem"
    }

    # Optional
    display_name   = local.sgwrt_name
    #freeform_tags  =   var.#freeform_tags
}

locals {
    Okit_sgwrt_id = oci_core_route_table.Okit_sgwrt.id
}


*/
# ------ Create Subnet
# ---- Create Public Subnet
resource "oci_core_subnet" "Okit_Sn001" {
    # Required
    compartment_id             = local.Okit_Comp002_id
    vcn_id                     = local.Okit_Vcn001_id
    cidr_block                 = var.sub01_ip_range
    # Optional
    display_name               = local.subnet_name
    dns_label                  = local.subnet_name
    security_list_ids          = [local.Okit_Sl002_id]
    route_table_id             = local.Okit_Rt002_id
    dhcp_options_id            = local.Okit_Vcn001_dhcp_options_id
    prohibit_public_ip_on_vnic = true
    #freeform_tags              =   var.#freeform_tags
}

locals {
    Okit_Sn001_id              = oci_core_subnet.Okit_Sn001.id
    Okit_Sn001_domain_name     = oci_core_subnet.Okit_Sn001.subnet_domain_name
}

resource "oci_core_subnet" "Okit_Sn002" {
    # Required
    compartment_id             = local.Okit_Comp002_id
    vcn_id                     = local.Okit_Vcn001_id
    cidr_block                 = var.sub02_ip_range
    # Optional
    display_name               = local.subnet_name_02
    dns_label                  = local.subnet_name_02
    security_list_ids          = [local.Okit_Sl002_id]
    route_table_id             = local.Okit_Rt002_id
    dhcp_options_id            = local.Okit_Vcn001_dhcp_options_id
    prohibit_public_ip_on_vnic = true
    #freeform_tags              =   var.#freeform_tags
}

locals {
    Okit_Sn002_id              = oci_core_subnet.Okit_Sn002.id
    Okit_Sn002_domain_name     = oci_core_subnet.Okit_Sn002.subnet_domain_name
}
