class profiles::devmode_application {

  file { [  '/run', '/run/gunicorn', '/var/log/gunicorn' ]:
    ensure => 'directory',
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0750',
  }

  file {
    'install_gunicorn':
      ensure => 'file',
      source => '/vagrant/scripts/gunicorn.sh',
      path => '/usr/local/bin/gunicorn_script.sh',
      # owner => 'root',
      # group => 'root',
      mode  => '0744', # Use 0700 if it is sensitive
      notify => Exec['install_gunicorn_script'],
  }
  exec {
    'install_gunicorn_script':
      command => '/usr/local/bin/gunicorn_script.sh'
  }

  file { '/etc/systemd/system/gunicorn.service':
    ensure => '/vagrant/var/config/gunicorn/gunicorn.service',
    notify => Service['gunicorn'],
  }

  service { 'gunicorn':
    ensure => 'running',
    provider => 'systemd'
  }

  ufw::allow { 'allow-gunicorn-from-all':
    port => 8000,
    ip   => 'any',
  }

}
