# tf-module-static-site-cicd
creates AWS infrastructure for reviewing static website.  compatible with [ntno/tf-module-static-site](https://github.com/ntno/tf-module-static-site).

Artifact Bucket:
  - used to store rendered site content

CI Role:
  - read/write to objects in artifact bucket
  - create cloudformation stacks (restricted by stack name)
  - create/destroy S3 buckets for static website testing (restricted by bucket name)
    - read/write to temporary S3 buckets
  - read/write on specified SSM parameters (optional)

CD Role(s):
  - can only be assumed in job with github environment `github_cd_environment_name`
    - this allows you to restrict who can deploy to the CD environment via repository/workflow settings
  - read/write to objects in artifact bucket
  - read/write to objects in site bucket
  - invalidate on cloudfront distribution for site (optional)
  - read/write on specified SSM parameters (optional)
  
## prerequisites
- set up GitHub OpenID Connect provider
  - [Use OpenID Connect within your workflows to authenticate with Amazon Web Services.](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services) 
  - [AWS Credentials GitHub action](https://github.com/aws-actions/configure-aws-credentials)

## example usage

```
# update x.x.x to desired version
module "docs_site_cicd" {
  source               = "git::https://github.com/ntno/tf-module-static-site-cicd?ref=x.x.x"
  artifact_bucket_name = "ntno.net-artifacts"
  github_repo          = "ntno.net"
  github_org           = "ntno"
  tags                 = local.global_tags

  integration_environment = {
    ci_prefix               = "ntno-net-ci-pr-"
    github_environment_name = "gh-ci"
    tags = {
      project-environment = "integration"
    }
  }

  deployment_environments = {
    "production" = {
      github_environment_name = "gh-prod"
      deploy_bucket           = "ntno.net"
      tags = {
        project-environment = "production"
      }
    }
  }
}
```
