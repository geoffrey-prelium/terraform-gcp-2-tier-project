# C:/terraform-projet-2-tiers/modules/gcp-vm/outputs.tf

output "vm_external_ip" {
  description = "L'IP externe de la VM (si elle existe, sinon 'none')."

  # Logique conditionnelle :
  # Si on a assigne une IP, on la renvoie.
  # Sinon, on renvoie "none" pour eviter une erreur.
  value = var.assign_public_ip ? google_compute_instance.vm.network_interface[0].access_config[0].nat_ip : "none"
}

output "vm_internal_ip" {
  description = "L'IP interne (privee) de la VM."
  value       = google_compute_instance.vm.network_interface[0].network_ip
}

output "vm_name" {
  description = "Le nom de la VM creee."
  value       = google_compute_instance.vm.name
}