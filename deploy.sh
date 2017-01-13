#!/bin/sh

# Script para instalação do Salt-Minion em servidores RHEL/CentOS

# Define funcao para instalação do salt-minion
function InstallMinion(){
        sudo yum clean expire-cache
        sudo yum install -y salt-minion
        sudo rm -f /etc/salt/minion
        curl http://jon.hdi.com.br/repo/salt/minion > /etc/salt/minion
}

echo -e "Determinando versao...\n"; sleep 2
if grep -q -i "release 6" /etc/redhat-release; then
        echo -e "Instalando salt para RHEL/CentOS 6.x\n"
                sleep 1
        sudo yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el6.noarch.rpm
        InstallMinion
        sudo chkconfig salt-minion on
        sudo service salt-minion restart
else
        echo -e "Instalando salt para RHEL/CentOS 7.x\n"
                sleep 1
        sudo yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm
        InstallMinion
        sudo systemctl enable salt-minion.service
        sudo systemctl restart salt-minion.service
fi
