# The pulp node configuration
#
# In this scenario we assume there is another pulp instance somewhere and this
# talks to a qpid router somewhere.
class foreman_proxy_content::pulp::node (
  String $foreman_url = $::foreman_proxy_content::foreman_url,
  Optional[String] $pulp_max_speed = $foreman_proxy_content::params::pulp_max_speed,
  String $pulp_admin_password = $::foreman_proxy_content::pulp_admin_password,
  Boolean $qpid_router = $::foreman_proxy_content::qpid_router,
  String $qpid_router_hub_host = $::foreman_proxy_content::parent_fqdn,
  Integer[0, 65535] $qpid_router_hub_port = $::foreman_proxy_content::qpid_router_hub_port,
  String $qpid_router_broker_addr = $::foreman_proxy_content::qpid_router_broker_addr,
  Integer[0, 65535] $qpid_router_broker_port = $::foreman_proxy_content::qpid_router_broker_port,
  Boolean $enable_ostree = $::foreman_proxy_content::enable_ostree,
  Boolean $enable_yum = $::foreman_proxy_content::enable_yum,
  Boolean $enable_file = $::foreman_proxy_content::enable_file,
  Boolean $enable_deb = $::foreman_proxy_content::enable_deb,
  Boolean $enable_puppet = $::foreman_proxy_content::enable_puppet,
  Boolean $enable_docker = $::foreman_proxy_content::enable_docker,
  Optional[Integer[0, 65535]] $pulp_proxy_port = $foreman_proxy_content::pulp_proxy_port,
  Optional[String] $pulp_proxy_url = $foreman_proxy_content::pulp_proxy_url,
  Optional[String] $pulp_proxy_username = $foreman_proxy_content::pulp_proxy_username,
  Optional[String] $pulp_proxy_password = $foreman_proxy_content::pulp_proxy_password,
  Integer[0] $pulp_worker_timeout = $foreman_proxy_content::pulp_worker_timeout,
) {
  if $qpid_router {
    include ::foreman_proxy_content::dispatch_router

    qpid::router::connector { 'hub':
      host         => $qpid_router_hub_host,
      port         => $qpid_router_hub_port,
      ssl_profile  => 'client',
      role         => 'inter-router',
      idle_timeout => 0,
    }

    qpid::router::link_route { 'hub-pulp-route-in':
      prefix    => 'pulp.',
      direction => 'in',
    }

    qpid::router::link_route { 'hub-pulp-route-out':
      prefix    => 'pulp.',
      direction => 'out',
    }

    qpid::router::link_route { 'hub-qmf-route-in':
      prefix    => 'qmf.',
      direction => 'in',
    }

    qpid::router::link_route { 'hub-qmf-route-out':
      prefix    => 'qmf.',
      direction => 'out',
    }
  }

  include ::apache
  include ::apache::mod::proxy
  include ::apache::mod::proxy_http
  include ::foreman_proxy_content::pub_dir

  include ::certs::qpid
  class { '::qpid':
    ssl                    => true,
    ssl_cert_db            => $::certs::nss_db_dir,
    ssl_cert_password_file => $::certs::qpid::nss_db_password_file,
    ssl_cert_name          => 'broker',
    interface              => 'lo',
    subscribe              => Class['certs', 'certs::qpid'],
  }

  include ::certs::apache
  include ::certs::qpid_client
  class { '::pulp':
    enable_ostree          => $enable_ostree,
    enable_rpm             => $enable_yum,
    enable_iso             => $enable_file,
    enable_deb             => $enable_deb,
    enable_puppet          => $enable_puppet,
    enable_docker          => $enable_docker,
    default_password       => $pulp_admin_password,
    messaging_transport    => 'qpid',
    messaging_auth_enabled => false,
    messaging_ca_cert      => $::certs::ca_cert,
    messaging_client_cert  => $::certs::qpid_client::messaging_client_cert,
    messaging_url          => "ssl://${qpid_router_broker_addr}:${qpid_router_broker_port}",
    broker_url             => "qpid://${qpid_router_broker_addr}:${qpid_router_broker_port}",
    broker_use_ssl         => true,
    manage_broker          => false,
    manage_httpd           => true,
    manage_plugins_httpd   => true,
    manage_squid           => true,
    repo_auth              => true,
    node_server_ca_cert    => $::certs::pulp_server_ca_cert,
    https_cert             => $::certs::apache::apache_cert,
    https_key              => $::certs::apache::apache_key,
    ca_cert                => $::certs::ca_cert,
    yum_max_speed          => $pulp_max_speed,
    enable_crane           => true,
    proxy_port             => $pulp_proxy_port,
    proxy_url              => $pulp_proxy_url,
    proxy_username         => $pulp_proxy_username,
    proxy_password         => $pulp_proxy_password,
    worker_timeout         => $pulp_worker_timeout,
    crane_data_dir         => '/var/lib/pulp/published/docker/v2/app',
    subscribe              => Class['certs', 'certs::apache', 'certs::qpid_client'],
  }

  pulp::apache::fragment { 'gpg_key_proxy':
    ssl_content => template('foreman_proxy_content/_pulp_gpg_proxy.erb', 'foreman_proxy_content/httpd_pub.erb'),
  }
}
