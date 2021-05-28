
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.1.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.1.2"
    }
  }
}

provider "kubernetes" {
  config_path    = var.kube_config
  config_context = var.kube_context
}

provider "helm" {
  kubernetes {
    config_path    = var.kube_config
    config_context = var.kube_context
  }
}

resource "kubernetes_namespace" "ghga-infra-namespace" {
  metadata {
    name = "ghga-infra"
  }
}

resource "helm_release" "nginx-ingress" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx/"
  chart      = "ingress-nginx"
  namespace  = "kube-system"
}

resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "kube-system"
  version    = "v1.0.4"
  set {
    name  = "installCRDs"
    value = true
  }
}

resource "helm_release" "adminer" {
  name       = "adminer"
  repository = "https://cetic.github.io/helm-charts"
  chart      = "adminer"
  namespace  = "ghga-infra"
}

resource "helm_release" "postgresql" {
  name       = "ghga-test-db"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "9.8.4"
  namespace  = "ghga-infra"

  set {
    name  = "image.tag"
    value = "12"
  }

  set {
    name  = "postgresqlPostgresPassword"
    value = var.postgresql_postgres_password
  }

  set {
    name  = "postgresqlUsername"
    value = var.postgresql_username
  }

  set {
    name  = "postgresqlPassword"
    value = var.postgresql_password
  }

  set {
    name  = "service.port"
    value = 5432
  }
}

resource "" "name" {
  
}