# @summary Configure pulp
#
# @param is_mirror
#   Whether this Pulp is a mirror of another Pulp or not
#
# @param enable_ostree
#   Enable ostree content plugin, this requires an ostree install
#
# @param enable_yum
#   Enable rpm content plugin, including syncing of yum content
#
# @param enable_file
#   Enable file content plugin
#
# @param enable_puppet
#   Enable puppet content plugin
#
# @param puppet_wsgi_processes
#   Number of WSGI processes to spawn for the puppet webapp
#
# @param enable_docker
#   Enable docker content plugin
#
# @param enable_deb
#   Enable debian content plugin
#
# @param proxy_port
#   Port of the http proxy server
#
# @param proxy_host
#   Host of the http proxy server
#
# @param proxy_username
#   Proxy username for authentication
#
# @param proxy_password
#   Proxy password for authentication
#
# @param mongodb_name
#   Name of the database to use
#
# @param mongodb_seeds
#   Comma-separated list of hostname:port of database replica seed hosts
#
# @param mongodb_username
#   The user name to use for authenticating to the MongoDB server
#
# @param mongodb_password
#   The password to use for authenticating to the MongoDB server
#
# @param mongodb_replica_set
#   The name of replica set configured in MongoDB, if one is in use
#
# @param mongodb_ssl
#   Whether to connect to the database server using SSL.
#
# @param mongodb_ssl_keyfile
#   A path to the private keyfile used to identify the local connection against mongod. If
#                        included with the certfile then only the ssl_certfile is needed.
#
# @param mongodb_ssl_certfile
#   The certificate file used to identify the local connection against mongod.
#
# @param mongodb_verify_ssl
#   Specifies whether a certificate is required from the other side of the connection, and
#                        whether it will be validated if provided. If it is true, then the ca_certs parameter
#                        must point to a file of CA certificates used to validate the connection.
#
# @param mongodb_ca_path
#   The ca_certs file contains a set of concatenated "certification authority" certificates,
#                        which are used to validate certificates passed from the other end of the connection.
#
# @param mongodb_unsafe_autoretry
#   If true, retry commands to the database if there is a connection error.
#                             Warning: if set to true, this setting can result in duplicate records.
#
# @param mongodb_write_concern
#   Write concern of 'majority' or 'all'. When 'all' is specified, 'w' is set
#   to number of seeds specified. Please note that 'all' will cause Pulp to
#   halt if any of the replica set members is not available. 'majority' is used
#   by default
#
# @param mongodb_manage_db
#   Boolean to install and configure the mongodb.
#
class foreman_proxy_content::pulp (
  Boolean $is_mirror,

  Boolean $enable_ostree = false,
  Boolean $enable_yum = true,
  Boolean $enable_file = true,
  Boolean $enable_puppet = false,
  Integer[1] $puppet_wsgi_processes = 1,
  Boolean $enable_docker = true,
  Boolean $enable_deb = false,

  Stdlib::Host $broker_host = 'localhost',
  Stdlib::Port $broker_port = 5671,

  Optional[String] $default_password = undef,
  Optional[String] $yum_max_speed = undef,
  Optional[Integer[1]] $num_workers = undef,
  Optional[Integer[0]] $worker_timeout = undef,

  Optional[Stdlib::Host] $proxy_host = undef,
  Optional[Stdlib::Port] $proxy_port = undef,
  Optional[String] $proxy_username = undef,
  Optional[String] $proxy_password = undef,

  Optional[Stdlib::Fqdn] $server_name = undef,
  Optional[String] $ssl_protocol = undef,

  String $mongodb_name = 'pulp_database',
  Optional[String] $mongodb_seeds = undef,
  String $mongodb_username = undef,
  String $mongodb_password = undef,
  String $mongodb_replica_set = undef,
  Boolean $mongodb_ssl = false,
  Optional[Stdlib::Absolutepath] $mongodb_ssl_keyfile = undef,
  Optional[Stdlib::Absolutepath] $mongodb_ssl_certfile = undef,
  Boolean $mongodb_verify_ssl = true,
  Optional[Stdlib::Absolutepath] $mongodb_ca_path = undef,
  Boolean $mongodb_unsafe_autoretry = false,
  Optional[Enum['majority', 'all']] $mongodb_write_concern = undef,
  Boolean $mongodb_manage_db = true,
) {

  $pulp2 = $enable_ostree or $enable_yum or $enable_file or $enable_puppet or $enable_docker or $enable_deb
  $pulp3 = false

  include certs::apache

  if $pulp2 {
    include certs::qpid_client

    class { 'pulp':
      server_name            => pick($server_name, $certs::apache::hostname),
      ca_cert                => $certs::apache::ca_cert,
      https_cert             => $certs::apache::apache_cert,
      https_key              => $certs::apache::apache_key,
      db_ca_path             => $mongodb_ca_path,
      db_name                => $mongodb_name,
      db_password            => $mongodb_password,
      db_replica_set         => $mongodb_replica_set,
      db_seeds               => $mongodb_seeds,
      db_ssl                 => $mongodb_ssl,
      db_ssl_certfile        => $mongodb_ssl_certfile,
      db_ssl_keyfile         => $mongodb_ssl_keyfile,
      db_unsafe_autoretry    => $mongodb_unsafe_autoretry,
      db_username            => $mongodb_username,
      db_verify_ssl          => $mongodb_verify_ssl,
      db_write_concern       => $mongodb_write_concern,
      default_password       => $default_password,
      enable_crane           => true, # requires https://github.com/theforeman/puppet-pulp/pull/378
      enable_deb             => $enable_deb,
      enable_docker          => $enable_docker,
      enable_iso             => $enable_file,
      enable_katello         => !$is_mirror,
      enable_ostree          => $enable_ostree,
      enable_puppet          => $enable_puppet,
      enable_rpm             => $enable_yum,
      manage_db              => $mongodb_manage_db,
      manage_httpd           => $is_mirror,
      manage_plugins_httpd   => true,
      manage_squid           => true,
      manage_broker          => false,
      broker_url             => "qpid://${broker_host}:${broker_port}",
      broker_use_ssl         => true,
      messaging_auth_enabled => false,
      messaging_ca_cert      => $certs::qpid_client::qpid_client_ca_cert,
      messaging_client_cert  => $certs::qpid_client::qpid_client_cert,
      messaging_transport    => 'qpid',
      messaging_url          => "ssl://${broker_host}:${broker_port}",
      num_workers            => $num_workers,
      proxy_password         => $proxy_password,
      proxy_port             => $proxy_port,
      proxy_url              => $proxy_host,
      proxy_username         => $proxy_username,
      puppet_wsgi_processes  => $puppet_wsgi_processes,
      repo_auth              => true,
      ssl_protocol           => $ssl_protocol,
      worker_timeout         => $worker_timeout,
      yum_max_speed          => $yum_max_speed,
      subscribe              => Class['certs', 'certs::apache', 'certs::qpid_client'],
    }
    contain pulp

    $pulp_url = "https://${pulp::server_name}/pulp"
  } else {
    $pulp_url = undef
  }

  include foreman_proxy
  class { 'foreman_proxy::plugin::pulp':
    enabled          => $pulp2 and !$is_mirror,
    pulpnode_enabled => $pulp2 and $is_mirror,
    pulp3_enabled    => $pulp3,
    pulp3_mirror     => $is_mirror,
    pulp_url         => $pulp_url,
  }
}
