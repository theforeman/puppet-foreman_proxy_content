Puppet::Type.newtype(:bootstrap_rpm) do
  desc 'bootstrap_rpm creates an RPM with CA certificate and subscription-manager configuration'

  ensurable

  newparam(:name, :namevar => true) do
    desc "The name of the bootstrap RPM"
  end

  newparam(:script) do
    desc "The script to include in the bootstrap RPM"
  end

  newparam(:dest) do
    desc "Location on disk to deploy the bootstrap RPM"
  end

  newparam(:symlink) do
    desc "Name of the symlink to link the most recent RPM to"
  end

  autorequire(:file) do
    [self[:dest]]
  end

  autorequire(:rhsm_reconfigure_script) do
    [self[:script]]
  end

  autorequire(:package) do
    ['rpm-build']
  end

  def refresh
    provider.create
  end
end
