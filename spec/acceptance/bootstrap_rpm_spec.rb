require 'spec_helper_acceptance'

describe 'bootstrap_rpm' do

  context 'with default params' do
    let(:pp) do
      <<-EOS
      include foreman_proxy_content::bootstrap_rpm

      package { "katello-ca-consumer-#{host_inventory['fqdn']}":
        ensure => installed,
        source => "/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-1.noarch.rpm",
        require => Class['foreman_proxy_content::bootstrap_rpm'],
      }
      EOS
    end

    it_behaves_like 'a idempotent resource'

    describe file('/var/www/html/pub/katello-rhsm-consumer') do
      it { should be_file }
      it { should be_mode 755 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end

    describe file('/var/www/html/pub/katello-ca-consumer-latest.noarch.rpm') do
      it { should be_symlink }
    end

    describe file('/var/www/html/pub/katello-server-ca.crt') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end

    describe command('rpm -qp /var/www/html/pub/katello-ca-consumer-latest.noarch.rpm --requires') do
      its(:stdout) { should match(/^subscription-manager/) }
    end

    describe command('rpm -qp /var/www/html/pub/katello-ca-consumer-latest.noarch.rpm --list') do
      its(:stdout) { should match(/^\/usr\/bin\/katello-rhsm-consumer/) }
    end

    describe x509_certificate('/etc/rhsm/ca/katello-server-ca.pem') do
      it { should be_certificate }
    end

    describe x509_certificate('/etc/rhsm/ca/katello-default-ca.pem') do
      it { should be_certificate }
    end

    describe file('/etc/rhsm/rhsm.conf') do
      its(:content) { should match /repo_ca_cert = %\(ca_cert_dir\)skatello-server-ca.pem/ }
      its(:content) { should match /prefix = \/rhsm/ }
      its(:content) { should match /full_refresh_on_yum = 1/ }
      its(:content) { should match /package_profile_on_trans = 1/ }
      its(:content) { should match /hostname = #{host_inventory['fqdn']}/ }
      its(:content) { should match /baseurl = https:\/\/#{host_inventory['fqdn']}\/pulp\/repos/ }
    end
  end
end
