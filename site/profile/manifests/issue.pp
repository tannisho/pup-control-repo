# unceremoniously snagged bits from simp-issue module
class profile::issue (
  $source = lookup('issue::source', { 'default_value' => undef }),
  $hostname = $facts['hostname'],
) {
  file { '/etc/issue':
    ensure => file,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    source => $source,
  }

  file { '/etc/issue.net':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => $source,
    require => File['/etc/issue'],
  }

  exec { 'disable_motd_welcome':
    command => 'chmod -x /etc/update-motd.d/*',
    onlyif  => 'find /etc/update-motd.d -mindepth 1 ! -type l -exec ls -l {} \;|grep -w x',
  }
}
