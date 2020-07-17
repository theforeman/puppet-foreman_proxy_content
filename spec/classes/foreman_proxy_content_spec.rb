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
          }
          PUPPET
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('katello-debug') }
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
          }
          PUPPET
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('pulp').with(manage_squid: true) }
        it { is_expected.not_to contain_class('foreman_proxy_content::dispatch_router') }
        it { is_expected.not_to contain_class('pulpcore') }
        it { is_expected.to contain_class('foreman_proxy_content::pub_dir') }

        it do
          is_expected.to contain_pulp__apache__fragment('gpg_key_proxy')
            .with_ssl_content(%r{ProxyPass /katello/api/v2/repositories/ https://foo\.example\.com/katello/api/v2/repositories/})
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

        it do
          is_expected.to contain_class('pulpcore')
            .with(manage_apache: false)
            .that_comes_before('Class[foreman_proxy::plugin::pulp]')
        end

        it do
          is_expected.to contain_foreman__config__apache__fragment('pulpcore')
            .with_ssl_content(%r{ProxyPass /pulp/api/v3 http://127\.0\.0\.1:24817/pulp/api/v3})
            .with_ssl_content(%r{ProxyPass /pulp/content http://127\.0\.0\.1:24816/pulp/content})
            .with_ssl_content(%r{ProxyPass /pulpcore_registry/v2/ http://127\.0\.0\.1:24816/v2/})
            .with_content(%r{ProxyPass /pulp/content http://127\.0\.0\.1:24816/pulp/content})
          is_expected.to contain_foreman__config__apache__fragment('pulpcore-isos')
            .with_content(%r{ProxyPass /pulp/isos http://127\.0\.0\.1:24816/pulp/content})
        end
      end

      context 'pulpcore with custom media root' do
        let(:params) do
          {
            qpid_router: false,
            pulpcore_media_root: '/var/lib/pulp/docroot'
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

        it do
          is_expected.to contain_class('pulpcore')
            .with(manage_apache: false)
            .with(pulpcore_media_root: '/var/lib/pulp/docroot')
            .that_comes_before('Class[foreman_proxy::plugin::pulp]')
        end

        it do
          is_expected.to contain_foreman__config__apache__fragment('pulpcore')
            .with_ssl_content(%r{ProxyPass /pulp/api/v3 http://127\.0\.0\.1:24817/pulp/api/v3})
            .with_ssl_content(%r{ProxyPass /pulp/content http://127\.0\.0\.1:24816/pulp/content})
            .with_ssl_content(%r{ProxyPass /pulpcore_registry/v2/ http://127\.0\.0\.1:24816/v2/})
            .with_content(%r{ProxyPass /pulp/content http://127\.0\.0\.1:24816/pulp/content})
          is_expected.to contain_foreman__config__apache__fragment('pulpcore-isos')
            .with_content(%r{ProxyPass /pulp/isos http://127\.0\.0\.1:24816/pulp/content})
        end
      end

      context 'pulpcore with external postgres' do
        let(:params) do
          {
            qpid_router: false,
            pulpcore_manage_postgresql: false,
            pulpcore_postgresql_host: 'postgres-pulpcore.example.com',
            pulpcore_postgresql_port: 2345,
            pulpcore_postgresql_user: 'pulpuser',
            pulpcore_postgresql_password: 'sUpersEkret',
            pulpcore_postgresql_db_name: 'pulpcore1'
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
      end

      context 'pulpcore with external postgres and SSL' do
        let(:params) do
          {
            qpid_router: false,
            pulpcore_manage_postgresql: false,
            pulpcore_postgresql_ssl: true,
            pulpcore_postgresql_ssl_require: true,
            pulpcore_postgresql_ssl_cert: '/my/pulpcore-postgres.crt',
            pulpcore_postgresql_ssl_key: '/my/pulpcore-postgres.key',
            pulpcore_postgresql_ssl_root_ca: '/my/root/ca.crt',
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

      context 'pulp-2to3-migration', if: facts[:operatingsystemmajrelease] == '7' do
        let(:params) do
          {
            qpid_router: false
          }
        end

        let(:pre_condition) do
          <<-PUPPET
          include foreman_proxy
          class { 'foreman_proxy::plugin::pulp':
            enabled          => true,
            pulpnode_enabled => false,
            pulpcore_enabled => true,
            pulpcore_mirror  => false,
          }
          PUPPET
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('pulpcore').with(manage_apache: false) }

        it do
          is_expected.to contain_class('pulpcore::plugin::migration')
            .with_mongo_db_name('pulp_database')
            .with_mongo_db_seeds('localhost:27017')
            .with_mongo_db_ssl(false)
            .with_mongo_db_verify_ssl(true)
            .with_mongo_db_ca_path('/etc/pki/tls/certs/ca-bundle.crt')
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
              pulpcore_enabled => true,
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
              pulpcore_enabled => true,
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
