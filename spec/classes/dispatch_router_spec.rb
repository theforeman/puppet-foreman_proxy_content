require 'spec_helper'

describe 'foreman_proxy_content::dispatch_router' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'with explicit parameters' do
        let :params do
          {
            :listener_host => '0.0.0.0',
            :listener_port => 5647,
            :logging_path  => '/var/log/qdrouterd',
            :logging_level => 'info+',
          }
        end

        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
