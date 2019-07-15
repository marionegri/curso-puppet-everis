$dns1 = '8.8.8.8'
$dns2 = '8.8.4.4'
$arquivo = '/etc/resolv.conf'
$conteudo = "nameserver ${dns1}\nnameserver ${dns2}"

file { $arquivo:
  ensure => 'present',
  content => $conteudo,
}