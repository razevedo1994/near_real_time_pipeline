resource "aws_s3tables_table_bucket" "s3tables_bucket" {
  name = "nrt-bucket"
}

resource "aws_s3tables_namespace" "s3tables_namespace" {
  namespace        = "example-namespace"
  table_bucket_arn = aws_s3tables_table_bucket.table_bucket.arn
}

resource "aws_s3tables_table" "s3tables_table" {
  name             = "example_table"
  namespace        = aws_s3tables_namespace.s3tables_namespace.namespace
  table_bucket_arn = aws_s3tables_namespace.s3tables_bucket.table_bucket_arn
  format           = "ICEBERG"
}