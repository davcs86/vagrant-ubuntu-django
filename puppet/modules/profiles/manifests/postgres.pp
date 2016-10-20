class profiles::postgres {
  # include docker
  #
  # ::docker::image { 'kiasaki/alpine-postgres': }
  #
  # ::docker::run { 'postgres':
  #   image   => 'kiasaki/alpine-postgres',
  #   ports   => ["5432:5432"],
  #   volumes => ['/vagrant/var/data/postgres:/var/lib/postgresql/data'],
  #   restart_service => true,
  #   env => ["POSTGRES_PASSWORD=0nepr0\$2015", "POSTGRES_USER=onepro", "POSTGRES_DB=onesim"],
  #   extra_parameters => [ '--restart=always' ],
  # }

  file { '/vagrant/var/data/postgres':
    ensure => directory,
  }

  # preferred symlink syntax
  file { '/pg_data':
    ensure => 'link',
    target => '/vagrant/var/data/postgres',
  }

  file { "/etc/environment":
    content => inline_template("PGDATA=/pg_data")
  }

  $connection_settings_super2 = {
    'PGUSER'     => "onepro",
    'PGPASSWORD' => "0nepr0_2015",
    'PGDATABASE'     => "onesim",
    'PGPORT'     => 5432,
    'PGDATABASE' => "onesim"
  }

  class { 'postgresql::globals':
    encoding            => 'UTF-8',
    locale              => 'en_US.UTF-8',
    manage_package_repo => true,
    version             => '9.2',
  }->
  class{ 'postgresql::server':
    ip_mask_allow_all_users    => '0.0.0.0/0',
    listen_addresses           => '*',
    postgres_password          => $connection_settings_super2['PGPASSWORD'],
    ipv4acls                   => ['local all all md5']
  }

  # Connect with no special settings, i.e domain sockets, user postgres
  # postgresql::server::role{'super2':
  #   username => $connection_settings_super2['PGUSER'],
  #   password_hash => postgresql_password($connection_settings_super2['PGUSER'], $connection_settings_super2['PGPASSWORD']),
  #   superuser     => true,
  #   # connect_settings => {},
  #   require          => [
  #     Class['postgresql::server'],
  #     Class['postgresql::server::service'],
  #   ],
  # }

  # Now using this new user connect via TCP
  postgresql::server::db { 'onesim':
    user => $connection_settings_super2['PGUSER'],
    password => $connection_settings_super2['PGPASSWORD'],
    require          => [
      Class['postgresql::server'],
      Class['postgresql::server::service'],
    ],
  }->
  postgresql::validate_db_connection { 'Validate my postgres connection':
    database_host           => 'localhost',
    database_username       => $connection_settings_super2['PGUSER'],
    database_password       => $connection_settings_super2['PGPASSWORD'],
    database_name           => $connection_settings_super2['PGDATABASE'],
  }

  ufw::allow { 'allow-postgres-from-all':
    port => $connection_settings_super2['PGPORT'],
    ip   => 'any',
  }

  ::consul::service { 'postgres':
    port => $connection_settings_super2['PGPORT'],
  }
}
