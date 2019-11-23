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
# === Advanced parameters:
#
# $puppet::                             Enable puppet
#
# $pulp_admin_password::                Password for the Pulp admin user. It should be left blank so that a random password is generated
#
# $pulp_max_speed::                     The maximum download speed per second for a Pulp task, such as a sync. (e.g. "4 Kb" (Uses SI KB), 4MB, or 1GB" )
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

  String $pulp_admin_password = $foreman_proxy_content::params::pulp_admin_password,
  Optional[String] $pulp_max_speed = $foreman_proxy_content::params::pulp_max_speed,
  Optional[Integer[1]] $pulp_num_workers = $foreman_proxy_content::params::pulp_num_workers,
  Optional[String] $pulp_proxy_password = $foreman_proxy_content::params::pulp_proxy_password,
  Optional[Stdlib::Port] $pulp_proxy_port = $foreman_proxy_content::params::pulp_proxy_port,
  Optional[String] $pulp_proxy_url = $foreman_proxy_content::params::pulp_proxy_url,
  Optional[String] $pulp_proxy_username = $foreman_proxy_content::params::pulp_proxy_username,
  Optional[Integer[1]] $pulp_puppet_wsgi_processes = $foreman_proxy_content::params::pulp_puppet_wsgi_processes,
  Optional[Stdlib::Absolutepath] $pulp_ca_cert = $foreman_proxy_content::params::pulp_ca_cert,
  Integer[0] $pulp_worker_timeout = $foreman_proxy_content::params::pulp_worker_timeout,

  Boolean $puppet = $foreman_proxy_content::params::puppet,

  Boolean $reverse_proxy = $foreman_proxy_content::params::reverse_proxy,
  Stdlib::Port $reverse_proxy_port = $foreman_proxy_content::params::reverse_proxy_port,
  Optional[String] $ssl_protocol = $foreman_proxy_content::params::ssl_protocol,

  Optional[String] $rhsm_hostname = $foreman_proxy_content::params::rhsm_hostname,
  String $rhsm_url = $foreman_proxy_content::params::rhsm_url,

  Boolean $qpid_router = $foreman_proxy_content::params::qpid_router,
  Stdlib::Port $qpid_router_hub_port = $foreman_proxy_content::params::qpid_router_hub_port,
  Optional[String] $qpid_router_agent_addr = $foreman_proxy_content::params::qpid_router_agent_addr,
  Stdlib::Port $qpid_router_agent_port = $foreman_proxy_content::params::qpid_router_agent_port,
  String $qpid_router_broker_addr = $foreman_proxy_content::params::qpid_router_broker_addr,
  Stdlib::Port $qpid_router_broker_port = $foreman_proxy_content::params::qpid_router_broker_port,
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
  include foreman_proxy

  $foreman_proxy_fqdn = $facts['fqdn']
  $foreman_url = $foreman_proxy::foreman_base_url

  ensure_packages('katello-debug')

  class { 'certs::foreman_proxy':
    hostname => $foreman_proxy_fqdn,
    notify   => Service['foreman-proxy'],
  }

  class { 'certs::apache':
    hostname => $foreman_proxy_fqdn,
  }

  class { 'foreman_proxy_content::pulp':
    is_mirror             => true,
    enable_ostree         => $enable_ostree,
    enable_yum            => $enable_yum,
    enable_file           => $enable_file,
    enable_puppet         => $enable_puppet,
    enable_docker         => $enable_docker,
    enable_deb            => $enable_deb,
    default_password      => $pulp_admin_password,
    yum_max_speed         => $pulp_max_speed,
    num_workers           => $pulp_num_workers,
    broker_host           => $qpid_router_broker_addr,
    broker_port           => $qpid_router_broker_port,
    proxy_password        => $pulp_proxy_password,
    proxy_port            => $pulp_proxy_port,
    proxy_host            => $pulp_proxy_url,
    proxy_username        => $pulp_proxy_username,
    puppet_wsgi_processes => $pulp_puppet_wsgi_processes,
    ca_cert               => $pulp_ca_cert,
    worker_timeout        => $pulp_worker_timeout,
    ssl_protocol          => $ssl_protocol,
  }
  contain foreman_proxy_content::pulp

  if $foreman_proxy_content::pulp2 {
    if $qpid_router {
      class { 'foreman_proxy_content::dispatch_router':
        agent_addr    => $qpid_router_agent_addr,
        agent_port    => $qpid_router_agent_port,
        ssl_cipher    => $qpid_router_ssl_ciphers,
        ssl_protocols => $qpid_router_ssl_protocols,
        logging_level => $qpid_router_logging_level,
        logging       => $qpid_router_logging,
        logging_path  => $qpid_router_logging_path,
      }

      class { 'foreman_proxy_content::dispatch_router::connector':
        host => $parent_fqdn,
        port => $qpid_router_hub_port,
      }
    }

    if $manage_broker {
      contain foreman_proxy_content::broker
    }
  }

  file {'/etc/httpd/conf.d/pulp_nodes.conf':
    ensure  => file,
    content => template('foreman_proxy_content/pulp_nodes.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  pulp::apache::fragment{'gpg_key_proxy':
    ssl_content => template('foreman_proxy_content/_pulp_gpg_proxy.erb', 'foreman_proxy_content/httpd_pub.erb'),
  }

  class { 'foreman_proxy_content::reverse_proxy':
    path         => '/',
    url          => "${foreman_url}/",
    servername   => $foreman_proxy_fqdn,
    port         => $reverse_proxy_port,
    ssl_protocol => $ssl_protocol,
  }

  class { 'certs::katello':
    hostname       => $foreman_proxy_fqdn,
    deployment_url => $rhsm_url,
    rhsm_port      => $reverse_proxy_port,
    require        => Class['certs'],
  }
  ensure_packages('katello-client-bootstrap')

  include apache
  apache::vhost { 'foreman_proxy_content':
    servername          => $foreman_proxy_fqdn,
    port                => 80,
    priority            => '05',
    docroot             => '/var/www/html',
    options             => ['SymLinksIfOwnerMatch'],
    additional_includes => ["${apache::confd_dir}/pulp-vhosts80/*.conf"],
    custom_fragment     => template('foreman_proxy_content/httpd_pub.erb'),
  }

  if $puppet {
    # We can't pull the certs out to the top level, because of how it gets the default
    # parameter values from the main certs class.  Kafo can't handle that case, so
    # it remains here for now.
    include puppet
    if $puppet::server and $puppet::server::foreman {
      class { 'certs::puppet':
        hostname => $foreman_proxy_fqdn,
        before   => Class['foreman::puppetmaster'],
      }
    }
  }
}
