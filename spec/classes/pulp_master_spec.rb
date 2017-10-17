require 'spec_helper'

describe 'foreman_proxy_content::pulp::master' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'with explicit parameters' do
        let :params do
          {
            :qpid_router => true,
            :hub_host    => '0.0.0.0',
            :hub_port    => 5646,
            :broker_host => 'localhost',
            :broker_port => 5671,
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
      end
    end
  end
end
