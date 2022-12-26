{
    "Version": "2012-10-17",
    "Id": "ssm_policy",
    "Statement": [
        {
            "Sid": "ReadParameters",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ssm:GetParameterHistory",
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": ${read-paths}
        },
        {
            "Sid": "WriteParameters",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ssm:PutParameter",
                "ssm:LabelParameterVersion",
                "ssm:DeleteParameter",
                "ssm:UnlabelParameterVersion",
                "ssm:RemoveTagsFromResource",
                "ssm:AddTagsToResource",             
                "ssm:DeleteParameters"
            ],
            "Resource": ${write-paths}
        }
    ]
}