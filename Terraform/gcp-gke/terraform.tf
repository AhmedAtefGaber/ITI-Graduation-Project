terraform {
  backend "gcs" {
    credentials = "./cred.json"
    bucket      = "terraform-state-my-first-gke-iti-project-281015"
    prefix      = "terraform/state"
  }
}
