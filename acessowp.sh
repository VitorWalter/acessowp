#!/bin/bash
#
# acessowp.sh  
#
# Autor:Vitor Walter
#
# ------------------------------------------------------------------------ #
#  Este programa irá gerar o acesso ao administrador do Wordpress
#  
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
dominio=$1
raiz=$(cwd $dominio && pwd)
acesso=$(cat $raiz/wp-config.php | grep "DB_NAME" | awk -F " " {'print$3'} | tr -d "'")
server_domain=$(cat /etc/userdomains | grep "$dominio" | awk -F":" {'print $1'})
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
if [ $# -ne 1 ];
    then
        echo "sintase incorreta. 
        Digite a seguinte sintase acessowp.sh <dominio>" 
        exit 1
        
fi
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
if [ "$dominio" = "$server_domain" ]
then
    echo "domínio existe no servidor"
    $raiz
    pwtemp setwp $acesso
else
    echo "domínio não existe no servidor"
    exit 1
fi
# ------------------------------------------------------------------------ #
