
{
    "Version": "2012-10-17",
    "Id": "read_write_cd_bucket_policy",
    "Statement": [
        {
            "Sid": "ReadCdBucketConfig",
            "Effect": "Allow",
            "Principal": "*",
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
        }
    ]
}