credentials        = "./cred.json"
project_id         = "iti-project-281015"
region             = "europe-west4"
zones              = ["europe-west4-a", "europe-west4-b"]
name               = "gke-cluster"
machine_type       = "n1-standard-1"
min_count          = 1
max_count          = 2
disk_size_gb       = 10
service_account    = "terraform@iti-project-281015.iam.gserviceaccount.com"
initial_node_count = 1
