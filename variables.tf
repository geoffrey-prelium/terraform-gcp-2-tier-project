# C:/terraform-projet-2-tiers/variables.tf

variable "gcp_project_id" {
  type        = string
  description = "L'ID de votre projet GCP (ex: terraform-gemini-477616)"

  # ! ACTION REQUISE !
  # Mettez votre veritable ID de projet ici
  default = "terraform-gemini-477616"
}

variable "gcp_region" {
  type        = string
  description = "Region principale pour le deploiement."
  default     = "europe-west1"
}

variable "gcp_region_zone" {
  type        = string
  description = "Zone specifique (dans la region) pour les VMs."
  default     = "europe-west1-b"
}

variable "ssh_user_name" {
  type        = string
  description = "Votre nom d'utilisateur pour la connexion SSH."
  default     = "geoffrey"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Chemin vers votre cle publique SSH (generee en Semaine 1)."
  default     = "~/.ssh/gcp_terraform_key.pub"
}