require 'puppet/type/file/owner'
require 'puppet/type/file/group'
require 'puppet/type/file/mode'

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

  newparam(:owner, parent: Puppet::Type::File::Owner) do
    desc "Specifies the owner of the private key. Valid options: a string containing a username or integer containing a uid."
  end

  newparam(:group, parent: Puppet::Type::File::Group) do
    desc "Specifies a permissions group for the private key. Valid options: a string containing a group name or integer containing a gid."
  end

  newparam(:mode, parent: Puppet::Type::File::Mode) do
    desc "Specifies the permissions mode of the private key. Valid options: a string containing a permission mode value in octal notation."
  end

  newproperty(:symlink) do
    desc "Name of the symlink to link the most recent RPM to"

    def latest_rpm
      provider.latest_rpm
    end

    def should_to_s(newvalue)
      self.class.format_value_for_display(latest_rpm)
    end

    def insync?(is)
      is == latest_rpm
    end
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

  def generate
    file_opts = {
      ensure: (self[:ensure] == :absent) ? :absent : :file,
      path: "#{self[:dest]}/#{self[:name]}",
    }

    [:owner,
     :group,
     :mode].each do |param|
      file_opts[param] = self[param] unless self[param].nil?
    end

    excluded_metaparams = [:before, :notify, :require, :subscribe, :tag]

    Puppet::Type.metaparams.each do |metaparam|
      unless self[metaparam].nil? || excluded_metaparams.include?(metaparam)
        file_opts[metaparam] = self[metaparam]
      end
    end

    [Puppet::Type.type(:file).new(file_opts)]
  end
end
