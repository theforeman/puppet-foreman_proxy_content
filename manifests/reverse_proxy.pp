# Adds http reverse-proxy to parent conf
#
# @param path_url_map
#   The paths and corresponding URLs where to mount the reverse proxy
# @param port
#   The port to listen on
# @param ssl_protocol
#   The ssl protocol(s) to accept
# @param vhost_params
#   Any parameters to pass to the apache::vhost resource
# @param proxy_pass_params
#   Any parameters to pass to the proxy_pass param of the apache::vhost resource
# @param ensure
#   Specifies if the virtual host is present or absent.
# @param priority
#   Sets the relative load-order for Apache HTTPD VirtualHost configuration files. See Apache::Vhost
define foreman_proxy_content::reverse_proxy (
  Hash[Stdlib::Unixpath, String[1]] $path_url_map = { '/' => "${foreman_proxy_content::foreman_url}/" },
  Stdlib::Port $port = $foreman_proxy_content::reverse_proxy_port,
  Variant[Array[String], String, Undef] $ssl_protocol = undef,
  Hash[String, Any] $vhost_params = {},
  Hash[String, Variant[String, Integer]] $proxy_pass_params = { 'disablereuse' => 'on', 'retry' => '0' },
  Enum['present', 'absent'] $ensure = 'present',
  Variant[String, Boolean] $priority = '28',
) {
  include apache
  include certs::apache
  include certs::foreman_proxy

  Class['certs', 'certs::ca', 'certs::apache', 'certs::foreman_proxy'] ~> Class['apache::service']

  $vhost_name = $title

  $proxy_pass = $path_url_map.map |$path, $url| {
    {
      'path'         => $path,
      'url'          => $url,
      'reverse_urls' => [$url],
      'params'       => $proxy_pass_params,
    }
  }

  apache::vhost { $vhost_name:
    ensure                 => $ensure,
    servername             => $certs::apache::hostname,
    serveraliases          => $certs::apache::cname,
    port                   => $port,
    docroot                => '/var/www/',
    priority               => $priority,
    ssl_options            => ['+StdEnvVars', '+ExportCertData', '+FakeBasicAuth'],
    ssl                    => true,
    ssl_proxyengine        => true,
    ssl_proxy_ca_cert      => $certs::ca_cert,
    ssl_proxy_machine_cert => $certs::foreman_proxy::foreman_proxy_ssl_client_bundle,
    ssl_cert               => $certs::apache::apache_cert,
    ssl_key                => $certs::apache::apache_key,
    ssl_chain              => $certs::apache::apache_ca_cert,
    ssl_ca                 => $certs::apache::ca_cert,
    ssl_verify_client      => 'optional',
    ssl_verify_depth       => 10,
    ssl_protocol           => $ssl_protocol,
    request_headers        => ['set X_RHSM_SSL_CLIENT_CERT "%{SSL_CLIENT_CERT}s"'],
    proxy_pass             => $proxy_pass,
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
