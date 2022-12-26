{
    "Version": "2012-10-17",
    "Id": "cdcd_read_write_artifacts_policy",
    "Statement": [
        {
            "Sid": "ReadWriteArtifactsBucketObjects",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetEncryptionConfiguration"
            ],
            "Resource": [
                "arn:aws:s3:::${bucket-name}"
            ]
        }
    ]
}


