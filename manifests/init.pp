# == Class: foreman_proxy_content
#
# Configure content for foreman proxy for use by katello
#
# === Parameters:
#
# $enable_yum::                                Enable the RPM content feature. This allows syncing, managing and serving RPM content to be consumed by package managers like yum and dnf.
#
# $enable_file::                               Enable the file content feature. This allows syncing, managing, and serving file content.
#
# $enable_docker::                             Enable the container content feature. This allows syncing, managing, and serving container content.
#
# $enable_deb::                                Enable the Debian content feature. This allows syncing, managing, and serving Debian content.
#
# $enable_ansible::                            Enable the Ansible content feature. This allows syncing, managing, and serving Ansible content.
#
# $enable_python::                             Enable the Python content feature. This allows syncing, managing, and serving Python content.
#
# $enable_ostree::                             Enable the OSTree content feature. This allows syncing, managing, and serving OSTree content. This is not available on el7.
#
# $enable_katello_agent::                      Enable katello-agent for remote yum actions
#
# $pulpcore_mirror::                           Deploy Pulp to be used as a mirror
#
# === Advanced parameters:
#
# $puppet::                                    Enable puppet
#
# $reverse_proxy::                             Add reverse proxy to the parent
#
# $reverse_proxy_port::                        Reverse proxy listening port
#
# $qpid_router_hub_addr::                      Address for dispatch router hub
#
# $qpid_router_hub_port::                      Port for dispatch router hub
#
# $qpid_router_agent_addr::                    Listener address for goferd agents
#
# $qpid_router_agent_port::                    Listener port for goferd agents
#
# $qpid_router_broker_addr::                   Address of qpidd broker to connect to
#
# $qpid_router_broker_port::                   Port of qpidd broker to connect to
#
# $qpid_router_logging_level::                 Logging level of dispatch router (e.g. info+ or debug+)
#
# $qpid_router_logging::                       Whether to log to file or syslog.
#
# $qpid_router_logging_path::                  Directory for dispatch router logs, if using file logging
#
# $qpid_router_ssl_ciphers::                   SSL Ciphers to support in dispatch router
#
# $qpid_router_ssl_protocols::                 Protocols to support in dispatch router (e.g. TLSv1.2, etc)
#
# $pulpcore_allowed_content_checksums::        List of checksums to use for pulpcore content operations
#
# $pulpcore_manage_postgresql::                Manage the Pulpcore PostgreSQL database.
#
# $pulpcore_postgresql_host::                  Host of the Pulpcore PostgreSQL database. Must be specified if external/unmanaged.
#
# $pulpcore_postgresql_port::                  Port of the Pulpcore PostgreSQL database.
#
# $pulpcore_postgresql_user::                  User of the Pulpcore PostgreSQL database.
#
# $pulpcore_postgresql_password::              Password of the Pulpcore PostgreSQL database.
#
# $pulpcore_postgresql_db_name::               Name of the Pulpcore database in PostgreSQL.
#
# $pulpcore_postgresql_ssl::                   Enable SSL connection to the Pulpcore PostgreSQL database. Only meaningful for external/unmanaged DB.
#
# $pulpcore_postgresql_ssl_require::           Configure Pulpcore to require an encrypted connection to the PostgreSQL database.
#
# $pulpcore_postgresql_ssl_cert::              Path to SSL certificate to use for Pulpcore connection to PostgreSQL database.
#
# $pulpcore_postgresql_ssl_key::               Path to key file to use for Pulpcore connection to PostgreSQL database.
#
# $pulpcore_postgresql_ssl_root_ca::           Path to the root certificate authority to validate the certificate supplied by the PostgreSQL database server.
#
# $pulpcore_worker_count::                     Number of pulpcore workers. Defaults to 8 or the number of CPU cores, whichever is smaller.
#                                              Enabling more than 8 workers, even with additional CPU cores available, likely results in performance
#                                              degradation due to I/O blocking and is not recommended in most cases. Modifying this parameter should be done
#                                              incrementally with benchmarking at each step to determine an optimal value for your deployment.
#
# $pulpcore_content_service_worker_timeout::   Gunicorn worker timeout in seconds for the pulpcore-content.service
#
# $pulpcore_api_service_worker_timeout::       Gunicorn worker timeout in seconds for the pulpcore-api.service
#
# $pulpcore_django_secret_key::                Secret key used for cryptographic operations by Pulpcore's django runtime
#
# $pulpcore_cache_enabled::                    Enable Redis based content caching within the Pulp content app.
#
# $pulpcore_cache_expires_ttl::                The number of seconds that content should be cached for.
#                                              Specify 'None' to never expire the cache.
#
class foreman_proxy_content (
  Boolean $pulpcore_mirror = false,

  Boolean $puppet = true,

  Boolean $reverse_proxy = false,
  Stdlib::Port $reverse_proxy_port = 8443,

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

  Boolean $enable_yum = true,
  Boolean $enable_file = true,
  Boolean $enable_docker = true,
  Boolean $enable_deb = true,
  Boolean $enable_ansible = true,
  Boolean $enable_python = true,
  Boolean $enable_ostree = false,
  Boolean $enable_katello_agent = false,

  Boolean $pulpcore_manage_postgresql = true,
  Stdlib::Host $pulpcore_postgresql_host = 'localhost',
  Stdlib::Port $pulpcore_postgresql_port = 5432,
  Pulpcore::ChecksumTypes $pulpcore_allowed_content_checksums = ['sha1', 'sha224', 'sha256', 'sha384', 'sha512'],
  String $pulpcore_postgresql_user = 'pulp',
  String $pulpcore_postgresql_password = $foreman_proxy_content::params::pulpcore_postgresql_password,
  String $pulpcore_postgresql_db_name = 'pulpcore',
  Boolean $pulpcore_postgresql_ssl = false,
  Boolean $pulpcore_postgresql_ssl_require = true,
  Stdlib::Absolutepath $pulpcore_postgresql_ssl_cert = '/etc/pki/katello/certs/pulpcore-database.crt',
  Stdlib::Absolutepath $pulpcore_postgresql_ssl_key = '/etc/pki/katello/private/pulpcore-database.key',
  Stdlib::Absolutepath $pulpcore_postgresql_ssl_root_ca = '/etc/pki/tls/certs/ca-bundle.crt',
  Integer[0] $pulpcore_worker_count = $foreman_proxy_content::params::pulpcore_worker_count,
  Optional[String[50]] $pulpcore_django_secret_key = undef,
  Integer[0] $pulpcore_content_service_worker_timeout = 90,
  Integer[0] $pulpcore_api_service_worker_timeout = 90,
  Boolean $pulpcore_cache_enabled = true,
  Optional[Variant[Integer[1], Enum['None']]] $pulpcore_cache_expires_ttl = undef,
) inherits foreman_proxy_content::params {
  include certs
  include foreman_proxy

  $foreman_url = $foreman_proxy::foreman_base_url
  $foreman_host = foreman_proxy_content::host_from_url($foreman_url)
  $reverse_proxy_real = $pulpcore_mirror or $reverse_proxy

  # TODO: make it configurable
  # https://github.com/theforeman/puppet-foreman_proxy_content/issues/407
  $shared_with_foreman_vhost = !$pulpcore_mirror

  $rhsm_path = '/rhsm'
  $rhsm_port = 443

  ensure_packages('katello-debug')

  include certs::foreman_proxy
  Class['certs::foreman_proxy'] ~> Service['foreman-proxy']

  if $reverse_proxy_real {
    foreman_proxy_content::reverse_proxy { "rhsm-pulpcore-https-${reverse_proxy_port}":
      url      => "${foreman_url}/",
      port     => $reverse_proxy_port,
      priority => '10',
      before   => Class['pulpcore::apache'],
    }
  }

  include foreman_proxy_content::pub_dir

  class { 'foreman_proxy_content::dispatch_router':
    ensure        => bool2str($enable_katello_agent, 'present', 'absent'),
    agent_addr    => $qpid_router_agent_addr,
    agent_port    => $qpid_router_agent_port,
    ssl_ciphers   => $qpid_router_ssl_ciphers,
    ssl_protocols => $qpid_router_ssl_protocols,
    logging_level => $qpid_router_logging_level,
    logging       => $qpid_router_logging,
    logging_path  => $qpid_router_logging_path,
  }
  contain foreman_proxy_content::dispatch_router

  if $enable_katello_agent {
    if $pulpcore_mirror {
      class { 'foreman_proxy_content::dispatch_router::connector':
        host => $foreman_host,
        port => $qpid_router_hub_port,
      }
      contain foreman_proxy_content::dispatch_router::connector
    } else {
      class { 'foreman_proxy_content::dispatch_router::hub':
        hub_addr    => $qpid_router_hub_addr,
        hub_port    => $qpid_router_hub_port,
        broker_addr => $qpid_router_broker_addr,
        broker_port => $qpid_router_broker_port,
      }
      contain foreman_proxy_content::dispatch_router::hub
    }
  }

  if $pulpcore_mirror {
    $pulpcore_allowed_import_path    = ['/var/lib/pulp/sync_imports']
    $pulpcore_allowed_export_path    = []

    pulpcore::apache::fragment{'gpg_key_proxy':
      https_content => template('foreman_proxy_content/_pulp_gpg_proxy.erb'),
    }
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
  } else {
    $pulpcore_https_vhost_name = "rhsm-pulpcore-https-${rhsm_port}"

    include certs::apache
    Class['certs::apache'] ~> Class['pulpcore::apache']
    $servername = $certs::apache::hostname
    $priority = '10'
    $apache_http_vhost = undef
    $apache_https_vhost = $pulpcore_https_vhost_name
    $apache_https_cert = undef
    $apache_https_key = undef
    $apache_https_ca = undef
    $apache_https_chain = undef

    if $rhsm_port != $reverse_proxy_port {
      foreman_proxy_content::reverse_proxy { $pulpcore_https_vhost_name:
        path     => $rhsm_path,
        url      => "${foreman_url}${rhsm_path}",
        docroot  => $pulpcore::apache_docroot,
        port     => $rhsm_port,
        priority => '10',
        before   => Class['pulpcore::apache'],
      }
    }
  }

  $api_client_auth_cn_map = Hash($foreman_proxy::trusted_hosts.map |$host| {
      [$host, 'admin']
  })

  class { 'pulpcore':
    allowed_content_checksums      => $pulpcore_allowed_content_checksums,
    allowed_import_path            => $pulpcore_allowed_import_path,
    allowed_export_path            => $pulpcore_allowed_export_path,
    apache_http_vhost              => $apache_http_vhost,
    apache_https_vhost             => $apache_https_vhost,
    apache_https_cert              => $apache_https_cert,
    apache_https_key               => $apache_https_key,
    apache_https_ca                => $apache_https_ca,
    apache_https_chain             => $apache_https_chain,
    apache_vhost_priority          => $priority,
    servername                     => $servername,
    static_url                     => '/pulp/assets/',
    postgresql_manage_db           => $pulpcore_manage_postgresql,
    postgresql_db_host             => $pulpcore_postgresql_host,
    postgresql_db_port             => $pulpcore_postgresql_port,
    postgresql_db_user             => $pulpcore_postgresql_user,
    postgresql_db_password         => $pulpcore_postgresql_password,
    postgresql_db_name             => $pulpcore_postgresql_db_name,
    postgresql_db_ssl              => $pulpcore_postgresql_ssl,
    postgresql_db_ssl_require      => $pulpcore_postgresql_ssl_require,
    postgresql_db_ssl_cert         => $pulpcore_postgresql_ssl_cert,
    postgresql_db_ssl_key          => $pulpcore_postgresql_ssl_key,
    postgresql_db_ssl_root_ca      => $pulpcore_postgresql_ssl_root_ca,
    worker_count                   => $pulpcore_worker_count,
    django_secret_key              => $pulpcore_django_secret_key,
    content_service_worker_timeout => $pulpcore_content_service_worker_timeout,
    api_service_worker_timeout     => $pulpcore_api_service_worker_timeout,
    api_client_auth_cn_map         => $api_client_auth_cn_map,
    cache_enabled                  => $pulpcore_cache_enabled,
    cache_expires_ttl              => $pulpcore_cache_expires_ttl,
    before                         => Class['foreman_proxy::plugin::pulp'],
  }

  if $enable_docker {
    include pulpcore::plugin::container
    unless $shared_with_foreman_vhost {
      class { 'foreman_proxy_content::container':
        pulpcore_https_vhost => $apache_https_vhost,
      }

      class { 'foreman_proxy::plugin::container_gateway':
        pulp_endpoint => "https://${servername}",
      }
    }
  }
  if $enable_file {
    class { 'pulpcore::plugin::file':
      use_pulp2_content_route => true,
    }
  }
  if $enable_yum {
    class { 'pulpcore::plugin::rpm':
      use_pulp2_content_route => true,
    }
  }
  if $enable_deb {
    class { 'pulpcore::plugin::deb':
      use_pulp2_content_route => true,
    }
  }
  if $enable_ansible {
    class { 'pulpcore::plugin::ansible':
    }
  }
  if $enable_python {
    class { 'pulpcore::plugin::python':
    }
  }
  if $enable_ostree {
    class { 'pulpcore::plugin::ostree':
    }
  }
  include pulpcore::plugin::certguard # Required to be present by Katello when syncing a content proxy

  $rhsm_url = "https://${servername}:${rhsm_port}${rhsm_path}"

  class { 'foreman_proxy::plugin::pulp':
    pulpcore_enabled      => true,
    pulpcore_mirror       => $pulpcore_mirror,
    pulpcore_api_url      => "https://${servername}",
    pulpcore_content_url  => "https://${servername}${pulpcore::apache::content_path}",
    client_authentication => ['client_certificate'],
    rhsm_url              => $rhsm_url,
    require               => Class['pulpcore'],
  }

  class { 'foreman_proxy_content::bootstrap_rpm':
    rhsm_hostname => $servername,
    rhsm_port     => $rhsm_port,
    rhsm_path     => $rhsm_path,
  }

  # smart_proxy_pulp dynamically retrieves the Pulp content types and Katello
  # uses this. This means the features need to be refreshed after a content
  # type is added. The API also changes so apipie cache needs to be regenerated.
  # lint:ignore:spaceship_operator_without_tag
  if $foreman_proxy::register_in_foreman {
    Pulpcore::Plugin <| |> ~> Foreman_smartproxy[$foreman_proxy::registered_name]
    Foreman_smartproxy[$foreman_proxy::registered_name] -> Foreman::Rake <| title == 'apipie:cache:index' |>
  }
  Pulpcore::Plugin <| |> ~> Foreman::Rake <| title == 'apipie:cache:index' |>
  # lint:endignore

  if $puppet {
    # We can't pull the certs out to the top level, because of how it gets the default
    # parameter values from the main certs class.  Kafo can't handle that case, so
    # it remains here for now.
    include puppet
    if $puppet::server and $puppet::server::foreman {
      class { 'certs::puppet':
        hostname => $certs::foreman_proxy::hostname,
        before   => Class['puppet::server::config'],
      }
    }
  }
}
