# Exercise 04

data "terraform_remote_state" "e04" {
  backend = "local"
  config = {
    path = "./src/e04/terraform.tfstate"
  }
}

output "e04_remote_state_bucket_name" {
  value = data.terraform_remote_state.e04.outputs.bucket_name
}
