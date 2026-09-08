#!/usr/bin/env bash

# Vérification de l'argument
if [ -z "$1" ]; then
    echo "Usage: $0 <IP>"
    exit 1
fi

IP="$1"

# Scan les ports ouverts
sudo nmap -sSV -Pn -vvv -p- --open --reason -oA ${IP}_port_1000_SYN ${IP} >/dev/null 

echo "Scan terminé :"
cat ${IP}_port_1000_SYN.nmap | grep -e "open" | grep -e "tcp" 
echo ""


# Boucle sur les ports HTTP et HTTPS et les rajoute dans /etc/hosts
PORTS_WEB=$(cat ${IP}_port_1000_SYN.nmap | grep -e "http" | grep -e "open" | awk -F'/' '{print $1}')
for PORT in $PORTS_WEB; do
	#echo "traitement du port $PORTS_WEB"
    SCHEME="http"
    [ "$PORT" -eq 443 ] && SCHEME="https"
    URL="${SCHEME}://${IP}:${PORT}"

    # Récupération de l'en-tête Location avec un timeout de 3 secondes
    LOCATION=$(curl -s -I -m 3 "$URL" | grep -i "^location:" | awk '{print $2}' | tr -d '\r')
	
    if [ -n "$LOCATION" ]; then
		echo "LOCATION = $LOCATION"
		echo " "
        # Extraction du nom de domaine depuis l'URL de redirection
        DOMAIN=$(echo "$LOCATION" | sed -E 's#https?://([^/@:]+).*#\1#')

        # Si un domaine est extrait et qu'il ne s'agit pas de l'IP elle-même
        if [ -n "$DOMAIN" ] && [ "$DOMAIN" != "$IP" ]; then
            # Vérification si l'association existe déjà dans /etc/hosts
            if grep -qE "^[[:space:]]*${IP}[[:space:]]+.*${DOMAIN}" /etc/hosts; then
                echo "[=] Entrée déjà présente dans /etc/hosts : $IP $DOMAIN"
				echo " "
            else
                echo "[+] Ajout dans /etc/hosts : $IP $DOMAIN"
                echo "$IP $DOMAIN" | sudo tee -a /etc/hosts > /dev/null
            fi
			echo "Lancement de Gobuster"
			SUBDOMAINS=$(gobuster vhost -u $LOCATION -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-20000.txt --append-domain | grep -e "Status: 200" | awk '{print $2}')
			echo " "
			echo " "
			echo "SUBDOMAINS = ${SCHEME}://$SUBDOMAINS"
			echo " "
			for SUBDOMAIN in $SUBDOMAINS; do
				if [ -n "$SUBDOMAIN" ] && [ "$SUBDOMAIN" != "$IP" ]; then
				# Vérification si l'association existe déjà dans /etc/hosts
					if grep -qE "^[[:space:]]*${IP}[[:space:]]+.*${SUBDOMAIN}" /etc/hosts; then
						echo "[=] Entrée déjà présente dans /etc/hosts : $IP $SUBDOMAIN"
					else
						echo "[+] Ajout dans /etc/hosts : $IP $SUBDOMAIN"
						echo "$IP $SUBDOMAIN" | sudo tee -a /etc/hosts > /dev/null
					fi
				fi
			done
		fi
	fi
done
