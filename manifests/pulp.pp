# @summary Configure pulp
# @api private
class foreman_proxy_content::pulp {
  include certs::apache
  include certs::qpid_client

  $broker_url = "qpid://${foreman_proxy_content::qpid_router_broker_addr}:${foreman_proxy_content::qpid_router_broker_port}"
  $messaging_url = "ssl://${foreman_proxy_content::qpid_router_broker_addr}:${foreman_proxy_content::qpid_router_broker_port}"

  $enable_katello = $foreman_proxy_content::pulp2_master
  $manage_httpd = $foreman_proxy_content::pulp2_node

  # TODO: in katello, not here
  $db_ca_path = undef
  $db_name = undef
  $db_password = undef
  $db_replica_set = undef
  $db_seeds = undef
  $db_ssl = undef
  $db_ssl_certfile = undef
  $db_ssl_keyfile = undef
  $db_unsafe_autoretry = undef
  $db_username = undef
  $db_verify_ssl = undef
  $db_write_concern = undef
  $manage_db = undef

  # TODO: difference
  if $foreman_proxy_content::pulp2_master {
    $messaging_ca_cert      = $certs::qpid_client::qpid_client_ca_cert
    $messaging_client_cert  = $certs::qpid_client::qpid_client_cert
    $ca_cert                = undef
    $https_cert             = undef
    $https_key              = undef
  } else {
    $messaging_ca_cert      = pick($foreman_proxy_content::pulp_ca_cert, $certs::ca_cert)
    $messaging_client_cert  = $certs::qpid_client_cert
    $ca_cert                = $certs::apache::ca_cert
    $https_cert             = $certs::apache::apache_cert
    $https_key              = $certs::apache::apache_key
  }

  # TODO: probably useless - was passed to pulp(node) but appears unused
  #node_server_ca_cert    => $certs::pulp_server_ca_cert,

  class { 'pulp':
    broker_url             => $broker_url,
    broker_use_ssl         => true,
    ca_cert                => $ca_cert,
    db_ca_path             => $db_ca_path,
    db_name                => $db_name,
    db_password            => $db_password,
    db_replica_set         => $db_replica_set,
    db_seeds               => $db_seeds,
    db_ssl                 => $db_ssl,
    db_ssl_certfile        => $db_ssl_certfile,
    db_ssl_keyfile         => $db_ssl_keyfile,
    db_unsafe_autoretry    => $db_unsafe_autoretry,
    db_username            => $db_username,
    db_verify_ssl          => $db_verify_ssl,
    db_write_concern       => $db_write_concern,
    https_cert             => $https_cert,
    https_key              => $https_key,
    default_password       => $foreman_proxy_content::pulp_admin_password, # TODO: not in katello
    enable_deb             => $foreman_proxy_content::enable_deb,
    enable_docker          => $foreman_proxy_content::enable_docker,
    enable_iso             => $foreman_proxy_content::enable_file,
    enable_katello         => $enable_katello,
    enable_ostree          => $foreman_proxy_content::enable_ostree,
    enable_puppet          => $foreman_proxy_content::enable_puppet,
    enable_rpm             => $foreman_proxy_content::enable_yum,
    manage_broker          => false,
    manage_db              => $manage_db,
    manage_httpd           => $manage_httpd,
    manage_plugins_httpd   => true,
    manage_squid           => true,
    messaging_auth_enabled => false,
    messaging_ca_cert      => $messaging_client_cert,
    messaging_client_cert  => $messaging_client_cert,
    messaging_transport    => 'qpid',
    messaging_url          => $messaging_url,
    num_workers            => $foreman_proxy_content::pulp_num_workers,
    proxy_password         => $foreman_proxy_content::pulp_proxy_password, # TODO: not in katello
    proxy_port             => $foreman_proxy_content::pulp_proxy_port, # TODO: not in katello
    proxy_url              => $foreman_proxy_content::pulp_proxy_url, # TODO: not in katello
    proxy_username         => $foreman_proxy_content::pulp_proxy_username, # TODO: not in katello
    puppet_wsgi_processes  => $foreman_proxy_content::pulp_puppet_wsgi_processes,
    repo_auth              => true,
    server_name            => $foreman_proxy_content::foreman_proxy_fqdn, # TODO: not here
    ssl_protocol           => $foreman_proxy_content::ssl_protocol,
    subscribe              => Class['certs', 'certs::apache', 'certs::qpid_client'],
    worker_timeout         => $foreman_proxy_content::pulp_worker_timeout,
    yum_max_speed          => $foreman_proxy_content::pulp_max_speed,
  }

  contain pulp

  class { 'pulp::crane':
    cert         => $certs::apache::apache_cert,
    key          => $certs::apache::apache_key,
    ca_cert      => $certs::apache::ca_cert,
    data_dir     => '/var/lib/pulp/published/docker/v2/app',
    ssl_protocol => $foreman_proxy_content::ssl_protocol,
    require      => Class['certs::apache'],
  }

  if $foreman_proxy_content::qpid_router {
    class { 'foreman_proxy_content::dispatch_router':
      agent_addr    => $foreman_proxy_content::qpid_router_addr,
      agent_port    => $foreman_proxy_content::qpid_router_agent_port,
      ssl_ciphers   => $foreman_proxy_content::qpid_router_ssl_ciphers,
      ssl_protocols => $foreman_proxy_content::qpid_router_ssl_protocols,
      logging_level => $foreman_proxy_content::qpid_router_logging_level,
      logging       => $foreman_proxy_content::qpid_router_logging,
      logging_path  => $foreman_proxy_content::qpid_router_logging_path,
      Require        => Class['pulp'],
    }

    if $foreman_proxy_content::pulp2_master {
      class { 'foreman_proxy_content::dispatch_router::hub':
        hub_addr      => $foreman_proxy_content::qpid_router_hub_addr,
        hub_port      => $foreman_proxy_content::qpid_router_hub_port,
        broker_addr   => $foreman_proxy_content::qpid_router_broker_addr,
        broker_port   => $foreman_proxy_content::qpid_router_broker_port,
        sasl_mech     => $foreman_proxy_content::qpid_router_sasl_mech,
        sasl_username => $foreman_proxy_content::qpid_router_sasl_username,
        sasl_password => $foreman_proxy_content::qpid_router_sasl_password,
      }
    } else {
      class { 'foreman_proxy_content::dispatch_router::connector':
        host => $foreman_proxy_content::parent_fqdn,
        port => $foreman_proxy_content::qpid_router_hub_port,
      }
    }
  }

  include foreman_proxy_content::pub_dir

  if $pulp2_node {
    include apache

    file {'/etc/httpd/conf.d/pulp_nodes.conf':
      ensure  => file,
      content => template('foreman_proxy_content/pulp_nodes.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

    if $manage_broker {
      include foreman_proxy_content::broker
    }

    pulp::apache::fragment{'gpg_key_proxy':
      ssl_content => template('foreman_proxy_content/_pulp_gpg_proxy.erb', 'foreman_proxy_content/httpd_pub.erb'),
    }
  }
}
