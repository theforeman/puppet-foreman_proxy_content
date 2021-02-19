require 'spec_helper_acceptance'

describe 'dispatch_router' do
  context 'with default parameters' do
    let(:pp) do
      <<-PUPPET
      include foreman_proxy_content::dispatch_router
      PUPPET
    end

    it_behaves_like 'a idempotent resource'

    describe service('qdrouterd') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    describe port('5647') do
      it { is_expected.to be_listening }
    end
  end

  context 'with ensure absent' do
    let(:pp) do
      <<-PUPPET
      class { 'foreman_proxy_content::dispatch_router':
        ensure => 'absent',
      }
      PUPPET
    end

    it_behaves_like 'a idempotent resource'

    describe service('qdrouterd') do
      it { is_expected.not_to be_running }
      it { is_expected.not_to be_enabled }
    end

    describe port('5647') do
      it { is_expected.not_to be_listening }
    end
  end
end
