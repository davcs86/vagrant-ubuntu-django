class roles::database {
  include profiles::base
  include profiles::consul
  include profiles::redissvr
  include profiles::postgres
  # include profiles::mongo
}
#