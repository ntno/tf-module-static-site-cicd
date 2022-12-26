# tf-module-static-site-cicd
creates AWS infrastructure for reviewing static website.  compatible with [ntno/tf-module-static-site](https://github.com/ntno/tf-module-static-site).

Artifact Bucket:
- used to store versioned site content

CI Role:
  - read/write to objects in artifact bucket
  - create cloudformation stacks (restricted by stack name)
  - create/destroy S3 buckets for static website testing (restricted by bucket name)
  - read/write to temporary S3 buckets
  - read/write on SSM parameters (optional)

CD Role:
  - read/write to objects in artifact bucket
  - read/write to objects in site bucket
  - invalidate on cloudfront distribution for site
  - read/write on SSM parameters (optional)
  
## prerequisites
- set up GitHub OpenID Connect provider
  - [Use OpenID Connect within your workflows to authenticate with Amazon Web Services.](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services) 
  - [AWS Credentials GitHub action](https://github.com/aws-actions/configure-aws-credentials)

## example usage:   

```
# update x.x.x to desired version
module "docs_site_cicd" {
  source = "git::https://github.com/ntno/tf-module-static-site-cicd?ref=x.x.x"
  site_bucket                = "ntno.net"
  artifact_bucket_name       = "ntno.net-artifacts"
  ci_prefix                  = "ntno-net-ci-pr"
  github_repo                = "ntno.net"
  github_org                 = "ntno"
  cloudfront_distribution_id = module.docs_site.content_cloudfront_distribution_info.id
  tags                       = local.global_tags
}

```