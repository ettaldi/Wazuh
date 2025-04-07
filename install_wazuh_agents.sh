#!/bin/bash

# Demander l'adresse IP du serveur Wazuh
read -p "Entrez l'adresse IP du serveur Wazuh : " WAZUH_SERVER

# Demander le chemin des fichiers contenant les adresses IP des machines
read -p "Entrez le chemin du fichier contenant les adresses IP des machines Linux : " LINUX_FILE
read -p "Entrez le chemin du fichier contenant les adresses IP des machines Windows : " WINDOWS_FILE

# Fonction pour installer l'agent Wazuh sur les machines Linux
install_linux_agent() {
    IP=$1
    echo "Installation de l'agent Wazuh sur la machine Linux $IP..."

    # Demander les identifiants de la machine Linux
    read -p "Entrez le nom d'utilisateur pour la machine Linux $IP : " LINUX_USER
    read -sp "Entrez le mot de passe pour la machine Linux $IP : " LINUX_PASS
    echo

    # Commandes d'installation
    sshpass -p $LINUX_PASS ssh -o StrictHostKeyChecking=no $LINUX_USER@$IP "
        curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
        echo \"deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main\" | tee -a /etc/apt/sources.list.d/wazuh.list
        apt-get update
        WAZUH_MANAGER=\"$WAZUH_SERVER\" apt-get install -y wazuh-agent
        systemctl daemon-reload
        systemctl enable wazuh-agent
        systemctl start wazuh-agent
    "

    echo "Agent Wazuh installé sur la machine Linux $IP"
}

# Fonction pour installer l'agent Wazuh sur les machines Windows
install_windows_agent() {
    IP=$1
    echo "Installation de l'agent Wazuh sur la machine Windows $IP..."

    # Demander les identifiants de la machine Windows
    read -p "Entrez le nom d'utilisateur pour la machine Windows $IP : " WINDOWS_USER
    read -sp "Entrez le mot de passe pour la machine Windows $IP : " WINDOWS_PASS
    echo

    # Commandes d'installation
    sshpass -p $WINDOWS_PASS ssh -o StrictHostKeyChecking=no $WINDOWS_USER@$IP "
        Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.11.2-1.msi -OutFile C:\\Windows\\Temp\\wazuh-agent.msi
        Start-Process msiexec.exe -ArgumentList '/i', 'C:\\Windows\\Temp\\wazuh-agent.msi', '/quiet', 'WAZUH_MANAGER=$WAZUH_SERVER' -NoNewWindow -Wait
        Start-Service -Name 'Wazuh'
    "

    echo "Installation réussie sur la machine Windows $IP"
}

# Installation sur les machines Linux
echo "Installation des agents Wazuh sur les machines Linux..."
while IFS= read -r ip; do
    install_linux_agent $ip
done < $LINUX_FILE

# Installation sur les machines Windows
echo "Installation des agents Wazuh sur les machines Windows..."
while IFS= read -r ip; do
    install_windows_agent $ip
done < $WINDOWS_FILE

echo "Installation des agents Wazuh terminée sur toutes les machines."
