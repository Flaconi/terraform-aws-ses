data "aws_region" "current" {}

data "aws_route53_zone" "this" {
  count        = local.create_route53_records ? 1 : 0
  name         = var.domain
  private_zone = false
}
