# The puppet aspect of a content proxy
class foreman_proxy_content::puppet {
  # We can't pull the certs out to the top level, because of how it gets the default
  # parameter values from the main ::certs class.  Kafo can't handle that case, so
  # it remains here for now.
  include ::puppet
  if $::puppet::server and $::puppet::server::foreman {
    class { '::certs::puppet':
      hostname => $foreman_proxy_fqdn,
      require  => Class['certs'],
      before   => Class['puppet'],
    }
  }
}
