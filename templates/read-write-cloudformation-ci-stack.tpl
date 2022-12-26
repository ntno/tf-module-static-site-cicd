{
    "Version": "2012-10-17",
    "Id": "read_write_ci_cloudformation_policy",
    "Statement": [
        {
            "Sid": "CreateDestroyCiCloudformationStacks",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "cloudformation:RollbackStack",
                "cloudformation:CreateStack",
                "cloudformation:Describe*",
                "cloudformation:DeleteStack",
                "cloudformation:ListStackResources"
            ],
            "Resource": [
                "arn:aws:cloudformation:*:${aws-account-id}:stack/${ci-prefix}*/*"
            ]
        }
    ]
}