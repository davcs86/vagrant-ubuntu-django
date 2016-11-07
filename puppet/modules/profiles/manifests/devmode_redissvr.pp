class profiles::devmode_redissvr {

  # install latest stable build.
  class { 'redis::install':
    redis_user            => "vagrant",
    redis_group           => "vagrant"
  }->
  file { '/etc/systemd/system/redis-server_instance1.service':
    ensure => '/vagrant/var/config/redis/redis-server_instance1.service',
  }

  redis::server { 'instance1':
    redis_ip        => '0.0.0.0',
    # redis_append_enable  => true,
    # redis_appendfsync => 'no',
    # redis_dir     => '/vagrant/var/data/redis'
  }

  ufw::allow { 'allow-redis-from-all':
    port => 6379,
    ip   => 'any',
  }

}

