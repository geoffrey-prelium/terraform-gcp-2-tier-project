# C:/terraform-projet-2-tiers/modules/gcp-vm/variables.tf

variable "vm_name" {
  description = "Le nom de la VM a creer."
  type        = string
}

variable "machine_type" {
  description = "Le type de machine (ex: e2-micro)."
  type        = string
  default     = "e2-micro" # On met une valeur par defaut raisonnable
}

variable "gcp_zone" {
  description = "La zone ou deployer la VM (ex: europe-west1-b)."
  type        = string
}

variable "subnet_link" {
  description = "Le self_link du subnet auquel attacher la VM."
  type        = string
}

variable "tags" {
  description = "Une liste de tags reseau a attacher (pour le firewall)."
  type        = list(string)
  default     = [] # Par defaut, aucun tag
}

variable "assign_public_ip" {
  description = "Definit si la VM doit avoir une IP publique."
  type        = bool
  default     = false # Le plus securise par defaut
}

variable "startup_script_content" {
  description = "Le CONTENU (texte) du script de demarrage."
  type        = string
  default     = "# Script vide par defaut"
}

variable "ssh_user_name" {
  description = "Utilisateur pour la cle SSH."
  type        = string
}

variable "ssh_public_key_path" {
  description = "Chemin (sur la machine qui lance Terraform) vers la cle SSH publique."
  type        = string
}