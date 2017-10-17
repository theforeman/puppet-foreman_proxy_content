# Adds http reverse-proxy to parent conf
class foreman_proxy_content::reverse_proxy (
  $path = '/',
  $url  = "${foreman_proxy_content::foreman_url}/",
  $port = $::foreman_proxy_content::reverse_proxy_port,
  $ssl_protocol = $::foreman_proxy_content::ssl_protocol,
) {
  include ::apache
  include ::certs::apache
  include ::certs::foreman_proxy

  Class['certs', 'certs::ca', 'certs::apache', 'certs::foreman_proxy'] ~> Class['apache::service']

  apache::vhost { 'katello-reverse-proxy':
    servername             => $::certs::apache::hostname,
    port                   => $port,
    docroot                => '/var/www/',
    priority               => '28',
    ssl_options            => ['+StdEnvVars', '+ExportCertData', '+FakeBasicAuth'],
    ssl                    => true,
    ssl_proxyengine        => true,
    ssl_proxy_ca_cert      => $::certs::ca_cert,
    ssl_proxy_machine_cert => $::certs::foreman_proxy::foreman_proxy_ssl_client_bundle,
    ssl_cert               => $::certs::apache::apache_cert,
    ssl_key                => $::certs::apache::apache_key,
    ssl_ca                 => $::certs::ca_cert,
    ssl_verify_client      => 'optional',
    ssl_verify_depth       => 10,
    ssl_protocol           => $ssl_protocol,
    request_headers        => ['set X_RHSM_SSL_CLIENT_CERT "%{SSL_CLIENT_CERT}s"'],
    proxy_pass             => [
      {
        'path'         => $path,
        'url'          => $url,
        'reverse_urls' => [$path, $url]
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
  }
}
