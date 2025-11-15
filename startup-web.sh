#!/bin/bash
# === SCRIPT SERVEUR WEB ===

# Mettre a jour les paquets
apt-get update

# Installer Nginx
apt-get install -y nginx

# Creer une page de test simple
echo "<h1>Serveur Web (Frontend) - OK</h1>" > /var/www/html/index.html

# Demarrer le service
systemctl start nginx