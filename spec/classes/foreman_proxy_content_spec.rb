require 'spec_helper'

describe 'foreman_proxy_content' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      let :pre_condition do
        "include foreman_proxy"
	  end


      it { should contain_package('katello-debug') }
      it { should contain_package('katello-client-bootstrap') }

      context 'with pulp' do
        let(:params) do
          {
            :pulp_oauth_secret => 'mysecret',
            :qpid_router       => false
          }
        end

        let(:pre_condition) do
          "include foreman_proxy
          class {'foreman_proxy::plugin::pulp': pulpnode_enabled => true}
          class {'apache': apache_version => '2.4'}"
        end

        it { should contain_class('pulp').with(:oauth_secret => 'mysecret') }
        it { should_not contain_class('foreman_proxy_content::dispatch_router') }

        it { should contain_pulp__apache__fragment('gpg_key_proxy').with({
          :ssl_content => %r{ProxyPass /katello/api/repositories/}} ) }
      end
    end
  end
end
