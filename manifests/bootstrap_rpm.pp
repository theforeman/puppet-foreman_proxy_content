# This class builds an RPM containing the bootstrap for a subscription-manager consumer
# This file is placed in $rpm_serve_dir.
# @api private
class foreman_proxy_content::bootstrap_rpm (
  Stdlib::Absolutepath $server_ca_cert,
  String $server_ca_name,
  Stdlib::Absolutepath $default_ca_cert,
  String $default_ca_name,
  Stdlib::Fqdn $rhsm_hostname = $facts['networking']['fqdn'],
  Stdlib::Port $rhsm_port = 443,
  Pattern[/\A(\/[a-zA-Z0-9]+)+(\/)?\z/] $rhsm_path = '/rhsm',
  Stdlib::Absolutepath $rpm_serve_dir = '/var/www/html/pub',
) {
  $katello_rhsm_setup_script = 'katello-rhsm-consumer'
  $katello_rhsm_setup_script_location = "/usr/bin/${katello_rhsm_setup_script}"
  $candlepin_cert_rpm_alias_filename = 'katello-ca-consumer-latest.noarch.rpm'

  $bootstrap_rpm_name = "katello-ca-consumer-${rhsm_hostname}"

  include trusted_ca
  trusted_ca::ca { 'katello_server-host-cert':
    source  => $server_ca_cert,
    require => File[$server_ca_cert],
  }

  package { 'rpm-build':
    ensure => installed,
  }

  include apache
  file { $rpm_serve_dir:
    ensure => directory,
    owner  => 'apache',
    group  => 'apache',
    mode   => '0755',
  }

  # Placing the CA in the pub dir for trusting by a user in their browser
  file { "${rpm_serve_dir}/${server_ca_name}.crt":
    ensure  => file,
    source  => $server_ca_cert,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File[$server_ca_cert],
  } ->
  rhsm_reconfigure_script { "${rpm_serve_dir}/${katello_rhsm_setup_script}":
    ensure          => present,
    default_ca_cert => $default_ca_cert,
    server_ca_cert  => $server_ca_cert,
    default_ca_name => $default_ca_name,
    server_ca_name  => $server_ca_name,
    rhsm_hostname   => $rhsm_hostname,
    rhsm_port       => $rhsm_port,
    rhsm_path       => $rhsm_path,
    owner           => 'root',
    group           => 'root',
    mode            => '0644',
  }

  bootstrap_rpm { $bootstrap_rpm_name:
    ensure  => present,
    script  => "${rpm_serve_dir}/${katello_rhsm_setup_script}",
    dest    => $rpm_serve_dir,
    symlink => "${rpm_serve_dir}/${candlepin_cert_rpm_alias_filename}",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
