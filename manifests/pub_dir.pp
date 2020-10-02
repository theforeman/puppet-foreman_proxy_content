# @summary Manages the pub httpd directory
#
# The HTTP public direction contains files like the katello ca certificate
# for download by clients
#
# @param servername
#   The servername to be used in the Apache vhost
# @param pub_dir_options
#   The Directory options as Apache applies them
class foreman_proxy_content::pub_dir (
  String $servername = $facts['networking']['fqdn'],
  String $pub_dir_options = '+FollowSymLinks +Indexes',
) {
  include foreman_proxy_content
  include apache

  ensure_packages('katello-client-bootstrap')

  if ($foreman_proxy_content::pulpcore or $foreman_proxy_content::pulp_master) {
    include foreman::config::apache

    foreman::config::apache::fragment { 'pub_dir':
      content     => template('foreman_proxy_content/httpd_pub.erb'),
      ssl_content => template('foreman_proxy_content/httpd_pub.erb'),
    }
  } elsif $foreman_proxy_content::pulp {
    pulp::apache::fragment { 'pub_dir':
      ssl_content => template('foreman_proxy_content/httpd_pub.erb'),
    }

    file { "${apache::confd_dir}/pulp-vhosts80/pub_dir.conf":
      ensure  => file,
      content => template('foreman_proxy_content/httpd_pub.erb'),
      owner   => 'apache',
      group   => 'apache',
      mode    => '0600',
      notify  => Service['httpd'],
    }
  } else {
    apache::vhost { 'foreman_proxy_content':
      servername      => $servername,
      port            => 80,
      priority        => '05',
      docroot         => '/var/www/html',
      options         => ['SymLinksIfOwnerMatch'],
      custom_fragment => template('foreman_proxy_content/httpd_pub.erb'),
    }
  }
}
