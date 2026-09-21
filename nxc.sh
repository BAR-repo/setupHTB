#!/bin/bash

# Vérification du nombre d'arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 variable1 variable2"
    exit 1
fi

user="$1"
password="$2"

protocoles=("smb" "ssh" "ldap" "ftp" "wmi" "winrm" "rdp" "mssql" "nfs")

#{protocoles=("smb" "ssh" "ldap" "ftp" "wmi" "winrm" "rdp" "vnc" "mssql" "nfs")

# Boucle sur les protocoles
for protocole in "${protocoles[@]}"; do
    nxc $protocole 10.10.110.0/24 "$user" "$password"
	nxc $protocole 172.16.1.0/24 "$user" "$password"
done
