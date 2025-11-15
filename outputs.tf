# C:/terraform-projet-2-tiers/outputs.tf

output "web_subnet_link" {
  description = "Lien (self_link) vers le subnet public (web)"

  # Logique robuste :
  # "Pour (for) chaque subnet (s) dans la liste (module.vpc.subnets)
  # si (if) le nom du subnet (s.name) est "subnet-web-public"
  # alors retourne son lien (s.self_link).
  # Prend le premier [0] resultat."
  value = [for s in module.vpc.subnets : s.self_link if s.name == "subnet-web-public"][0]
}

output "db_subnet_link" {
  description = "Lien (self_link) vers le subnet prive (db)"

  # Meme logique pour le subnet DB
  value = [for s in module.vpc.subnets : s.self_link if s.name == "subnet-db-private"][0]
}

output "network_name" {
  description = "Nom du VPC principal"
  value       = module.vpc.network_name
}

output "web_vm_external_ip" {
  description = "IP Publique du serveur Web"
  # On lit la sortie de notre module "vm_web"
  value = module.vm_web.vm_external_ip
}

output "web_vm_internal_ip" {
  description = "IP Privee du serveur Web"
  value       = module.vm_web.vm_internal_ip
}

output "db_vm_external_ip" {
  description = "IP Publique du serveur DB (devrait etre 'none')"
  value       = module.vm_db.vm_external_ip
}

output "db_vm_internal_ip" {
  description = "IP Privee du serveur DB"
  value       = module.vm_db.vm_internal_ip
}