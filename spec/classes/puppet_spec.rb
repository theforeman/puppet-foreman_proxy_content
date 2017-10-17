require 'spec_helper'

describe 'foreman_proxy_content::puppet' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('puppet') }
      it { is_expected.to contain_class('puppet::server') }
      it { is_expected.to contain_class('certs::puppet').that_notifies('Class[puppet]') }
    end
  end
end
