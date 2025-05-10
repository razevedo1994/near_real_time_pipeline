data "aws_caller_identity" "current" {}

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

# Policies

data "aws_iam_policy_document" "table_bucket_policy" {
  statement {
    actions = ["s3tables:*"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    resources = ["${aws_s3tables_table_bucket.s3tables_bucket.arn}/*"]
  }
}

resource "aws_s3tables_table_bucket_policy" "table_bucket_policy" {
  resource_policy  = data.aws_iam_policy_document.table_bucket_policy.json
  table_bucket_arn = aws_s3tables_table_bucket.s3tables_bucket.arn
}

resource "aws_s3tables_table_policy" "s3table_policy" {
  resource_policy  = data.aws_iam_policy_document.table_policy.json
  name             = aws_s3tables_table.s3tables_table.name
  namespace        = aws_s3tables_table.s3tables_table.namespace
  table_bucket_arn = aws_s3tables_table.s3tables_table.table_bucket_arn
}
data "aws_iam_policy_document" "table_policy" {
  statement {
    actions = ["s3tables:*"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    resources = ["${aws_s3tables_table.s3tables_table.arn}"]
  }
}

# Resource Link

resource "aws_glue_catalog_database" "this" {
  name = "s3-table-database"
  catalog_id = data.aws_caller_identity.current.account_id
  target_database {
      catalog_id    = "${data.aws_caller_identity.current.account_id}:s3tablescatalog/${aws_s3tables_table_bucket.s3tables_bucket.name}"
      database_name = aws_s3tables_namespace.s3tables_namespace.name
      region        = var.aws_region
    }

}

