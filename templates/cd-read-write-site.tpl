{
    "Version": "2012-10-17",
    "Id": "cd_read_write_site_policy",
    "Statement": [
        {
            "Sid": "ReadCdBucketConfig",
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketWebsite",
                "s3:GetBucketAcl",
                "s3:GetBucketPolicy",
                "s3:GetEncryptionConfiguration"
            ],
            "Resource": [
                "arn:aws:s3:::${bucket-name}"
            ]
        },
        {
            "Sid": "ReadWriteCdBucketObjects",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${bucket-name}",
                "arn:aws:s3:::${bucket-name}/*"
            ]
        }
    ]
}