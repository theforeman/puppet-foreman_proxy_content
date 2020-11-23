require 'spec_helper'

describe 'foreman_proxy_content::pub_dir' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let(:pre_condition) do
        <<-PUPPET
        class { 'foreman_proxy_content':
          enable_pulp2    => false,
          enable_pulpcore => false
        }
        PUPPET
      end

      it { should compile.with_all_deps }
      it { should contain_package('katello-client-bootstrap') }
    end
  end
end
