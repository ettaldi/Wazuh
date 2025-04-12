#!/bin/bash

check_success() {
    if [ $? -eq 0 ]; then
        echo "$1"
    else
        echo "Erreur lors de l'exécution de la commande précédente."
        exit 1
    fi
}

echo "=== Installation de Wazuh server ==="

read -p "Entrez l'adresse IP du serveur : " SERVER_IP
read -p "Entrez le nom du serveur : " SERVER_NAME

curl -sO https://packages.wazuh.com/4.11/wazuh-install.sh
check_success "Fichier wazuh-install.sh téléchargé"

curl -sO https://packages.wazuh.com/4.11/config.yml
check_success "Fichier config.yml téléchargé (sera remplacé)"

cat <<EOF > config.yml
nodes:
  indexer:
    - name: "$SERVER_NAME"
      ip: "$SERVER_IP"

  server:
    - name: "$SERVER_NAME"
      ip: "$SERVER_IP"

  dashboard:
    - name: "$SERVER_NAME"
      ip: "$SERVER_IP"
EOF

check_success "Fichier config.yml généré avec succès"

bash wazuh-install.sh --generate-config-files
check_success "Fichiers de configuration générés"

curl -sO https://packages.wazuh.com/4.11/wazuh-install.sh
check_success "Script wazuh-install.sh re-téléchargé"

bash wazuh-install.sh --wazuh-indexer "$SERVER_NAME"
check_success "Wazuh Indexer installé"

bash wazuh-install.sh --start-cluster
check_success "Cluster démarré"

bash wazuh-install.sh --wazuh-server "$SERVER_NAME"
check_success "Wazuh Server installé"

bash wazuh-install.sh --wazuh-dashboard "$SERVER_NAME"
check_success "Dashboard installé"

echo ""
echo "Mots de passe générés (également enregistrés dans password.txt) :"
tar -axf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt -O > password.txt
