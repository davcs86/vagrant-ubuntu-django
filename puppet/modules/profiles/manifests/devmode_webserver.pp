class profiles::devmode_webserver {
  include nginx
  # Workaround, issue https://github.com/voxpupuli/puppet-nginx/issues/942
  Class['nginx::package'] -> Nginx::Resource::Upstream <||>

  ufw::allow { 'allow-http-from-all':
    port => 80,
    ip   => 'any',
  }

  ::nginx::resource::upstream { 'app':
    members => [
      "http://localhost:8000"
    ],
  }
  ::nginx::resource::vhost { 'default':
    proxy => 'http://app',
  }

}
