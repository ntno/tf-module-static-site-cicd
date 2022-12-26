{
    "Version": "2012-10-17",
    "Id": "ci_temp_cloudformation_policy",
    "Statement": [
        {
            "Sid": "CreateDestroyCiCloudformationStacks",
            "Effect": "Allow",
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