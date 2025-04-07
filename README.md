# **Wazuh**

**Wazuh** est une plateforme open-source offrant des capacités de détection des menaces, de surveillance de l'intégrité des fichiers, d'analyse des journaux et de réponse aux incidents.

## **Fonctionnalités**

- Détection des intrusions
- Surveillance des fichiers et logs
- Gestion des agents
- Alertes en temps réel

---

### **Installez Git**

#### Debian
```bash
sudo apt install git -y
```

### **Clonez le dépôt**
```bash
git clone https://github.com/ettaldi/Wazuh
```

### **Entrez dans le répertoire**
```bash
cd Wazuh
```

## **Installation Wazuh server**

```bash
chmod +x install_wazuh_server.sh
```

```bash
./install_wazuh_server.sh
```

## **Installation Wazuh agents**
> **Important :** Assurez-vous de remplir les fichiers machines_linux.txt ou machines_windows.txt avec les adresses IP des agents, en séparant chaque adresse par un espace.
```bash
chmod +x install_wazuh_agents.sh
```
```bash
./install_wazuh_agents.sh
```

## **Trouvez-moi sur**
<div align="center">
<a href="https://www.linkedin.com/in/mohamed-rayan-ettaldi-6b7501244/" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" />
  </a>
</div>

