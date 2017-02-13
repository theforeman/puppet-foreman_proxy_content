# Default params for foreman_proxy_content settings
class foreman_proxy_content::params {

  # when not specified, we expect all in one installation
  $parent_fqdn        = $::fqdn

  $reverse_proxy      = false
  $reverse_proxy_port = 8443

  $certs_tar = undef

  $rhsm_proxy = true
  $rhsm_url = '/rhsm'
  $rhsm_port = 443

  $puppet                    = true

  $pulp_ports                = [443]
  $pulp_master               = false
  $pulp_admin_password       = cache_data('foreman_cache_data', 'pulp_node_admin_password', random_password(32))
  $pulp_oauth_effective_user = 'admin'
  $pulp_oauth_key            = 'katello'
  $pulp_oauth_secret         = undef
  $pulp_max_speed            = undef

  $qpid_router               = true
  $qpid_router_hub_addr      = '0.0.0.0'
  $qpid_router_agent_addr    = '0.0.0.0'
  $qpid_router_broker_addr   = 'localhost'
  $qpid_router_hub_port      = 5646
  $qpid_router_agent_port    = 5647
  $qpid_router_broker_port   = 5671
  $qpid_router_logging_level = 'info+'
  $qpid_router_logging_path  = '/var/log/qdrouterd'
  $enable_ostree             = false
}
