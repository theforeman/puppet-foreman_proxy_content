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
# $proxy_pulp_deb_to_pulpcore::         Proxy /pulp/deb to Pulpcore at /pulp/content
#
# $proxy_pulp_isos_to_pulpcore::        Proxy /pulp/isos to Pulpcore at /pulp/content
#
# $proxy_pulp_yum_to_pulpcore::         Proxy /pulp/yum to Pulpcore at /pulp/content
#
# $reverse_proxy::                      Add reverse proxy to the parent
#
# $reverse_proxy_port::                 Reverse proxy listening port
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
# $qpid_router_sasl_mech::              SASL mechanism to be used from router to broker
#
# $qpid_router_sasl_username::          SASL username to be used from router to broker
#
# $qpid_router_sasl_password::          SASL password to be used from router to broker
#
# $manage_broker::                      Manage the qpid message broker when applicable
#
# $pulp_worker_timeout::                The amount of time (in seconds) before considering a worker as missing. If Pulp's
#                                       mongo database has slow I/O, then setting a higher number may resolve issues where workers are
#                                       going missing incorrectly.
#
# $pulpcore_manage_postgresql::         Manage the Pulpcore PostgreSQL database.
#
# $pulpcore_postgresql_host::           Host of the Pulpcore PostgreSQL database. Must be specified if external/unmanaged.
#
# $pulpcore_postgresql_port::           Port of the Pulpcore PostgreSQL database.
#
# $pulpcore_postgresql_user::           User of the Pulpcore PostgreSQL database.
#
# $pulpcore_postgresql_password::       Password of the Pulpcore PostgreSQL database.
#
# $pulpcore_postgresql_db_name::        Name of the Pulpcore database in PostgreSQL.
#
# $pulpcore_postgresql_ssl::            Enable SSL connection to the Pulpcore PostgreSQL database. Only meaningful for external/unmanaged DB.
#
# $pulpcore_postgresql_ssl_require::    Configure Pulpcore to require an encrypted connection to the PostgreSQL database.
#
# $pulpcore_postgresql_ssl_cert::       Path to SSL certificate to use for Pulpcore connection to PostgreSQL database.
#
# $pulpcore_postgresql_ssl_key::        Path to key file to use for Pulpcore connection to PostgreSQL database.
#
# $pulpcore_postgresql_ssl_root_ca::    Path to the root certificate authority to validate the certificate supplied by the PostgreSQL database server.
#
# $pulpcore_worker_count::              Number of pulpcore workers. Defaults to 8 or the number of CPU cores, whichever is smaller.
#                                       Enabling more than 8 workers, even with additional CPU cores available, likely results in performance
#                                       degradation due to I/O blocking and is not recommended in most cases. Modifying this parameter should be done
#                                       incrementally with benchmarking at each step to determine an optimal value for your deployment.
#
class foreman_proxy_content (
  String[1] $parent_fqdn = $foreman_proxy_content::params::parent_fqdn,
  String $pulp_admin_password = $foreman_proxy_content::params::pulp_admin_password,
  Optional[String] $pulp_max_speed = undef,
  Optional[Integer[1]] $pulp_num_workers = undef,
  Optional[String] $pulp_proxy_password = undef,
  Optional[Stdlib::Port] $pulp_proxy_port = undef,
  Optional[String] $pulp_proxy_url = undef,
  Optional[String] $pulp_proxy_username = undef,
  Integer[1] $pulp_puppet_wsgi_processes = 1,
  Optional[Stdlib::Absolutepath] $pulp_ca_cert = undef,
  Integer[0] $pulp_worker_timeout = 60,

  Boolean $puppet = true,

  Boolean $reverse_proxy = false,
  Stdlib::Port $reverse_proxy_port = 8443,

  Boolean $qpid_router = true,
  Optional[String] $qpid_router_hub_addr = undef,
  Stdlib::Port $qpid_router_hub_port = 5646,
  Optional[String] $qpid_router_agent_addr = undef,
  Stdlib::Port $qpid_router_agent_port = 5647,
  String $qpid_router_broker_addr = 'localhost',
  Stdlib::Port $qpid_router_broker_port = 5671,
  String $qpid_router_logging_level = 'info+',
  Enum['file', 'syslog'] $qpid_router_logging = 'syslog',
  Stdlib::Absolutepath $qpid_router_logging_path = '/var/log/qdrouterd',
  String $qpid_router_ssl_ciphers = 'ALL:!aNULL:+HIGH:-SSLv3:!IDEA-CBC-SHA',
  Optional[Array[String]] $qpid_router_ssl_protocols = undef,
  Optional[String] $qpid_router_sasl_mech = 'PLAIN',
  Optional[String] $qpid_router_sasl_username = 'katello_agent',
  Optional[String] $qpid_router_sasl_password = $foreman_proxy_content::params::qpid_router_sasl_password,
  Boolean $enable_ostree = false,
  Boolean $enable_yum = true,
  Boolean $enable_file = true,
  Boolean $proxy_pulp_deb_to_pulpcore = true,
  Boolean $proxy_pulp_isos_to_pulpcore = true,
  Boolean $proxy_pulp_yum_to_pulpcore = true,
  Boolean $enable_puppet = true,
  Boolean $enable_docker = true,
  Boolean $enable_deb = true,

  Boolean $manage_broker = true,

  Boolean $pulpcore_manage_postgresql = true,
  Stdlib::Host $pulpcore_postgresql_host = 'localhost',
  Stdlib::Port $pulpcore_postgresql_port = 5432,
  String $pulpcore_postgresql_user = 'pulp',
  String $pulpcore_postgresql_password = $foreman_proxy_content::params::pulpcore_postgresql_password,
  String $pulpcore_postgresql_db_name = 'pulpcore',
  Boolean $pulpcore_postgresql_ssl = false,
  Boolean $pulpcore_postgresql_ssl_require = true,
  Stdlib::Absolutepath $pulpcore_postgresql_ssl_cert = '/etc/pki/katello/certs/pulpcore-database.crt',
  Stdlib::Absolutepath $pulpcore_postgresql_ssl_key = '/etc/pki/katello/private/pulpcore-database.key',
  Stdlib::Absolutepath $pulpcore_postgresql_ssl_root_ca = '/etc/pki/tls/certs/ca-bundle.crt',
  Integer[0] $pulpcore_worker_count = $foreman_proxy_content::params::pulpcore_worker_count,
) inherits foreman_proxy_content::params {
  include certs
  include foreman_proxy
  include foreman_proxy::plugin::pulp

  $pulp_master = $foreman_proxy::plugin::pulp::enabled
  $pulp = $foreman_proxy::plugin::pulp::pulpnode_enabled
  $pulpcore_mirror = $foreman_proxy::plugin::pulp::pulpcore_mirror
  $pulpcore = $foreman_proxy::plugin::pulp::pulpcore_enabled

  $enable_pulp2_rpm = $enable_yum and !($pulpcore and $proxy_pulp_yum_to_pulpcore)
  $enable_pulp2_iso = $enable_file and !($pulpcore and $proxy_pulp_isos_to_pulpcore)
  $enable_pulp2_deb = $enable_deb and !($pulpcore and $proxy_pulp_deb_to_pulpcore)

  $foreman_url = $foreman_proxy::foreman_base_url
  $reverse_proxy_real = ($pulp or $pulpcore_mirror) or $reverse_proxy

  # TODO: doesn't allow deploying a Pulp non-mirror without Foreman
  $shared_with_foreman_vhost = ($pulpcore and !$pulpcore_mirror) or $pulp_master

  $rhsm_port = $reverse_proxy_real ? {
    true  => $reverse_proxy_port,
    false => 443
  }

  ensure_packages('katello-debug')

  if ($pulp_master or $pulp) and $facts['os']['release']['major'] != '7' {
    fail('Pulp 2 is only supported on CentOS 7')
  }

  class { 'certs::foreman_proxy':
    notify => Service['foreman-proxy'],
  }

  class { 'foreman_proxy_content::bootstrap_rpm':
    rhsm_port => $rhsm_port,
  }

  if $reverse_proxy_real {
    class { 'foreman_proxy_content::reverse_proxy':
      url  => "${foreman_url}/",
      port => $reverse_proxy_port,
    }
  }

  if $pulp_master or $pulp {
    if $qpid_router {
      class { 'foreman_proxy_content::dispatch_router':
        agent_addr    => $qpid_router_agent_addr,
        agent_port    => $qpid_router_agent_port,
        ssl_ciphers   => $qpid_router_ssl_ciphers,
        ssl_protocols => $qpid_router_ssl_protocols,
        logging_level => $qpid_router_logging_level,
        logging       => $qpid_router_logging,
        logging_path  => $qpid_router_logging_path,
      }
      contain foreman_proxy_content::dispatch_router

      if $pulp_master {
        class { 'foreman_proxy_content::dispatch_router::hub':
          hub_addr      => $qpid_router_hub_addr,
          hub_port      => $qpid_router_hub_port,
          broker_addr   => $qpid_router_broker_addr,
          broker_port   => $qpid_router_broker_port,
          sasl_mech     => $qpid_router_sasl_mech,
          sasl_username => $qpid_router_sasl_username,
          sasl_password => $qpid_router_sasl_password,
        }
        contain foreman_proxy_content::dispatch_router::hub
      } else {
        class { 'foreman_proxy_content::dispatch_router::connector':
          host => $parent_fqdn,
          port => $qpid_router_hub_port,
        }
        contain foreman_proxy_content::dispatch_router::connector
      }
    }

    include certs::apache
    class { 'pulp::crane':
      cert      => $certs::apache::apache_cert,
      key       => $certs::apache::apache_key,
      ssl_chain => $certs::katello_server_ca_cert,
      ca_cert   => $certs::katello_default_ca_cert,
      data_dir  => '/var/lib/pulp/published/docker/v2/app',
      require   => Class['certs::apache'],
    }

  }

  include foreman_proxy_content::pub_dir

  if $pulp {
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

    class { 'certs::qpid_client':
      require => Class['pulp::install'],
      notify  => Class['pulp::service'],
    }

    class { 'pulp':
      enable_ostree          => $enable_ostree,
      enable_rpm             => $enable_pulp2_rpm,
      enable_iso             => $enable_pulp2_iso,
      enable_deb             => $enable_pulp2_deb,
      enable_puppet          => $enable_puppet,
      enable_docker          => $enable_docker,
      default_password       => $pulp_admin_password,
      messaging_transport    => 'qpid',
      messaging_auth_enabled => false,
      messaging_ca_cert      => pick($pulp_ca_cert, $certs::qpid_client::qpid_client_ca_cert),
      messaging_client_cert  => $certs::qpid_client::qpid_client_cert,
      messaging_url          => "ssl://${qpid_router_broker_addr}:${qpid_router_broker_port}",
      broker_url             => "qpid://${qpid_router_broker_addr}:${qpid_router_broker_port}",
      broker_use_ssl         => true,
      manage_broker          => false,
      manage_httpd           => true,
      manage_plugins_httpd   => true,
      manage_squid           => true,
      puppet_wsgi_processes  => $pulp_puppet_wsgi_processes,
      num_workers            => $pulp_num_workers,
      repo_auth              => true,
      https_cert             => $certs::apache::apache_cert,
      https_key              => $certs::apache::apache_key,
      https_chain            => $certs::apache::apache_ca_cert,
      https_ca_cert          => $certs::ca_cert,
      yum_max_speed          => $pulp_max_speed,
      proxy_port             => $pulp_proxy_port,
      proxy_url              => $pulp_proxy_url,
      proxy_username         => $pulp_proxy_username,
      proxy_password         => $pulp_proxy_password,
      worker_timeout         => $pulp_worker_timeout,
    }

    pulp::apache::fragment{'gpg_key_proxy':
      ssl_content => template('foreman_proxy_content/_pulp_gpg_proxy.erb'),
    }
  }

  if $pulpcore {
    if $pulpcore_mirror {
      $pulpcore_allowed_import_path    = ['/var/lib/pulp/sync_imports']
      $pulpcore_allowed_export_path    = []
    } else {
      $pulpcore_allowed_import_path    = ['/var/lib/pulp/sync_imports', '/var/lib/pulp/imports']
      $pulpcore_allowed_export_path    = ['/var/lib/pulp/exports']
    }
    if $shared_with_foreman_vhost {
      include foreman::config::apache
      $servername = $foreman::config::apache::servername
      $priority = $foreman::config::apache::priority
      $apache_http_vhost = 'foreman'
      $apache_https_vhost = 'foreman-ssl'
      $apache_https_cert = undef
      $apache_https_key = undef
      $apache_https_ca = undef
      $apache_https_chain = undef
      Class['foreman::config::apache'] -> Class['pulpcore::apache']
    } elsif $pulp and $pulp::manage_httpd {
      $servername = $pulp::server_name
      $priority = '05'
      $apache_http_vhost = 'pulp-http'
      $apache_https_vhost = 'pulp-https'
      $apache_https_cert = undef
      $apache_https_key = undef
      $apache_https_ca = undef
      $apache_https_chain = undef
      Class['pulp::apache'] -> Class['pulpcore::apache']
    } else {
      include certs::apache
      Class['certs::apache'] ~> Class['pulpcore::apache']
      $servername = $certs::apache::hostname
      $priority = undef
      $apache_http_vhost = undef
      $apache_https_vhost = undef
      $apache_https_cert = $certs::apache::apache_cert
      $apache_https_key = $certs::apache::apache_key
      $apache_https_ca = $certs::katello_default_ca_cert
      $apache_https_chain = $certs::katello_server_ca_cert
    }

    class { 'pulpcore':
      allowed_import_path       => $pulpcore_allowed_import_path,
      allowed_export_path       => $pulpcore_allowed_export_path,
      apache_http_vhost         => $apache_http_vhost,
      apache_https_vhost        => $apache_https_vhost,
      apache_https_cert         => $apache_https_cert,
      apache_https_key          => $apache_https_key,
      apache_https_ca           => $apache_https_ca,
      apache_https_chain        => $apache_https_chain,
      apache_vhost_priority     => $priority,
      servername                => $servername,
      static_url                => '/pulp/assets/',
      postgresql_manage_db      => $pulpcore_manage_postgresql,
      postgresql_db_host        => $pulpcore_postgresql_host,
      postgresql_db_port        => $pulpcore_postgresql_port,
      postgresql_db_user        => $pulpcore_postgresql_user,
      postgresql_db_password    => $pulpcore_postgresql_password,
      postgresql_db_name        => $pulpcore_postgresql_db_name,
      postgresql_db_ssl         => $pulpcore_postgresql_ssl,
      postgresql_db_ssl_require => $pulpcore_postgresql_ssl_require,
      postgresql_db_ssl_cert    => $pulpcore_postgresql_ssl_cert,
      postgresql_db_ssl_key     => $pulpcore_postgresql_ssl_key,
      postgresql_db_ssl_root_ca => $pulpcore_postgresql_ssl_root_ca,
      worker_count              => $pulpcore_worker_count,
      before                    => Class['foreman_proxy::plugin::pulp'],
    }

    if $pulp_master {
      include pulp
      class { 'pulpcore::plugin::migration':
        mongo_db_name         => $pulp::db_name,
        mongo_db_seeds        => $pulp::db_seeds,
        mongo_db_username     => $pulp::db_username,
        mongo_db_password     => $pulp::db_password,
        mongo_db_replica_set  => $pulp::db_replica_set,
        mongo_db_ssl          => $pulp::db_ssl,
        mongo_db_ssl_keyfile  => $pulp::db_ssl_keyfile,
        mongo_db_ssl_certfile => $pulp::db_ssl_certfile,
        mongo_db_verify_ssl   => $pulp::db_verify_ssl,
        mongo_db_ca_path      => $pulp::db_ca_path,
      }
    }

    include pulpcore::plugin::container
    class { 'pulpcore::plugin::file':
      use_pulp2_content_route => $proxy_pulp_isos_to_pulpcore,
    }
    class { 'pulpcore::plugin::rpm':
      use_pulp2_content_route => $proxy_pulp_yum_to_pulpcore,
    }
    if $enable_deb {
      class { 'pulpcore::plugin::deb':
        use_pulp2_content_route => $proxy_pulp_deb_to_pulpcore,
      }
    }
    include pulpcore::plugin::certguard
  }

  if $puppet {
    # We can't pull the certs out to the top level, because of how it gets the default
    # parameter values from the main certs class.  Kafo can't handle that case, so
    # it remains here for now.
    include puppet
    if $puppet::server and $puppet::server::foreman {
      class { 'certs::puppet':
        hostname => $certs::foreman_proxy::hostname,
        before   => Class['foreman::puppetmaster'],
      }
    }
  }
}
