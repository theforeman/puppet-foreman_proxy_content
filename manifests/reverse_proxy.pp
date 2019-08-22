# Adds http reverse-proxy to parent conf
#
# @param path
#   The path where to mount the reverse proxy
# @param url
#   The URL to forward to
# @param servername
#   The Apache vhost server name to listen on
# @param port
#   The port to listen on
# @param ssl_protocol
#   The ssl protocol(s) to accept
# @param vhost_params
#   Any parameters to pass to the apache::vhost resource
# @param proxy_pass_params
#   Any parameters to pass to the proxy_pass param of the apache::vhost resource
class foreman_proxy_content::reverse_proxy (
  Stdlib::Unixpath $path = '/',
  Stdlib::Httpurl $url = "${foreman_proxy_content::foreman_url}/",
  Stdlib::Fqdn $servername = $foreman_proxy_content::foreman_proxy_fqdn,
  Stdlib::Port $port = $foreman_proxy_content::reverse_proxy_port,
  Variant[Array[String], String, Undef] $ssl_protocol = undef,
  Hash[String, Any] $vhost_params = {},
  Hash[String, String] $proxy_pass_params = {},
) {
  include apache
  include certs::apache
  include certs::foreman_proxy

  Class['certs', 'certs::ca', 'certs::apache', 'certs::foreman_proxy'] ~> Class['apache::service']

  apache::vhost { 'katello-reverse-proxy':
    servername             => $servername,
    port                   => $port,
    docroot                => '/var/www/',
    priority               => '28',
    ssl_options            => ['+StdEnvVars', '+ExportCertData', '+FakeBasicAuth'],
    ssl                    => true,
    ssl_proxyengine        => true,
    ssl_proxy_ca_cert      => $certs::ca_cert,
    ssl_proxy_machine_cert => $certs::foreman_proxy::foreman_proxy_ssl_client_bundle,
    ssl_cert               => $certs::apache::apache_cert,
    ssl_key                => $certs::apache::apache_key,
    ssl_chain              => $certs::katello_server_ca_cert,
    ssl_ca                 => $certs::ca_cert,
    ssl_verify_client      => 'optional',
    ssl_verify_depth       => 10,
    ssl_protocol           => $ssl_protocol,
    request_headers        => ['set X_RHSM_SSL_CLIENT_CERT "%{SSL_CLIENT_CERT}s"'],
    proxy_pass             => [
      {
        'path'         => $path,
        'url'          => $url,
        'reverse_urls' => [$path, $url],
        'params'       => $proxy_pass_params,
      }
    ],
    error_documents        => [
      {
        'error_code' => '500',
        'document'   => '\'{"displayMessage": "Internal error, contact administrator", "errors": ["Internal error, contact administrator"], "status": "500" }\''
      },
      {
        'error_code' => '503',
        'document'   => '\'{"displayMessage": "Service unavailable or restarting, try later", "errors": ["Service unavailable or restarting, try later"], "status": "503" }\''
      },
    ],
    *                      => $vhost_params,
  }
}
