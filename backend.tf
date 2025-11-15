# C:/terraform-projet-2-tiers/backend.tf

# On dit a Terraform de ne PAS utiliser le disque local
terraform {
  backend "gcs" {
    # Remplacez par le nom de votre nouveau bucket
    bucket = "tfstate-projet-2-tiers-geoffrey"

    # C'est comme un "dossier" a l'interieur du bucket
    # pour garder les choses propres.
    prefix = "terraform/state/production"
  }
}