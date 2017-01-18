# == Class: foreman_proxy_content
#
# Configure content for foreman proxy for use by katello
#
# === Parameters:
#
# $parent_fqdn::                        FQDN of the parent node.
#
# $enable_ostree::                      Boolean to enable ostree plugin. This requires existence of an ostree install.
#                                       type:boolean
#
# $certs_tar::                          Path to a tar with certs for the node
#
# $puppet::                             Use puppet
#                                       type:boolean
#
# === Advanced parameters:
#
# $pulp_master::                        Whether the foreman_proxy_content should be identified as a pulp master server
#                                       type:boolean
#
# $pulp_admin_password::                Password for the Pulp admin user. It should be left blank so that a random password is generated
#
# $pulp_oauth_effective_user::          User to be used for Pulp REST interaction
#
# $pulp_oauth_key::                     OAuth key to be used for Pulp REST interaction
#
# $pulp_oauth_secret::                  OAuth secret to be used for Pulp REST interaction
#
# $puppet_ca_proxy::                    The actual server that handles puppet CA.
#                                       Setting this to anything non-empty causes
#                                       the apache vhost to set up a proxy for all
#                                       certificates pointing to the value.
#
# $puppet_server_implementation::       Puppet master implementation, either "master" (traditional
#                                       Ruby) or "puppetserver" (JVM-based)
# $reverse_proxy::                      Add reverse proxy to the parent
#                                       type:boolean
#
# $reverse_proxy_port::                 Reverse proxy listening port
#
# $rhsm_url::                           The URL that the RHSM API is rooted at
#
# $qpid_router::                        Configure qpid dispatch router
#                                       type:boolean
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
class foreman_proxy_content (
  $parent_fqdn                  = $foreman_proxy_content::params::parent_fqdn,
  $certs_tar                    = $foreman_proxy_content::params::certs_tar,
  $pulp_master                  = $foreman_proxy_content::params::pulp_master,
  $pulp_admin_password          = $foreman_proxy_content::params::pulp_admin_password,
  $pulp_oauth_effective_user    = $foreman_proxy_content::params::pulp_oauth_effective_user,
  $pulp_oauth_key               = $foreman_proxy_content::params::pulp_oauth_key,
  $pulp_oauth_secret            = $foreman_proxy_content::params::pulp_oauth_secret,

  $puppet                       = $foreman_proxy_content::params::puppet,
  $puppet_ca_proxy              = $foreman_proxy_content::params::puppet_ca_proxy,
  $puppet_server_implementation = undef,

  $reverse_proxy                = $foreman_proxy_content::params::reverse_proxy,
  $reverse_proxy_port           = $foreman_proxy_content::params::reverse_proxy_port,

  $rhsm_url                     = $foreman_proxy_content::params::rhsm_url,

  $qpid_router                  = $foreman_proxy_content::params::qpid_router,
  $qpid_router_hub_addr         = $foreman_proxy_content::params::qpid_router_hub_addr,
  $qpid_router_hub_port         = $foreman_proxy_content::params::qpid_router_hub_port,
  $qpid_router_agent_addr       = $foreman_proxy_content::params::qpid_router_agent_addr,
  $qpid_router_agent_port       = $foreman_proxy_content::params::qpid_router_agent_port,
  $qpid_router_broker_addr      = $foreman_proxy_content::params::qpid_router_broker_addr,
  $qpid_router_broker_port      = $foreman_proxy_content::params::qpid_router_broker_port,
  $qpid_router_logging_level    = $foreman_proxy_content::params::qpid_router_logging_level,
  $qpid_router_logging_path     = $foreman_proxy_content::params::qpid_router_logging_path,
  $enable_ostree                = $foreman_proxy_content::params::enable_ostree,
) inherits foreman_proxy_content::params {
  validate_bool($enable_ostree)

  include ::certs
  include ::foreman_proxy
  include ::foreman_proxy::plugin::pulp

  validate_present($foreman_proxy_content::parent_fqdn)
  validate_absolute_path($foreman_proxy_content::qpid_router_logging_path)

  $pulp = $::foreman_proxy::plugin::pulp::pulpnode_enabled
  if $pulp {
    validate_present($pulp_oauth_secret)
  }

  $foreman_proxy_fqdn = $::fqdn
  $foreman_url = "https://${parent_fqdn}"
  $reverse_proxy_real = $pulp or $reverse_proxy

  $rhsm_port = $reverse_proxy_real ? {
    true  => $reverse_proxy_port,
    false => '443'
  }

  package{ ['katello-debug', 'katello-client-bootstrap']:
    ensure => installed,
  }

  class { '::certs::foreman_proxy':
    hostname => $foreman_proxy_fqdn,
    require  => Package['foreman-proxy'],
    before   => Service['foreman-proxy'],
  } ~>
  class { '::certs::katello':
    deployment_url => $foreman_proxy_content::rhsm_url,
    rhsm_port      => $foreman_proxy_content::rhsm_port,
  }

  if $pulp or $reverse_proxy_real {
    class { '::certs::apache':
      hostname => $foreman_proxy_fqdn,
    } ~>
    Class['certs::foreman_proxy'] ~>
    class { '::foreman_proxy_content::reverse_proxy':
      path => '/',
      url  => "${foreman_url}/",
      port => $foreman_proxy_content::reverse_proxy_port,
    }
  }

  if $pulp_master or $pulp {
    if $qpid_router {
      class { '::foreman_proxy_content::dispatch_router':
        require => Class['pulp'],
      }
    }

    class { '::pulp::crane':
      cert    => $certs::apache::apache_cert,
      key     => $certs::apache::apache_key,
      ca_cert => $certs::ca_cert,
      require => Class['certs::apache'],
    }
  }

  if $pulp {
    include ::apache
    $apache_version = $::apache::apache_version

    file {'/etc/httpd/conf.d/pulp_nodes.conf':
      ensure  => file,
      content => template('foreman_proxy_content/pulp_nodes.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

    apache::vhost { 'foreman_proxy_content':
      servername      => $foreman_proxy_fqdn,
      port            => 80,
      priority        => '05',
      docroot         => '/var/www/html',
      options         => ['SymLinksIfOwnerMatch'],
      custom_fragment => template('foreman_proxy_content/_pulp_includes.erb', 'foreman_proxy_content/httpd_pub.erb'),
    }

    class { '::certs::qpid': } ~>
    class { '::certs::qpid_client': } ~>
    class { '::qpid':
      ssl                    => true,
      ssl_cert_db            => $::certs::nss_db_dir,
      ssl_cert_password_file => $::certs::qpid::nss_db_password_file,
      ssl_cert_name          => 'broker',
    } ~>
    class { '::pulp':
      enable_rpm                => true,
      enable_puppet             => true,
      enable_docker             => true,
      enable_ostree             => $enable_ostree,
      default_password          => $pulp_admin_password,
      oauth_enabled             => true,
      oauth_key                 => $pulp_oauth_key,
      oauth_secret              => $pulp_oauth_secret,
      messaging_transport       => 'qpid',
      messaging_auth_enabled    => false,
      messaging_ca_cert         => $certs::ca_cert,
      messaging_client_cert     => $certs::params::messaging_client_cert,
      messaging_url             => "ssl://${foreman_proxy_fqdn}:5671",
      broker_url                => "qpid://${qpid_router_broker_addr}:${qpid_router_broker_port}",
      broker_use_ssl            => true,
      manage_broker             => false,
      manage_httpd              => true,
      manage_plugins_httpd      => true,
      manage_squid              => true,
      repo_auth                 => true,
      node_oauth_effective_user => $pulp_oauth_effective_user,
      node_oauth_key            => $pulp_oauth_key,
      node_oauth_secret         => $pulp_oauth_secret,
      node_server_ca_cert       => $certs::params::pulp_server_ca_cert,
      https_cert                => $certs::apache::apache_cert,
      https_key                 => $certs::apache::apache_key,
      ca_cert                   => $certs::ca_cert,
      crane_data_dir            => '/var/lib/pulp/published/docker/v2/app',
    }

    pulp::apache::fragment{'gpg_key_proxy':
      ssl_content => template('foreman_proxy_content/_pulp_gpg_proxy.erb'),
    }
  }

  if $puppet {
    class { '::certs::puppet':
      hostname => $foreman_proxy_fqdn,
    } ~>
    class { '::puppet':
      server                      => true,
      server_ca                   => $::foreman_proxy::puppetca,
      server_foreman_url          => $foreman_url,
      server_foreman_ssl_cert     => $::certs::puppet::client_cert,
      server_foreman_ssl_key      => $::certs::puppet::client_key,
      server_foreman_ssl_ca       => $::certs::puppet::ssl_ca_cert,
      server_storeconfigs_backend => false,
      server_dynamic_environments => true,
      server_environments_owner   => 'apache',
      server_config_version       => '',
      server_enc_api              => 'v2',
      server_ca_proxy             => $puppet_ca_proxy,
      server_implementation       => $puppet_server_implementation,
      additional_settings         => {
                                        'disable_warnings' => 'deprecations',
      },
    }
  }

  if $certs_tar {
    certs::tar_extract { $foreman_proxy_content::certs_tar: } -> Class['certs']
    Certs::Tar_extract[$certs_tar] -> Class['certs::foreman_proxy']

    if $reverse_proxy_real or $pulp {
      Certs::Tar_extract[$certs_tar] -> Class['certs::apache']
    }

    if $pulp {
      Certs::Tar_extract[$certs_tar] -> Class['certs'] -> Class['::certs::qpid']
    }

    if $puppet {
      Certs::Tar_extract[$certs_tar] -> Class['certs::puppet']
    }
  }
}
