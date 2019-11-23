# @summary Install and configure Qpid Dispatch Router
#
# @param agent_addr
#   Listener address for goferd agents
#
# @param agent_port
#   Listener port for goferd agents
#
# @param logging_level
#   Logging level of dispatch router (e.g. info+ or debug+)
#
# @param logging
#   Whether to log to file or syslog.
#
# @param logging_path
#   Directory for dispatch router logs, if using file logging
#
# @param ssl_ciphers
#   SSL Ciphers to support in dispatch router
#
# @param ssl_protocols
#   Protocols to support in dispatch router (e.g. TLSv1.2, etc)
class foreman_proxy_content::dispatch_router (
  Optional[Stdlib::Host] $agent_addr = undef,
  Stdlib::Port $agent_port = 5647,

  Optional[String] $ssl_ciphers = undef,
  Optional[Array[String]] $ssl_protocols = undef,

  String $logging_level = 'info+',
  Enum['file', 'syslog'] $logging = 'syslog',
  Stdlib::Absolutepath $logging_path = '/var/log/qdrouterd',
) {

  contain qpid::router

  # SSL Certificate Configuration
  class { 'certs::qpid_router':
    require => Class['qpid::router::install'],
  }
  ~> qpid::router::ssl_profile { 'client':
    ca   => $certs::ca_cert,
    cert => $certs::qpid_router::client_cert,
    key  => $certs::qpid_router::client_key,
  }
  ~> qpid::router::ssl_profile { 'server':
    ca        => $certs::ca_cert,
    cert      => $certs::qpid_router::server_cert,
    key       => $certs::qpid_router::server_key,
    ciphers   => $ssl_ciphers,
    protocols => $ssl_protocols,
  }

  # Listen for katello-agent clients
  qpid::router::listener { 'clients':
    host        => $agent_addr,
    port        => $agent_port,
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
