# Obtendo o nome do S.O e a versao do kernel
# Esses dados estao nos fatos: kernel e kernelversion
notify { 'kernel': message => "O sistema operacional eh ${::kernel} versao ${::kernelversion}." }

# Obtendo o nome da distro GNU/Linux
# Esse dados estao nos fatos: operatingsystem e operatingsystemrelease
notify { 'distro': message => "A distribuicao GNU/Linux eh ${::operatingsystem}
   versão ${::operatingsystemrelease}." }

# Alguns sysadmins criam o '/home' em particao separada do '/'
# Vamos testar o fato: mountpoints['/home'],
# Se existir essa particao, vamos obter o espaco livre, contido
# no fato mountpoints['/home']['available_bytes']
if $::mountpoints['/home'] {
  $free_space = $::mountpoints['/home']['available_bytes']
}
# Se entrar no elsif, eh porque o '/home' esta na mesma particao do '/'
# Vamos testar o fato: mountpoints['/'],
# E vamos obter o espaco livre, contido
# no fato mountpoints['/']['available_bytes']
 elsif $::mountpoints['/'] {
  $free_space = $::mountpoints['/']['available_bytes']
}

# Alguns sysadmins criam o '/home' em particao separada do '/'
# Vamos testar o fato: mountpoints['/home'],
# Se existir essa particao, vamos obter o espaco livre, contido
# no fato mountpoints['/home']['available_bytes']
if $::mountpoints['/home'] {
  $free_space = $::mountpoints['/home']['available_bytes']
}
# Se entrar no elsif, eh porque o '/home' esta na mesma particao do '/'
# Vamos testar o fato: mountpoints['/'],
# E vamos obter o espaco livre, contido
# no fato mountpoints['/']['available_bytes']
 elsif $::mountpoints['/'] {
  $free_space = $::mountpoints['/']['available_bytes']
}

# O espaco requerido eh de 2GB ou 2000000 bytes
$space_required = 2000000

# Testando se ha o espaco requerido em '/home'
if $free_space > $space_required {
  notify { 'info_free_space': message => "[OK] Ha espaco livre suficiente em /home. Espaco requerido: \
     ${space_required} bytes, espaco livre: ${free_space} bytes", }
} else {
  notify { 'info_free_space': message => "[ERRO] Espaco insuficiente em /home. Espaco requerido: \
     ${space_required} bytes, espaco livre: ${free_space} bytes" }
}