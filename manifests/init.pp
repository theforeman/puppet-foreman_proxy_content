# == Class: foreman_proxy_content
#
# Configure content for foreman proxy for use by katello
#
# === Parameters:
#
# $parent_fqdn::                        FQDN of the parent node.
#
# $enable_ostree::                      Boolean to enable ostree plugin. This requires existence of an ostree install.
#
# $certs_tar::                          Path to a tar with certs for the node
#
# === Advanced parameters:
#
# $puppet::                             Enable puppet
#
# $pulp_master::                        Whether the foreman_proxy_content should be identified as a pulp master server
#
# $pulp_admin_password::                Password for the Pulp admin user. It should be left blank so that a random password is generated
#
# $pulp_max_speed::                     The maximum download speed per second for a Pulp task, such as a sync. (e.g. "4 Kb" (Uses SI KB), 4MB, or 1GB" )
#
# $pulp_max_tasks_per_child::           Number of tasks after which the worker is restarted and the memory it allocated is returned to the system
#
# $pulp_num_workers::                   Number of Pulp workers to use.
#
# $pulp_proxy_port::                    Port of the http proxy server
#
# $pulp_proxy_url::                     URL of the http proxy server
#
# $pulp_proxy_username::                Proxy username for authentication
#
# $pulp_proxy_password::                Proxy password for authentication
#
# $pulp_puppet_wsgi_processes::         Number of WSGI processes to spawn for the puppet webapp
#
# $pulp_ca_cert::                       Absolute path to PEM encoded CA certificate file, used by Pulp to validate the identity of the broker using SSL.
#
# $reverse_proxy::                      Add reverse proxy to the parent
#
# $reverse_proxy_port::                 Reverse proxy listening port
#
# $rhsm_hostname::                      The hostname that the RHSM API is rooted at
#
# $rhsm_url::                           The URL path that the RHSM API is rooted at
#
# $ssl_protocol::                       Apache SSLProtocol configuration to use
#
# $qpid_router::                        Configure qpid dispatch router
#
# $qpid_router_hub_addr::               Address for dispatch router hub
#
# $qpid_router_hub_port::               Port for dispatch router hub
#
# $qpid_router_agent_addr::             Listener address for goferd agents
#
# $qpid_router_agent_port::             Listener port for goferd agents
#
# $qpid_router_broker_addr::            Address of qpidd broker to connect to
#
# $qpid_router_broker_port::            Port of qpidd broker to connect to
#
# $qpid_router_logging_level::          Logging level of dispatch router (e.g. info+ or debug+)
#
# $qpid_router_logging_path::           Directory for dispatch router logs
#
# $manage_broker::                      Manage the qpid message broker when applicable
#
class foreman_proxy_content (
  String[1] $parent_fqdn = $foreman_proxy_content::params::parent_fqdn,
  Optional[Stdlib::Absolutepath] $certs_tar = $foreman_proxy_content::params::certs_tar,
  Boolean $pulp_master = $foreman_proxy_content::params::pulp_master,
  String $pulp_admin_password = $foreman_proxy_content::params::pulp_admin_password,
  Optional[String] $pulp_max_speed = $foreman_proxy_content::params::pulp_max_speed,
  Optional[Integer[1]] $pulp_max_tasks_per_child = $foreman_proxy_content::params::pulp_max_tasks_per_child,
  Optional[Integer[1]] $pulp_num_workers = $foreman_proxy_content::params::pulp_num_workers,
  Optional[String] $pulp_proxy_password = $foreman_proxy_content::params::pulp_proxy_password,
  Optional[Integer[0, 65535]] $pulp_proxy_port = $foreman_proxy_content::params::pulp_proxy_port,
  Optional[String] $pulp_proxy_url = $foreman_proxy_content::params::pulp_proxy_url,
  Optional[String] $pulp_proxy_username = $foreman_proxy_content::params::pulp_proxy_username,
  Optional[Integer[1]] $pulp_puppet_wsgi_processes = $foreman_proxy_content::params::pulp_puppet_wsgi_processes,
  Optional[Stdlib::Absolutepath] $pulp_ca_cert = $foreman_proxy_content::params::pulp_ca_cert,

  Boolean $puppet = $foreman_proxy_content::params::puppet,

  Boolean $reverse_proxy = $foreman_proxy_content::params::reverse_proxy,
  Integer[0, 65535] $reverse_proxy_port = $foreman_proxy_content::params::reverse_proxy_port,
  Optional[String] $ssl_protocol = $foreman_proxy_content::params::ssl_protocol,

  Optional[String] $rhsm_hostname = $foreman_proxy_content::params::rhsm_hostname,
  String $rhsm_url = $foreman_proxy_content::params::rhsm_url,

  Boolean $qpid_router = $foreman_proxy_content::params::qpid_router,
  String $qpid_router_hub_addr = $foreman_proxy_content::params::qpid_router_hub_addr,
  Integer[0, 65535] $qpid_router_hub_port = $foreman_proxy_content::params::qpid_router_hub_port,
  String $qpid_router_agent_addr = $foreman_proxy_content::params::qpid_router_agent_addr,
  Integer[0, 65535] $qpid_router_agent_port = $foreman_proxy_content::params::qpid_router_agent_port,
  String $qpid_router_broker_addr = $foreman_proxy_content::params::qpid_router_broker_addr,
  Integer[0, 65535] $qpid_router_broker_port = $foreman_proxy_content::params::qpid_router_broker_port,
  String $qpid_router_logging_level = $foreman_proxy_content::params::qpid_router_logging_level,
  Stdlib::Absolutepath $qpid_router_logging_path = $foreman_proxy_content::params::qpid_router_logging_path,
  Boolean $enable_ostree = $foreman_proxy_content::params::enable_ostree,

  Boolean $manage_broker = $foreman_proxy_content::params::manage_broker,
) inherits foreman_proxy_content::params {
  include ::certs
  include ::foreman_proxy
  include ::foreman_proxy::plugin::pulp

  $pulp = $::foreman_proxy::plugin::pulp::pulpnode_enabled

  $foreman_proxy_fqdn = $::fqdn
  $foreman_url = $::foreman_proxy::foreman_base_url
  $reverse_proxy_real = $pulp or $reverse_proxy

  $rhsm_port = $reverse_proxy_real ? {
    true  => $reverse_proxy_port,
    false => '443'
  }

  ensure_packages('katello-debug')

  class { '::certs::foreman_proxy':
    hostname => $foreman_proxy_fqdn,
    require  => Class['certs'],
    notify   => Service['foreman-proxy'],
  }

  class { '::certs::katello':
    hostname       => $rhsm_hostname,
    deployment_url => $rhsm_url,
    rhsm_port      => $rhsm_port,
    require        => Class['certs'],
  }

  if $pulp or $reverse_proxy_real {
    class { '::certs::apache':
      hostname => $foreman_proxy_fqdn,
      require  => Class['certs'],
    }
    ~> class { '::foreman_proxy_content::reverse_proxy':
      path         => '/',
      url          => "${foreman_url}/",
      port         => $reverse_proxy_port,
      subscribe    => Class['certs::foreman_proxy'],
      ssl_protocol => $ssl_protocol,
    }
  }

  if $pulp_master or $pulp {
    if $qpid_router {
      class { '::foreman_proxy_content::dispatch_router':
        require => Class['pulp'],
      }
    }

    class { '::pulp::crane':
      cert         => $certs::apache::apache_cert,
      key          => $certs::apache::apache_key,
      ca_cert      => $certs::ca_cert,
      data_dir     => '/var/lib/pulp/published/docker/v2/app',
      ssl_protocol => $ssl_protocol,
      require      => Class['certs::apache'],
    }
  }

  if $pulp {
    include ::apache

    file {'/etc/httpd/conf.d/pulp_nodes.conf':
      ensure  => file,
      content => template('foreman_proxy_content/pulp_nodes.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

    include ::foreman_proxy_content::pub_dir

    if $manage_broker {
      include ::foreman_proxy_content::broker
    }

    class { '::certs::qpid_client':
      require => Class['certs'],
    }
    ~> class { '::pulp':
      enable_rpm             => true,
      enable_puppet          => true,
      enable_docker          => true,
      enable_ostree          => $enable_ostree,
      default_password       => $pulp_admin_password,
      messaging_transport    => 'qpid',
      messaging_auth_enabled => false,
      messaging_ca_cert      => pick($pulp_ca_cert, $::certs::ca_cert),
      messaging_client_cert  => $certs::messaging_client_cert,
      messaging_url          => "ssl://${qpid_router_broker_addr}:${qpid_router_broker_port}",
      broker_url             => "qpid://${qpid_router_broker_addr}:${qpid_router_broker_port}",
      broker_use_ssl         => true,
      manage_broker          => false,
      manage_httpd           => true,
      manage_plugins_httpd   => true,
      manage_squid           => true,
      puppet_wsgi_processes  => $pulp_puppet_wsgi_processes,
      max_tasks_per_child    => $pulp_max_tasks_per_child,
      num_workers            => $pulp_num_workers,
      repo_auth              => true,
      node_server_ca_cert    => $certs::pulp_server_ca_cert,
      https_cert             => $certs::apache::apache_cert,
      https_key              => $certs::apache::apache_key,
      ssl_protocol           => $ssl_protocol,
      ca_cert                => $certs::ca_cert,
      yum_max_speed          => $pulp_max_speed,
      proxy_port             => $pulp_proxy_port,
      proxy_url              => $pulp_proxy_url,
      proxy_username         => $pulp_proxy_username,
      proxy_password         => $pulp_proxy_password,
    }

    pulp::apache::fragment{'gpg_key_proxy':
      ssl_content => template('foreman_proxy_content/_pulp_gpg_proxy.erb', 'foreman_proxy_content/httpd_pub.erb'),
    }
  }

  if $puppet {
    # We can't pull the certs out to the top level, because of how it gets the default
    # parameter values from the main ::certs class.  Kafo can't handle that case, so
    # it remains here for now.
    include ::puppet
    include ::puppet::server
    class { '::certs::puppet':
      hostname => $foreman_proxy_fqdn,
      require  => Class['certs'],
      notify   => Class['puppet'],
    }
  }

  if $certs_tar {
    certs::tar_extract { $certs_tar:
      before => Class['certs'],
    }
  }
}
