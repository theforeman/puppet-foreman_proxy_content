# The pulp master configuration
#
# This scenario assumes the pulp master is already configured otherwise,
# usually via puppet-katello. Here we only configure the qpid router (if
# desired) and crane.
class foreman_proxy_content::pulp::master (
  Boolean $qpid_router = $::foreman_proxy_content::qpid_router,
  String $hub_host = $::foreman_proxy_content::qpid_router_hub_addr,
  Integer[0, 65535] $hub_port = $::foreman_proxy_content::qpid_router_hub_port,
  String $broker_host = $::foreman_proxy_content::qpid_router_broker_addr,
  Integer[0, 65535] $broker_port = $::foreman_proxy_content::qpid_router_broker_port,
) {
  if $qpid_router {
    include ::foreman_proxy_content::dispatch_router

    qpid::router::listener {'hub':
      host        => $hub_host,
      port        => $hub_port,
      role        => 'inter-router',
      ssl_profile => 'server',
    }

    # Connect dispatch router to the local qpid
    qpid::router::connector { 'broker':
      host         => $broker_host,
      port         => $broker_port,
      ssl_profile  => 'client',
      role         => 'route-container',
      idle_timeout => 0,
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
      direction  => 'in',
      connection => 'broker',
    }

    qpid::router::link_route { 'broker-qmf-route-out':
      prefix     => 'qmf.',
      direction  => 'out',
      connection => 'broker',
    }
  }

  include ::certs::apache
  class { '::pulp::crane':
    cert      => $::certs::apache::apache_cert,
    key       => $::certs::apache::apache_key,
    ca_cert   => $::certs::ca_cert,
    data_dir  => '/var/lib/pulp/published/docker/v2/app',
    subscribe => Class['certs::apache'],
  }
}
