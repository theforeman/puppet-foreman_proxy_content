# Pulp Installation Packages
class capsule::install {
  package{ ['katello-debug']:
    ensure => installed,
  }
}
