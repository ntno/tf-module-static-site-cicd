{
    "Version": "2012-10-17",
    "Id": "ci_read_write_temp_policy",
    "Statement": [
        {
            "Sid": "CreateDestroyCiBuckets",
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketPublicAccessBlock",
                "s3:PutBucketPublicAccessBlock",
                "s3:PutEncryptionConfiguration",
                "s3:DeleteBucketWebsite",
                "s3:GetBucketWebsite",
                "s3:PutBucketWebsite",
                "s3:PutBucketPolicy",
                "s3:CreateBucket",
                "s3:GetBucketAcl",
                "s3:PutBucketAcl",
                "s3:DeleteBucketPolicy",
                "s3:DeleteBucket",
                "s3:GetBucketPolicy",
                "s3:GetEncryptionConfiguration"
            ],
            "Resource": [
                "arn:aws:s3:::${ci-prefix}*"
            ]
        },
        {
            "Sid": "ReadWriteCiBucketObjects",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:DeleteObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::${ci-prefix}*/*"
            ]
        }
    ]
}