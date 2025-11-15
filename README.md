# Projet Terraform : Infrastructure Cloud 2-Tiers sur GCP

Ce projet déploie une infrastructure web 2-tiers (Frontend/Backend) complète sur Google Cloud Platform en utilisant Terraform.

L'objectif est de démontrer la maîtrise des concepts fondamentaux de l'Infrastructure as Code (IaC), y compris les modules, le state distant, la gestion du réseau et les "best practices" de sécurité.

## 🏛️ Architecture

L'infrastructure est composée des éléments suivants :

* **Réseau (Module Public)** : 1 VPC (`vpc-projet-2-tiers`) contenant deux subnets :
    * `subnet-web-public` (10.10.1.0/24)
    * `subnet-db-private` (10.10.2.0/24)
* **Frontend (Module Local)** : 1 VM (`vm-web-frontend`) dans le subnet public, provisionnée avec Nginx.
* **Backend (Module Local)** : 1 VM (`vm-db-backend`) dans le subnet privé (sans IP publique), provisionnée avec MySQL.

## 🔐 Sécurité

La sécurité est gérée par des **Tags** :

1.  **HTTP (Public)** : Internet (`0.0.0.0/0`) peut accéder au port `80` des VMs taguées `web-server`.
2.  **SSH (Public)** : Internet (`0.0.0.0/0`) peut accéder au port `22` des VMs taguées `allow-ssh`.
3.  **MySQL (Privé)** : Seules les VMs taguées `web-server` peuvent accéder au port `3306` des VMs taguées `db-server`.

## 🚀 Comment l'utiliser

### Prérequis

1.  Compte GCP
2.  Terraform (v1.0+)
3.  SDK `gcloud` (authentifié avec `gcloud auth application-default login`)
4.  Une clé SSH (ex: `~/.ssh/gcp_terraform_key.pub`)

### Déploiement

1.  **Créer un Backend Bucket :**
    * Créez un bucket GCS unique (ex: `tfstate-projet-2-tiers-xxxx`) avec le versioning activé.
    * Mettez à jour le nom du bucket dans `backend.tf`.

2.  **Configurer les variables :**
    * Mettez à jour votre `gcp_project_id` dans `variables.tf`.

3.  **Déployer :**
    ```sh
    terraform init
    terraform plan
    terraform apply
    ```

### Destruction

N'oubliez pas de nettoyer les ressources pour éviter les frais.
```sh
terraform destroy