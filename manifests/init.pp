# == Class: foreman_proxy_content
#
# Configure content for foreman proxy for use by katello
#
# === Parameters:
#
# $parent_fqdn::                        FQDN of the parent pulp node.
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
# $pulp_master_standalone::             Whether the pulp master should manage httpd, only useable when having a pulp master without katello on the same server
#
# $pulp_admin_password::                Password for the Pulp admin user. It should be left blank so that a random password is generated
#
# $pulp_oauth_effective_user::          User to be used for Pulp REST interaction
#
# $pulp_oauth_key::                     OAuth key to be used for Pulp REST interaction
#
# $pulp_oauth_secret::                  OAuth secret to be used for Pulp REST interaction
#
# $pulp_max_speed::                     The maximum download speed per second for a Pulp task, such as a sync. (e.g. "4 Kb" (Uses SI KB), 4MB, or 1GB" )
#
# $pulp_consumers_crl::                 Certificate revocation list for consumers which are no valid (have had their client certs revoked)
#
# $pulp_max_tasks_per_child::           Number of tasks after which the worker is restarted and the memory it allocated is returned to the system
#
# $pulp_num_workers::                   Number of Pulp workers to use.
#
# $pulp_proxy_password::                Proxy password for authentication
#
# $pulp_proxy_port::                    Port the proxy is running on
#
# $pulp_proxy_url::                     URL of the proxy server
#
# $pulp_proxy_username::                Proxy username for authentication
#
# $pulp_puppet_wsgi_processes::         Number of WSGI processes to spawn for the puppet webapp
#
# $reverse_proxy::                      Add reverse proxy to the parent
#
# $reverse_proxy_port::                 Reverse proxy listening port
#
# $rhsm_url::                           The URL that the RHSM API is rooted at
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
# $install_local_qpid::                 Should a local qpid server be installed
class foreman_proxy_content (
  String[1] $parent_fqdn = $foreman_proxy_content::params::parent_fqdn,
  Optional[Stdlib::Absolutepath] $certs_tar = $foreman_proxy_content::params::certs_tar,
  Boolean $pulp_master = $foreman_proxy_content::params::pulp_master,
  Boolean $pulp_master_standalone = $foreman_proxy_content::params::pulp_master_standalone,
  String $pulp_admin_password = $foreman_proxy_content::params::pulp_admin_password,
  String $pulp_oauth_effective_user = $foreman_proxy_content::params::pulp_oauth_effective_user,
  String $pulp_oauth_key = $foreman_proxy_content::params::pulp_oauth_key,
  Optional[String] $pulp_oauth_secret = $foreman_proxy_content::params::pulp_oauth_secret,
  Optional[String] $pulp_max_speed = $foreman_proxy_content::params::pulp_max_speed,

  Boolean $puppet = $foreman_proxy_content::params::puppet,

  Boolean $reverse_proxy = $foreman_proxy_content::params::reverse_proxy,
  Integer[0, 65535] $reverse_proxy_port = $foreman_proxy_content::params::reverse_proxy_port,

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
  Boolean $install_local_qpid = $foreman_proxy_content::params::install_local_qpid,
  Optional[String] $pulp_consumers_crl = undef,
  Optional[Integer] $pulp_max_tasks_per_child = undef,
  Optional[Integer] $pulp_num_workers = undef,
  Optional[String] $pulp_proxy_password = undef,
  Optional[Integer] $pulp_proxy_port = undef,
  Optional[String] $pulp_proxy_url = undef,
  Optional[String] $pulp_proxy_username = undef,
  Optional[String] $pulp_puppet_wsgi_processes = undef,
) inherits foreman_proxy_content::params {
  include ::certs
  include ::foreman_proxy
  include ::foreman_proxy::plugin::pulp

  $pulp_node = $::foreman_proxy::plugin::pulp::pulpnode_enabled
  if $pulp_node and $pulp_master {
    fail('You cannot install pulp_node and pulp_master on same server')
  }

  if $pulp_node or $pulp_master {
    assert_type(String[1], $pulp_oauth_secret)
  }

  $foreman_proxy_fqdn = $::fqdn
  $foreman_url = $::foreman_proxy::foreman_base_url
  $setup_reverse_proxy = $pulp_node or $reverse_proxy or $pulp_master_standalone
  $create_pub_dir = $pulp_node or $reverse_proxy or $pulp_master_standalone
  $install_pulp = $pulp_node or $pulp_master
  $manage_httpd = $pulp_node or $pulp_master_standalone

  $rhsm_port = $setup_reverse_proxy ? {
    true  => $reverse_proxy_port,
    false => '443'
  }

  include ::certs::foreman_proxy
  Class['::certs::foreman_proxy'] ~> Service['foreman-proxy']

  class { '::certs::katello':
    deployment_url => $rhsm_url,
    rhsm_port      => $rhsm_port,
  }

  if $setup_reverse_proxy {
    class { '::certs::apache':
      hostname => $foreman_proxy_fqdn,
      require  => Class['certs'],
    }
    ~> class { '::foreman_proxy_content::reverse_proxy':
      path      => '/',
      url       => "${foreman_url}/",
      port      => $reverse_proxy_port,
      subscribe => Class['certs::foreman_proxy'],
    }
  }

  if $pulp_master or $pulp_node {
    if $qpid_router {
      class { '::foreman_proxy_content::dispatch_router':
        require => Class['pulp'],
      }
    }

    class { '::pulp::crane':
      cert     => $certs::apache::apache_cert,
      key      => $certs::apache::apache_key,
      ca_cert  => $certs::ca_cert,
      data_dir => '/var/lib/pulp/published/docker/v2/app',
      require  => Class['certs::apache'],
    }
  }

  if $pulp_node {
    file {'/etc/httpd/conf.d/pulp_nodes.conf':
      ensure  => file,
      content => template('foreman_proxy_content/pulp_nodes.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

    $default_password =  $pulp_admin_password
  }

  if $create_pub_dir {
    package { 'katello-client-bootstrap':
      ensure => installed,
    }
    include ::apache
    apache::vhost { 'foreman_proxy_content':
      servername          => $foreman_proxy_fqdn,
      port                => 80,
      priority            => '05',
      docroot             => '/var/www/html',
      options             => ['SymLinksIfOwnerMatch'],
      additional_includes => ['/etc/pulp/vhosts80/*.conf'],
      custom_fragment     => template('foreman_proxy_content/httpd_pub.erb'),
    }
  }

  # current behaviour always install qpid with a pulp_node unless you explicitly disable local qpid
  # pulp_master without standalone already has qpid through katello install
  if $install_local_qpid and ( $pulp_node or $pulp_master_standalone ) {
    include ::certs::qpid
    class { '::qpid':
      ssl                    => true,
      ssl_cert_db            => $::certs::nss_db_dir,
      ssl_cert_password_file => $::certs::qpid::nss_db_password_file,
      ssl_cert_name          => 'broker',
      interface              => 'lo',
      subscribe              => Class['::certs::qpid'],
    }
  }

  if $install_pulp {
    include ::certs::qpid_client

    if $manage_httpd {
      $ca_cert = $::certs::ca_cert
      $https_cert = $certs::apache::apache_cert
      $https_key = $certs::apache::apache_key
    } else {
      $ca_cert = undef
      $https_cert = undef
      $https_key = undef
    }

    if $pulp_node {
      $node_oauth_effective_user = $pulp_oauth_effective_user
      $node_oauth_key            = $pulp_oauth_key
      $node_oauth_secret         = $pulp_oauth_secret
      $node_server_ca_cert       = $certs::pulp_server_ca_cert
    } else {
      $node_oauth_effective_user = undef
      $node_oauth_key            = undef
      $node_oauth_secret         = undef
      $node_server_ca_cert       = undef
    }



    class { '::pulp':
      broker_url                => "qpid://${qpid_router_broker_addr}:${qpid_router_broker_port}",
      broker_use_ssl            => true,
      ca_cert                   => $ca_cert,
      consumers_crl             => $pulp_consumers_crl,
      default_password          => $default_password,
      enable_docker             => true,
      enable_katello            => $pulp_master,
      enable_ostree             => $enable_ostree,
      enable_parent_node        => false,
      enable_puppet             => true,
      enable_rpm                => true,
      https_cert                => $https_cert,
      https_key                 => $https_key,
      manage_broker             => false,
      manage_httpd              => $manage_httpd,
      manage_plugins_httpd      => true,
      manage_squid              => true,
      max_tasks_per_child       => $pulp_max_tasks_per_child,
      messaging_auth_enabled    => false,
      messaging_ca_cert         => $certs::ca_cert,
      messaging_client_cert     => $certs::qpid_client::messaging_client_cert,
      messaging_transport       => 'qpid',
      messaging_url             => "ssl://${qpid_router_broker_addr}:${qpid_router_broker_port}",
      node_oauth_effective_user => $node_oauth_effective_user,
      node_oauth_key            => $node_oauth_key,
      node_oauth_secret         => $node_oauth_secret,
      node_server_ca_cert       => $node_server_ca_cert,
      num_workers               => $pulp_num_workers,
      oauth_enabled             => true,
      oauth_key                 => $pulp_oauth_key,
      oauth_secret              => $pulp_oauth_secret,
      proxy_password            => $pulp_proxy_password,
      proxy_port                => $pulp_proxy_port,
      proxy_url                 => $pulp_proxy_url,
      proxy_username            => $pulp_proxy_username,
      puppet_wsgi_processes     => $pulp_puppet_wsgi_processes,
      repo_auth                 => true,
      subscribe                 => Class['certs::qpid_client'],
      yum_max_speed             => $pulp_max_speed,
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
