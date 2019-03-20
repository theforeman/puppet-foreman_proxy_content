# Default params for foreman_proxy_content settings
class foreman_proxy_content::params {

  # when not specified, we expect all in one installation
  $parent_fqdn        = $facts['fqdn']

  $reverse_proxy      = false
  $reverse_proxy_port = 8443

  $ssl_protocol = undef

  $certs_tar = undef
  $rhsm_hostname = undef
  $rhsm_url = '/rhsm'

  $puppet                    = true

  $pulp_master               = false
  $pulp_admin_password       = extlib::cache_data('foreman_cache_data', 'pulp_node_admin_password', extlib::random_password(32))
  $pulp_max_speed            = undef
  $pulp_max_tasks_per_child  = undef
  $pulp_num_workers          = undef
  $pulp_proxy_password       = undef
  $pulp_proxy_port           = undef
  $pulp_proxy_url            = undef
  $pulp_proxy_username       = undef
  $pulp_puppet_wsgi_processes = 1
  $pulp_ca_cert              = undef
  $pulp_worker_timeout       = 60

  $qpid_router               = true
  $qpid_router_agent_addr    = undef
  $qpid_router_agent_port    = 5647
  $qpid_router_broker_addr   = 'localhost'
  $qpid_router_broker_port   = 5671
  $qpid_router_hub_addr      = undef
  $qpid_router_hub_port      = 5646
  $qpid_router_logging_level = 'info+'
  $qpid_router_logging       = 'syslog'
  $qpid_router_logging_path  = '/var/log/qdrouterd'
  $qpid_router_ssl_ciphers   = undef
  $qpid_router_ssl_protocols = undef
  $qpid_router_sasl_mech   = 'PLAIN'
  $qpid_router_sasl_username = 'katello_agent'
  $qpid_router_sasl_password = cache_data('foreman_cache_data', 'qpid_router_sasl_password', random_password(16))

  $enable_ostree             = false
  $enable_yum                = true
  $enable_file               = true
  $enable_puppet             = true
  $enable_docker             = true
  $enable_deb                = true

  $manage_broker             = true
}
