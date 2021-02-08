require 'spec_helper_acceptance'

describe 'pulpcore mirror' do
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

      class { 'foreman_proxy_content':
        pulpcore_mirror => true,
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

  describe file('/etc/httpd/conf.d/10-pulpcore.conf') do
    it { is_expected.to be_file }
    it { is_expected.to contain(%r{DocumentRoot "/var/lib/pulp/pulpcore_static}) }
  end

  describe file('/etc/httpd/conf.d/10-rhsm-pulpcore-https-443.conf') do
    it { is_expected.to be_file }
    # TODO: this is a regression introduced in 76e2a6852d1d2ca33935ccf8a6ab69992c32ec1d
    it { is_expected.to contain(%{DocumentRoot "/var/www}) }
  end
end
