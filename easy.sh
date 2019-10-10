#!/bin/bash

echo "BAJANDO FIREWALL"
systemctl stop firewalld
systemctl disable firewalld
systemctl status firewalld
sleep 3
echo "EDITANDO RC.LOCAL"
sleep 3
echo if test -f /sys/kernel/mm/transparent_hugepage/enabled >> /etc/rc.local
echo then >> /etc/rc.local
echo 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' >> /etc/rc.local
echo fi >> /etc/rc.local     
echo 'if test -f /sys/kernel/mm/transparent_hugepage/defrag' >> /etc/rc.local
echo then >> /etc/rc.local
echo 'echo never > /sys/kernel/mm/transparent_hugepage/defrag' >> /etc/rc.local
echo fi >> /etc/rc.local
echo "RC.LOCAL EDITADO"
cat /etc/rc.local
sleep 5
echo -------------------------------------------------------------------------
echo "EDITANDO LIMITS.CONF"
sleep 3
echo End of file >> /etc/security/limits.conf
echo '* soft nofile 64000' >> /etc/security/limits.conf
echo '* hard nofile 64000' >> /etc/security/limits.conf
echo  "LIMITS.CONF EDITADO"
cat /etc/security/limits.conf
sleep 5
echo -------------------------------------------------------------------------
echo "HABILITANDO RC.LOCAL"
chmod +x /etc/rc.d/rc.local
systemctl enable rc-local
systemctl start rc-local
systemctl status rc-local
sleep 3
echo "RC.LOCAL HABILITADO"
echo ------------------------------------------------------------------------
echo
echo "DESCOMPRIMIENDO SPLUNK"
cd /opt
pwd
sleep 4
tar -xvzf splunk-7.2.6-c0bf0f679ce9-Linux-x86_64.tgz
sleep 3
echo "ARCHIVO DESCOMPRIMIDO"
sleep 3
echo -----------------------------------------------------------------------
echo "ASIGNANDO PERMISOS"
chown -R splunk:splunk splunk
ll
echo -----------------------------------------------------------------------
echo "INICIANDO INSTALACION"
sleep 3
splunk/bin/splunk enable boot-start -user splunk
sleep 3
echo ----------------------------------------------------------------------------
echo "INICIANDO SERVICIOS"
cd splunk/bin
./splunk start
sleep 5
echo "VERIFICANDO SERVICIOS"
ps -fea | grep splunk
sleep 3
exit

