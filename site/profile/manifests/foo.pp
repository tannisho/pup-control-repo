#
class profile::foo (
  $hn = $facts['networking']['hostname'],
  $shn = $facts['short_hostname'],
  $ip = $facts['networking']['ip'],
) {

  notify{"hostname value is: ${hn}": }
  notify{"short hostname value is: ${shn}": }
  notify{"ip address value is: ${ip}": }

}
