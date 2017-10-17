require 'spec_helper'

describe 'foreman_proxy_content' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'without parameters' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('katello-debug') }
      end

      context 'with pulp master' do
        let :params do
          {
            :pulp_master       => true,
            :qpid_router       => false
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('foreman_proxy_content::pulp::master') }
        it { is_expected.not_to contain_class('foreman_proxy_content::pulp::node') }
        it { is_expected.not_to contain_class('pulp') }
        it { is_expected.not_to contain_class('foreman_proxy_content::dispatch_router') }
      end

      context 'with pulp node' do
        let :pre_condition do
          <<-EOS
          class { '::foreman_proxy::plugin::pulp':
            pulpnode_enabled => true,
          }
          EOS
        end
        let :params do
          {
            :pulp_master       => false,
            :qpid_router       => false
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.not_to contain_class('foreman_proxy_content::pulp::master') }
        it { is_expected.to contain_class('foreman_proxy_content::pulp::node') }
        it { is_expected.to contain_class('pulp') }
        it { is_expected.not_to contain_class('foreman_proxy_content::dispatch_router') }
        it { is_expected.to contain_package('katello-client-bootstrap') }
        it { is_expected.to contain_class('foreman_proxy_content::pub_dir') }
      end

      context 'with dispatch router' do
        let :params do
          {
            :pulp_master       => true,
            :qpid_router       => true,
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('foreman_proxy_content::dispatch_router') }
        it { is_expected.to contain_service('qdrouterd') }
      end
    end
  end
end
