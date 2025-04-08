# **Wazuh**
[![Bash](https://img.shields.io/badge/Bash-5.x-blue?style=for-the-badge&logo=gnubash&logoColor=white)]()


**Wazuh** est une plateforme open-source offrant des capacités de détection des menaces, de surveillance de l'intégrité des fichiers, d'analyse des journaux et de réponse aux incidents.

## **Fonctionnalités**

- Détection des intrusions
- Surveillance des fichiers et logs
- Gestion des agents
- Alertes en temps réel

---

## **Clonage**

#### 
```bash
sudo apt update && sudo apt upgrade
sudo apt install git -y
```

#### Clonez le dépôt
```bash
sudo git clone https://github.com/ettaldi/Wazuh
```

#### Entrez dans le répertoire
```bash
sudo cd Wazuh
```

## **Installation Wazuh server**

```bash
sudo chmod +x wazuh_server.sh
sudo ./wazuh_server.sh
```
## **Avant l'installation Wazuh agents**
> Avant d’installer les agents Wazuh, il est essentiel d’activer le service SSH sur la machine principale ainsi que sur toutes les machines agents (Linux et Windows). Cela permettra au script de s’exécuter correctement à distance.
#### Sur la machine exécutant le script
```bash
sudo apt update
sudo apt install ufw openssh-server sshpass -y
sudo systemctl enable ssh
sudo systemctl start ssh
sudo ufw allow ssh
```
#### Sur les machines agents
### Linux
```bash
sudo apt install ufw openssh-server -y
sudo systemctl enable ssh
sudo systemctl start ssh
sudo ufw allow ssh
```
### Windows
```bash
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
New-NetFirewallRule -Name "OpenSSH" -DisplayName "SSH Port 22" `
    -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```
> **Important :** N'oubliez pas de fermer les ports sur votre machine et vos agents apres l'execution du script
## **Installation Wazuh agents**
```bash
sudo chmod +x wazuh_agents.sh
sudo ./wazuh_agents.sh
```
> **Important :** Assurez-vous de remplir les fichiers machines_linux.txt ou machines_windows.txt avec les adresses IP des agents (chacune sur une ligne séparée).
## **Trouvez-moi sur**
<div align="center">
<a href="https://www.linkedin.com/in/mohamed-rayan-ettaldi-6b7501244/" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" />
  </a>
</div>

