# **Wazuh**
[![Bash](https://img.shields.io/badge/Bash-5.x-blue?style=for-the-badge&logo=gnubash&logoColor=white)]()


**Wazuh** est une plateforme open-source offrant des capacités de détection des menaces, de surveillance de l'intégrité des fichiers, d'analyse des journaux et de réponse aux incidents.

## **Fonctionnalités**

- Détection des intrusions
- Surveillance des fichiers et logs
- Gestion des agents
- Alertes en temps réel

---
> **Important :** Avant de procéder à l'installation, veuillez vérifier les prérequis matériels et le système d'exploitation, notamment pour l'intégration de Wazuh (https://documentation.wazuh.com/current/quickstart.html#requirements).    
## **Clonage**

#### 
```bash
sudo apt update -y && sudo apt upgrade -y
sudo apt install git -y
```

#### Clonez le dépôt
```bash
sudo git clone https://github.com/ettaldi/Wazuh
```

#### Entrez dans le répertoire
```bash
cd Wazuh
```

## **Installation Wazuh server**

```bash
sudo chmod +x wazuh_server.sh
sudo ./wazuh_server.sh
sudo systemctl restart wazuh-manager
```

---
## **Installation Wazuh agents**
> Avant d'exécuter la commande d'installation, veillez à remplacer l'adresse IP par celle de votre serveur Wazuh, à utiliser le nom d'hôte de la machine comme nom d’agent pour une meilleure identification, et choisissez un groupe (ou laissez 'default' si vous n’en avez pas).
### **Linux**
#### **RPM amd64**
#### 
```bash
curl -o wazuh-agent-4.11.2-1.x86_64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.11.2-1.x86_64.rpm && sudo WAZUH_MANAGER='Addresse IP' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Nom_agent' rpm -ihv wazuh-agent-4.11.2-1.x86_64.rpm
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```
#### **DEB amd64**
#### 
```bash
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.11.2-1_amd64.deb && sudo WAZUH_MANAGER='Addresse IP' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Nom_agent' dpkg -i ./wazuh-agent_4.11.2-1_amd64.deb
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```
#### **RPM aarch64**
#### 
```bash
curl -o wazuh-agent-4.11.2-1.aarch64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.11.2-1.aarch64.rpm && sudo WAZUH_MANAGER='Addresse IP' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Nom_agent' rpm -ihv wazuh-agent-4.11.2-1.aarch64.rpm
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```
#### **DEB aarch64**
#### 
```bash
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.11.2-1_arm64.deb && sudo WAZUH_MANAGER='Addresse IP' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Nom_agent' dpkg -i ./wazuh-agent_4.11.2-1_arm64.deb
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```
### **Windows**
#### 
```bash
Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.11.2-1.msi -OutFile $env:tmp\wazuh-agent; msiexec.exe /i $env:tmp\wazuh-agent /q WAZUH_MANAGER='Addresse IP' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Nom_agent'
NET START WazuhSvc
```
### **macOS**
#### **Intel**
#### 
```bash
curl -so wazuh-agent.pkg https://packages.wazuh.com/4.x/macos/wazuh-agent-4.11.2-1.intel64.pkg && echo "WAZUH_MANAGER='Addresse IP' && WAZUH_AGENT_GROUP='default' && WAZUH_AGENT_NAME='Nom_agent'" > /tmp/wazuh_envs && sudo installer -pkg ./wazuh-agent.pkg -target /
sudo /Library/Ossec/bin/wazuh-control start
```
#### **Apple silicon**
#### 
```bash
curl -so wazuh-agent.pkg https://packages.wazuh.com/4.x/macos/wazuh-agent-4.11.2-1.arm64.pkg && echo "WAZUH_MANAGER='Addresse IP' && WAZUH_AGENT_GROUP='default' && WAZUH_AGENT_NAME='Nom_agent'" > /tmp/wazuh_envs && sudo installer -pkg ./wazuh-agent.pkg -target /
sudo /Library/Ossec/bin/wazuh-control start
```

## **Configuration**
### **File integrity monitoring**
**File integrity monitoring** est une fonctionnalité de sécurité qui suit les modifications des fichiers sur un système. Elle détecte les modifications, ajouts ou suppressions de fichiers, ce qui permet d'identifier les menaces potentielles ou les activités non autorisées.
#### **Manager**
```bash
sudo sed -i '/<\/global>/i \  <logall>yes</logall>\n  <logall_json>yes</logall_json>' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-manager
```
#### **Agent**
```bash
sudo sed -i '/<directories>\/bin,\/sbin,\/boot<\/directories>/a \ <directories check_all="yes" report_changes="yes" realtime="yes">/root</directories>' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-agent
```
### **Vulnerability detection**
**Vulnerability detection** est une fonction qui permet d’identifier les failles de sécurité connues dans les logiciels installés sur un système.
#### **Manager**
```bash
sudo sed -i '/<\/ossec_config>/i \<vulnerability-detector>\n  <enabled>yes</enabled>\n  <provider name="canonical">\n    <enabled>yes</enabled>\n  </provider>\n</vulnerability-detector>' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-manager
```
#### **Agent**
```bash
sudo apt install -y auditd && sudo sed -i '/<\/ossec_config>/i \<localfile>\n  <log_format>audit</log_format>\n  <location>/var/log/audit/audit.log</location>\n</localfile>' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-agent && echo -e "-a exit,always -F euid=0 -F arch=b64 -S execve -k audit-wazuh-c\n-a exit,always -F euid=0 -F arch=b32 -S execve -k audit-wazuh-c" | sudo tee -a /etc/audit/audit.rules > /dev/null && sudo auditctl -R /etc/audit/audit.rules
```
### **Blocking SSH Brute force attacks**
**Blocking SSH Brute force attacks** c’est empêcher un attaquant de tester plusieurs mots de passe sur le service SSH en détectant ces tentatives et en bloquant automatiquement son adresse IP.
#### **Manager**
```bash
sudo sed -i '/<\/ossec_config>/i \<active-response>\n  <command>firewall-drop</command>\n  <location>local</location>\n  <rules_id>5763</rules_id>\n  <timeout>180</timeout>\n</active-response>' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-manager
```
## **Trouvez-moi sur**
<div align="center">
<a href="https://www.linkedin.com/in/mohamed-rayan-ettaldi-6b7501244/" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" />
  </a>
</div>

