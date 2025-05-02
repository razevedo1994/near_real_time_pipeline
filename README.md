# Overview

This project demonstrates how to build a scalable, cost-effective data lake architecture on AWS that ingests, processes, and stores streaming data using Amazon S3 Tables and Amazon Data Firehose. The entire infrastructure is defined as code using Terraform for reproducibility and easy deployment.

# Key Features

Fully automated infrastructure provisioning with Terraform
Real-time data ingestion with Amazon Kinesis Data Firehose
Optimized data storage using Amazon S3 Tables for structured query capabilities
Data partitioning strategies for efficient querying
Built-in data transformation and enrichment
Monitoring and alerting capabilities

# Architecture

The architecture follows AWS best practices for building data lakes:

Data Sources - Various applications and services generate streaming data
Ingestion Layer - Amazon Kinesis Data Firehose collects and buffers incoming data
Storage Layer - Amazon S3 with S3 Tables for structured, queryable storage
Analytics Layer - Seamless integration with AWS analytics services (Athena, Redshift Spectrum)

# Prerequisites

- AWS Account with appropriate permissions
- Terraform (v1.5.0+)
- AWS CLI configured with your credentials
- Git