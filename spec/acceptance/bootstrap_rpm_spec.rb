require 'spec_helper_acceptance'

describe 'bootstrap_rpm', :order => :defined do

  before(:suite) do
    on hosts, 'rm -rf /var/www/html/pub/*rpm'
  end

  context 'with default params' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        include foreman_proxy_content::bootstrap_rpm

        package { "katello-ca-consumer-#{host_inventory['fqdn']}":
          ensure => installed,
          source => "/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-1.noarch.rpm",
          require => Class['foreman_proxy_content::bootstrap_rpm'],
        }
        PUPPET
      end
    end

    describe file('/var/www/html/pub/katello-rhsm-consumer') do
      it { should be_file }
      it { should be_mode 755 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end

    describe file("/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-1.noarch.rpm") do
      it { should be_file }
    end

    describe file("/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-2.noarch.rpm") do
      it { should_not exist }
    end

    describe file('/var/www/html/pub/katello-ca-consumer-latest.noarch.rpm') do
      it { should be_symlink }
      it { should be_linked_to "/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-1.noarch.rpm" }
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
      its(:content) { should match %r{baseurl = https://#{host_inventory['fqdn']}/pulp/content/} }
      its(:content) { should match /port = 443/ }
    end
  end

  context 'ensure symlink is present if deleted' do
    it 'removes symlink and re-applies the manifest' do
      apply_manifest("exec { '/bin/unlink /var/www/html/pub/katello-ca-consumer-latest.noarch.rpm': }", catch_failures: true)
      apply_manifest("class { 'foreman_proxy_content::bootstrap_rpm': }", catch_failures: true)
    end

    describe file("/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-1.noarch.rpm") do
      it { should be_file }
    end

    describe file("/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-2.noarch.rpm") do
      it { should_not exist }
    end

    describe file('/var/www/html/pub/katello-ca-consumer-latest.noarch.rpm') do
      it { should be_symlink }
      it { should be_linked_to "/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-1.noarch.rpm" }
    end
  end

  context 'creates new RPM after CA changes' do
    before(:all) do
      pp_setup = <<-PUPPET
        exec { "rm -rf /root/ssl-build":
          path => "/bin:/usr/bin",
        }
      PUPPET

      apply_manifest(pp_setup, catch_failures: true)
    end

    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        include foreman_proxy_content::bootstrap_rpm

        package { "katello-ca-consumer-#{host_inventory['fqdn']}":
          ensure => latest,
          source => "/var/www/html/pub/katello-ca-consumer-latest.noarch.rpm",
          require => Class['foreman_proxy_content::bootstrap_rpm'],
        }
        PUPPET
      end
    end

    describe file("/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-2.noarch.rpm") do
      it { should be_file }
    end

    describe file('/var/www/html/pub/katello-ca-consumer-latest.noarch.rpm') do
      it { should be_symlink }
      it { should be_linked_to "/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-2.noarch.rpm" }
    end

    describe file('/var/www/html/pub/katello-rhsm-consumer') do
      it { should be_file }
      it { should be_mode 755 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end

  context 'creates new RPM after port changes' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        class { 'foreman_proxy_content::bootstrap_rpm':
          rhsm_port => 8443,
        }

        package { "katello-ca-consumer-#{host_inventory['fqdn']}":
          ensure => latest,
          source => "/var/www/html/pub/katello-ca-consumer-latest.noarch.rpm",
          require => Class['foreman_proxy_content::bootstrap_rpm'],
        }
        PUPPET
      end
    end

    describe file("/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-3.noarch.rpm") do
      it { should be_file }
    end

    describe file('/var/www/html/pub/katello-ca-consumer-latest.noarch.rpm') do
      it { should be_symlink }
      it { should be_linked_to "/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-3.noarch.rpm" }
    end

    describe file('/var/www/html/pub/katello-rhsm-consumer') do
      it { should be_file }
      it { should be_mode 755 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its(:content) { should match(/8443/) }
    end

    describe file('/etc/rhsm/rhsm.conf') do
      its(:content) { should match /repo_ca_cert = %\(ca_cert_dir\)skatello-server-ca.pem/ }
      its(:content) { should match /prefix = \/rhsm/ }
      its(:content) { should match /full_refresh_on_yum = 1/ }
      its(:content) { should match /package_profile_on_trans = 1/ }
      its(:content) { should match /hostname = #{host_inventory['fqdn']}/ }
      its(:content) { should match %r{baseurl = https://#{host_inventory['fqdn']}/pulp/content/} }
      its(:content) { should match /port = 443/ }
    end
  end

  context 'correctly sets latest RPM after reaching RPM release of 10' do
    it 'applies 7 more times without error' do
      7.times do |num|
        apply_manifest(
          "class { 'foreman_proxy_content::bootstrap_rpm': rhsm_port => 844#{num}, }",
          catch_failures: true
        )
      end
    end

    describe file("/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-10.noarch.rpm") do
      it { should be_file }
    end

    describe file('/var/www/html/pub/katello-ca-consumer-latest.noarch.rpm') do
      it { should be_symlink }
      it { should be_linked_to "/var/www/html/pub/katello-ca-consumer-#{host_inventory['fqdn']}-1.0-10.noarch.rpm" }
    end
  end
end
