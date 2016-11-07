class profiles::devmode_postgres {

  $connection_settings_super2 = {
    'PGUSER'     => "onepro",
    'PGPASSWORD' => "0nepr0_2015",
    'PGDATABASE' => "onesim",
    'PGPORT'     => 5432
  }

  class { 'postgresql::globals':
    encoding            => 'UTF-8',
    locale              => 'en_US.UTF-8',
    manage_package_repo => true,
    version             => '9.2'
  }->
  class{ 'postgresql::server':
    ip_mask_allow_all_users    => '0.0.0.0/0',
    listen_addresses           => '*',
    postgres_password          => $connection_settings_super2['PGPASSWORD'],
    ipv4acls                   => ['local all all md5']
  }

  # Now using this new user connect via TCP
  postgresql::server::db { 'onesim':
    user => $connection_settings_super2['PGUSER'],
    password => $connection_settings_super2['PGPASSWORD'],
    require => [
      Class['postgresql::server'],
      Class['postgresql::server::service'],
    ],
  }->
  postgresql::validate_db_connection { 'Validate my postgres connection':
    database_host           => '127.0.0.1',
    database_username       => $connection_settings_super2['PGUSER'],
    database_password       => $connection_settings_super2['PGPASSWORD'],
    database_name           => $connection_settings_super2['PGDATABASE'],
  }

  ufw::allow { 'allow-postgres-from-all':
    port => $connection_settings_super2['PGPORT'],
    ip   => 'any',
  }

}
