# Set the global Exec path to something reasonable
Exec {
  path => [
    '/usr/local/bin',
    '/usr/local/sbin',
    '/usr/bin',
    '/usr/sbin',
    '/bin',
    '/sbin'
  ]
}

if $facts.get('role') {

  include "role::${facts['role']}"

}

# Hiera class lookups and inclusions (replaces `hiera_include()`)
$hiera_classes          = lookup('classes',          Array[String], 'unique', [])
$hiera_class_exclusions = lookup('class_exclusions', Array[String], 'unique', [])
$hiera_included_classes = $hiera_classes - $hiera_class_exclusions

include $hiera_included_classes
