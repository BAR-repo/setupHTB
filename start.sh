#!/usr/bin/env bash

#Ouvre deux autre terminaux
#mate-terminal & mate-terminal &

#Ajout d'alias dans le .bash_aliases
echo "alias c='clear'" >> ~/.bash_aliases

#Création des dossiers Privesc
mkdir -p ~/privesc_linux ~/privesc_windows

#Téléchargement de ressources utiles
wget -P ~/privesc_linux https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh
wget -P ~/privesc_windows https://github.com/peass-ng/PEASS-ng/blob/master/winPEAS/winPEASbat/winPEAS.bat
wget -P ~/privesc_windows https://github.com/peass-ng/PEASS-ng/blob/master/winPEAS/winPEASps1/winPEAS.ps1
wget -P ~/privesc_windows https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASany_ofs.exe
wget -P ~/privesc_windows https://github.com/AlessandroZ/LaZagne/releases/download/v2.4.7/LaZagne.exe
git clone https://github.com/SpecterOps/BloodHound-Legacy.git ~/privesc_windows
git clone https://github.com/shibaaa204/Pack2TheRoot ~/privesc_linux
git clone https://github.com/danielmiessler/SecLists.git

# ajout d'alias pour lancer serveur web
# 
# scan nmap full
#sudo nmap -sSV -Pn -vvv -p- --open --reason -oA ${IP}_FULL_ports_SYN ${IP} >/dev/null 
