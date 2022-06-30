# Exercises

Exercise contents will be added to `e<n>.tf` files.

## 00 - Setup

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

## 01 - Bucket

Add a GCS bucket in using `google_storage_bucket`.

## 02 - Variable

Add a variable to store your name using `variable`.

## 03 - Bucket object

Add file with your name from step 02 to the bucket from step 01 using `google_storage_bucket_object`.
