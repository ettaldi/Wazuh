> **Stage :** Implémentation d’un SIEM avec Wazuh
# **Wazuh** 
[![Bash](https://img.shields.io/badge/Bash-5.x-blue?style=for-the-badge&logo=gnubash&logoColor=white)]()


**Wazuh** est une plateforme open-source offrant des capacités de détection des menaces, de surveillance de l'intégrité des fichiers, d'analyse des journaux et de réponse aux incidents.

## **Fonctionnalités**

- Détection des intrusions
- Surveillance des fichiers et logs
- Gestion des agents
- Alertes en temps réel

---
> **Important :** Avant de procéder à l'installation, veuillez vérifier les prérequis matériels et le système d'exploitation, notamment pour l'intégration de Wazuh : https://documentation.wazuh.com/current/quickstart.html#requirements 
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
> Exécute le script pour installer le serveur Wazuh et redémarre le service du serveur Wazuh pour appliquer les changements.
---
## **Installation Wazuh agents**
> Avant d'exécuter la commande d'installation, veillez à remplacer `Addresse_IP` par celle de votre serveur Wazuh, `Nom_agent` et choisissez un groupe (ou laissez `default` si vous n’en avez pas).
### **Linux**
#### **RPM amd64**
> Télécharge le paquet RPM du Wazuh agent pour architecture x86_64.
#### 
```bash
curl -o wazuh-agent-4.11.2-1.x86_64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.11.2-1.x86_64.rpm && sudo WAZUH_MANAGER='Addresse_IP' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Nom_agent' rpm -ihv wazuh-agent-4.11.2-1.x86_64.rpm
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```

#### **DEB amd64**
> Télécharge le paquet DEB pour architecture amd64.
#### 
```bash
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.11.2-1_amd64.deb && sudo WAZUH_MANAGER='Addresse_IP' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Nom_agent' dpkg -i ./wazuh-agent_4.11.2-1_amd64.deb
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```

#### **RPM aarch64**
> Pareil que le RPM amd64, mais pour architecture ARM64.
#### 
```bash
curl -o wazuh-agent-4.11.2-1.aarch64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.11.2-1.aarch64.rpm && sudo WAZUH_MANAGER='Addresse_IP' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Nom_agent' rpm -ihv wazuh-agent-4.11.2-1.aarch64.rpm
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```

#### **DEB aarch64**
> Pour les machines ARM64.
#### 
```bash
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.11.2-1_arm64.deb && sudo WAZUH_MANAGER='Addresse_IP' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Nom_agent' dpkg -i ./wazuh-agent_4.11.2-1_arm64.deb
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```
### **Windows**
> Pour les machines Windows.
#### 
```bash
Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.11.2-1.msi -OutFile $env:tmp\wazuh-agent; msiexec.exe /i $env:tmp\wazuh-agent /q WAZUH_MANAGER='Addresse_IP' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Nom_agent'
NET START WazuhSvc
```
### **macOS**
#### **Intel**
> Télécharge le paquet d’installation pour Mac Intel.
#### 
```bash
curl -so wazuh-agent.pkg https://packages.wazuh.com/4.x/macos/wazuh-agent-4.11.2-1.intel64.pkg && echo "WAZUH_MANAGER='Addresse_IP' && WAZUH_AGENT_GROUP='default' && WAZUH_AGENT_NAME='Nom_agent'" > /tmp/wazuh_envs && sudo installer -pkg ./wazuh-agent.pkg -target /
sudo /Library/Ossec/bin/wazuh-control start
```
#### **Apple silicon**
> Pareil que pour Intel, mais avec un paquet adapté aux Mac M1/M2.
#### 
```bash
curl -so wazuh-agent.pkg https://packages.wazuh.com/4.x/macos/wazuh-agent-4.11.2-1.arm64.pkg && echo "WAZUH_MANAGER='Addresse_IP' && WAZUH_AGENT_GROUP='default' && WAZUH_AGENT_NAME='Nom_agent'" > /tmp/wazuh_envs && sudo installer -pkg ./wazuh-agent.pkg -target /
sudo /Library/Ossec/bin/wazuh-control start
```
---
## **Configuration**
### **Surveillance de l'intégrité des fichiers**
**Surveillance de l'intégrité des fichiers (File integrity monitoring)** est une fonctionnalité de sécurité qui suit les modifications des fichiers sur un système. Elle détecte les modifications, ajouts ou suppressions de fichiers, ce qui permet d'identifier les menaces potentielles ou les activités non autorisées.
#### **Manager**
```bash
sudo sed -i 's|<logall>no</logall>|<logall>yes</logall>|; s|<logall_json>no</logall_json>|<logall_json>yes</logall_json>|' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-manager
```
#### **Agent**
```bash
sudo sed -i '/<directories>\/bin,\/sbin,\/boot<\/directories>/a \ <directories check_all="yes" report_changes="yes" realtime="yes">/root</directories>' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-agent
```
### **Détection des vulnérabilités**
**Détection des vulnérabilités (Vulnerability detection)** est une fonction qui permet d’identifier les failles de sécurité connues dans les logiciels installés sur un système.
#### **Manager**
```bash
sudo sed -i '/<\/ossec_config>/i \<vulnerability-detector>\n  <enabled>yes</enabled>\n  <provider name="canonical">\n    <enabled>yes</enabled>\n  </provider>\n</vulnerability-detector>' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-manager
```
#### **Agent**
> `auditd` est utilisé pour activer la journalisation des commandes.
```bash
sudo apt install -y auditd && sudo sed -i '/<\/ossec_config>/i \<localfile>\n  <log_format>audit</log_format>\n  <location>/var/log/audit/audit.log</location>\n</localfile>' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-agent && echo -e "-a exit,always -F euid=0 -F arch=b64 -S execve -k audit-wazuh-c\n-a exit,always -F euid=0 -F arch=b32 -S execve -k audit-wazuh-c" | sudo tee -a /etc/audit/audit.rules > /dev/null && sudo auditctl -R /etc/audit/audit.rules
```
### **Blocage des attaques par force brute sur SSH**
**Blocage des attaques par force brute sur SSH** c’est empêcher un attaquant de tester plusieurs mots de passe sur le service SSH en détectant ces tentatives et en bloquant automatiquement son adresse IP.
#### **Manager**
```bash
sudo sed -i '/<\/ossec_config>/i \<active-response>\n  <command>firewall-drop</command>\n  <location>local</location>\n  <rules_id>5763</rules_id>\n  <timeout>180</timeout>\n</active-response>' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-manager
```
### **Détection de fichiers malveillants avec VirusTotal**
**API VirusTotal** est un outil qui permet d’analyser automatiquement des fichiers, des URL, des IP et des domaines pour détecter des malwares à l’aide des services de VirusTotal.
> Tu peux récupérer une clé API ici : https://www.virustotal.com/gui/join-us
#### **Manager**
```bash
sudo bash -c 'cat <<EOF >> /var/ossec/etc/rules/local_rules.xml

<group name="local,custom">

  <rule id="100200" level="7">
    <if_sid>550</if_sid>
    <field name="file">/root</field>
    <description>File modified in /root directory.</description>
  </rule>

  <rule id="100201" level="7">
    <if_sid>554</if_sid>
    <field name="file">/root</field>
    <description>File added in /root directory.</description>
  </rule>

</group>

EOF'
```
```bash
sudo sed -i '/<\/ossec_config>/i \<integration>\n  <name>virustotal</name>\n  <api_key>clé_api_virustotal</api_key>\n  <rule_id>100200,100201</rule_id>\n  <alert_format>json</alert_format>\n</integration>' /var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-manager
```
> N'oubliez pas de remplacer `clé_api_virustotal` par votre clé API personnelle obtenue sur votre compte VirusTotal.
### **Alertes par mail via un serveur SMTP**
**Alertes par mail via un serveur SMTP** permettent d’envoyer automatiquement des emails quand une menace ou un événement de sécurité est détecté, en utilisant un serveur d’envoi.
```bash
sudo apt update && sudo apt install -y postfix mailutils libsasl2-2 ca-certificates libsasl2-modules
sudo cp /usr/share/postfix/main.cf.debian /etc/postfix/main.cf
```
> Choisissez `Pas de configuration` comme type de configuration du mail général.
```bash
sudo tee /etc/postfix/main.cf > /dev/null <<EOF
smtpd_banner = \$myhostname ESMTP \$mail_name (Debian)
biff = no
append_dot_mydomain = no
readme_directory = no
compatibility_level = 3.6

# Gmail SMTP relay
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_tls_security_level = encrypt
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt

# SASL auth
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous
EOF
```
```bash
sudo tee /etc/postfix/sasl_passwd > /dev/null <<EOF
[smtp.gmail.com]:587 email_source:mot_de_passe_application
EOF
```
> N'oubliez pas de remplacer `email_source` par adresse e-mail source, et `mot_de_passe_application` par le mot de passe d'application généré pour l'authentification.
```bash
sudo postmap /etc/postfix/sasl_passwd
sudo chmod 400 /etc/postfix/sasl_passwd
sudo chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
sudo systemctl restart postfix
```
```bash
sudo sed -i \
-e 's|<email_notification>no</email_notification>|<email_notification>yes</email_notification>|' \
-e 's|<smtp_server>.*</smtp_server>|<smtp_server>localhost</smtp_server>|' \
-e 's|<email_from>.*</email_from>|<email_from>email_source</email_from>|' \
-e 's|<email_to>.*</email_to>|<email_to>email_destinataire</email_to>|g' \
/var/ossec/etc/ossec.conf && sudo systemctl restart wazuh-manager
```
> N'oubliez pas de remplacer `email_source` par adresse e-mail source et `email_destinataire` par l'adresse email du destinataire des alertes.
## **Trouvez-moi sur**
<div align="center">
<a href="https://www.linkedin.com/in/mohamed-rayan-ettaldi-6b7501244/" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" />
  </a>
</div>

