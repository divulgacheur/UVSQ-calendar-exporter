# Projet d'export d'emploi du temps UVSQ au format iCal

## Description

Ce projet fournit un script **bash** qui permet d'extraire les données d'emploi du temps du site `edt.uvsq.fr` et de les convertir en un fichier iCal. Cela vous permet d'intégrer facilement votre emploi du temps avec Google Agenda, Outlook ou toute autre application qui supporte le format iCal. Pour une mise à jour dynamique des cours, il est nécessaire d'héberger le fichier iCal sur un serveur web accessible.

## Installation

### Pré-requis

Les paquets suivants sont nécessaires sur la machine qui exécutera ce script :

- `jq` : un processeur léger et flexible de ligne de commande JSON
- `curl` : un outil de transfert de données

Vous pouvez les installer sur un système basé sur Debian avec la commande suivante:

```bash
sudo apt install jq curl
```

### Téléchargement

Clonez le répertoire à l'aide de la commande suivante :

```bash
git clone https://github.com/divulgacheur/UVSQ-calendar-exporter
```

## Utilisation

1. Ouvrez le fichier `convert_edt_to_ical.sh` dans un éditeur de texte.
2. Modifiez la valeur de la variable `FORMATION` pour qu'elle corresponde au code de votre formation. Ce code est visible dans l'URL que vous utilisez pour voir votre calendrier, par exemple dans `https://edt.uvsq.fr/cal?vt=agendaWeek&dt=2023-09-18&et=group&fid0=MYISR2_888` le code de la formation est `MYISR2_888`.
3. Exécutez le script avec la commande. Il est à noter que la sortie du script se fait sur la sortie standard et qu'il est donc nécessaire de la rédiriger vers un fichier :

```bash
bash convert_edt_to_ical.sh > edt.ical
```

Le fichier généré pourra être importé dans votre application de calendrier préférée, ou bien mis à disposition de tous graĉe à un serveur web, ce qui permettra de mettre à jour le calendrier dynamiquement.

## Contribution

N'hésitez pas à soumettre des issues ou des pull requests si vous avez des améliorations ou des corrections à suggérer.

## Licence

Ce projet est sous licence GPL-3.0. Voir le fichier [LICENSE](LICENSE) pour plus de détails.
