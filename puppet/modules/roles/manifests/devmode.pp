class roles::devmode{
  include profiles::base
  include profiles::devmode_redissvr
  include profiles::devmode_postgres
  include profiles::devmode_application
  include profiles::devmode_webserver
}
#