Puppet::Type.type(:rhsm_reconfigure_script).provide(:rhsm_reconfigure_script) do

  def create
    template = render_template
    File.open(resource[:path], 'w', 0o755) do |file|
      file.write(template)
    end
  end

  def exists?
    File.exist?(resource[:path]) && (File.read(resource[:path]) == render_template)
  end

  private

  def render_template
    ::ERB.new(script_template).result(binding)
  end

  def server_ca_cert
    # Reads the server CA certificate from
    # disk on the client
    File.read(resource[:server_ca_cert])
  end

  def default_ca_cert
    # Reads the default CA certificate from
    # disk on the client
    File.read(resource[:default_ca_cert])
  end

  def script_template
    <<~'HEREDOC'
      #!/bin/bash

      set -e

      KATELLO_SERVER=<%= resource[:rhsm_hostname] %>
      PORT=<%= resource[:rhsm_port] %>

      KATELLO_SERVER_CA_CERT=<%= resource[:server_ca_name] %>.pem
      KATELLO_DEFAULT_CA_CERT=<%= resource[:default_ca_name] %>.pem

      CERT_DIR=/etc/rhsm/ca
      PREFIX=<%= resource[:rhsm_path] %>
      CFG=/etc/rhsm/rhsm.conf
      CFG_BACKUP=$CFG.kat-backup
      CA_TRUST_ANCHORS=/etc/pki/ca-trust/source/anchors

      read -r -d '' KATELLO_DEFAULT_CA_DATA << EOM || true
      <%= default_ca_cert %>
      EOM

      read -r -d '' KATELLO_SERVER_CA_DATA << EOM || true
      <%= server_ca_cert %>
      EOM

      is_debian()
      {
        if [ -r "/etc/os-release" ]
        then
          ID="$(sed -n -e "s/^ID\s*=\s*\(.*\)/\1/p" /etc/os-release)"
          ID_LIKE="$(sed -n -e "s/^ID_LIKE\s*=\s*\(.*\)/\1/p" /etc/os-release)"

          if [ "$ID" = "debian" ] ||       # Debian
             [ "$ID_LIKE" = "debian" ] ||  # e.g Ubuntu
             [ "$ID_LIKE" = "ubuntu" ]     # e.g. Linux Mint
          then
            return 0
          fi
        fi
        return 1
      }

      # exit on non-RHEL systems or when rhsm.conf is not found
      test -f $CFG || exit
      type -P subscription-manager >/dev/null || type -P subscription-manager-cli >/dev/null || exit

      # backup configuration during the first run
      test -f $CFG_BACKUP || cp $CFG $CFG_BACKUP

      # create the cert
      echo "$KATELLO_SERVER_CA_DATA" > $CERT_DIR/$KATELLO_SERVER_CA_CERT
      chmod 644 $CERT_DIR/$KATELLO_SERVER_CA_CERT

      echo "$KATELLO_DEFAULT_CA_DATA" > $CERT_DIR/$KATELLO_DEFAULT_CA_CERT
      chmod 644 $CERT_DIR/$KATELLO_DEFAULT_CA_CERT

      if is_debian
      then
        # Debian setup
        BASEURL=https://$KATELLO_SERVER/pulp/deb

        subscription-manager config \
          --server.hostname="$KATELLO_SERVER" \
          --server.prefix="$PREFIX" \
          --server.port="$PORT" \
          --rhsm.repo_ca_cert="%(ca_cert_dir)s$KATELLO_SERVER_CA_CERT" \
          --rhsm.baseurl="$BASEURL"
      else
        # rhel setup
        BASEURL=https://$KATELLO_SERVER/pulp/content/

        subscription-manager config \
          --server.hostname="$KATELLO_SERVER" \
          --server.prefix="$PREFIX" \
          --server.port="$PORT" \
          --rhsm.repo_ca_cert="%(ca_cert_dir)s$KATELLO_SERVER_CA_CERT" \
          --rhsm.baseurl="$BASEURL"

        # Older versions of subscription manager may not recognize
        # report_package_profile and package_profile_on_trans options.
        # So set them separately and redirect out & error to /dev/null
        # to fail silently.
        subscription-manager config --rhsm.package_profile_on_trans=1 > /dev/null 2>&1 || true
        subscription-manager config --rhsm.report_package_profile=1 > /dev/null 2>&1 || true

        if grep --quiet full_refresh_on_yum $CFG; then
          sed -i "s/full_refresh_on_yum\s*=.*$/full_refresh_on_yum = 1/g" $CFG
        else
          full_refresh_config="#config for on-premise management\nfull_refresh_on_yum = 1"
          sed -i "/baseurl/a $full_refresh_config" $CFG
        fi
      fi

      # also add the katello ca cert to the system wide ca cert store
      if [ -d $CA_TRUST_ANCHORS ]; then
        cp $CERT_DIR/$KATELLO_SERVER_CA_CERT $CA_TRUST_ANCHORS
        update-ca-trust extract
      fi

      # restart yggdrasild if it is installed and running
      systemctl try-restart yggdrasil >/dev/null 2>&1 || true

      exit 0
    HEREDOC
  end

end
