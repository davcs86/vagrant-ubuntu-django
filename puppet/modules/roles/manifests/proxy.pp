class roles::proxy {
  include profiles::base
  include profiles::consul
  include profiles::webserver
}
