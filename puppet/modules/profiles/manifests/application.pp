class profiles::application {

  # exec { "install python3":
  #   command => "/usr/bin/apt-get install libpq-dev python3-dev python3-pip -y"
  # }->
  # exec { "install virtualenv":
  #   command => "/usr/bin/pip3  install pip3 install virtualenv"
  # }

  exec { "install gunicorn":
      # path => ["/usr/bin", "/usr/sbin", "/bin/bash"],
      command => "/bin/bash -c '/vagrant/scripts/gunicorn.sh'",
      # refreshonly => true
  }
  # class { 'python' :
  #   ensure     => 'present',
  #   pip        => 'present',
  #   dev        => 'absent',
  #   virtualenv => 'absent',
  #   manage_gunicorn => false,
  #   gunicorn   => 'present'
  # }
  #
  # python::requirements { '/vagrant/var/sources/requirements.txt' :
  #   #virtualenv => '/var/www/project1',
  #   #proxy      => 'http://proxy.domain.com:3128',
  #   #owner      => 'vagrant',
  #   #group      => 'vagrant',
  # }


  # python::virtualenv { '/virtualenvs/onesim' :
  #   venv_dir     => '/virtualenvs',
  #   owner        => 'vagrant',
  #   group        => 'vagrant',
  #   cwd => '/usr/bin',
  #   requirements => '/vagrant/var/sources/requirements.txt'
  # }

  # python::gunicorn { 'onesim' :
  #   ensure      => present,
  #   # virtualenv  => '/virtualenvs/onesim',
  #   mode        => 'wsgi',
  #   # dir         => '/vagrant/var/sources',
  #   dir         => '/vagrant/var/www',
  #   bind        => '0.0.0.0:8000',
  #   # environment => 'prod',
  #   # appmodule   => '_project_.wsgi:application',
  #   appmodule   => 'server:app',
  #   #owner      => 'vagrant',
  #   #group      => 'vagrant',
  #   # osenv       => { 'DBHOST' => 'dbserver.example.com' },
  #   # timeout     => 30,
  #   # template    => 'python/gunicorn.erb',
  # }

  # docker::image { 'davcs86/django-app':
  #   ensure => 'present',
  #   image_tag => 'v1',
  #   docker_file => '/vagrant/var/sources/Dockerfile',
  #   # subscribe => File['/vagrant/var/sources/Dockerfile']
  # }

  # ::docker::image { 'tswicegood/gunicorn': }

  # ::docker::run { 'django-app':
  #   # image   => 'tswicegood/gunicorn',
  #   image   => 'davcs86/django-app:v1',
  #   ports   => ["8000:8000"],
  #   env_file => [],
  #   volumes => ['/vagrant/var/data/django/media:/media', '/vagrant/var/data/django/cache:/cache', '/vagrant/var/data/django/static:/static', '/vagrant/var/sources:/app'],
  #   #restart_service => true,
  #   #extra_parameters => [ '--restart=always' ],
  # }

  ::consul::service { 'django-app':
    port => 8000,
  }

}