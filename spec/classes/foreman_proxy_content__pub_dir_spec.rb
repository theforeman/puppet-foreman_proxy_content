require 'spec_helper'

describe 'foreman_proxy_content::pub_dir' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let(:pre_condition) do
        <<-PUPPET
        include foreman_proxy
        class { 'foreman_proxy::plugin::pulp':
          enabled          => false,
          pulpnode_enabled => false,
          pulpcore_enabled => false,
        }
        PUPPET
      end

      it { should compile.with_all_deps }
      it { should contain_package('katello-client-bootstrap') }
    end
  end
end
