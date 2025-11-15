# C:/terraform-projet-2-tiers/main.tf

# Le bloc 'terraform' definit les exigences de Terraform lui-meme
terraform {
  required_providers {
    # Nous avons besoin du provider Google
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0" # On "verrouille" la version majeure
    }
    # (Nous ajouterons 'random' et 'templatefile' plus tard si besoin)
  }
}

# Le bloc 'provider' configure un provider specifique
# C'est ici qu'on lui donne notre projet
provider "google" {
  project = var.gcp_project_id # Lit la variable definie dans variables.tf
  region  = var.gcp_region
}

# C'est une bonne pratique d'activer l'API ici
# C'est la "cle de contact" pour la Compute Engine
resource "google_project_service" "compute_api" {
  project = var.gcp_project_id
  service = "compute.googleapis.com"

  # Important: empeche 'terraform destroy' de desactiver l'API,
  # ce qui pourrait bloquer d'autres projets.
  disable_on_destroy = false
}