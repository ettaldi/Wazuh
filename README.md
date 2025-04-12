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
```


## **Installation Wazuh agents**
### **Linux**
#### **RPM amd64**
#### 
```bash
curl -o wazuh-agent-4.11.2-1.x86_64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.11.2-1.x86_64.rpm && sudo WAZUH_MANAGER='Addresse IP' WAZUH_AGENT_GROUP='Groupe_agent' WAZUH_AGENT_NAME='Nom_agent' rpm -ihv wazuh-agent-4.11.2-1.x86_64.rpm
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```
#### **RPM amd64**
#### 
```bash
curl -o wazuh-agent-4.11.2-1.x86_64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.11.2-1.x86_64.rpm && sudo WAZUH_MANAGER='Addresse IP' WAZUH_AGENT_GROUP='Groupe_agent' WAZUH_AGENT_NAME='Nom_agent' rpm -ihv wazuh-agent-4.11.2-1.x86_64.rpm
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```
#### **RPM aarch64**
#### 
```bash
curl -o wazuh-agent-4.11.2-1.aarch64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.11.2-1.aarch64.rpm && sudo WAZUH_MANAGER='Addresse IP' WAZUH_AGENT_GROUP='Groupe_agent' WAZUH_AGENT_NAME='Nom_agent' rpm -ihv wazuh-agent-4.11.2-1.aarch64.rpm
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```
#### **DEB aarch64**
#### 
```bash
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.11.2-1_arm64.deb && sudo WAZUH_MANAGER='Addresse IP' WAZUH_AGENT_GROUP='Groupe_agent' WAZUH_AGENT_NAME='Nom_agent' dpkg -i ./wazuh-agent_4.11.2-1_arm64.deb
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```
### **Windows**
#### 
```bash
Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.11.2-1.msi -OutFile $env:tmp\wazuh-agent; msiexec.exe /i $env:tmp\wazuh-agent /q WAZUH_MANAGER='Addresse IP' WAZUH_AGENT_GROUP='Groupe_agent' WAZUH_AGENT_NAME='Nom_agent'
NET START WazuhSvc
```
### **macOS**
#### **Intel**
#### 
```bash
curl -so wazuh-agent.pkg https://packages.wazuh.com/4.x/macos/wazuh-agent-4.11.2-1.intel64.pkg && echo "WAZUH_MANAGER='Addresse IP' && WAZUH_AGENT_GROUP='Groupe_agent' && WAZUH_AGENT_NAME='Nom_agent'" > /tmp/wazuh_envs && sudo installer -pkg ./wazuh-agent.pkg -target /
sudo /Library/Ossec/bin/wazuh-control start
```
#### **Apple silicon**
#### 
```bash
curl -so wazuh-agent.pkg https://packages.wazuh.com/4.x/macos/wazuh-agent-4.11.2-1.arm64.pkg && echo "WAZUH_MANAGER='Addresse IP' && WAZUH_AGENT_GROUP='Groupe_agent' && WAZUH_AGENT_NAME='Nom_agent'" > /tmp/wazuh_envs && sudo installer -pkg ./wazuh-agent.pkg -target /
sudo /Library/Ossec/bin/wazuh-control start
```
## **Trouvez-moi sur**
<div align="center">
<a href="https://www.linkedin.com/in/mohamed-rayan-ettaldi-6b7501244/" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" />
  </a>
</div>

