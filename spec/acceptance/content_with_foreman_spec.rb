require 'spec_helper_acceptance'

describe 'pulpcore non-mirror' do
  it_behaves_like 'an idempotent resource' do
    let(:manifest) do
      <<~PUPPET
      include certs::foreman_proxy

      class { 'foreman_proxy':
        register_in_foreman => false,
        ssl_ca              => $certs::foreman_proxy::proxy_ca_cert,
        ssl_cert            => $certs::foreman_proxy::proxy_cert,
        ssl_key             => $certs::foreman_proxy::proxy_key,
      }

      include certs::apache

      class { 'foreman::config::apache':
        ssl       => true,
        ssl_ca    => $certs::apache::apache_ca_cert,
        # ssl_chain is not passed here, in production it is
        ssl_cert  => $certs::apache::apache_cert,
        ssl_key   => $certs::apache::apache_key,
        require   => Class['certs::apache'],
      }

      class { 'foreman_proxy_content':
        pulpcore_mirror => false,
        # No Ansible repo is set up in our CI
        enable_ansible  => false,
      }
      PUPPET
    end
  end

  describe service('httpd') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  describe file('/etc/httpd/conf.d/05-foreman.conf') do
    it { is_expected.to be_file }
    it { is_expected.to contain(%{DocumentRoot "/usr/share/foreman/public"}) }
  end

  describe file('/etc/httpd/conf.d/05-foreman-ssl.conf') do
    it { is_expected.to be_file }
    it { is_expected.to contain(%{DocumentRoot "/usr/share/foreman/public"}) }
  end

  describe command("pulp status") do
    its(:exit_status) { is_expected.to eq 0 }
    its(:stdout) { is_expected.to match(/versions/) }
    its(:stderr) { is_expected.not_to match(/Error/) }
  end

  describe command("pulp user list") do
    its(:exit_status) { is_expected.to eq 0 }
    its(:stdout) { is_expected.to match(/admin/) }
    its(:stderr) { is_expected.not_to match(/Error/) }
  end
end
