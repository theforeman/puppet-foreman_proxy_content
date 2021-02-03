# @summary Configure qpid router to listen as a hub
#
# @param hub_addr
#   Address to listen on
#
# @param hub_port
#   Port to listen on
#
# @param broker_addr
#   Address of qpidd broker to connect to
#
# @param broker_port
#   Port of qpidd broker to connect to
#
# @param sasl_mech
#   SASL mechanism to be used from router to broker
#
# @param sasl_username
#   SASL username to be used from router to broker
#
# @param sasl_password
#   SASL password to be used from router to broker
class foreman_proxy_content::dispatch_router::hub (
  Optional[String] $hub_addr = undef,
  Stdlib::Port $hub_port = 5646,
  String $broker_addr = undef,
  Stdlib::Port $broker_port = 5671,
  String $sasl_mech = 'PLAIN',
  String $sasl_username = 'katello_agent',
  String $sasl_password = extlib::cache_data('foreman_cache_data', 'qpid_router_sasl_password', extlib::random_password(16)),
) {
  include foreman_proxy_content::dispatch_router

  qpid::router::listener {'hub':
    host        => $hub_addr,
    port        => $hub_port,
    role        => 'inter-router',
    ssl_profile => 'server',
  }

  # Connect dispatch router to the local qpid
  qpid::router::connector { 'broker':
    host          => $broker_addr,
    port          => $broker_port,
    sasl_mech     => $sasl_mech,
    sasl_username => $sasl_username,
    sasl_password => $sasl_password,
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

  qpid::router::link_route { 'broker-katello-agent-route-in':
    prefix     => 'katello.agent',
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
}
