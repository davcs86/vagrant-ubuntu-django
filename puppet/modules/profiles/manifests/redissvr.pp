class profiles::redissvr {

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
    redis_append_enable  => true,
    redis_appendfsync => 'no',
    redis_dir     => '/vagrant/var/data/redis'
  }

  ufw::allow { 'allow-redis-from-all':
    port => 6379,
    ip   => 'any',
  }

  #include docker

  #::docker::run { 'redis':
  #  image   => 'redis:alpine',
  #  ports   => ["6379:6379"],
  #  volumes => ['/vagrant/var/data/redis:/data'],
  #  restart_service => true,
  #  extra_parameters => [ '--restart=always' ],
  #}

  # file { '/vagrant/var/data/redis':
  #   ensure => directory,
  # }

  ::consul::service { 'redis':
    port => 6379,
  }
}

