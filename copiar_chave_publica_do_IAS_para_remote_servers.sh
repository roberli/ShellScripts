#!/bin/bash
# Verificando o UID do usuário que executou o script
if [ "$USER" != eqxadmin ]; then
    echo "Requer USER eqxadmin. Por favor altere o USER e tente novamente !!!"

    # Finaliza o script
    exit 1
fi

SSHPASS=/bin/sshpass
SSH_COPY_ID=/bin/ssh-copy-id
ID_RSA=/home/eqxadmin/.ssh/id_rsa.pub

echo "###############################"
echo "Acessando PATH do USER EQXADMIN"
echo "###############################"
        cd /home/eqxadmin/

echo "################################################################"
echo "Por favor insira a senha SSH do servidor remoto do USER eqxadmin"
echo "################################################################"
        read -r USERPASS

echo "########################################"
echo "Por favor insira o IP do servidor remoto"
echo "########################################"
        read -r REMOTEIP

echo "###############################################"
echo "Copiando a chave Pública para o servidor remoto"
echo "###############################################"
        sshpass -p "$USERPASS" $SSH_COPY_ID -o StrictHostKeyChecking=no -i $ID_RSA "$USER"@"$REMOTEIP"

echo "#############################################################################################################"
echo "Teste do ANSIBLE, se a mensagem aparecer em VERDE prosseguir com o próximo. Vermelho verificar o problema !!!"
echo "#############################################################################################################"
        ansible -m ping 'aprovisionamento'

exit 0