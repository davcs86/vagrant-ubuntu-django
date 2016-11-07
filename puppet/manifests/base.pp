Exec {
  path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# this is a hack to work around
# https://github.com/saz/puppet-dnsmasq/issues/10
define common::line { }

node 'master' {
  include roles::master
}

node 'database' {
   include roles::database
}

node 'proxy' {
  include roles::proxy
}

# others are instances of the webapp
node default {
  include roles::app
}

node 'devmode' {
  include roles::devmode
}