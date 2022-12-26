
resource "aws_iam_policy" "read_write_artifacts_bucket_cicd_policy" {
  name        = format("ReadWrite_CICD_%s_S3", var.artifact_bucket_name)
  path        = "/CustomerManaged/"
  description = format("Allows read/write on %s S3 bucket for CICD", var.artifact_bucket_name)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/read-write-artifacts-bucket.tpl",
    {
      bucket-name = var.artifact_bucket_name
    }
  )
}

resource "aws_iam_role" "role" {
  name = format("%s-CI", var.domain_name)

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}