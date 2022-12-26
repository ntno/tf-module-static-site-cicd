{
    "Version": "2012-10-17",
    "Id": "read_write_artifacts_bucket_policy",
    "Statement": [
        {
            "Sid": "ReadWrite_${bucket-name}_Objects",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetEncryptionConfiguration"
            ],
            "Resource": [
                "arn:aws:s3:::${bucket-name}",
                "arn:aws:s3:::${bucket-name}/*"
            ]
        }
    ]
}


