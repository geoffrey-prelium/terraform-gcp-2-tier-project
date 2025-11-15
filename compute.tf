# C:/terraform-projet-2-tiers/compute.tf

# =========================================================
# VM 1 : Serveur Web (Frontend)
# =========================================================
module "vm_web" {
  source = "./modules/gcp-vm" # Appel a notre "usine"

  # --- Parametres de base ---
  vm_name      = "vm-web-frontend"
  machine_type = "e2-micro"
  gcp_zone     = var.gcp_region_zone

  # --- Parametres de securite ---
  tags                = ["web-server", "allow-ssh"]
  ssh_user_name       = var.ssh_user_name
  ssh_public_key_path = var.ssh_public_key_path

  # --- Parametres Reseau (CORRECTION) ---
  # On ne peut pas lire 'output.web_subnet_link'.
  # On doit lire la source : 'module.vpc'.
  subnet_link = [for s in module.vpc.subnets : s.self_link if s.name == "subnet-web-public"][0]

  assign_public_ip = true # OUI, il faut une IP publique

  # --- Provisioning ---
  # On lit le script web et on injecte son contenu
  startup_script_content = templatefile("${path.cwd}/startup-web.sh", {})
}


# =========================================================
# VM 2 : Serveur Base de Donnees (Backend)
# =========================================================
module "vm_db" {
  source = "./modules/gcp-vm" # Appel a notre "usine"

  # --- Parametres de base ---
  vm_name      = "vm-db-backend"
  machine_type = "e2-micro"
  gcp_zone     = var.gcp_region_zone

  # --- Parametres de securite ---
  tags                = ["db-server", "allow-ssh"]
  ssh_user_name       = var.ssh_user_name
  ssh_public_key_path = var.ssh_public_key_path

  # --- Parametres Reseau (CORRECTION) ---
  # Idem, on lit directement la sortie de 'module.vpc'.
  subnet_link = [for s in module.vpc.subnets : s.self_link if s.name == "subnet-db-private"][0]

  assign_public_ip = false # NON, pas d'IP publique (securite)

  # --- Provisioning ---
  # On lit le script DB et on injecte son contenu
  startup_script_content = templatefile("${path.cwd}/startup-db.sh", {})
}