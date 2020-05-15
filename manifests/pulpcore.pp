# Deploy a pulpcore instance
#
# @param enable_container_content
#   Whether the container content should be enabled by including the container
#   plugin

# @param enable_file_content
#   Whether the file content should be enabled by including the file plugin
#
# @param proxy_legacy_pulp_isos
#   Whether the legacy Pulp URLs should be proxies to the content server
#
# @param manage_postgresql
#   Manage the Pulpcore PostgreSQL database.
#
# @param postgresql_host
#   Host of the Pulpcore PostgreSQL database. Must be specified if external/unmanaged.
#
# @param postgresql_port
#   Port of the Pulpcore PostgreSQL database.
#
# @param postgresql_user
#   User of the Pulpcore PostgreSQL database.
#
# @param postgresql_password
#   Password of the Pulpcore PostgreSQL database.
#
# @param postgresql_ssl
#   Enable SSL connection to the Pulpcore PostgreSQL database. Only meaningful for external/unmanaged DB.
#
# @param postgresql_ssl_require
#   Configure Pulpcore to require an encrypted connection to the PostgreSQL database.
#
# @param postgresql_ssl_cert
#   Path to SSL certificate to use for Pulpcore connection to PostgreSQL database.
#
# @param postgresql_ssl_key
#   Path to key file to use for Pulpcore connection to PostgreSQL database.
#
# @param postgresql_ssl_root_ca
#   Path to the root certificate authority to validate the certificate supplied by the PostgreSQL database server.
class foreman_proxy_content::pulpcore (
  Boolean $enable_container_content = true,
  Boolean $enable_file_content = true,
  Boolean $proxy_legacy_pulp_isos = true,
  Boolean $manage_postgresql = true,
  Stdlib::Host $postgresql_host = 'localhost',
  Stdlib::Port $postgresql_port = 5432,
  Optional[String] $postgresql_user = undef,
  Optional[String] $postgresql_password = undef,
  Boolean $postgresql_ssl = false,
  Boolean $postgresql_ssl_require = true,
  Optional[Stdlib::Absolutepath] $postgresql_ssl_cert = undef,
  Optional[Stdlib::Absolutepath] $postgresql_ssl_key = undef,
  Optional[Stdlib::Absolutepath] $postgresql_ssl_root_ca = undef,
) {
  include foreman::config::apache

  include foreman_proxy
  class { 'foreman_proxy::plugin::pulp':
    enabled              => false,
    pulpnode_enabled     => false,
    pulpcore_enabled     => true,
    pulpcore_mirror      => false,
    pulpcore_api_url     => "https://${foreman::config::apache::servername}",
    pulpcore_content_url => "https://${foreman::config::apache::servername}/content",
  }

  class { 'pulpcore':
    remote_user_environ_name  => 'HTTP_REMOTE_USER',
    manage_apache             => false,
    servername                => $foreman::config::apache::servername,
    postgresql_manage_db      => $manage_postgresql,
    postgresql_db_host        => $postgresql_host,
    postgresql_db_port        => $postgresql_port,
    postgresql_db_user        => $postgresql_user,
    postgresql_db_password    => $postgresql_password,
    postgresql_db_ssl         => $postgresql_ssl,
    postgresql_db_ssl_require => $postgresql_ssl_require,
    postgresql_db_ssl_cert    => $postgresql_ssl_cert,
    postgresql_db_ssl_key     => $postgresql_ssl_key,
    postgresql_db_ssl_root_ca => $postgresql_ssl_root_ca,
    before                    => Class['foreman_proxy::plugin::pulp'],
  }

  if $enable_container_content {
    include pulpcore::plugin::container
  }

  if $enable_file_content {
    include pulpcore::plugin::file

    if $proxy_legacy_pulp_isos {
      foreman::config::apache::fragment { 'pulpcore-isos':
        content => template('foreman_proxy_content/pulpcore-isos-apache.conf.erb'),
      }
    }
  }

  foreman::config::apache::fragment { 'pulpcore':
    content     => template('foreman_proxy_content/pulpcore-content-apache.conf.erb'),
    ssl_content => template(
      'foreman_proxy_content/pulpcore-api-apache.conf.erb',
      'foreman_proxy_content/pulpcore-content-apache.conf.erb',
      'foreman_proxy_content/pulpcore-docker-apache.conf.erb'
    ),
  }
}
