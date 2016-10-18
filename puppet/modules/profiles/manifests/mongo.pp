class profiles::mongo {

  # apt::source { 'mongo-org':
  #   location => '[arch=amd64] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2',
  #   repos    => 'multiverse',
  #   key      => {
  #     'id'     => 'EA312927',
  #     'server' => 'keyserver.ubuntu.com',
  #   },
  #   include  => {
  #     'src' => false,
  #     'deb' => true,
  #   },
  # }
  #
  # file { '/vagrant/var/data/mongo':
  #   ensure => directory,
  # }
  #
  # # preferred symlink syntax
  # file { '/mongo_data':
  #   ensure => 'link',
  #   target => '/vagrant/var/data/mongo',
  # }
  #
  # exec { "apt-get update":
  #   command => "/usr/bin/apt-get update"
  # }->
  # exec { "apt-get install mongo":
  #   command => "/usr/bin/apt-get install mongodb-org -y"
  # }->
  # file { '/etc/systemd/system/mongodb.service':
  #   ensure => '/vagrant/var/config/mongo/mongo.service',
  # }->
  # exec { "unmask mongo service":
  #   command => "systemctl unmask mongodb"
  # }

  include docker

  ::docker::image { 'mongo': }

  ::docker::run { 'mongo':
    image   => 'mongo',
    ports   => ["27017:27017"],
    volumes => ['/vagrant/var/data/mongo:/data/db/'],
    restart_service => true,
    env => ["MONGODB_PASS=0nepr0\$2015", "MONGODB_USER=onepro", "MONGODB_DATABASE=onesim"],
    extra_parameters => [ '--restart=always' ],
  }

  # class {'::mongodb::globals':
  #   manage_package_repo => false,
  # }->
  # class {'::mongodb::server':
  #   auth => true,
  #   bind_ip => ["0.0.0.0"],
  #   config => '/etc/mongod.conf',
  #   # dbpath => '/mongo_data'
  # }
  #
  # mongodb::db { 'onesim':
  #   user          => 'onepro',
  #   password_hash => mongodb_password('onepro', '0nepr0_2015')
  # }

  ::consul::service { 'mongo':
    port => 27017,
  }
}
