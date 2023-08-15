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
# $enable_ostree::                             Enable the OSTree content feature. This allows syncing, managing, and serving OSTree content.
#
# $pulpcore_mirror::                           Deploy Pulp to be used as a mirror
#
# === Advanced parameters:
#
# $reverse_proxy::                             Add reverse proxy to the parent
#
# $reverse_proxy_port::                        Reverse proxy listening port
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
# $pulpcore_additional_import_paths::          Additional allowed paths that Pulpcore can use for content imports, or sync from using file:// protocol
#
# $pulpcore_additional_export_paths::          Additional allowed paths that Pulpcore can use for content exports
#
# $pulpcore_telemetry::                        Enable upload of anonymous usage data to https://analytics.pulpproject.org/
#
# $pulpcore_hide_guarded_distributions::       Hide distributions that are protected by a content guard from the default listing
#
class foreman_proxy_content (
  Boolean $pulpcore_mirror = false,

  Boolean $reverse_proxy = false,
  Stdlib::Port $reverse_proxy_port = 8443,

  Boolean $enable_yum = true,
  Boolean $enable_file = true,
  Boolean $enable_docker = true,
  Boolean $enable_deb = true,
  Boolean $enable_ansible = true,
  Boolean $enable_python = true,
  Boolean $enable_ostree = false,

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
  Variant[Stdlib::Absolutepath, Array[Stdlib::Absolutepath]] $pulpcore_additional_import_paths = [],
  Variant[Stdlib::Absolutepath, Array[Stdlib::Absolutepath]] $pulpcore_additional_export_paths = [],
  Boolean $pulpcore_telemetry = false,
  Boolean $pulpcore_hide_guarded_distributions = true,
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

  $insights_path = '/redhat_access'

  ensure_packages('katello-debug')

  include certs::foreman_proxy
  Class['certs::foreman_proxy'] ~> Service['foreman-proxy']

  if $reverse_proxy_real {
    foreman_proxy_content::reverse_proxy { "rhsm-pulpcore-https-${reverse_proxy_port}":
      path_url_map => { '/' => "${foreman_url}/" },
      port         => $reverse_proxy_port,
      priority     => '10',
      before       => Class['pulpcore::apache'],
    }
  }

  if $pulpcore_mirror {
    $pulpcore_https_vhost_name = "rhsm-pulpcore-https-${rhsm_port}"

    if $rhsm_port != $reverse_proxy_port {
      foreman_proxy_content::reverse_proxy { $pulpcore_https_vhost_name:
        path_url_map => {
          $rhsm_path     => "${foreman_url}${rhsm_path}",
          $insights_path => "${foreman_url}${insights_path}",
        },
        port         => $rhsm_port,
        priority     => '10',
        before       => Class['pulpcore::apache'],
      }
    }
  }

  include foreman_proxy_content::pub_dir

  class { 'qpid::router':
    ensure => 'absent',
  }
  contain qpid::router

  if $pulpcore_mirror {
    $base_allowed_import_paths    = ['/var/lib/pulp/sync_imports']
    $base_allowed_export_paths    = []

    pulpcore::apache::fragment { 'gpg_key_proxy':
      https_content => template('foreman_proxy_content/_pulp_gpg_proxy.erb'),
    }
  } else {
    $base_allowed_import_paths    = ['/var/lib/pulp/sync_imports', '/var/lib/pulp/imports']
    $base_allowed_export_paths    = ['/var/lib/pulp/exports']
  }

  $pulpcore_allowed_import_paths = unique($base_allowed_import_paths + $pulpcore_additional_import_paths)
  $pulpcore_allowed_export_paths = unique($base_allowed_export_paths + $pulpcore_additional_export_paths)

  if $shared_with_foreman_vhost {
    include foreman::config::apache
    $servername = $foreman::config::apache::servername
    $serveraliases = $foreman::config::apache::serveraliases
    $client_facing_servername = $servername
    $priority = $foreman::config::apache::priority
    $apache_http_vhost = 'foreman'
    $apache_https_vhost = 'foreman-ssl'
    $apache_https_cert = undef
    $apache_https_key = undef
    $apache_https_ca = undef
    $apache_https_chain = undef
    Class['foreman::config::apache'] -> Class['pulpcore::apache']
  } else {
    include certs::apache
    Class['certs::apache'] ~> Class['pulpcore::apache']
    $servername = $certs::apache::hostname
    $serveraliases = $certs::apache::cname
    $priority = '10'
    $apache_http_vhost = undef
    $apache_https_vhost = $pulpcore_https_vhost_name
    $apache_https_cert = undef
    $apache_https_key = undef
    $apache_https_ca = undef
    $apache_https_chain = undef

    if $foreman_proxy::registration_url {
      $client_facing_servername = foreman_proxy_content::host_from_url($foreman_proxy::registration_url)

      unless $client_facing_servername in $serveraliases {
        fail("The foreman_proxy::registration_url (${client_facing_servername}) does not match the specified cname: ${serveraliases}")
      }
    } else {
      $client_facing_servername = $servername
    }
  }

  $api_client_auth_cn_map = Hash($foreman_proxy::trusted_hosts.map |$host| {
      [$host, 'admin']
  })

  class { 'pulpcore':
    allowed_content_checksums      => $pulpcore_allowed_content_checksums,
    allowed_import_path            => $pulpcore_allowed_import_paths,
    allowed_export_path            => $pulpcore_allowed_export_paths,
    apache_http_vhost              => $apache_http_vhost,
    apache_https_vhost             => $apache_https_vhost,
    apache_https_cert              => $apache_https_cert,
    apache_https_key               => $apache_https_key,
    apache_https_ca                => $apache_https_ca,
    apache_https_chain             => $apache_https_chain,
    apache_vhost_priority          => $priority,
    servername                     => $servername,
    serveraliases                  => $serveraliases,
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
    telemetry                      => $pulpcore_telemetry,
    hide_guarded_distributions     => $pulpcore_hide_guarded_distributions,
  }

  if $shared_with_foreman_vhost {
    include certs::foreman
    class { 'pulpcore::cli':
      pulpcore_url => "https://${servername}",
      dry_run      => true,
      cert         => $certs::foreman::client_cert,
      key          => $certs::foreman::client_key,
      require      => Class['certs::foreman'],
    }
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

  $rhsm_url = "https://${client_facing_servername}:${rhsm_port}${rhsm_path}"

  class { 'foreman_proxy::plugin::pulp':
    pulpcore_enabled      => true,
    pulpcore_mirror       => $pulpcore_mirror,
    pulpcore_api_url      => "https://${servername}",
    pulpcore_content_url  => "https://${client_facing_servername}${pulpcore::apache::content_path}",
    client_authentication => ['client_certificate'],
    rhsm_url              => $rhsm_url,
    require               => Class['pulpcore'],
  }

  class { 'foreman_proxy_content::bootstrap_rpm':
    rhsm_hostname => $client_facing_servername,
    rhsm_port     => $rhsm_port,
    rhsm_path     => $rhsm_path,
  }

  # smart_proxy_pulp dynamically retrieves the Pulp content types and Katello
  # uses this. This means the features need to be refreshed after a content
  # type is added.
  # lint:ignore:spaceship_operator_without_tag
  if $foreman_proxy::register_in_foreman {
    Pulpcore::Plugin <| |> ~> Foreman_smartproxy[$foreman_proxy::registered_name]
  }
  # lint:endignore
}
