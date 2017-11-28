require 'spec_helper'

describe 'foreman_proxy_content' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      let :pre_condition do
        "include foreman_proxy"
	  end


      it { should contain_package('katello-debug') }

      context 'with pulp' do
        let(:params) do
          {
            :qpid_router       => false
          }
        end

        let(:pre_condition) do
          "include foreman_proxy
          class {'foreman_proxy::plugin::pulp': pulpnode_enabled => true}"
        end

        it { should contain_class('pulp').with(:manage_squid => true) }
        it { should_not contain_class('foreman_proxy_content::dispatch_router') }

        it { should contain_class('foreman_proxy_content::pub_dir') }

        it { should contain_pulp__apache__fragment('gpg_key_proxy').with({
          :ssl_content => %r{ProxyPass /katello/api/repositories/ https://foo\.example\.com/katello/api/repositories/}} ) }
      end

      context 'with rhsm_hostname and rhsm_url' do
        let(:params) do
          {
            :rhsm_hostname => 'katello.example.com',
            :rhsm_url      => '/abc/rhsm'
          }

          it do
            should contain_class('certs::katello').with(
              :hostname => 'katello.example.com',
              :deployment_url => '/abc/rhsm'
            )
          end
        end
      end
    end
  end
end
