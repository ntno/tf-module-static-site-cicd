{
    "Version": "2012-10-17",
    "Id": "cd_invalidate_cloudfront_policy",
    "Statement": [
        {
            "Sid": "InvalidateCloudfrontDistribution",
            "Effect": "Allow",
            "Action": [
                "cloudfront:CreateInvalidation"
            ],
            "Resource": [
                "arn:aws:cloudfront::${aws-account-id}:distribution/${cloudfront-distribution-id}"
            ]
        }
    ]
}