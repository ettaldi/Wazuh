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

