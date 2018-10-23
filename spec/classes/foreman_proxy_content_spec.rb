require 'spec_helper'

describe 'foreman_proxy_content' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'without parameters' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('katello-debug') }
      end

      context 'with pulp' do
        let(:params) do
          {
            qpid_router: false
          }
        end

        let(:pre_condition) do
          <<-PUPPET
          include foreman_proxy
          class { 'foreman_proxy::plugin::pulp':
            pulpnode_enabled => true,
          }
          PUPPET
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('pulp').with(manage_squid: true) }
        it { is_expected.not_to contain_class('foreman_proxy_content::dispatch_router') }

        it { is_expected.to contain_class('foreman_proxy_content::pub_dir') }

        it do
          is_expected.to contain_pulp__apache__fragment('gpg_key_proxy')
            .with_ssl_content(%r{ProxyPass /katello/api/repositories/ https://foo\.example\.com/katello/api/repositories/})
        end
      end

      context 'with rhsm_hostname and rhsm_url' do
        let(:params) do
          {
            rhsm_hostname: 'katello.example.com',
            rhsm_url: '/abc/rhsm'
          }
        end

        it { is_expected.to compile.with_all_deps }
        it do
          is_expected.to contain_class('certs::katello')
            .with_hostname('katello.example.com')
            .with_deployment_url('/abc/rhsm')
        end
      end

      context 'with puppet' do
        let(:params) do
          {
            puppet: true,
          }
        end

        describe 'with puppet server enabled' do
          let(:pre_condition) do
            <<-PUPPET
            class { 'puppet':
              server         => true,
              server_foreman => true,
            }
            PUPPET
          end

          it { is_expected.to compile.with_all_deps }
          it do
            is_expected.to contain_class('certs::puppet')
              .that_comes_before('Class[foreman::puppetmaster]')
          end
        end

        describe 'with puppet server disabled' do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.not_to contain_class('certs::puppet') }
        end
      end
    end
  end
end
