# Exercises

## 00-setup

Install and enable dependencies:
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
gsutil mb -b on -l europe-west4 gs://tf-class-intermediate-state
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

# 01-bucket

## Create a bucket
Add a bucket in GCS using `google_storage_bucket`.
