#
class role::generic {
  include profile::base
  include profile::luks
  include profile::ua
}
