require 'puppet/type/file/owner'
require 'puppet/type/file/group'
require 'puppet/type/file/mode'

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
    desc "Path that RHSM should be configured to talk to"
    defaultto '/rhsm'
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

  def generate
    file_opts = {
      ensure: (self[:ensure] == :absent) ? :absent : :file,
    }

    [:path,
     :owner,
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
