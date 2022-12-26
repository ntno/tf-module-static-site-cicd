{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${aws-account-id}:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
          "token.actions.githubusercontent.com:sub": "repo:${github-org}/${github-repo}:ref:refs/heads/main"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:${github-org}/${github-repo}:*"
        }
      }
    }
  ]
}