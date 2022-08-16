#!/usr/bin/env bash
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
acesso=$(cat wp-config.php | grep "DB_NAME" | awk -F " " {'print$3'} | tr -d "'")
raiz=$(cwd $dominio && pwd)
server_domain=$(cat /etc/userdomains | grep "$dominio" | awk -F":" {'print $1'})
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
if [ $# -ne 1 ];
    then
        echo "sintase incorreta. 
        Digite a seguinte sintase acessowp.sh <dominio>" 
        exit 1
        
fi

if [ "$dominio" = "$server_domain" ]
then
    echo "domínio existe no servidor"
    cwd $dominio
    pwtemp setwp $acesso
else
    echo "domínio não existe no servidor"
    exit 1
fi

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
cwd $dominio
pwtemp setwp $acesso
# ------------------------------------------------------------------------ #
