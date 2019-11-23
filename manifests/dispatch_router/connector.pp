# @summary Configure qpid router to connect to a hub
#
# @param host
#   The host to connect to
# @param port
#   The port to connect to
#
class foreman_proxy_content::dispatch_router::connector (
  Stdlib::Host $host,
  Stdlib::Port $port = 5646,
) {
  include foreman_proxy_content::dispatch_router

  qpid::router::connector { 'hub':
    host         => $host,
    port         => $port,
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
