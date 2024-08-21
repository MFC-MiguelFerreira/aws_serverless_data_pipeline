# AWS Serverless Data Pipeline

## Objectives

The goal of this project is to build a Serverless, IaC and Low Cost data pipeline on AWS.

## Requisites

### Infrastructure as Code (IaC) [Must Have]

The main reasons to use the development paradigm are:

- Learning Terraform
- Easy to destroy the cloud resource to not inccur in costs
- The reproducibility of the pipeline

### Datalake [Must Have]

This project need to construct a Datalake with two layers:

- Raw Layer: Stores unprocessed data directly from the source.
- Curated Layer: Contains transformed and cleaned data ready for analysis.

### Data Pipeline [Must Have]

This need to represent a data pipeline if the following characteristics:

- Extract data from a source
- Load data into the raw layer of the Data Lake
- Transform data for the curated layer of the Data Lake

### Data Catalog [Nice to Have]

The catalog needs to represent metadata about the data stored in the Data Lake, including schema information.
