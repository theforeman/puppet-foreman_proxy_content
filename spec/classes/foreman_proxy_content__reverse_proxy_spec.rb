require 'spec_helper'

describe 'foreman_proxy_content::reverse_proxy' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      describe 'with inherited parameters' do

        let(:pre_condition) do
          <<-PUPPET
          include foreman_proxy_content
          PUPPET
        end

        it { is_expected.to compile.with_all_deps }
        it do
          is_expected.to contain_apache__vhost('katello-reverse-proxy')
            .with_servername(facts[:fqdn])
            .with_aliases([])
            .with_port(8443)
            .with_proxy_pass([{
              'path' => '/',
              'url' => "https://#{facts[:fqdn]}/",
              'reverse_urls' => ["https://#{facts[:fqdn]}/"],
              'params' => {'disablereuse' => 'on', 'retry' => '0'},
            }])
        end
      end

      describe 'with explicit parameters' do
        let(:params) { { url: 'https://foreman.example.com/', port: 443 } }

        it { is_expected.to compile.with_all_deps }
        it do
          is_expected.to contain_apache__vhost('katello-reverse-proxy')
            .with_servername('foo.example.com')
            .with_aliases([])
            .with_port(443)
            .without_keepalive # Not part of the vhost but used in the vhost_params
            .with_proxy_pass([{
              'path' => '/',
              'url' => 'https://foreman.example.com/',
              'reverse_urls' => ['https://foreman.example.com/'],
              'params' => {'disablereuse' => 'on', 'retry' => '0'},
            }])
          is_expected.to contain_concat__fragment('katello-reverse-proxy-proxy')
            .with_content(%r{^\s+ProxyPass / https://foreman\.example\.com/ disablereuse=on retry=0$})
        end

        describe 'with custom servername and cnames' do
          let(:pre_condition) do
            <<-PUPPET
            class { 'certs::apache':
              hostname => 'proxy.example.com',
              cname    => ['proxy-01.example.com'],
            }
            PUPPET
          end

          it { is_expected.to compile.with_all_deps }
          it do
            is_expected.to contain_apache__vhost('katello-reverse-proxy')
              .with_servername('proxy.example.com')
              .with_aliases(['proxy-01.example.com'])
          end
        end

        describe 'with vhost_params' do
          let(:params) { super().merge(vhost_params: {keepalive: 'on'}) }

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_apache__vhost('katello-reverse-proxy').with_keepalive('on') }
        end

        describe 'with proxy_pass_params' do
          let(:params) { super().merge(proxy_pass_params: {disablereuse: 'off'}) }

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
