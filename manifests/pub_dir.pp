# @summary Manages the pub httpd directory
#
# The HTTP public direction contains files like the katello ca certificate
# for download by clients
#
# @param pub_dir_options
#   The Directory options as Apache applies them
#
# @param ensure_bootstrap
#   Enable installing the katello-client-bootstrap RPM
class foreman_proxy_content::pub_dir (
  String $pub_dir_options = '+FollowSymLinks +Indexes',
  Enum['present', 'absent'] $ensure_bootstrap = 'present',
) {
  stdlib::ensure_packages('katello-client-bootstrap', { 'ensure' => $ensure_bootstrap })

  include apache::mod::alias

  if '+Indexes' in $pub_dir_options.split(' ') {
    include apache::mod::dir
    include apache::mod::autoindex
  }

  pulpcore::apache::fragment { 'pub_dir':
    http_content  => template('foreman_proxy_content/httpd_pub.erb'),
    https_content => template('foreman_proxy_content/httpd_pub.erb'),
  }
}
