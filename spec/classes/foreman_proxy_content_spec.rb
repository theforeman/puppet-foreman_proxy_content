require 'spec_helper'

describe 'foreman_proxy_content' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'without parameters' do
        let(:pre_condition) do
          <<-PUPPET
          include foreman_proxy
          class { 'foreman_proxy::plugin::pulp':
            enabled          => false,
            pulpnode_enabled => false,
            pulpcore_enabled => false,
          }
          PUPPET
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('katello-debug') }
        it { is_expected.to contain_class('foreman_proxy_content::pub_dir') }
      end

      context 'with pulp', if: facts[:operatingsystemmajrelease] == '7' do
        let(:params) do
          {
            qpid_router: false
          }
        end

        let(:pre_condition) do
          <<-PUPPET
          include foreman_proxy
          class { 'foreman_proxy::plugin::pulp':
            enabled          => false,
            pulpnode_enabled => true,
            pulpcore_enabled => false,
          }
          PUPPET
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('pulp').with(manage_squid: true) }
        it { is_expected.not_to contain_class('foreman_proxy_content::dispatch_router') }
        it { is_expected.to contain_class('pulpcore') }
        it { is_expected.to contain_class('foreman_proxy_content::pub_dir') }

        it do
          is_expected.to contain_class('foreman_proxy_content::reverse_proxy')
            .with(path: '/')
            .with(port: 8443)
        end
      end

      context 'with pulpcore' do
        let(:params) do
          {
            qpid_router: false
          }
        end

        let(:pre_condition) do
          <<-PUPPET
          include foreman_proxy
          class { 'foreman_proxy::plugin::pulp':
            enabled          => false,
            pulpnode_enabled => false,
            pulpcore_enabled => true,
            pulpcore_mirror  => false,
          }
          PUPPET
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('foreman_proxy_content::pub_dir') }
        it do
          is_expected.to contain_class('pulpcore')
            .with(apache_http_vhost: 'foreman')
            .with(apache_https_vhost: 'foreman-ssl')
            .that_comes_before('Class[foreman_proxy::plugin::pulp]')
        end

        context 'as mirror' do
          let(:pre_condition) do
            <<-PUPPET
            include foreman_proxy
            class { 'foreman_proxy::plugin::pulp':
              enabled          => false,
              pulpnode_enabled => false,
              pulpcore_enabled => true,
              pulpcore_mirror  => true,
            }
            PUPPET
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('foreman_proxy_content::pub_dir') }
          it do
            is_expected.to contain_class('pulpcore')
              .with(apache_http_vhost: true)
              .with(apache_https_vhost: true)
              .that_comes_before('Class[foreman_proxy::plugin::pulp]')
          end
          it do
            is_expected.to contain_class('foreman_proxy_content::reverse_proxy')
              .with(path: '/')
              .with(port: 8443)
          end
          it do
            is_expected.to contain_pulpcore__apache__fragment('gpg_key_proxy')
              .with_https_content(%r{ProxyPass /katello/api/v2/repositories/ https://foo\.example\.com/katello/api/v2/repositories/})
          end
        end

        context 'with external postgres' do
          let(:params) do
            super().merge(
              pulpcore_manage_postgresql: false,
              pulpcore_postgresql_host: 'postgres-pulpcore.example.com',
              pulpcore_postgresql_port: 2345,
              pulpcore_postgresql_user: 'pulpuser',
              pulpcore_postgresql_password: 'sUpersEkret',
              pulpcore_postgresql_db_name: 'pulpcore1'
            )
          end

          it { is_expected.to compile.with_all_deps }

          it do
            is_expected.to contain_class('pulpcore')
              .with_postgresql_manage_db(false)
              .with_postgresql_db_host('postgres-pulpcore.example.com')
              .with_postgresql_db_port(2345)
              .with_postgresql_db_user('pulpuser')
              .with_postgresql_db_password('sUpersEkret')
              .with_postgresql_db_name('pulpcore1')
              .with_postgresql_db_ssl(false)
          end

          context 'and SSL' do
            let(:params) do
              super().merge(
                pulpcore_postgresql_ssl: true,
                pulpcore_postgresql_ssl_require: true,
                pulpcore_postgresql_ssl_cert: '/my/pulpcore-postgres.crt',
                pulpcore_postgresql_ssl_key: '/my/pulpcore-postgres.key',
                pulpcore_postgresql_ssl_root_ca: '/my/root/ca.crt',
              )
            end

            it { is_expected.to compile.with_all_deps }

            it do
              is_expected.to contain_class('pulpcore')
                .with_postgresql_manage_db(false)
                .with_postgresql_db_ssl(true)
                .with_postgresql_db_ssl_require(true)
                .with_postgresql_db_ssl_cert('/my/pulpcore-postgres.crt')
                .with_postgresql_db_ssl_key('/my/pulpcore-postgres.key')
                .with_postgresql_db_ssl_root_ca('/my/root/ca.crt')
            end
          end
        end
      end

      context 'with puppet' do
        let(:params) do
          {
            puppet: true,
          }
        end

        describe 'with puppet server enabled' do
          let(:pre_condition) do
            <<-PUPPET
            class { 'puppet':
              server         => true,
              server_foreman => true,
            }
            include foreman_proxy
            class { 'foreman_proxy::plugin::pulp':
              enabled          => false,
              pulpnode_enabled => false,
              pulpcore_enabled => false,
              pulpcore_mirror  => false,
            }
            PUPPET
          end

          it { is_expected.to compile.with_all_deps }
          it do
            is_expected.to contain_class('certs::puppet')
              .that_comes_before('Class[foreman::puppetmaster]')
          end
        end

        describe 'with puppet server disabled' do
          let(:pre_condition) do
            <<-PUPPET
            include foreman_proxy
            class { 'foreman_proxy::plugin::pulp':
              enabled          => false,
              pulpnode_enabled => false,
              pulpcore_enabled => false,
              pulpcore_mirror  => false,
            }
            PUPPET
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.not_to contain_class('certs::puppet') }
        end
      end
    end
  end
end
