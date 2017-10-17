# == Class: foreman_proxy_content::dispatch_router
#
# Install and configure Qpid Dispatch Router
#
class foreman_proxy_content::dispatch_router (
  $listener_host = $::foreman_proxy_content::qpid_router_agent_addr,
  $listener_port = $::foreman_proxy_content::qpid_router_agent_port,
  $logging = $::foreman_proxy_content::qpid_router_logging,
  $logging_path = $::foreman_proxy_content::qpid_router_logging_path,
  $logging_level = $::foreman_proxy_content::qpid_router_logging_level,
  $ssl_ciphers = $::foreman_proxy_content::qpid_router_ssl_ciphers,
  $ssl_protocols = $::foreman_proxy_content::qpid_router_ssl_protocols,
) {
  include ::qpid::router

  # SSL Certificate Configuration
  include ::certs
  include ::certs::qpid_router

  Class['qpid::router::install'] -> Class['certs::qpid_router']

  qpid::router::ssl_profile { 'client':
    ca        => $certs::ca_cert,
    cert      => $certs::qpid_router::client_cert,
    key       => $certs::qpid_router::client_key,
    subscribe => Class['certs', 'certs::qpid_router'],
  }

  qpid::router::ssl_profile { 'server':
    ca        => $certs::ca_cert,
    cert      => $certs::qpid_router::server_cert,
    key       => $certs::qpid_router::server_key,
    ciphers   => $ssl_ciphers,
    protocols => $ssl_protocols,
    subscribe => Class['certs', 'certs::qpid_router'],
  }

  # Listen for katello-agent clients
  qpid::router::listener { 'clients':
    host        => $listener_host,
    port        => $listener_port,
    ssl_profile => 'server',
  }

  # Enable logging to syslog or file
  if $logging == 'file' {
    file { $logging_path:
      ensure => directory,
      owner  => 'qdrouterd',
    }
  }

  $output_real = $logging ? {
    'file'   => "${logging_path}/qdrouterd.log",
    'syslog' => 'syslog',
  }

  qpid::router::log { 'logging':
    level  => $logging_level,
    output => $output_real,
  }
}
