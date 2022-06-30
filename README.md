# tf-class-intermediate

Exercises in Terraform adjusted for GCP. Original class repo: [jwkidd3/terraform](https://github.com/jwkidd3/terraform).

## Using Terraform

Initialize Terraform:
```
terraform init
```
Show planned changes:
```
terraform plan
```
Apply changes:
```
terraform apply
```
*(answer yes if changes are OK)*

## Exercises

Exercise contents will be added to `e<n>.tf` files.

### 00 - Setup

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

Add overrides for your project and organization in a new file `override.auto.tf`. Example content:
```
google_org_id     = "0123456789"
google_billing_id = "012345A-B45678-987654"
google_project    = "my-class-project1234"
```

Initialize Terraform:
```
terraform init
```

Apply config to enable APIs:
```
terraform apply
```

### 01 - Bucket

Add a GCS bucket in using `google_storage_bucket`.

### 02 - Variable

Add a variable to store your name using `variable`.

### 03 - Bucket object

Add file with your name from step 02 to the bucket from step 01 using `google_storage_bucket_object`.

### 04 - Query remote state

*(note about 04a: remote state bucket for this project was added in step 00)*

Add a data resource using `terraform_remote_state` to get and output a value from an other Terraform project.

### 05 - Add alternate provider

Add an alternate provider with a different default project, and create a bucket using it.

### 06a - Create a module

Add a module with input variables to create some objects.

### 06b - Create a webserver

- Provision an instance using `google_compute_instance`
- Open for access from public Internet
- Install nginx on the webserver
