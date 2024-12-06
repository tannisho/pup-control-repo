#
class profile::grub (
) {

  include grub2

  file_line { 'add_unrestricted_grub':
    path  => '/etc/grub.d/10_linux',
    line  => 'CLASS="--class gnu-linux --class gnu --class os --unrestricted"',
    match => 'CLASS="--class gnu-linux --class gnu --class os"',
  }

  File_line['add_unrestricted_grub'] -> Class['grub2']

}
