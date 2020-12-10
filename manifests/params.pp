# Default params for foreman_proxy_content settings
class foreman_proxy_content::params {
  # when not specified, we expect all in one installation
  $parent_fqdn = $facts['networking']['fqdn']

  $qpid_router_sasl_password = extlib::cache_data('foreman_cache_data', 'qpid_router_sasl_password', extlib::random_password(16))

  $pulpcore_postgresql_password = extlib::cache_data('pulpcore_cache_data', 'db_password', extlib::random_password(32))
  $pulpcore_worker_count        = min(8, $facts['processors']['count'])
}
