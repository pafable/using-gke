terraform {
    required_version = ">= 0.14"

    required_providers {
      google = {
          source = "hashicorp/google"
          version = ">= 3.61"
      }
    }
}

provider "google" {
    project = "ghost-blog-302601"
    region = "us-east1"
    zone = "us-east1-b"
}

resource "google_container_cluster" "gke_cluster" {
    name = "ghost-gke-cluster"
    location = "us-east1"
    remove_default_node_pool = true
    initial_node_count = 1
    min_master_version = "1.18.16-gke.302"
    node_version = "1.18.16-gke.302"
}

resource "google_container_node_pool" "nodes" {
    name = "ghost-gke-cluster-pool"
    location = "us-east1"
    cluster = google_container_cluster.gke_cluster.name
    node_count = 1

    node_config {
        preemptible = true
        machine_type = "e2-small"
    }
}