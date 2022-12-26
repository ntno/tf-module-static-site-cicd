
{
    "Version": "2012-10-17",
    "Id": "read_write_cd_bucket_policy",
    "Statement": [
        {
            "Sid": "ReadWriteCdBucketObjects",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::${bucket-name}/*"
            ]
        }
    ]
}