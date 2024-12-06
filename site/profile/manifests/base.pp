#
class profile::base {
  include profile::timekeepers
  include profile::issue
  include profile::grub
  include accounts
  include auditd
  include ssh
  include sudo
  include timezone
}
