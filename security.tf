# C:/terraform-projet-2-tiers/security.tf

# On récupère le nom de notre VPC
# Un bloc "data" lit une ressource qui EXISTE DEJA.
# Il ne crée rien, il ne fait que "lire".
data "google_compute_network" "main_vpc" {
  # On lui dit de trouver le réseau dont le nom
  # est celui sorti par notre module vpc.
  name = module.vpc.network_name
}

# =========================================================
# REGLE 1 : Autoriser le HTTP (Port 80) depuis Internet
# =========================================================
resource "google_compute_firewall" "allow_http" {
  name = "allow-http-ingress-80"

  # On attache cette règle au réseau lu par notre bloc "data"
  network = data.google_compute_network.main_vpc.self_link

  # Ingress = Trafic ENTRANT
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"] # Port HTTP
  }

  # Source : N'importe qui sur Internet
  source_ranges = ["0.0.0.0/0"]

  # Cible : Uniquement les VMs avec ce tag
  target_tags = ["web-server"]
}

# =========================================================
# REGLE 2 : Autoriser le SSH (Port 22) depuis Internet
# =========================================================
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-ingress-22"
  network = data.google_compute_network.main_vpc.self_link

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"] # Port SSH
  }

  # Source : N'importe qui sur Internet
  source_ranges = ["0.0.0.0/0"]

  # Cible : Les VMs avec ce tag (nos deux VMs l'ont)
  target_tags = ["allow-ssh"]
}

# =========================================================
# REGLE 3 : Autoriser le MySQL (Port 3306) du Web vers la DB
# =========================================================
resource "google_compute_firewall" "allow_internal_mysql" {
  name    = "allow-web-to-db-mysql-3306"
  network = data.google_compute_network.main_vpc.self_link

  direction = "INGRESS" # Ingress... vers la DB

  allow {
    protocol = "tcp"
    ports    = ["3306"] # Port MySQL
  }

  # Cible : S'applique aux VMs taguées 'db-server'
  target_tags = ["db-server"]

  # Source : Vient UNIQUEMENT des VMs taguées 'web-server'
  # C'est la ligne qui sécurise notre architecture.
  source_tags = ["web-server"]
}