class profiles::postgresClient {

  exec { "install postgresql client":
    command => "/usr/bin/apt-get install libpq-dev postgresql-common postgresql-client -y"
  }

}
