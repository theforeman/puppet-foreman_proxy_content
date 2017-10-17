require 'spec_helper'

describe 'foreman_proxy_content::reverse_proxy' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'with explicit parameters' do
        let :url do
          'https://foo.example.com/'
        end

        let :params do
          {
            :url => url,
            :port => 443,
            :ssl_protocol => :nil,
          }
        end

        it { is_expected.to compile.with_all_deps }

        it do
          is_expected.to create_apache__vhost('katello-reverse-proxy'). \
            with_servername('foo.example.com'). \
            with_port(443). \
            with_docroot('/var/www/'). \
            with_priority(28). \
            with_ssl_options(['+StdEnvVars', '+ExportCertData', '+FakeBasicAuth']). \
            with_ssl(true). \
            with_ssl_proxyengine(true). \
            with_ssl_proxy_ca_cert('/etc/pki/katello/certs/katello-default-ca.crt'). \
            with_ssl_proxy_machine_cert('/etc/pki/katello/private/foo.example.com-foreman-proxy-client-bundle.pem'). \
            with_ssl_cert('/etc/pki/katello/certs/katello-apache.crt'). \
            with_ssl_key('/etc/pki/katello/private/katello-apache.key'). \
            with_ssl_ca('/etc/pki/katello/certs/katello-default-ca.crt'). \
            with_ssl_verify_client('optional'). \
            with_ssl_verify_depth(10). \
            with_ssl_protocl(nil). \
            with_request_headers(['set X_RHSM_SSL_CLIENT_CERT "%{SSL_CLIENT_CERT}s"']). \
            with_proxy_pass([{'path' => '/', 'url' => url, 'reverse_urls' => ['/', url]}])
        end
      end
    end
  end
end
