# @summary Compose RHSM reconfigure script via concats
# @api private
define foreman_proxy_content::rhsm_reconfigure_script(
  Stdlib::Absolutepath $ca_cert,
  Stdlib::Absolutepath $server_ca_cert,
  Stdlib::Absolutepath $rhsm_ca_dir,
  String $default_ca_name,
  String $server_ca_name,
  Stdlib::Port $rhsm_port,
  Stdlib::Fqdn $rhsm_hostname,
  String $rhsm_prefix,
) {

  concat { $title:
    owner => 'root',
    group => 'root',
    mode  => '0755',
  }

  concat::fragment { "${title}+script_start":
    target  => $title,
    content => "#!/bin/bash\n\nset -e\n",
    order   => '01',
  }

  concat::fragment { "${title}+default_ca_data":
    target  => $title,
    content => "read -r -d '' KATELLO_DEFAULT_CA_DATA << EOM || true\n",
    order   => '02',
  }

  concat::fragment { "${title}+ca_cert":
    target => $title,
    source => $ca_cert,
    order  => '03',
  }

  concat::fragment { "${title}+end_ca_cert":
    target  => $title,
    content => "\nEOM\n\n",
    order   => '04',
  }

  concat::fragment { "${title}+server_ca_data":
    target  => $title,
    content => "read -r -d '' KATELLO_SERVER_CA_DATA << EOM || true\n",
    order   => '05',
  }

  concat::fragment { "${title}+server_ca_cert":
    target => $title,
    source => $server_ca_cert,
    order  => '06',
  }

  concat::fragment { "${title}+end_server_ca_cert":
    target  => $title,
    content => "\nEOM\n\n",
    order   => '07',
  }

  concat::fragment { "${title}+reconfigure":
    target  => $title,
    content => template('foreman_proxy_content/bootstrap_rpm/rhsm-katello-reconfigure.erb'),
    order   => '10',
  }

}
