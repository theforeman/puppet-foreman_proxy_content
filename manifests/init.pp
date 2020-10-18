# == Class: foreman_proxy_content
#
# Configure content for foreman proxy for use by katello
#
# === Advanced parameters:
#
# $puppet::                             Enable puppet
#
# $reverse_proxy::                      Add reverse proxy to the parent
#
# $reverse_proxy_port::                 Reverse proxy listening port
#
# $ssl_protocol::                       Apache SSLProtocol configuration to use
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
  Boolean $puppet = true,

  Boolean $reverse_proxy = false,
  Stdlib::Port $reverse_proxy_port = 8443,
  Optional[String] $ssl_protocol = undef,

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

  $pulpcore_mirror = $foreman_proxy::plugin::pulp::pulpcore_mirror
  $pulpcore = $foreman_proxy::plugin::pulp::pulpcore_enabled

  $foreman_proxy_fqdn = $facts['networking']['fqdn']
  $foreman_url = $foreman_proxy::foreman_base_url
  $reverse_proxy_real = $pulpcore_mirror or $reverse_proxy

  # TODO: doesn't allow deploying a Pulp non-mirror without Foreman
  $shared_with_foreman_vhost = $pulpcore and !$pulpcore_mirror

  $reverse_proxy_real = !$shared_with_foreman_vhost and $reverse_proxy

  $rhsm_port = $reverse_proxy_real ? {
    true  => $reverse_proxy_port,
    false => 443
  }

  ensure_packages('katello-debug')

  class { 'certs::foreman_proxy':
    hostname => $foreman_proxy_fqdn,
    require  => Class['certs'],
    notify   => Service['foreman-proxy'],
  }

  class { 'foreman_proxy_content::bootstrap_rpm':
    rhsm_port => $rhsm_port,
  }

  if $reverse_proxy_real {
    class { 'certs::apache':
      hostname => $foreman_proxy_fqdn,
      require  => Class['certs'],
    }
    ~> class { 'foreman_proxy_content::reverse_proxy':
      path         => '/',
      url          => "${foreman_url}/",
      port         => $reverse_proxy_port,
      subscribe    => Class['certs::foreman_proxy'],
      ssl_protocol => $ssl_protocol,
    }
  }

  include foreman_proxy_content::pub_dir

  if $pulpcore {
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

    include pulpcore::plugin::container
    class { 'pulpcore::plugin::file':
      use_pulp2_content_route => true,
    }
    class { 'pulpcore::plugin::rpm':
      use_pulp2_content_route => true,
    }
    class { 'pulpcore::plugin::deb':
      use_pulp2_content_route => true,
    }
    include pulpcore::plugin::certguard

    unless $shared_with_foreman_vhost {
      pulpcore::apache::fragment { 'gpg_key_proxy':
        https_content => template('foreman_proxy_content/_pulp_gpg_proxy.erb'),
      }
    }
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
