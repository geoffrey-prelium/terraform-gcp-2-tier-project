# C:/terraform-projet-2-tiers/network.tf

# On appelle un module depuis le Registre Terraform
module "vpc" {
  # L'adresse "Auteur/Nom/Provider" du module
  source  = "terraform-google-modules/network/google"
  version = "~> 8.0" # On verrouille la version

  # --- Arguments passes au module ---
  project_id   = var.gcp_project_id
  network_name = "vpc-projet-2-tiers"

  # On s'assure que l'API est activee AVANT de creer le VPC
  depends_on = [google_project_service.compute_api]

  # --- C'est ici la magie ---
  # On lui passe une LISTE de DEUX subnets a creer.
  subnets = [
    # 1. Le Subnet Public (pour le Web)
    {
      subnet_name   = "subnet-web-public"
      subnet_ip     = "10.10.1.0/24" # Plage d'IP pour le web
      subnet_region = var.gcp_region
    },

    # 2. Le Subnet Prive (pour la DB)
    {
      subnet_name   = "subnet-db-private"
      subnet_ip     = "10.10.2.0/24" # Plage d'IP SEPAREE pour la DB
      subnet_region = var.gcp_region
    }
  ]
}