require 'spec_helper'

describe 'foreman_proxy_content::broker' do
  on_supported_os.each do |os, facts|
    context "on #{os}", if: facts[:operatingsystemmajrelease] == '7' do
      let :facts do
        facts
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
