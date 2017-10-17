require 'spec_helper'

describe 'foreman_proxy_content::pulp::node' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'with explicit parameters' do
        let :params do
          {
            :foreman_url               => 'https://foo.example.com',
            :pulp_max_speed            => '',
            :pulp_admin_password       => 'secret',
            :qpid_router               => true,
            :qpid_router_hub_host      => 'hub.example.com',
            :qpid_router_hub_port      => 5647,
            :qpid_router_broker_addr   => 'localhost',
            :qpid_router_broker_port   => 5671,
            :enable_ostree             => true,
          }
        end

        # dispatch_router is included and reads its variables from the main
        # class so we work around that here.
        let :pre_condition do
          <<-EOS
          class { '::foreman_proxy_content::dispatch_router':
            listener_host => '0.0.0.0',
            listener_port => 5647,
            logging_path  => '/var/log/qdrouterd',
            logging_level => 'info+',
          }
          EOS
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('foreman_proxy_content::dispatch_router') }
        it { is_expected.to contain_class('foreman_proxy_content::pub_dir') }

        it do
          is_expected.to contain_pulp__apache__fragment('gpg_key_proxy').\
             with_ssl_content(%r{ProxyPass /katello/api/repositories/ https://foo\.example\.com/katello/api/repositories/})
        end
      end
    end
  end
end
