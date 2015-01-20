#Adds http reverse-proxy to parent conf
class capsule::reverse_proxy(
  $path = '/',
  $url  = "https://${capsule::parent_fqdn}/",
  $port = 8443
  ) {

  if $capsule::parent_reverse_proxy {
    include ::apache
    apache::vhost { 'katello-reverse-proxy':
      servername        => $capsule::capsule_fqdn,
      port              => $port,
      docroot           => '/var/www/',
      priority          => '28',
      ssl_options       => ['+StdEnvVars',
                            '+ExportCertData',
                            '+FakeBasicAuth'],
      ssl               => true,
      ssl_proxyengine   => true,
      ssl_cert          => $certs::params::foreman_proxy_cert,
      ssl_key           => $certs::params::foreman_proxy_key,
      ssl_ca            => $certs::params::foreman_proxy_ca_cert,
      ssl_verify_client => 'optional',
      ssl_verify_depth  => 1,
      request_headers   => ['set SSL_CLIENT_CERT "%{SSL_CLIENT_CERT}s"',
                            "set X_FORWARDED_PROTO 'https'"],
      proxy_pass        => [{
        'path'         => $path,
        'url'          => $url,
        'reverse_urls' => [$path, $url]
      }],
      error_documents   => [{
          'error_code' => '503',
          'document'   => '\'{"displayMessage": "Internal error, contact administrator", "errors": ["Internal error, contact administrator"], "status": "500" }\''
        },
        {
          'error_code' => '503',
          'document'   => '\'{"displayMessage": "Service unavailable or restarting, try later", "errors": ["Service unavailable or restarting, try later"], "status": "503" }\''
        },
      ]
    }
  }
}
