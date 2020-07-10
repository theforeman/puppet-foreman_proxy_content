require 'spec_helper'

describe 'foreman_proxy_content::bootstrap_rpm' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      describe 'with inherited parameters' do
        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
