resource oci_load_balancer_load_balancer otm_wpaspoclb {
  compartment_id = var.compartment_ocid
  display_name = local.lb_name#"wpaspoclb"
  ip_mode    = "IPV4"
  is_private = "true"
  network_security_group_ids = [
    oci_core_network_security_group.nsgprivlb01.id,
  ]
  #reserved_ips = <<Optional value not found in discovery>>
  shape = var.lb_shape#"flexible"
  shape_details {
    maximum_bandwidth_in_mbps = var.maximum_bandwidth_in_mbps#"10"
    minimum_bandwidth_in_mbps = var.minimum_bandwidth_in_mbps#"10"
  }
  subnet_ids = [
    local.Okit_Sn001_id,
  ]
}

resource oci_load_balancer_listener otm_wpaspoclb_wpaspoclblsnr01 {
  connection_configuration {
    backend_tcp_proxy_protocol_version = "0"
    idle_timeout_in_seconds            = "60"
  }
  default_backend_set_name = oci_load_balancer_backend_set.otm_wpaspoclbbs01.name
  hostname_names = [
  ]
  load_balancer_id = oci_load_balancer_load_balancer.otm_wpaspoclb.id
  name             = local.lstn1_name#"wpaspoclblsnr01"
  #path_route_set_name = <<Optional value not found in discovery>>
  port     = "80"
  protocol = "HTTP"
  #routing_policy_name = <<Optional value not found in discovery>>
  rule_set_names = [
  ]
}

resource oci_load_balancer_backend_set otm_wpaspoclbbs01 {
  health_checker {
    interval_ms         = "10000"
    port                = "80"
    protocol            = "TCP"
    response_body_regex = ""
    retries             = "3"
    return_code         = "200"
    timeout_in_millis   = "3000"
    #url_path            = var.healthch_url_path#"/wpas/Login.html"
  }
  load_balancer_id = oci_load_balancer_load_balancer.otm_wpaspoclb.id
  name             = local.bcknd1_name#"wpaspoclbbs01"
  policy           = "ROUND_ROBIN"
}

resource oci_load_balancer_backend otm_vm {
  count = local.vm_count
  backendset_name  = oci_load_balancer_backend_set.otm_wpaspoclbbs01.name
  backup           = "false"
  drain            = "false"
  ip_address       = oci_core_instance.webvm[count.index].private_ip
  load_balancer_id = oci_load_balancer_load_balancer.otm_wpaspoclb.id
  offline          = "false"
  port             = "80"
  weight           = "1"
}

resource oci_load_balancer_backend_set otm_app_wpaspoclbbs01 {
  health_checker {
    interval_ms         = "10000"
    port                = "80"
    protocol            = "TCP"
    response_body_regex = ""
    retries             = "3"
    return_code         = "200"
    timeout_in_millis   = "3000"
    #url_path            = var.healthch_url_path#"/wpas/Login.html"
  }
  load_balancer_id = oci_load_balancer_load_balancer.otm_wpaspoclb.id
  name             = local.bcknd2_name#"wpaspoclbbs01"
  policy           = "ROUND_ROBIN"
}

resource oci_load_balancer_backend otm_app {
  count = local.app_no_web_vm_count
  backendset_name  = oci_load_balancer_backend_set.otm_app_wpaspoclbbs01.name
  backup           = "false"
  drain            = "false"
  ip_address       = oci_core_instance.appvm[count.index].private_ip
  load_balancer_id = oci_load_balancer_load_balancer.otm_wpaspoclb.id
  offline          = "false"
  port             = "80"
  weight           = "1"
}