# Default params for foreman_proxy_content settings
class foreman_proxy_content::params {

  # when not specified, we expect all in one installation
  $parent_fqdn                  = $facts['networking']['fqdn']

  $reverse_proxy                = false
  $reverse_proxy_port           = 8443

  $ssl_protocol                 = undef

  $certs_tar                    = undef
  $rhsm_hostname                = undef
  $rhsm_url                     = '/rhsm'

  $puppet                       = true

  $pulp_admin_password          = extlib::cache_data('foreman_cache_data', 'pulp_node_admin_password', extlib::random_password(32))
  $pulp_max_speed               = undef
  $pulp_num_workers             = undef
  $pulp_proxy_password          = undef
  $pulp_proxy_port              = undef
  $pulp_proxy_url               = undef
  $pulp_proxy_username          = undef
  $pulp_puppet_wsgi_processes   = 1
  $pulp_ca_cert                 = undef
  $pulp_worker_timeout          = 60

  $qpid_router                  = true
  $qpid_router_agent_addr       = undef
  $qpid_router_agent_port       = 5647
  $qpid_router_broker_addr      = 'localhost'
  $qpid_router_broker_port      = 5671
  $qpid_router_hub_addr         = undef
  $qpid_router_hub_port         = 5646
  $qpid_router_logging_level    = 'info+'
  $qpid_router_logging          = 'syslog'
  $qpid_router_logging_path     = '/var/log/qdrouterd'
  $qpid_router_ssl_ciphers      = undef
  $qpid_router_ssl_protocols    = undef
  $qpid_router_sasl_mech        = 'PLAIN'
  $qpid_router_sasl_username    = 'katello_agent'
  $qpid_router_sasl_password    = extlib::cache_data('foreman_cache_data', 'qpid_router_sasl_password', extlib::random_password(16))

  $enable_ostree                = false
  $enable_yum                   = true
  $enable_file                  = true
  $proxy_pulp_isos_to_pulpcore  = true
  $proxy_pulp_yum_to_pulpcore   = true
  $enable_puppet                = true
  $enable_docker                = true
  $enable_deb                   = true

  $manage_broker                = true

  $pulpcore_manage_postgresql      = true
  $pulpcore_postgresql_host        = 'localhost'
  $pulpcore_postgresql_port        = 5432
  $pulpcore_postgresql_user        = 'pulp'
  $pulpcore_postgresql_password    = extlib::cache_data('pulpcore_cache_data', 'db_password', extlib::random_password(32))
  $pulpcore_postgresql_db_name     = 'pulpcore'
  $pulpcore_postgresql_ssl         = false
  $pulpcore_postgresql_ssl_require = true
  $pulpcore_postgresql_ssl_cert    = '/etc/pki/katello/certs/pulpcore-database.crt'
  $pulpcore_postgresql_ssl_key     = '/etc/pki/katello/private/pulpcore-database.key'
  $pulpcore_postgresql_ssl_root_ca = '/etc/pki/tls/certs/ca-bundle.crt'
  $pulpcore_worker_count           = min(8, $facts['processors']['count'])
  $pulpcore_media_root             = '/var/lib/pulp'
}
