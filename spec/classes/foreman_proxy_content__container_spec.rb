require 'spec_helper'

describe 'foreman_proxy_content::container' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:pre_condition) do
        <<-PUPPET
        include foreman_proxy
        PUPPET
      end

      describe 'with inherited parameters' do

        it { is_expected.to compile.with_all_deps }
        it do
          is_expected.to contain_apache__vhost__fragment('pulp-https-container')
            .with_vhost('pulpcore-https')
            .with_priority('10')
            .with_content(%r{^\s+<Location "/pulpcore_registry/v2/">$})
            .with_content(%r{^\s+Require expr %\{tolower:%\{SSL_CLIENT_S_DN_CN\}\} == "foo.example.com"$})
            .with_content(%r{^\s+RequestHeader set SSL_CLIENT_S_DN "admin"$})
            .with_content(%r{^\s+</Location>$})
            .with_content(%r{^\s+ProxyPass /v1/ https://foo\.example\.com:8443/container_gateway/v1/$})
            .with_content(%r{^\s+ProxyPass /v2/ https://foo\.example\.com:8443/container_gateway/v2/$})
            .with_content(%r{^\s+ProxyPassReverse /v1/ https://foo\.example\.com:8443/container_gateway/v1/$})
            .with_content(%r{^\s+ProxyPassReverse /v2/ https://foo\.example\.com:8443/container_gateway/v2/$})
        end
      end

      describe 'with explicit parameters' do
        let(:params) do
          {
            location_prefix: '/other_pulpcore_registry',
            registry_v1_path: '/vr1/',
            registry_v2_path: '/vr2/',
            pulpcore_https_vhost: 'rhsm-pulpcore-reverse-proxy-443',
            cname: 'anoTHeR.example.COM',
          }
        end

        it { is_expected.to compile.with_all_deps }
        it do
          is_expected.to contain_apache__vhost__fragment('pulp-https-container')
            .with_vhost('rhsm-pulpcore-reverse-proxy-443')
            .with_priority('10')
            .with_content(%r{^\s+<Location "/other_pulpcore_registry/vr2/">$})
            .with_content(%r{^\s+Require expr %\{tolower:%\{SSL_CLIENT_S_DN_CN\}\} == "another.example.com"$})
            .with_content(%r{^\s+RequestHeader set SSL_CLIENT_S_DN "admin"$})
            .with_content(%r{^\s+</Location>$})
            .with_content(%r{^\s+ProxyPass /vr1/ https://foo\.example\.com:8443/container_gateway/vr1/$})
            .with_content(%r{^\s+ProxyPass /vr2/ https://foo\.example\.com:8443/container_gateway/vr2/$})
            .with_content(%r{^\s+ProxyPassReverse /vr1/ https://foo\.example\.com:8443/container_gateway/vr1/$})
            .with_content(%r{^\s+ProxyPassReverse /vr2/ https://foo\.example\.com:8443/container_gateway/vr2/$})
        end
      end
    end
  end
end
