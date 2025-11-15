#!/bin/bash
# === SCRIPT SERVEUR DB ===

# Mettre a jour les paquets
apt-get update

# Exporter une variable d'environnement pour eviter
# les pop-ups d'installation de MySQL
export DEBIAN_FRONTEND=noninteractive

# Installer le serveur MySQL
apt-get install -y mysql-server

# --- Configuration critique ---
# Par defaut, MySQL n'ecoute que '127.0.0.1' (localhost).
# Nous devons lui dire d'ecouter sur '0.0.0.0' (toutes ses adresses IP)
# pour que le serveur Web (sur une autre IP) puisse s'y connecter.
sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mysql.conf.d/mysqld.cnf

# Redemarrer le service pour appliquer la configuration
systemctl restart mysql