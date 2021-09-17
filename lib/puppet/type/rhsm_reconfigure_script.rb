Puppet::Type.newtype(:rhsm_reconfigure_script) do
  desc 'Creates script to reconfigure RHSM to point at a server'

  ensurable

  newparam(:path, :namevar => true) do
    desc "Full path of RHSM reconfigure script"
  end

  newparam(:server_ca_cert) do
    desc "CA certificate used with Apache"
  end

  newparam(:default_ca_cert) do
    desc "Root CA for the deployment"
  end

  newparam(:server_ca_name) do
    desc "Filename of the server CA"
  end

  newparam(:default_ca_name) do
    desc "Filename of the default CA"
  end

  newparam(:rhsm_hostname) do
    desc "Hostname that RHSM should be configured to talk to"
  end

  newparam(:rhsm_port) do
    desc "Port that RHSM should be configured to talk to"
  end

  newparam(:rhsm_path) do
    desc "Port that RHSM should be configured to talk to"
    default '/rhsm'
  end

  autorequire(:file) do
    [
      self[:server_ca_cert],
      self[:default_ca_cert],
      File.dirname(self[:name])
    ]
  end

  def refresh
    provider.create unless provider.exist?
  end
end
