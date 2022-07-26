require 'spec_helper'

describe 'foreman_proxy_content::reverse_proxy' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:title) { 'my-reverse-proxy' }

      context 'with inherited parameters' do

        let(:pre_condition) do
          <<-PUPPET
          include foreman_proxy_content
          PUPPET
        end

        it { is_expected.to compile.with_all_deps }
        it do
          is_expected.to contain_apache__vhost('my-reverse-proxy')
            .with_servername(facts[:fqdn])
            .with_serveraliases([])
            .with_port(8443)
            .with_proxy_pass([{
              'path' => '/',
              'url' => "https://#{facts[:fqdn]}/",
              'reverse_urls' => ["https://#{facts[:fqdn]}/"],
              'params' => {'disablereuse' => 'on', 'retry' => '0'},
            }])
        end
      end

      context 'with explicit parameters' do
        let(:params) { { path_url_map: {'/' => 'https://foreman.example.com/'}, port: 443 } }
        let(:title) { 'katello-reverse-proxy-443' }

        it { is_expected.to compile.with_all_deps }
        it do
          is_expected.to contain_apache__vhost('katello-reverse-proxy-443')
            .with_servername('foo.example.com')
            .with_serveraliases([])
            .with_port(443)
            .without_keepalive # Not part of the vhost but used in the vhost_params
            .with_proxy_pass([{
              'path' => '/',
              'url' => 'https://foreman.example.com/',
              'reverse_urls' => ['https://foreman.example.com/'],
              'params' => {'disablereuse' => 'on', 'retry' => '0'},
            }])
          is_expected.to contain_concat__fragment('katello-reverse-proxy-443-proxy')
            .with_content(%r{^\s+ProxyPass / https://foreman\.example\.com/ disablereuse=on retry=0$})
        end

        context 'with custom servername and cnames' do
          let(:pre_condition) do
            <<-PUPPET
            class { 'certs::apache':
              hostname => 'proxy.example.com',
              cname    => ['proxy-01.example.com'],
            }
            PUPPET
          end
          let(:title) { 'katello-reverse-proxy' }

          it { is_expected.to compile.with_all_deps }
          it do
            is_expected.to contain_apache__vhost('katello-reverse-proxy')
              .with_servername('proxy.example.com')
              .with_serveraliases(['proxy-01.example.com'])
          end
        end

        context 'with vhost_params' do
          let(:params) { super().merge(vhost_params: {keepalive: 'on'}) }
          let(:title) { 'katello-reverse-proxy' }

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_apache__vhost('katello-reverse-proxy').with_keepalive('on') }
        end

        context 'with proxy_pass_params' do
          let(:params) { super().merge(proxy_pass_params: {disablereuse: 'off'}) }
          let(:title) { 'katello-reverse-proxy' }

          it { is_expected.to compile.with_all_deps }
          it do
            is_expected.to contain_apache__vhost('katello-reverse-proxy')
              .with_proxy_pass([{
                'path' => '/',
                'url' => 'https://foreman.example.com/',
                'reverse_urls' => ['https://foreman.example.com/'],
                'params' => {'disablereuse' => 'off'},
              }])
            is_expected.to contain_concat__fragment('katello-reverse-proxy-proxy')
              .with_content(%r{^\s+ProxyPass / https://foreman\.example\.com/ disablereuse=off$})
          end
        end
      end
    end
  end
end
