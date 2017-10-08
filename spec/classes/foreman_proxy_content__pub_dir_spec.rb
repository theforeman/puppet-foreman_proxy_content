require 'spec_helper'

describe 'foreman_proxy_content::pub_dir' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      it { should compile.with_all_deps }
      it { should contain_package('katello-client-bootstrap') }
    end
  end
end
