# @summary Pulp Container plugin
# @param location_prefix
#   In the Apache configuration a location with this prefix is exposed. The
#   version will be appended.
# @param registry_v1_path
#   The path beneath the location prefix to forward. This is also appended to
#   the content base url.
# @param registry_v2_path
#   The path beneath the location prefix to forward. This is also appended to
#   the content base url.
# @param pulpcore_https_vhost
#   The name of the Apache https vhost for Pulpcore
class foreman_proxy_content::container (
  String $location_prefix = '/pulpcore_registry',
  String $registry_v1_path = '/v1/',
  String $registry_v2_path = '/v2/',
  String $pulpcore_https_vhost = 'pulpcore-https',
) {
  include certs::foreman_proxy

  $context = {
    'directories'  => [
      {
        'provider'        => 'location',
        'path'            => "${location_prefix}${registry_v2_path}",
        'request_headers' => ["set SSL_CLIENT_S_DN \"admin\""],
        'requires'        => ["expr %{tolower:%{SSL_CLIENT_S_DN_CN}} == \"${certs::foreman_proxy::hostname.downcase}\""]
      },
    ],
    'proxy_pass' => [
      {
        'path' => $registry_v1_path,
        'url'  => "${foreman_proxy::real_registered_proxy_url}/container_gateway${registry_v1_path}",
      },
      {
        'path' => $registry_v2_path,
        'url'  => "${foreman_proxy::real_registered_proxy_url}/container_gateway${registry_v2_path}",
      },
    ],
  }

  $https_content = epp('foreman_proxy_content/container-gateway-fragment.epp', $context)

  apache::vhost::fragment { 'pulp-https-container':
    vhost    => $pulpcore_https_vhost,
    priority => '10',
    content  => $https_content,
  }
}
