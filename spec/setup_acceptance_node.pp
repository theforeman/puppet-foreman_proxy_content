$major = $facts['os']['release']['major']

# Defaults to staging, for release, use
# $baseurl = "https://yum.theforeman.org/releases/nightly/el${major}/x86_64/"
$baseurl = "http://koji.katello.org/releases/yum/foreman-nightly/RHEL/${major}/x86_64/"

yumrepo { 'foreman':
  baseurl  => $baseurl,
  gpgcheck => 0,
}

package { 'policycoreutils':
  ensure => installed,
}

if $facts['os']['release']['major'] == '8' {
  package { 'glibc-langpack-en':
    ensure => installed,
  }

  yumrepo { 'powertools':
    enabled => true,
  }

  yumrepo { 'katello':
    baseurl  => "http://yum.theforeman.org/katello/nightly/katello/el8/x86_64/",
    gpgcheck => 0,
  }
} elsif $facts['os']['release']['major'] == '7' {
  package { 'epel-release':
    ensure => installed,
  }
}
