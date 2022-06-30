# 00-setup

## Install and enable dependencies
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)
- [Terraform](https://www.terraform.io/downloads)

Configure gcloud CLI:
```
gcloud config configurations create tf-class-intermediate
gcloud init
```

Enable ADC credentials:
```
gcloud auth application-default login
```

Create state bucket:
```
gsutil mb gs://tf-class-intermediate
```
Add bucket name to backend configuration in `terraform.tf`.

Initialize Terraform:
```
terraform init
```

Apply config to enable APIs:
```
terraform apply
```
