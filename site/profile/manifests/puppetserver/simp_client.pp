#
class profile::puppetserver::simp_client(
  $simpserver = lookup('simp::client::simpserver', {'default_value' => undef}),
  $simpserverlocal = lookup('simp::client::simpserver::local', {'default_value' => undef}),
  $simpserverprivip = lookup('simp::client::simpserver::privip', {'default_value' => undef}),
  Stdlib::Absolutepath $ks_root = '/var/www/html/ks',
  Stdlib::Absolutepath $client_path = "${ks_root}/simp-client.sh",
  Stdlib::Absolutepath $client_priv_path = "${ks_root}/simp-client-priv.sh",
){

  package { 'apache2':
    ensure => installed,
  }

  -> file{ $ks_root:
    mode   => '0755',
    ensure => directory,
    owner  => root,
    group  => root,
  }

  -> file{ $client_path:
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('profile/puppetserver/simp-client.sh.epp'),
  }

  -> file{ $client_priv_path:
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('profile/puppetserver/simp-client-priv.sh.epp'),
  }

}
