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

if $facts['os']['release']['major'] == '8' {
  package { 'glibc-langpack-en':
    ensure => installed,
  }

  yumrepo { 'powertools':
    enabled => true,
  }
} elsif $facts['os']['release']['major'] == '7' {
  package { 'epel-release':
    ensure => installed,
  }
}
