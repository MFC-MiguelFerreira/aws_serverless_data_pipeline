# AWS Serverless Data Pipeline

## Objectives

The goal of this project is to build a Serverless, IaC and Low Cost data pipeline on AWS.

## Requisites

### Infrastructure as Code (IaC) [Must Have]

The main reasons to use the IaC development paradigm are:

- Learning Terraform
- The reproducibility of the pipeline
- Easy to destroy the cloud resource to not inccur in costs

### Datalake [Must Have]

This project need to construct a Datalake with two layers:

- Raw Layer: Stores unprocessed data directly from the source.
- Curated Layer: Contains transformed and cleaned data ready for analysis.

### Data Pipeline [Must Have]

This need to represent a data pipeline wuth the following characteristics:

- Extract data from a source
- Load data into the raw layer of the Data Lake
- Transform data from the raw to the curated layer of the Data Lake

### Data Catalog [Nice to Have]

The catalog needs to represent metadata about the data stored in the Data Lake, including schema information.

## Getting Started

### Prerequisites

Before you begin, ensure that you have the following tools installed:

- Terraform CLI: Make sure you have the Terraform CLI installed.
- AWS CLI: Also, ensure that you have the AWS CLI installed with a configured profile.

### First Steps

After cloning the repository, follow these steps to deploy the infrastructure using Terraform:

- Initialize Terraform:

    `terraform init`

- Plan your changes:

    `terraform plan`

- Apply the changes (specify the path to your `.tfvars` file):

    `terraform apply -var-file={path/to/.tfvars}`

- [Optional] To destroy the infrastructure (specify the path to your `.tfvars` file):

    `terraform destroy -var-file={path/to/.tfvars}`

Remember to replace `{path/to/.tfvars}` with the actual path to your `.tfvars` file.

### Docker Commands

https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-instructions

```bash
docker build -t python_lambda .
docker run --platform linux/amd64 -p 9000:8080 python_lambda lambdas/extract.handler
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"payload":"asdf"}'
```
