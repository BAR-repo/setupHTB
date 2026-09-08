#!/usr/bin/env bash

#Ouvre deux autre terminaux
mate-terminal & mate-terminal &

#Ajout d'alias dans le .bash_aliases
echo "alias c='clear'" >> ~/.bash_aliases


#Téléchargement de ressources utiles
wget https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh
wget https://github.com/peass-ng/PEASS-ng/blob/master/winPEAS/winPEASbat/winPEAS.bat
wget https://github.com/peass-ng/PEASS-ng/blob/master/winPEAS/winPEASps1/winPEAS.ps1
wget https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASany_ofs.exe

# ajout d'alias pour lancer serveur web
# 
# scan nmap full
#sudo nmap -sSV -Pn -vvv -p- --open --reason -oA ${IP}_FULL_ports_SYN ${IP} >/dev/null 
