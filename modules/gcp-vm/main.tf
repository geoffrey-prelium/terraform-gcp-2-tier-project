# C:/terraform-projet-2-tiers/modules/gcp-vm/main.tf

resource "google_compute_instance" "vm" {
  # --- Arguments de base ---
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.gcp_zone
  tags         = var.tags

  # --- Disque de demarrage ---
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # On fixe une image standard
    }
  }

  # --- Reseau ---
  network_interface {
    subnetwork = var.subnet_link

    # --- Logique conditionnelle pour l'IP Publique ---
    # Ce bloc "dynamic" ne s'executera que si var.assign_public_ip == true
    dynamic "access_config" {
      for_each = var.assign_public_ip ? [1] : []
      content {
        # Un bloc 'content' vide demande une IP ephemere
      }
    }
  }

  # --- Configuration au demarrage ---
  metadata = {
    # On passe le CONTENU du script (pas de 'templatefile' ici)
    "startup-script" = var.startup_script_content

    # On lit le contenu de la cle publique sur la machine locale
    "ssh-keys" = "${var.ssh_user_name}:${file(var.ssh_public_key_path)}"
  }
}