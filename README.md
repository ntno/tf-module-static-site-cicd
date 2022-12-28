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
  - role assumption restricted to a specific github environment `github_environment_name` (optional)
  
CD Role(s):
  - read/write to objects in artifact bucket
  - read/write to objects in site bucket
  - invalidate on cloudfront distribution for site (optional)
  - read/write on specified SSM parameters (optional)
  - role assumption restricted to a specific github environment `github_environment_name` (optional)
    - this allows you to restrict who can deploy to the CD environment via repository/workflow settings

## prerequisites
- set up GitHub OpenID Connect provider
  - [Use OpenID Connect within your workflows to authenticate with Amazon Web Services.](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services) 
  - [AWS Credentials GitHub action](https://github.com/aws-actions/configure-aws-credentials)
- create GitHub environments if using optional `github_environment_name` input
  - GitHub environments are not required, if `github_environment_name` is left blank role may be assumed by workflows for any branch in the repository

## example usage

### with GitHub Environment
Assume the following steps have already been completed:
- set up GitHub OpenID Connect provider (see prerequisites)
- create S3 static website bucket `ntno.net`
  - See [`ntno/tf-ntno.net`](https://github.com/ntno/tf-ntno.net) for complete example
- `gh-ci` and `gh-prod` GitHub Environment created in `ntno/ntno.net` repository (required for this example)

```
module "portfolio_site_cicd" {
  source = "git::https://github.com/ntno/tf-module-static-site-cicd?ref=x.x.x"

  artifact_bucket_name = "ntno.net-artifacts"
  github_org           = "ntno"
  github_repo          = "ntno.net"
  tags                 = local.global_tags

  integration_environment = {
    environment_id          = "integration"
    github_environment_name = "gh-ci"
    ci_prefix               = "ntno-net-ci-pr"
    tags = {
      project-environment = "integration"
    }
  }

  deployment_environments = {
    "production" = {
      deploy_bucket              = "ntno.net"
      github_environment_name    = "gh-prod"
      cloudfront_distribution_id = module.portfolio_site.content_cloudfront_distribution_info.id
      tags = {
        project-environment = "production"
      }
    }
  }
}
```

### without GitHub Environment
Assume the following steps have already been completed:
- set up GitHub OpenID Connect provider (see prerequisites)
- create S3 static website buckets `factually-settled-boxer` and `factually-settled-boxer-development`
  - See [`infra/`](https://github.com/ntno/mkdocs-demo/tree/main/infra) in `ntno/mkdocs-demo` for complete example

```
# update x.x.x to desired version
module "demo_site_cicd" {
  source = "git::https://github.com/ntno/tf-module-static-site-cicd?ref=x.x.x"

  artifact_bucket_name = "factually-settled-boxer-artifacts"
  github_org           = "ntno"
  github_repo          = "mkdocs-demo"
  tags                 = local.global_tags

  integration_environment = {
    environment_id = "integration"
    ci_prefix      = format("%s-%s-ci-pr-", "ntno", "mkdocs-demo")
    tags = {
      project-environment = "integration"
    }
  }

  deployment_environments = {
    "production" = {
      deploy_bucket           = "factually-settled-boxer"
      tags = {
        project-environment = "production"
      }
    },
    "development" = {
      deploy_bucket = "factually-settled-boxer-development"
      tags = {
        project-environment = "development"
      }
    }
  }
}
```