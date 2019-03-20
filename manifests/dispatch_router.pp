# == Class: foreman_proxy_content::dispatch_router
#
# Install and configure Qpid Dispatch Router
#
class foreman_proxy_content::dispatch_router (
) {

  class { '::qpid::router': }

  # SSL Certificate Configuration
  class { '::certs::qpid_router':
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
    ciphers   => $foreman_proxy_content::qpid_router_ssl_ciphers,
    protocols => $foreman_proxy_content::qpid_router_ssl_protocols,
  }

  # Listen for katello-agent clients
  qpid::router::listener { 'clients':
    host        => $foreman_proxy_content::qpid_router_agent_addr,
    port        => $foreman_proxy_content::qpid_router_agent_port,
    ssl_profile => 'server',
  }

  # Enable logging to syslog or file
  if $foreman_proxy_content::qpid_router_logging == 'file' {
    file { $foreman_proxy_content::qpid_router_logging_path:
      ensure => directory,
      owner  => 'qdrouterd',
    }
  }

  $output_real = $foreman_proxy_content::qpid_router_logging ? {
    'file'   => "${foreman_proxy_content::qpid_router_logging_path}/qdrouterd.log",
    'syslog' => 'syslog',
  }

  qpid::router::log { 'logging':
    level  => $foreman_proxy_content::qpid_router_logging_level,
    output => $output_real,
  }

  # Act as hub if pulp master, otherwise connect to hub
  if $foreman_proxy_content::pulp_master {
    qpid::router::listener {'hub':
      host        => $foreman_proxy_content::qpid_router_hub_addr,
      port        => $foreman_proxy_content::qpid_router_hub_port,
      role        => 'inter-router',
      ssl_profile => 'server',
    }

    # Connect dispatch router to the local qpid
    qpid::router::connector { 'broker':
      host          => $foreman_proxy_content::qpid_router_broker_addr,
      port          => $foreman_proxy_content::qpid_router_broker_port,
      sasl_mech     => $foreman_proxy_content::qpid_router_sasl_mech,
      sasl_username => $foreman_proxy_content::qpid_router_sasl_username,
      sasl_password => $foreman_proxy_content::qpid_router_sasl_password,
      ssl_profile   => 'client',
      role          => 'route-container',
      idle_timeout  => 0,
    }

    qpid::router::link_route { 'broker-pulp-route-out':
      prefix     => 'pulp.',
      direction  => 'out',
      connection => 'broker',
    }

    qpid::router::link_route { 'broker-pulp-task-route-in':
      prefix     => 'pulp.task',
      direction  => 'in',
      connection => 'broker',
    }

    qpid::router::link_route { 'broker-qmf-route-in':
      prefix     => 'qmf.',
      connection => 'broker',
      direction  => 'in',
    }

    qpid::router::link_route { 'broker-qmf-route-out':
      prefix     => 'qmf.',
      connection => 'broker',
      direction  => 'out',
    }
  } else {
    qpid::router::connector { 'hub':
      host         => $foreman_proxy_content::parent_fqdn,
      port         => $foreman_proxy_content::qpid_router_hub_port,
      ssl_profile  => 'client',
      role         => 'inter-router',
      idle_timeout => 0,
    }

    qpid::router::link_route { 'hub-pulp-route-in':
      prefix    => 'pulp.',
      direction => 'in',
    }

    qpid::router::link_route { 'hub-pulp-route-out':
      prefix    => 'pulp.',
      direction => 'out',
    }

    qpid::router::link_route { 'hub-qmf-route-in':
      prefix    => 'qmf.',
      direction => 'in',
    }

    qpid::router::link_route { 'hub-qmf-route-out':
      prefix    => 'qmf.',
      direction => 'out',
    }
  }
}
