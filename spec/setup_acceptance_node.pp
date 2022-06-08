class { 'foreman::repo':
  repo => 'nightly',
}

class { 'katello::repo':
  repo_version => 'nightly',
}

include pulpcore::repo

if $facts['os']['selinux']['enabled'] {
  package { 'pulpcore-selinux':
    ensure  => installed,
    require => Class['pulpcore::repo'],
  }
}

package { 'glibc-langpack-en':
  ensure => installed,
}

yumrepo { 'powertools':
  enabled => true,
}
