require 'spec_helper_acceptance'

describe 'pulpcore mirror' do
  context 'with default params' do
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
      it { is_expected.to contain('DocumentRoot "/var/lib/pulp/pulpcore_static"') }
    end

    describe port('443') do
      it { is_expected.to be_listening }
    end

    describe port('8443') do
      it { is_expected.not_to be_listening }
    end
  end

  context 'with reverse_proxy true' do
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
          reverse_proxy   => true,
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
      it { is_expected.to contain('DocumentRoot "/var/lib/pulp/pulpcore_static"') }
    end

    describe port('443') do
      it { is_expected.to be_listening }
    end

    describe port('8443') do
      it { is_expected.to be_listening }
    end
  end

  describe package('rubygem-smart_proxy_container_gateway') do
    it { is_expected.to be_installed }
  end

  context 'with docker disabled' do
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
          enable_docker   => false,
          # No Ansible repo is set up in our CI
          enable_ansible  => false,
        }
        PUPPET
      end
    end

    describe package('rubygem-smart_proxy_container_gateway') do
      it { is_expected.not_to be_installed }
    end
  end
end
