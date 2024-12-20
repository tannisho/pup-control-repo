#
class profile::ua (
  $ua_token = lookup('ua::ua_token', { 'default_value' => undef }),
  $account_name = lookup('ua::account_name', { 'default_value' => undef }),
  $hn = $facts['networking']['hostname'],
) {

  package { 'ubuntu-advantage-tools':
    ensure => present,
  }

  package { 'landscape-client':
    ensure => present,
  }

  package { 'jq':
    ensure => present,
  }

  exec { 'attach_ua_token':
    path     => ['/usr/bin','/usr/sbin'],
    provider => shell,
    command  => "ua attach ${ua_token}",
    onlyif   => 'ua status --format json| jq |grep attached|grep false',
  }

# need to figure out how to auto enable
#  exec { 'enable_fips_updates':
#    path     => ['/usr/bin','/usr/sbin'],
#    provider => shell,
#    command  => 'pro enable fips-updates',
#    onlyif   => 'pro status --format json|jq|grep -A1 fips-updates|grep disabled',
#  }

#  exec { 'register_landscape':
#    path     => ['/usr/bin','/usr/sbin'],
#    provider => shell,
#    command  => "landscape-config --computer-title \"${hn}\" --account-name ${account_name}",
#    onlyif   => 'landscape-config --is-registered|grep False',
#  }

#  Package['ubuntu-advantage-tools'] -> Exec['attach_ua_token'] -> Package['landscape-client'] -> Exec['register_landscape']

  Package['ubuntu-advantage-tools'] -> Package['jq'] -> Exec['attach_ua_token']

}
