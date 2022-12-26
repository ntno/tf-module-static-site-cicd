{
    "Version": "2012-10-17",
    "Id": "invalidate_cloudfront_distribution_policy",
    "Statement": [
        {
            "Sid": "InvalidateCloudfrontDistribution",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "cloudfront:CreateInvalidation"
            ],
            "Resource": [
                "arn:aws:cloudfront::${aws-account-id}:distribution/${cloudfront-distribution-id}"
            ]
        }
    ]
}


