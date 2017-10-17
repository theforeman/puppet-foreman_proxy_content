# == Class: foreman_proxy_content
#
# Configure content for foreman proxy for use by katello
#
# === Parameters:
#
# $parent_fqdn::                        FQDN of the parent node.
#
# $enable_ostree::                      Enable ostree content plugin, this requires an ostree install
#
# $enable_yum::                         Enable rpm content plugin, including syncing of yum content
#
# $enable_file::                        Enable file content plugin
#
# $enable_puppet::                      Enable puppet content plugin
#
# $enable_docker::                      Enable docker content plugin
#
# $enable_deb::                         Enable debian content plugin
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
# $qpid_router_logging::                Whether to log to file or syslog.
#
# $qpid_router_logging_path::           Directory for dispatch router logs, if using file logging
#
# $qpid_router_ssl_ciphers::            SSL Ciphers to support in dispatch router
#
# $qpid_router_ssl_protocols::          Protocols to support in dispatch router (e.g. TLSv1.2, etc)
#
# $manage_broker::                      Manage the qpid message broker when applicable
#
# $pulp_worker_timeout::                The amount of time (in seconds) before considering a worker as missing. If Pulp's
#                                       mongo database has slow I/O, then setting a higher number may resolve issues where workers are
#                                       going missing incorrectly.
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
  Integer[0] $pulp_worker_timeout = $foreman_proxy_content::params::pulp_worker_timeout,

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
  Enum['file', 'syslog'] $qpid_router_logging = $foreman_proxy_content::params::qpid_router_logging,
  Stdlib::Absolutepath $qpid_router_logging_path = $foreman_proxy_content::params::qpid_router_logging_path,
  Optional[String] $qpid_router_ssl_ciphers = $foreman_proxy_content::params::qpid_router_ssl_ciphers,
  Optional[Array[String]] $qpid_router_ssl_protocols = $foreman_proxy_content::params::qpid_router_ssl_protocols,
  Boolean $enable_ostree = $foreman_proxy_content::params::enable_ostree,
  Boolean $enable_yum = $foreman_proxy_content::params::enable_yum,
  Boolean $enable_file = $foreman_proxy_content::params::enable_file,
  Boolean $enable_puppet = $foreman_proxy_content::params::enable_puppet,
  Boolean $enable_docker = $foreman_proxy_content::params::enable_docker,
  Boolean $enable_deb = $foreman_proxy_content::params::enable_deb,

  Boolean $manage_broker = $foreman_proxy_content::params::manage_broker,
) inherits foreman_proxy_content::params {
  include ::certs
  include ::certs::foreman_proxy
  include ::foreman_proxy
  include ::foreman_proxy::plugin::pulp
  Class['certs::foreman_proxy'] ~> Class['foreman_proxy::service']

  $pulp_node = $::foreman_proxy::plugin::pulp::pulpnode_enabled

  if $pulp_node and $pulp_master {
    fail("Can't enable both pulp node and master support")
  }

  $foreman_url = $::foreman_proxy::foreman_base_url
  $setup_reverse_proxy = $pulp_node or $reverse_proxy

  $rhsm_port = $setup_reverse_proxy ? {
    true  => $reverse_proxy_port,
    false => '443'
  }

  ensure_packages('katello-debug')

  class { '::certs::katello':
    hostname       => $rhsm_hostname,
    deployment_url => $rhsm_url,
    rhsm_port      => $rhsm_port,
  }

  if $setup_reverse_proxy {
    include ::foreman_proxy_content::reverse_proxy
  }

  if $pulp_master {
    include ::foreman_proxy_content::pulp::master
  }

  if $pulp_node {
    include ::foreman_proxy_content::pulp::node
  }

  if $puppet {
    include ::foreman_proxy_content::puppet
  }

  if $certs_tar {
    certs::tar_extract { $certs_tar:
      before => Class['certs'],
    }
  }
}
