# @summary Manages a standalone qpid broker for pulp
#
# In Katello, the master pulp instance uses Katello's main qpid message broker.
# This can be used for a separate pulp instance that also needs a broker of its
# own.
#
# @param interface
#   The interface the broker listens on
class foreman_proxy_content::broker (
  String $interface = 'lo',
) {
  include certs::qpid

  class { 'qpid':
    ssl                    => true,
    ssl_cert_db            => $certs::nss_db_dir,
    ssl_cert_password_file => $certs::qpid::nss_db_password_file,
    ssl_cert_name          => 'broker',
    interface              => $interface,
    subscribe              => Class['certs', 'certs::qpid'],
  }
}
