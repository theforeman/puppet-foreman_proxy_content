class { 'foreman::repo':
  repo => 'nightly',
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

  class { 'katello::repo':
    repo_version => 'nightly',
  }
} elsif $facts['os']['release']['major'] == '7' {
  package { 'epel-release':
    ensure => installed,
  }
}
