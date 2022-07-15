require 'spec_helper'

describe 'foreman_proxy_content::pub_dir' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      it { should compile.with_all_deps }
      it { should contain_class('apache::mod::autoindex') }
      it { should contain_package('katello-client-bootstrap') }

      context 'apache without default mods and indexing disabled' do
        let(:params) do
          {
            pub_dir_options: '+FollowSymLinks',
          }
        end
        let(:pre_condition) do
          <<~PUPPET
          class { 'apache':
            default_mods => false,
          }
          PUPPET
        end

        it { should_not contain_class('apache::mod::autoindex') }
      end
    end
  end
end
